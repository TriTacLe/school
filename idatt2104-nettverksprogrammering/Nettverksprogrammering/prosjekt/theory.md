# CRDT theory + glossary

---

## What is a CRDT

A data structure designed so that multiple replicas can be edited independently and concurrently - without any coordination - and will always converge to the same final state when all operations are exchanged. No server needed to resolve conflicts. The structure's merge rules guarantee convergence mathematically.

Two categories:
- **Operation-based (op-based / CmRDT)**: replicas exchange the operations they performed. This project uses op-based.
- **State-based (CvRDT)**: replicas exchange their full state and merge it. Simpler but heavier on network.

| Problem | CRDT type |
|---------|-----------|
| Shared counter (increment/decrement) | PN-Counter |
| Shared set (add/remove elements) | OR-Set |
| Shared ordered sequence (text editing) | RGA, Logoot, LSEQ, WOOT |

---

## Three properties (join-semilattice)

The merge operation must satisfy:
1. **Idempotent:** `merge(A, A) = A` - applying the same state twice is harmless
2. **Commutative:** `merge(A, B) = merge(B, A)` - order of receiving states does not matter
3. **Associative:** `merge(A, merge(B, C)) = merge(merge(A, B), C)` - grouping does not matter

If merge satisfies all three, any order of state exchange converges to the same result. This is called **Strong Eventual Consistency (SEC)**.

---

## CmRDT - Operation-based

Send individual operations to other replicas. Operations must be commutative and idempotent.

**Requirement: causal delivery.** If operation A happened before operation B, every replica must see A before B. Without this, some CmRDTs can diverge.

**Tradeoff:** small messages, complex delivery guarantee required.

---

## CvRDT - State-based

Each replica periodically sends its full state. Receiver calls `merge(local, received)`. No delivery ordering required.

**Tradeoff:** safe with any delivery order, but sends full state on every sync.

---

## Delta-state

Instead of full state, send only the delta since last sync. The delta is a valid sub-state, so merge is still safe without causal delivery.

**Tradeoff:** bandwidth of op-based, safety of state-based.

---

## RGA (Replicated Growable Array)

The CRDT used for the text document. Each character gets a globally unique ID `(lamport_timestamp, replica_id)` when inserted. Instead of numeric positions (which shift on concurrent inserts), each character stores "I was inserted after character with ID X". Two people inserting at the same position concurrently both succeed and produce the same final order on every replica.

Deletes use tombstones: the character stays in the array so other replicas can still reference it as a parent. Text rendering skips tombstones.

---

## Lamport clock

Single counter. Increment on any local event. On receive: `max(local, received) + 1`. Gives total causal ordering within one replica's events. Used as part of RGA node IDs.

---

## Version Vector (VV)

A map from `ReplicaId` to the highest operation counter seen from that replica.

```
{ A: 5, B: 3, C: 7 }
```

Means: "I have seen the first 5 ops from A, first 3 from B, first 7 from C."

Used for delta sync: if I send you my VV and yours says `{ A: 3 }` but mine says `{ A: 5 }`, you know I need ops 4 and 5 from A. Sender computes the diff and sends only missing ops.

---

## Operation

An immutable description of one edit. Two kinds:
- **Insert**: "insert character 'a' with ID X, after the character with ID Y"
- **Delete**: "mark character with ID Y as deleted"

Operations are the unit of everything: broadcast over TCP, stored in the oplog, replayed on startup.

---

## OpLog

A log of every operation ever applied to a document, in no particular order. Two purposes:
1. Deduplication: same op arriving twice is applied only once.
2. Delta sync: `ops_since(remote_vv)` filters the log to ops the remote hasn't seen.

---

## Causal Buffer

When ops arrive out of order (op 3 before op 2), the causal buffer holds early ops until the gap fills, then delivers them in order. Per peer, per sequence number.

Without it: text could appear in wrong order even on a single connection.

---

## Anti-entropy / sync_tick

A background process that periodically checks if peers are in sync. Every N ms, pick one peer, send them your version vector (`Msg::Hello`). They compare to their own and reply with any ops you're missing (`Msg::StateSync`).

`OpBroadcast` is the fast path (real-time). `sync_tick` is the recovery path. If a broadcast was dropped or you were offline, sync_tick catches it within one interval.

---

## Atomic write

Write new content to a temporary file (`ops.bin.tmp`), then rename it over the target (`ops.bin`). `rename` is a single OS syscall - either fully completes or does nothing. If the process crashes mid-write, the old file is intact.

---

## Tombstones

Some CRDTs (OR-Set, RGA) never physically delete elements. A deleted element gets marked with a tombstone - hidden from external view but kept so other replicas can reference it.

Without tombstones: if one replica deletes an element and another still has it, merging would resurrect the element. Tombstones let the merge know "this was intentionally removed."

Tradeoff: state grows indefinitely without garbage collection (out of scope for this project).

---

## WebSocket vs CRDT

Different layers. WebSocket is transport - how bytes move. CRDT is a consistency model - what to do when writes conflict.

Traditional approach: WebSocket + central server. All writes go through the server, which decides order. Single point of failure.

CRDT approach: any transport (WebSocket, TCP, QUIC) + no central server. Each node merges independently. The math guarantees convergence.

---

## Text editing CRDTs compared

| Algorithm | Notes |
|-----------|-------|
| RGA | Linked list with stable unique IDs per element. This project. |
| Logoot | Tree-based position identifiers |
| LSEQ | Variable-length position identifiers |
| WOOT | Without operational transformation |
| Treedoc | Binary tree with tombstones |
| Fugue/FugueMax (2023) | Current state of the art, eliminates interleaving anomalies |

---

## Challenges

- **Metadata overhead**: RGA gives each character a UUID. 16 bytes per character on top of 1 byte of content. Columnar encoding (Automerge approach) compresses this significantly.
- **Tombstone accumulation**: state grows without bound unless you run GC.
- **Complex merge for advanced types**: trees and graphs with move operations require extra coordination logic.

---

# Rust concepts (project-specific)

---

## Ownership

Every value has exactly one owner. When the owner goes out of scope, the value is dropped. No garbage collector. Enforced at compile time.

---

## async / await

`async fn` returns a future. The future does nothing until `.await`ed. `.await` suspends the current task and lets the runtime run other tasks. This is how thousands of concurrent connections work on a small thread pool.

---

## Arc\<Mutex\<T\>\>

How shared mutable state passes between async tasks.
- `Mutex<T>` - lock. Only one task accesses `T` at a time.
- `Arc<T>` - atomic reference counting. Multiple owners across threads.

Combined: multiple tasks each hold a clone of `Arc<Mutex<Document>>`. Whoever needs to read/write locks the mutex, does the work, drops the lock. Never hold across `.await`.

---

## mpsc channel (multi-producer single-consumer)

One-directional async message pipe. Many senders, one receiver. Used to pass operations between components without sharing memory:
- TUI sends local ops to router
- Router sends remote ops to TUI
- TCP listener registers new peers with router

---

## tokio::spawn

Creates a new independent async task. Must be `'static` (own all its data) and `Send` (safe to move between threads). Use `async move` to transfer ownership of captured variables into the task.

---

## Result\<T, E\> and `?`

```rust
let bytes = fs::read(&path).await?;
// equivalent to:
let bytes = match fs::read(&path).await {
    Ok(b) => b,
    Err(e) => return Err(e.into()),
};
```

`?` propagates errors up the call stack automatically.

---

## Option\<T\>

Rust has no null. `Some(value)` or `None`. The compiler forces you to handle both cases.

---

## &str vs String vs &Path vs PathBuf

| Type | Owned? | Used for |
|------|--------|----------|
| `&str` | no | string literals, temporary text |
| `String` | yes | owned text that can grow |
| `&Path` | no | referring to a path temporarily |
| `PathBuf` | yes | owned path that can be modified |

Function parameters use borrowed types so callers don't give up ownership. Struct fields and spawned tasks use owned types.
