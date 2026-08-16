# Correctness and convergence

Formal argument that RGA satisfies Strong Eventual Consistency (SEC, Shapiro et al. 2011). Keep this in sync with the code - if the implementation diverges from the pseudocode here, update this file.

**SEC definition** (Shapiro et al. 2011, RR-7506 Section 2.2): A replicated object satisfies SEC if any two replicas that have applied the same set of updates are in equivalent state.

---

## RGA (Replicated Growable Array) - Honest assessment

RGA is an **op-based CRDT (CmRDT)**, not a state-based CvRDT. The convergence argument is different from semilattice proofs.

**State**: ordered list of nodes `[(id, char, deleted)]` where `id = (LamportClock, ReplicaId)`.

**Ops**:
- `Insert { id: (t, r), after: Option<NodeId>, char: char }`
- `Delete { id: NodeId }`

**Convergence requirement** (Roh et al. 2011, Section 4): two replicas applying the same set of Insert and Delete ops in any causally consistent order produce identical sequences, provided:

1. The tiebreaker on concurrent inserts is deterministic: `(lamport DESC, replica_id DESC)`.
2. Insert ops are applied after the `after` node exists locally (causal delivery).
3. `ReplicaId` comparison is a total order (UUID v7 bytes provide this).

**This is NOT a join-semilattice proof.** The convergence of RGA depends on op commutativity under causal delivery, not on merge forming a lattice.

**Op commutativity** (informal): Two concurrent inserts I1 and I2 at the same position produce the same sequence regardless of application order. They have different `id`s (different replica or different Lamport timestamp). The `while` loop in `apply(Insert)` inserts I1 and I2 in order of `(lamport DESC, replica_id DESC)` - the same loop runs identically on both replicas. Concurrent deletes are idempotent (tombstoning an already-tombstoned node is a no-op).

**Implementation requirement**: use `Vec<Node>` to maintain insertion order. The document order is insertion-point order (each character inserted "after" a specific existing node), not NodeId sort order. A BTreeMap sorted by NodeId would give wrong iteration order - it would output characters sorted by Lamport timestamp, not by their logical position in the text.

**Known limitation - interleaving anomaly** (Kleppmann 2021, "Lesser Known Issues in CRDTs"): if two replicas perform sequences of inserts at the same position, the resulting text may interleave the sequences character-by-character rather than keeping each sequence contiguous. Example:

```
Replica A inserts: "ab" after position 0
Replica B inserts: "cd" after position 0
Potential result: "cadb" or "acbd" (interleaved, not "abcd" or "cdab")
```

RGA does not prevent this. Fugue/FugueMax (Weidner & Kleppmann 2023) fixes this by extending the tiebreaker to include insertion context. We do not implement Fugue. This limitation must be disclosed at the oral defense.

**Causal delivery**: RGA requires Insert ops to arrive after their `after` node exists locally. Enforced by the causal buffer in `net/src/gossip.rs`. The causal buffer holds ops whose dependencies are not yet satisfied and releases them once the dependency arrives. Anti-entropy StateSync is the backstop if a dependency op is lost.

**State-based merge for anti-entropy**: During StateSync, serialize the full node list and merge by node ID union - any node in either list must be in the merged list, with `deleted = true` if deleted in either. This is not a semilattice merge in the strict sense (it requires node ID uniqueness across replicas, guaranteed by the `(Lamport, ReplicaId)` ID scheme). Safe for anti-entropy because the result is a superset of both inputs.

**Reference**: Roh, Jeon, Kim, Lee 2011, "Replicated abstract data types: Building blocks for collaborative applications". JPDC.

---

## What we do NOT prove

- **Tombstone GC**: we do not prove safety of any garbage collection protocol. GC is out of scope.
- **Byzantine fault tolerance**: we assume all peers are correct. A malicious peer sending a fabricated StateSync can corrupt state.
- **Termination under partition**: in a network partition, replicas diverge. They converge only after the partition heals and anti-entropy runs. We do not bound convergence time.
- **RGA under adversarial ordering**: the interleaving anomaly shows RGA is not optimal. We document and accept this.

---

## How to verify in tests

RGA: proptest convergence under shuffled op delivery.

```rust
// Convergence under shuffled delivery
proptest! {
    fn rga_converges(ops: Vec<Op>, seed: u64) {
        let mut r1 = Rga::new(REPLICA_A);
        let mut r2 = Rga::new(REPLICA_B);
        let shuffled = shuffle(ops.clone(), seed);
        for op in ops { r1.apply(op.clone()); }
        for op in shuffled { r2.apply(op); }
        assert_eq!(r1.text(), r2.text());
    }
}

// Idempotence: applying same op twice is a no-op
proptest! {
    fn rga_delete_idempotent(op: Op::Delete) {
        let mut r = Rga::new(REPLICA_A);
        r.apply(op.clone());
        r.apply(op.clone());
        // state unchanged after second apply
    }
}
```

Set `max_shrink_iters = 100` to avoid proptest hanging on complex shrink trees.
