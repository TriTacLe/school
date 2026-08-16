---
type: project
status: active
project: idatt2104
created: 2026-05-12
modified: 2026-05-15
tags: [ntnu, crdt, rust, networking]
---

# crdt-collab - project reference

P2P collaborative text editor in the terminal. Multiple nodes type concurrently. All nodes converge to the same text without a central server.

**Team:** Tri, Yazan, Shakti
**Repo:** `~/Desktop/ntnu/idatt2104-frivillig/crdt-collab` (remote: `yazanzarka1/crdt-collab`)
**Deadline:** 2026-05-26 23:59 portal + tag v1.0.0. Video 2026-05-29 23:59.

---

## Status (2026-05-16)

Transport layer complete and audited. mDNS peer discovery added (issue #35) - nodes on the same network now find each other automatically without `--peer` flags. All `just ci` checks green: fmt + clippy -D warnings + 48 tests + convergence + doc + preflight.

Gates: feature freeze (05-24) -> tag v1.0.0 (05-26) -> video demo (05-29).

### Completed audit items

- RGA DFS converted to iterative (stack overflow fix for large docs)
- LamportClock tick uses `checked_add` (overflow protection)
- OR-Set apply-based state merge (correct CRDT semantics)
- Panic hook installs before `enable_raw_mode` (terminal restored on crash)
- SIGINT / Ctrl-C graceful shutdown
- Protocol version checked at handshake (rejects mismatched wire format)
- Causal buffer capped at 4096 ops per peer (DoS guard)
- Snapshot atomic write (tmp + fsync + rename); directory fsync added
- `Msg::Bye` and `Msg::Ack` dropped (YAGNI - VV gossip covers recovery)
- `StateSync` now typed `ops: Vec<O>` (no double-bincode pass)
- `PROTOCOL_VERSION` centralized in `msg_codec` (single source of truth)
- `set_nodelay(true)` on dial and accept (removes Nagle ~40ms batching)
- Peer-selection in sync_tick now deterministic (sorted addr iteration)
- `identity` module renamed to `replica_id`
- mDNS peer discovery via `mdns-sd` - zero-config LAN peering, `--no-mdns` to opt out

### Deferred (post-demo)

- P1: ReplicaId-keyed peer map (NAT/restart resilience)
- P2: Single shared `Arc<Mutex<Document>>` for TUI + transport (eliminates two-doc divergence class)
- P3: Peer-event channel to TUI (fixes permanently-"solo" status bar)
- P4: `OpLog::ops_since` index (currently O(N) linear scan)
- P5: `ops_all` sort cache (re-sorts every autosave)
- P6: Snapshot compaction (full log rewrite every 30s)

---

## Crate structure

```
crdt-collab/
  crates/
    crdt-lib/        - pure CRDT logic, no I/O, no tokio
    crdt-transport/  - TCP networking, gossip, snapshot
    crdt-client/     - terminal UI (ratatui), entry point
```

`crdt-lib` knows nothing about the network. It only defines data structures and operations. `crdt-transport` imports types from it. `crdt-client` uses both.

---

## What each crate does

### crdt-lib (Yazan)
- RGA - the text document. Each character has a stable unique ID. Concurrent inserts at the same position converge deterministically.
- OR-Set - add-wins set. Concurrent add and remove: add wins.
- LWW Register - last-write-wins register using Lamport timestamps.
- LWW Map - map of LWW registers.
- Document - wraps RGA with an oplog and version vector. Exposes insert/delete/apply/ops_since.
- DocumentRegistry - manages multiple named documents per session. Main facade used by transport and TUI.
- VersionVector - tracks which ops each replica has seen.
- OpLog - deduplicates ops, used for delta sync.

### crdt-transport (Tri)
- `tcp_peer` - TCP connect/accept with exponential backoff. Frames messages with a 4-byte length prefix.
- `msg_router` - receives ops from TUI and network. Broadcasts local ops to all peers. Causal buffer ensures FIFO delivery per peer.
- `sync_tick` - fires every 500ms. Sends our version vector to one peer. Peer replies with ops we missed. Recovery path for dropped broadcasts.
- `snapshot` - saves op log to disk every 30s and on exit. Reloads on startup. Atomic write prevents corruption on crash.
- `replica_id` - generates and persists a ReplicaId (UUID v7) so identity survives restarts.
- `mdns` - registers `_crdt-collab._tcp.local.` and dials any discovered peer automatically. Dedupes against the existing peer map.

### crdt-client (Shakti)
- `app.rs` - main event loop, app state (document, cursor, peer count)
- `bridge.rs` - maps key events to document operations
- `view.rs` - View trait for switchable UI modes (editor, doc picker)
- `views/editor.rs` - renders document text with cursor highlight using ratatui
- `views/doc_picker.rs` - document selection UI for switching between documents
- `main.rs` - wires everything: loads snapshot, starts networking, runs TUI

---

## How a local edit flows

1. User presses a key in the TUI
2. `bridge.rs` calls `insert_after` or `delete` on the TUI document
3. Returns an `Operation`
4. `main.rs` sends it through `local_op_sender` channel to `msg_router`
5. `msg_router` applies it to the transport document and broadcasts `Msg::OpBroadcast` to all peers over TCP

---

## How a remote edit flows

1. Remote peer sends `Msg::OpBroadcast` over TCP
2. `tcp_peer` decodes the frame, sends `(addr, msg)` to `msg_router` via `inbound_sender` channel
3. `msg_router` checks the sequence number against what it expects from that peer
4. If in order: sends the operation to TUI via `remote_op_sender` channel, applies to transport doc
5. If early: parks in causal buffer until the gap fills
6. TUI event loop calls `try_recv` on `remote_op_receiver` each frame and applies ops to the TUI document

---

## How two nodes catch up after being out of sync

Every 500ms `sync_tick` fires on each node:
1. Picks one peer (sorted round-robin)
2. Sends `Msg::Hello` with local version vector
3. Peer sees the VV, computes `ops_since(that_vv)` - the ops the sender doesn't have
4. Sends them back as `Msg::StateSync`
5. Sender applies the missing ops to transport doc and forwards them to TUI

Even if a node was offline for an hour, within one sync_tick cycle it catches up completely.

---

## Wire protocol

Frame format: 4-byte big-endian length + bincode payload. Max frame 8 MiB.

| Message | When sent | Contains |
|---------|-----------|----------|
| `Hello` | on connect, every 500ms | protocol version, replica ID, version vector |
| `OpBroadcast` | every local edit | sender replica ID, sequence number, operation |
| `StateSync` | reply to Hello if sender is behind | typed Vec of missing operations |

---

## Persistence

Op log saved to `crdt-state/ops.bin`. On startup: load file, replay all ops. Write path: encode to `ops.bin.tmp`, sync, rename to `ops.bin`, fsync directory. The rename is atomic at OS level so a crash mid-write leaves the old file intact.

ReplicaId saved separately to `crdt-state/state.bin` by `node_cfg`.
