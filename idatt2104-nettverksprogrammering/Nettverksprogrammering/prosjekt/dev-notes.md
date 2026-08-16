# Dev notes

---

## Rust async rule

Only functions that do I/O or call other async functions need `async`. Pure logic functions (CRDT merge, version vector compare) are plain `fn`.

---

## Two documents design

`main.rs` creates two separate Document instances from the same snapshot:
- `tui_doc` - owned by `app::run` (the TUI). Not behind a mutex.
- `transport_doc` - `Arc<Mutex<Document>>` shared between router, sync_tick, autosave.

Both start with identical state (replayed from snapshot). They stay in sync via channels:
- Local ops: TUI produces op -> router applies it to transport_doc
- Remote ops: router applies to transport_doc -> sends to TUI via channel -> TUI applies to tui_doc

`transport_doc` must apply ALL ops (local + remote) to keep its version vector current. If it only applies remote ops, sync_tick sends a stale VV and peers re-send their full history on every tick.

---

## Mutex lock scope

Never hold a mutex lock across an `.await` point. If you lock `peers` and then await sending a message, another task needing `peers` deadlocks.

```rust
let sender = {
    let map = peers.lock().await;
    map.get(&addr).cloned()
};  // lock drops here
sender.send(msg).await;  // await after lock is gone
```

---

## Atomic file write

Always write to a `.tmp` file first, then rename. Rename is atomic at OS level. If the process crashes mid-write, the old file is intact. Direct overwrite risks a half-written corrupt file.

After rename, `fsync` the directory entry - otherwise the rename itself might not survive a power loss on Linux ext4/xfs.

---

## Channel naming

Use `sender` / `receiver` not `tx` / `rx`. More readable when explaining the code.

---

## Snapshot file names

- `ops.bin` - operation log (`snapshot.rs`)
- `state.bin` - ReplicaId (`replica_id.rs`)

Do not use the same filename for both. They live in the same directory.

---

## Causal buffer

TCP guarantees delivery order per connection, but we track sequence numbers to detect reconnect gaps. If a message is lost (connection drop, reconnect), gaps appear. The causal buffer holds ops until the gap fills, then drains in order. Without it the TUI could apply op3 before op2 from the same peer.

---

## sync_tick vs OpBroadcast

`OpBroadcast` = fast path. Sent immediately on every local edit. Low latency.
`sync_tick` = recovery path. Fires every 500ms regardless of edits. Catches any ops missed due to dropped connections.

Both are needed. `OpBroadcast` alone loses ops on connection drops. `sync_tick` alone has 500ms latency.

---

## Why op-based over state-based

RGA is inherently op-based - each edit is an Insert or Delete operation with a unique ID. These operations are broadcast directly and buffered in causal order per peer. The version vector + `ops_since()` gives efficient delta sync without sending full state.

---

## Why plain TCP and not iroh/QUIC

iroh adds NAT hole-punching which is useful for demos across different networks. But it added dependency complexity and the course demo runs on loopback or LAN anyway. Plain TCP with tokio is simpler, easier to reason about, and sufficient for the use case.

---

## Why rejected approaches

| Approach | Why rejected |
|----------|--------------|
| Central server | Single point of failure, defeats the P2P point |
| OT (Operational Transformation) | Requires central server to sequence ops |
| Full state gossip | Works but wastes bandwidth. Op broadcast + VV delta is better. |
| LWW-Register as text | Last-write-wins loses concurrent edits. RGA preserves all. |

---

## Wireshark

Run on loopback interface. Filter: `tcp.port == 4001 or tcp.port == 4002 or tcp.port == 4003`. Shows `OpBroadcast` packets on every keystroke and `StateSync` packets on reconnect.

---

## Transport layer (crdt-transport)

### Crate overview

```mermaid
graph TD
    TUI["crdt-client (TUI)"]
    TRANSPORT["crdt-transport"]
    LIB["crdt-lib (CRDT logic, no I/O)"]
    PEERS["Remote peers (TCP)"]

    TUI -->|"local op (mpsc)"| TRANSPORT
    TRANSPORT -->|"remote op (mpsc)"| TUI
    TRANSPORT -->|"Msg::OpBroadcast (TCP)"| PEERS
    PEERS -->|"Msg::OpBroadcast (TCP)"| TRANSPORT
    TRANSPORT -->|"Msg::StateSync (TCP)"| PEERS
    PEERS -->|"Msg::StateSync (TCP)"| TRANSPORT
    LIB -.->|"Operation, ReplicaId, VersionVector types"| TRANSPORT
    LIB -.->|"Operation, Document types"| TUI
```

`crdt-lib` has no tokio, no I/O. Pure logic only.

### Files in crdt-transport

```mermaid
graph LR
    subgraph crdt-transport
        CODEC["msg_codec - Msg enum + encode/decode"]
        CFG["node_cfg - PeerConfig + ReplicaId persist"]
        PEER["tcp_peer - TCP connect/accept + backoff"]
        ROUTER["msg_router - Fan-out + causal buffer"]
        AE["sync_tick - Periodic StateSync tick"]
        JOURNAL["snapshot - Atomic snapshot + reload"]
    end

    CODEC --> PEER
    CODEC --> ROUTER
    CFG --> PEER
    PEER --> ROUTER
    ROUTER --> AE
    AE --> JOURNAL
```

### Data flow - local write

```mermaid
sequenceDiagram
    participant TUI as crdt-client (TUI)
    participant Router as msg_router
    participant Peer as tcp_peer (per peer)
    participant Remote as Remote peer

    TUI->>Router: Operation (mpsc channel)
    Router->>Router: own_seq += 1
    Router->>Peer: Msg::OpBroadcast { from, seq, op }
    Peer->>Remote: TCP bytes (framed)
```

### Data flow - incoming op from peer

```mermaid
sequenceDiagram
    participant Remote as Remote peer
    participant Peer as tcp_peer
    participant Router as msg_router
    participant TUI as crdt-client (TUI)

    Remote->>Peer: TCP bytes
    Peer->>Router: (SocketAddr, Msg::OpBroadcast)
    Router->>Router: check seq vs seq_expected[from]
    alt seq == expected
        Router->>TUI: Operation (mpsc channel)
        Router->>Router: drain causal_buf
    else seq > expected (gap)
        Router->>Router: park in causal_buf[from][seq]
    else seq < expected
        Router->>Router: already seen, ignore
    end
```

### Data flow - sync_tick

```mermaid
sequenceDiagram
    participant ST as sync_tick (timer)
    participant Peer as selected peer
    participant Router as msg_router

    Note over ST: every interval_ms
    ST->>Peer: Msg::Hello { version_vec: local_vv }
    Peer->>Peer: diff = ops_since(local_vv)
    Peer->>Router: Msg::StateSync { ops: missing_ops }
    Router->>Router: apply missing ops, forward to TUI
```

### Channel map

```mermaid
graph LR
    TUI -->|"local_op_sender"| ROUTER
    ROUTER -->|"remote_op_sender"| TUI
    LISTENER -->|"new_peer_sender"| ROUTER
    ROUTER -->|"per-peer mpsc::Sender"| PEER1
    ROUTER -->|"per-peer mpsc::Sender"| PEER2
    PEER1 -->|"inbound_sender"| ROUTER
    PEER2 -->|"inbound_sender"| ROUTER
```

All communication via `tokio::sync::mpsc` - no shared state, no mutex between TUI and network code.

### Causal buffer - why?

```
op1 arrives (seq=1, expected=1) -> deliver to TUI, expected=2
op3 arrives (seq=3, expected=2) -> park in causal_buf[A][3]
op2 arrives (seq=2, expected=2) -> deliver to TUI, drain finds op3, deliver that too
```

TUI always sees: op1, op2, op3.

### Forbidden crates

`automerge`, `yrs`, `crdts`, `diamond-types`, `loro`, `rust-crdt`. `tools/preflight.sh` enforces this in CI.
