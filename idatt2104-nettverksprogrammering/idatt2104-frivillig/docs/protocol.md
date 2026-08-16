# Wire protocol spec

This document defines the gossip protocol for `net`. Read before touching `net/src/`.

---

## 1. Transport assumptions

- **Primary**: `tokio::net::TcpStream`. TCP provides reliable, ordered byte delivery but not causal ordering across separate connections.
- iroh/QUIC deferred to stretch. The transport abstraction in `net/src/peer.rs` allows swapping without touching gossip or anti-entropy.
- Either transport: delivery is reliable (retransmit on loss) but NOT causally ordered across different connections. The protocol must not rely on cross-connection causal ordering.

---

## 2. Frame format

All messages use length-prefixed encoding:

```
+-------------------+-------------------+
| length: u32 (BE)  | payload: bincode   |
+-------------------+-------------------+
```

Use `tokio_util::codec::LengthDelimitedCodec` (max frame size: 8 MiB). Never read raw bytes manually - always go through the codec.

Payload: `bincode::encode` of the `Msg` enum (see section 4).

---

## 3. Version handshake

On every new connection:

1. Initiator sends `Msg::Hello` immediately after the TCP/QUIC connection is established.
2. Responder sends `Msg::Hello` in reply.
3. If either side receives a `Hello` with a protocol version it does not recognize, it sends `Msg::Bye{reason: "version mismatch"}` and closes the connection.

Hello contains:
- `protocol_version: u8` (current: `1`)
- `replica_id: ReplicaId` (UUID v7, persisted across restarts)
- `version_vec: VectorClock` (what state the sender has already seen)

The version vector in Hello allows the responder to immediately compute what delta to send back. This replaces a separate Ack round-trip in the common case.

---

## 4. Message types

```
enum Msg {
    Hello {
        protocol_version: u8,
        replica_id: ReplicaId,
        version_vec: VectorClock,
    },
    Bye {
        reason: String,
    },
    OpBroadcast {
        from: ReplicaId,
        seq: u64,
        causal_deps: VectorClock,
        kind: CrdtKind,
        op: OpPayload,
    },
    StateSync {
        kind: CrdtKind,
        blob: Bytes,     // bincode-encoded CRDT delta state
    },
    DigestSync {
        kind: CrdtKind,
        version_vec: VectorClock,
    },
    Ack {
        kind: CrdtKind,
        up_to: VectorClock,
    },
}

enum CrdtKind { Rga }

// OpPayload is an enum per CrdtKind, bincode-encoded separately
```

---

## 5. Anti-entropy cycle

Goal: converge even if an OpBroadcast was missed (peer offline, packet dropped in UDP path).

Cycle period: 2000 ms (configurable via `NodeConfig.anti_entropy_ms`).

**Version-vector anti-entropy** (van Renesse et al. LADIS '08):

```
every 2000ms:
  for each peer p:
    send DigestSync { kind, version_vec: local_vc }
  
on receive DigestSync from p:
  if p.version_vec == local_vc:
    // already in sync, skip
    return
  // mismatch: compute and send delta
  delta = compute_delta(local_state, p.version_vec)
  send StateSync { kind, blob: bincode(delta) }

on receive StateSync from p:
  merge(local_state, bincode::decode(blob))
  send Ack { kind, up_to: local_vc }
```

Version vector comparison avoids sending full state when already in sync. On a busy LAN with 3 nodes, most anti-entropy rounds find no mismatch and cost only the version vector (N replicas * 8 bytes).

---

## 6. Op broadcast path

Goal: low-latency propagation of individual operations.

```
on local write op:
  apply op locally
  increment own slot in local Lamport / vector clock
  for each connected peer:
    send OpBroadcast { from, seq, causal_deps, kind, op }

on receive OpBroadcast { from, seq, causal_deps, kind, op }:
  if already seen (from, seq):
    return  // deduplication
  if causal_deps not satisfied (RGA only):
    buffer op, wait
  apply op
  mark (from, seq) as seen
  // do NOT re-broadcast (anti-gossip-storm)
```

Causal dependency check: required for RGA ops. An Insert must see its `after` node before it can be applied.

---

## 7. Reconnect and backoff

```
on connection drop:
  attempt = 0
  loop:
    wait min(2^attempt * 100ms, 30s)
    try connect to peer_addr
    if success:
      send Hello (fresh version vector)
      break
    attempt += 1
```

Max backoff: 30 seconds. After reconnect, send Hello with current version vector. The peer will reply with any missed delta.

---

## 8. Causal buffer (RGA only)

RGA Inserts reference an `after` node by ID. The node must exist locally before the Insert can be applied. If it doesn't exist yet (out-of-order delivery), buffer the op:

```
causal_buffer: HashMap<NodeId, Vec<OpBroadcast>>

on receive Insert { after = a, ... }:
  if node a exists locally:
    apply immediately
    drain buffer: check if any buffered op's dependency is now satisfied
  else:
    causal_buffer[a].push(op)

on receive Delete { id = a, ... }:
  if node a exists locally:
    apply immediately
  else:
    causal_buffer[a].push(op)  // mark tombstone once it arrives
```

StateSync is the backstop: periodic full merge will converge even if the causal buffer never drains. If the buffer exceeds 1000 ops, log a warning and trigger an immediate StateSync from a random peer.

---

## 9. Persistence

On any local state change, write a snapshot asynchronously:

```
on state change:
  spawn task: write bincode(state) to <replica_id>.state.bin (atomic: write tmp, rename)

on startup:
  if <replica_id>.state.bin exists:
    state = bincode::decode(file)
  else:
    state = initial state
```

Atomic write (write temp file, `fs::rename` to target) prevents a crash mid-write from corrupting the snapshot.

---

## 10. Version scheme

Protocol version is a single `u8` in the Hello message. Current version: `1`.

Compatibility:
- Breaking change (new message type, field removal, encoding change) = increment version.
- Additive change (new optional field at end of struct) = no increment.
- For a course project, breaking the protocol between two demo sessions is fine - just restart all nodes.

---

## 11. Security non-goals (v1)

- No TLS. All traffic is plaintext.
- No peer authentication. Any node that knows the port can connect and send arbitrary state.
- No integrity checks beyond what TCP provides (frame-level checksums).
- Threat model: trusted peers on loopback or LAN only.

TLS is planned as a `--features tls` gate using `rustls`. Listed as future work. The feature flag should be wired but the implementation is out of scope for v1.

---

## 12. Observable failure modes

| Mode | Symptom | Recovery |
|------|---------|---------|
| Peer unreachable | Connection drop → reconnect loop | Automatic (backoff reconnect) |
| Op delivered out of order | Causal buffer grows | StateSync drains it after 2s |
| Op never delivered | State diverges for up to 2s | Anti-entropy StateSync heals it |
| State corrupted | bincode decode error | Log + close connection; peer will StateSync again |
| Gossip storm | Log flooded with OpBroadcast | Deduplication on `(from, seq)` prevents re-broadcast |
| Causal buffer deadlock | Buffer never drains, demo frozen | StateSync backstop + restart node |
