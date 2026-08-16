---
type: project
status: active
project: idatt2104
created: 2026-05-12
modified: 2026-05-12
tags: [ntnu, course, networking, crdt, rust]
---

# IDATT2104 - Decision log

| Date | Area | Decision |
|------|------|----------|
| 2026-05-12 | Language | Rust 2024 edition |
| 2026-05-12 | Transport | TCP (tokio::TcpStream). iroh/QUIC deferred to stretch |
| 2026-05-12 | Serialisation | bincode 2.x on wire, serde_json for on-disk state only |
| 2026-05-12 | Clocks | LamportClock from scratch (course requirement). Vector clock for anti-entropy |
| 2026-05-12 | Demo | ratatui TUI, 3-peer collaborative text editor |
| 2026-05-12 | Testing | proptest, 1024+ cases per convergence law |
| 2026-05-12 | CI | fmt + clippy -D warnings + test + audit + tarpaulin + cargo doc |
| 2026-05-12 | TLS | Out of scope for v1. Future work |
| 2026-05-12 | Anti-entropy | Version-vector comparison only. Full delta on mismatch. 2s tick |
| 2026-05-13 | CRDTs | **RGA only** agreed in group meeting. PN-Counter and OR-Set dropped |
| 2026-05-13 | Crates | `rga` (CRDT logic), `net` (transport/gossip), `tui` (binary). Direction: tui -> net -> rga |
| 2026-05-13 | Team split | Tri: net + integration. Yazan: RGA. Shakti: TUI text editor |
| 2026-05-14 | Crates (actual) | **Renamed on push**: `crdt-lib` (pkg: `lib`), `crdt-net` (pkg: `net`), `crdt-client` (pkg: `client`). Direction unchanged. |
| 2026-05-14 | CRDTs (actual) | **Scope reversed on push**: `crdt-lib` contains LWW Register, LWW Map, OR-Set, RGA. Not RGA-only. |
| 2026-05-14 | RGA impl | Tree-based DFS (`HashMap<Id,Node>` + `HashMap<Id,BTreeSet<Id>>`), not `Vec`. Insert sorts by `BTreeSet` rev-iter for tiebreak. |
| 2026-05-15 | Transport framing | Raw TCP + 4-byte length-prefix + bincode. **No WebSocket.** WebSocket exists for browser clients (RFC 6455 = TCP + HTTP upgrade). Our TUI is a native process and opens raw TCP directly - no HTTP layer needed. Lower overhead, cleaner P2P. |
| 2026-05-15 | Frontend | TUI (ratatui) over WebSocket (browser). Consequence: no browser demo. Justification: true P2P has no central server to serve a web app from. |
| 2026-05-15 | Module naming | `identity` module renamed to `replica_id`. Ties directly to `lib::clock::ReplicaId`. Compile-time safe: Rust resolves modules at compile time, `cargo build` verifies all call sites. |
| 2026-05-15 | Wire protocol | Dropped `Msg::Bye` and `Msg::Ack` variants (YAGNI). Graceful disconnect and ack signalling not needed: VV anti-entropy + causal buffer already repair missed messages within one tick. |
| 2026-05-15 | Wire protocol | `PROTOCOL_VERSION` const moved to `msg_codec` (single source of truth, lives beside wire format). Was duplicated as local literal `1` in `tcp_peer`, `sync_tick`, and `msg_router`. |
| 2026-05-15 | Wire protocol | `StateSync { blob: Vec<u8> }` replaced with `StateSync { ops: Vec<O> }`. Typed variant removes double-bincode-encode: ops are now serialized once when the outer `Msg` is encoded, not pre-encoded into a blob. |
| 2026-05-15 | Transport | `set_nodelay(true)` on both dial and accept paths. Nagle's algorithm batches small writes ~40ms which would make keystroke propagation feel laggy during the demo. |
| 2026-05-15 | Snapshot | Snapshot `save()` now uses a single file handle (open -> write_all -> sync_all) instead of `tokio::fs::write` + re-open. Avoids syncing an already-closed fd. Directory fsync added after rename so the directory entry survives a power-cut. |
| 2026-05-16 | Discovery | mDNS peer discovery via `mdns-sd`. Nodes register `_crdt-collab._tcp.local.` and dial any discovered peer. Dedupes against existing peer map. `--no-mdns` flag to opt out. Removes need for manual `--peer` flags on a LAN. |
