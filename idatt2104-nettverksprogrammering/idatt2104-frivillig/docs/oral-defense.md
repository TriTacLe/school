# Oral defense prep

35 likely examiner questions with answer sketches. Keep answers concise - expand verbally. Target: 2-minute answer per question.

---

## 1. What is a CRDT and why does it matter?

A CRDT (Conflict-free Replicated Data Type) is a data structure that can be updated concurrently on multiple replicas with a mathematical guarantee that all replicas converge to the same state without coordination. It matters because traditional consensus (Raft, Paxos) requires round-trip latency for every write; CRDTs are available under network partition and convergent by construction.

---

## 2. What is Strong Eventual Consistency (SEC)?

SEC (Shapiro et al. 2011): any two replicas that have received the same set of updates have equivalent state, without coordination. Weaker than linearizability (no global ordering) but stronger than eventual consistency (guarantees convergence, not just "eventually same"). SEC is the formal property CRDTs satisfy.

---

## 3. What is the difference between CvRDT and CmRDT?

- **CvRDT** (state-based): merge entire state. Merge must be a join semilattice (commutative, associative, idempotent). Can re-send state any number of times.
- **CmRDT** (op-based): propagate operations. Ops must be commutative for concurrent pairs. Requires causal delivery (ops from same replica delivered in order).

RGA is a CmRDT. We implement causal delivery via the causal buffer in the transport layer. Tradeoff: CvRDTs are simpler to prove correct; CmRDTs are more bandwidth-efficient (send one op, not full state).

---

## 4. What is a join semilattice and how does it apply to CRDTs?

A join semilattice is a partially ordered set where every pair of elements has a least upper bound (join). For CvRDTs, the join is the merge function. Properties required:
- Commutativity: `merge(a, b) = merge(b, a)`
- Associativity: `merge(merge(a, b), c) = merge(a, merge(b, c))`
- Idempotence: `merge(a, a) = a`

If all three hold, any sequence of gossip rounds produces the same final state. RGA is a CmRDT so it does not use a semilattice merge - it uses op commutativity under causal delivery instead. State-based merge (for anti-entropy StateSync) works by union of node sets, which happens to be idempotent and commutative for RGA specifically.

---

## 5. Why does RGA use Vec\<Node\> instead of BTreeMap\<NodeId, Node\>?

Document order in RGA is insertion-point order: each character is inserted "after" a specific existing node. This order is defined by the sequence of insert operations, not by NodeId magnitude.

A BTreeMap sorted by NodeId would give the wrong iteration order - characters would be output sorted by Lamport timestamp, not by their logical position in the text. A Vec maintains insertion order explicitly. The tiebreak loop during `apply(Insert)` scans linearly and places the new node at the correct position within that Vec.

Linear scan is acceptable for demo documents (hundreds of characters). For production, a skip list or piece tree would improve performance.

---

## 6. Walk me through how the causal buffer works.

An `Op::Insert{after=a}` cannot be applied until node `a` exists in local state. If it arrives first (out-of-order delivery), it goes into the causal buffer - a `BTreeMap<NodeId, Vec<Op>>` keyed by the dependency node id.

After every `apply`, the buffer is checked: any buffered op whose dependency is now satisfied gets applied. This drains in order.

If the dependency op never arrives (network loss), the anti-entropy StateSync is the backstop: every 2s, a full state delta is sent and merged, which includes the missing node.

---

## 7. Walk me through the RGA design.

RGA is an op-based sequence CRDT. State: an ordered `Vec` of `(id, char, deleted)` nodes. Each node's `id` is `(LamportClock, ReplicaId)`.

- `local_insert(pos, char)`: tick Lamport clock, create `Op::Insert{id, after, char}`, apply locally, broadcast.
- `local_delete(pos)`: create `Op::Delete{id}`, set `deleted = true` (tombstone), broadcast.
- `text()`: filter visible (non-deleted) nodes, join chars.

Concurrent inserts at the same position: both reference the same `after` node. Tie-break by `(lamport DESC, replica_id DESC)` - deterministic total order. Same tie-break at every replica = same result regardless of delivery order.

---

## 8. Why did you implement Lamport clock and vector clock from scratch?

They are explicit course content in IDATT2104. Using an external crate would look like avoiding the hard part. Implementation is small (< 100 lines total) and is a strong oral defense point: we can explain every line. The Lamport clock is used in RGA node ids for tiebreaking; the vector clock is used in version-vector anti-entropy.

---

## 9. What is a vector clock and how does it encode causality?

A vector clock `VC = Map<ReplicaId, u64>` tracks the count of events each replica has seen. When replica `r` sends a message, it includes its current VC. A receiver takes `max` of each entry. An event A happens-before B (`A -> B`) if `VC_A[r] <= VC_B[r]` for all r, with strict inequality for at least one. Two events are concurrent if neither happens-before the other.

In our system: gossip `Hello` and version-vector comparison use vector clocks so peers know exactly which ops the other has seen.

---

## 10. How does the Lamport clock tiebreak in RGA work?

Each insert op gets an id `(LamportClock, ReplicaId)`. When two concurrent inserts both target the same `after` node, the tiebreak loop in `apply(Insert)` walks forward past any existing node whose id is greater than the new node's id (by `(lamport DESC, replica_id DESC)` ordering).

The result: a node with higher Lamport timestamp appears earlier (leftward) in the sequence. If two nodes have the same Lamport timestamp (concurrent, no causal relationship), the higher ReplicaId wins the leftward position. This ordering is a total order (Lamport is scalar, ReplicaId is UUID bytes), so every replica reaches the same conclusion without communication.

---

## 11. What is causal delivery and why does RGA need it?

Causal delivery means: if op A happened-before op B, then A is delivered before B. RGA requires this because an `Insert{after=a}` cannot be applied until node `a` exists in the local state. Without causal delivery, the receiver might get the Insert before the Insert that created `a`, leading to a missing anchor.

We enforce causal delivery with the causal buffer in `net/src/gossip.rs`: an op is held until all causally prior ops (same replica, lower sequence) have been applied.

---

## 12. What is anti-entropy and why do you need it alongside op broadcast?

Op broadcast (OpBroadcast) is best-effort: if a peer is offline when an op is broadcast, it misses the op. Anti-entropy is the backstop: periodically (every 2000ms), a node compares version vectors with a random peer and sends a full state delta on mismatch. This heals any gaps from missed op broadcasts.

The design mirrors the two-path approach in Dynamo and gossip literature: low-latency op path + high-reliability state path.

---

## 13. Why TCP and not iroh+QUIC?

TCP is simpler to debug and the demo runs on a LAN where NAT traversal is not needed. We started with TCP so we could focus on the CRDT and gossip logic without fighting iroh's API.

The wire abstraction in `net/src/peer.rs` is designed so the transport can be swapped: the gossip and anti-entropy layers only see a `(send, recv)` channel of `Msg<Op>` frames. If the demo needs to work between machines on different networks, the TCP transport can be replaced with iroh (which handles NAT hole-punching automatically).

---

## 14. Why bincode and not JSON or protobuf?

bincode: compact, deterministic, no schema evolution overhead for a course project. Serde derive macros make it zero-copy on structs. ~5-10x smaller on the wire than JSON.

JSON: used for the on-disk state file only (human-readable, easier to inspect during debugging). Not on the hot path.

protobuf: adds a schema compilation step and a separate IDL. No benefit for an internal Rust-only protocol.

---

## 15. Why does RGA accumulate tombstones instead of physically deleting?

A concurrent insert might reference a deleted node as its anchor. Physically removing the node breaks the anchor - the Insert can no longer find its position. Tombstones keep the node in the list with `deleted = true` so all future references to it still resolve.

Mitigation (future work): tombstone GC requires a distributed garbage collection protocol (all replicas agree a node is globally unreachable). For a short-lived demo document, tombstone accumulation is not a practical problem.

---

## 16. How do you test CRDT correctness?

Property-based testing with `proptest` for convergence under shuffled op delivery. The core test:

```rust
proptest! {
    fn rga_converges(ops: Vec<Op>, seed: u64) {
        let mut r1 = Rga::new(REPLICA_A);
        let mut r2 = Rga::new(REPLICA_B);
        let shuffled = shuffle(ops.clone(), seed);
        for op in &ops { r1.apply(op.clone()); }
        for op in shuffled { r2.apply(op); }
        assert_eq!(r1.text(), r2.text());
    }
}
```

Min 256 cases in fast run, 1024 in CI (`-- --ignored`). Also test idempotence (applying same delete twice is a no-op). `max_shrink_iters = 100` to avoid proptest hanging on complex shrink trees.

---

## 17. How would a new peer bootstrap when joining mid-session?

1. Node dials each peer in config. On connect, sends `Hello{replica_id, version_vec}`.
2. Peer sees the newcomer's version vector is empty (or behind).
3. Peer sends `StateSync{blob}` with the full current state.
4. Newcomer applies received state. Now caught up.
5. Future ops arrive via OpBroadcast + periodic anti-entropy.

This is the same path as crash recovery - same mechanism handles both fresh joins and restart after downtime.

---

## 18. What is your threat model?

Nodes are assumed to be trusted peers on a LAN or loopback. No encryption, no authentication. A malicious peer that can send arbitrary `Msg::StateSync` can corrupt shared CRDT state.

Future work: TLS via rustls, peer identity via signed ReplicaId (ed25519). Listed in README and ARCHITECTURE.md.

---

## 19. What is the current state of the art for sequence CRDTs?

Fugue/FugueMax (Weidner & Kleppmann, 2023, arXiv:2305.00583). Improves on RGA and YATA by eliminating "interleaving" - a convergence anomaly where concurrent inserts at the same position produce garbled output. FugueMax provably avoids all interleaving scenarios.

We implement RGA instead because: (1) RGA is more widely cited and easier to explain formally; (2) the Fugue tiebreaker is more complex (requires tracking right-subtree context on every node); (3) for the demo use case, RGA interleaving is not observable in practice.

---

## 20. Can you explain the RGA interleaving anomaly?

Three replicas, all start with `"hello "`.

- Replica A types `"world"`: `w`, `o`, `r`, `l`, `d` - each after the previous.
- Replica B types `"there"`: `t`, `h`, `e`, `r`, `e` - all inserted after the space.

If B's inserts all land at A before B has processed any of A's inserts, they interleave at the character level rather than appearing as a contiguous block.

Possible result: `"hello wthoerrlde"` instead of `"hello worldthere"` or `"hello thereworld"`.

This is not a convergence failure (both replicas get the same result), but the result is semantically poor for a text editor. We document and disclose this at oral defense.

---

## 21. How does your demo show the CRDT in action?

ratatui full-screen text editor backed by RGA. Running on two terminals (or two laptops on a LAN), a user types on one terminal and watches changes propagate to the other in real time.

Each keystroke generates an `Op::Insert` or `Op::Delete`. The op is applied locally for instant feedback, then broadcast to peers. Peers apply via `rga.apply(op)` and re-render. If a peer was offline, anti-entropy StateSync delivers the ops after reconnect.

---

## 22. What are the main risks and mitigations?

| Risk | Mitigation |
|------|-----------|
| TCP framing bug | Use `tokio_util::codec::LengthDelimitedCodec`, not manual reads |
| Causal buffer never drains | StateSync backstop every 2s; restart node as last resort |
| Rust learning curve blocks contributor | `rga` crate has no async - easier entry point |
| proptest slow in CI | Run with `-- --ignored` only in CI, not in dev |
| Tombstone accumulation | Restart demo process; GC is future work |

---

## 23. What would you change if you had three more weeks?

1. Tombstone GC via a distributed GC protocol.
2. Fugue/FugueMax as a drop-in RGA replacement (no interleaving).
3. TLS + ed25519 peer authentication.
4. Swap TCP for iroh+QUIC (NAT traversal, multi-network demo).
5. Browser client via WASM (`rga` crate compiles to wasm - I/O-free by design).

---

## 24. Explain the happens-before relation in your own words.

If event A happened-before event B (`A -> B`), it means A could have caused B - A was observed before B was created. Two events are concurrent if neither happened-before the other: they were generated without knowledge of each other.

In our system: if replica 1 sends op A, and replica 2 sends op B after receiving A, then A -> B. The vector clock at each replica encodes which events it has seen, allowing any other replica to compute the happens-before relation.

---

## 25. Why should this project get an A?

- RGA implemented from scratch with honest convergence proof, causal buffer, and anti-entropy.
- Post-2020 literature survey (Automerge 2.0, Diamond Types, Fugue, Loro, Eg-walker, Kleppmann move-tree).
- Lamport + vector clock implemented from scratch (course requirement, strong oral defense point).
- Property-based convergence tests (proptest), 1024 cases in CI.
- Full CI: fmt, clippy -D warnings, test, cargo audit, coverage, cargo doc on gh-pages.
- Live 3-peer demo showing RGA convergence under real network conditions.
- Engineering discipline: decision log with entries before code, convergence proof doc, architecture diagram, Wireshark captures.
- Honest about limitations: interleaving anomaly named, documented, and explained.

---

## 26. Show me how concurrent inserts converge to the same order from the code.

Walk the examiner through `apply` in `crates/rga/src/rga.rs`.

The tiebreak loop: after finding the `after` position, scan forward while `rga.nodes[insert_pos].id > new_id`. The `>` comparison uses `(lamport DESC, replica_id DESC)`. Because this comparison is a total order, the loop terminates at the same position on every replica, regardless of which op arrived first. Both replicas insert the node at the same index in the Vec.

Concurrent deletes are trivially idempotent: `node.deleted = true` applied twice has the same effect as once.

---

## 27. Why TCP over UDP for the transport?

TCP gives reliable, ordered delivery per connection for free. Implementing our own reliability on raw UDP (retransmit, ordering, framing) would cost more time than the 14-day budget allows.

For an op-based CRDT, you could argue UDP is fine - the anti-entropy StateSync is the backstop. But then you still need framing, sequence numbers, and retransmit logic, which is most of what TCP gives you. TCP is the correct tradeoff for a course project.

For a production P2P deployment, QUIC (via iroh) is strictly better: NAT traversal, no head-of-line blocking, lower overhead. The transport abstraction in `net/src/peer.rs` allows swapping.

---

## 28. What happens if a bincode frame is corrupted in transit?

TCP: the frame will arrive intact (TCP checksums prevent corruption at the byte level; if the TCP layer detects corruption, the packet is retransmitted). bincode corruption over TCP is not a realistic failure mode.

If it did happen: `bincode::decode` returns an error. The handler logs the error and closes the connection. The peer reconnects and StateSync restores consistent state. We do not crash on a decode error.

For the journal snapshot: atomic rename (write tmp, rename to target) prevents a half-written file. A corrupted snapshot is treated as "no snapshot" - node starts fresh and requests StateSync from peers.

---

## 29. Where would you add TLS?

Between TCP connection setup and the first `Msg::Hello`. We would wrap `TcpStream` with `tokio-rustls` before handing it to `LengthDelimitedCodec`. The rest of the protocol is unchanged.

We have a `--features tls` gate in `Cargo.toml` as a placeholder. Not implemented for v1 because the demo runs on loopback, and implementing TLS certificate management correctly costs ~2 days.

---

## 30. Why is op-based CRDT (CmRDT) the right choice for a text editor?

The document grows linearly with the number of ops. A state-based CvRDT would send the entire document on every anti-entropy tick, which gets expensive as users type. An op-based CRDT sends only the new character (a small constant-size op), regardless of document length.

The tradeoff is the causal buffer requirement: you need to handle out-of-order op delivery. For a text editor where document size matters but op size does not, CmRDT is the right tradeoff.

---

## 31. Can you explain why RGA is not a join semilattice?

The RGA state is a `Vec<Node>` (ordered list). For a semilattice, you need a unique least upper bound for any two states: given state A and state B, there must be exactly one "merged" state that is the join. But for two RGA states with concurrent inserts, the document order depends on the tiebreak applied during the `apply` operations, not on a merge function. If you merge by taking the union of nodes and sort by NodeId, you get a different ordering than the causal-insertion order that RGA maintains. RGA converges because ops commute under causal delivery, not because of a lattice structure.

---

## 32. Why not use Fugue/FugueMax if it's strictly better than RGA?

FugueMax (Weidner & Kleppmann 2023) provably eliminates all interleaving anomalies. It is the current state of the art.

We use RGA because: (1) the reference implementation is in TypeScript (Automerge); no stable Rust implementation to study; (2) RGA is more widely cited, better documented for self-implementation; (3) the Fugue tiebreaker is more complex (tracks right-subtree context on every insert); (4) for the demo use case (short collaborative doc, single cursor), RGA interleaving is not observable in practice.

If asked to compare: "Fugue improves on RGA's tiebreaker to prevent interleaving. Our RGA implements the classical Roh 2011 design. Upgrading to Fugue would require adding right-subtree context to every node - a well-understood extension but outside our 14-day scope."

---

## 33. How do you test that the network layer actually converges?

Integration test in `net/tests/three_peer.rs`:

1. Start 3 in-process nodes on loopback ports.
2. Have each node perform random insert/delete operations.
3. Wait for anti-entropy cycles to run.
4. Assert all nodes have equal state: `assert_eq!(node1.text(), node2.text(), node3.text())`.
5. Variant: one node goes offline during the operations, reconnects, and asserts convergence after one anti-entropy cycle.

This catches bugs that proptest (CRDT logic in isolation) cannot see: framing errors, reconnect failures, causal buffer bugs, wrong version vector tracking.

---

## 34. What happens if two replicas have different vector clock entries on startup?

Normal case: replica restores from journal snapshot. Its vector clock reflects saved state. On Hello exchange, peer sees the restored vector clock and sends only the delta since that snapshot.

If the snapshot is missing or corrupt: replica starts with empty vector clock. Peers see this and send full StateSync. The replica converges from scratch. Same mechanism as a new peer joining.

If replica_id changes between restarts (someone deleted the state file): this is a new replica from the system's perspective. Old entries in peer maps under the old replica_id stay but are never updated. This is why we persist replica_id in the journal sidecar (`state.json`).

---

## 35. Explain the version-vector anti-entropy in one minute.

Every 2 seconds, a node sends its version vector to a random peer. The version vector is `Map<ReplicaId, u64>` - for each known replica, the highest sequence number of ops we have applied from that replica.

If the peer's version vector is identical to ours: we are in sync, nothing to send.

If vectors differ: the peer sends a delta - the ops we are missing (sequences we have not seen yet). We apply the delta. Now both are in sync.

Cost when in sync: one version vector (N replicas * 8 bytes, so 24 bytes for a 3-peer demo). Cost when diverged: full delta. This is the version-vector approach from van Renesse et al. LADIS '08 - saves bandwidth by avoiding full state sync when already in sync.
