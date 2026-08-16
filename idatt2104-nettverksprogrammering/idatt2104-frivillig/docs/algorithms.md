# CRDT algorithms

Pseudocode only. Rust implementations live in `crates/rga/src/`. Every algorithm references its source paper.

---

## Shared primitives

### ReplicaId

```
type ReplicaId = UUID_v7  // time-sortable, 128-bit
```

Generated once on first start, persisted in `<doc>.state.json`. Same id across restarts.

### Vector clock

```
type VClock = Map<ReplicaId, u64>

tick(vc, r):
    vc[r] += 1
    return vc

merge(vc1, vc2):
    return Map { r -> max(vc1[r], vc2[r]) for all r in vc1 union vc2 }

happens_before(vc1, vc2):
    return all(vc1[r] <= vc2[r] for r in vc1) and any(vc1[r] < vc2[r] for r in vc1)

concurrent(vc1, vc2):
    return not happens_before(vc1, vc2) and not happens_before(vc2, vc1)
```

Source: Lamport (1978), extended to vectors by Mattern (1988) and Fidge (1988).

### Lamport clock

```
type LClock = u64

tick(lc):
    lc += 1
    return lc

observe(lc, other):
    lc = max(lc, other) + 1
    return lc
```

Used in RGA for total order on concurrent inserts at the same position. Tie-broken by `ReplicaId`.

---

## 1. RGA (Replicated Growable Array)

Source: Roh, H.-G., Jeon, M., Kim, J.-S., & Lee, J. (2011). Replicated abstract data types: Building blocks for collaborative applications. *Journal of Parallel and Distributed Computing*, 71(3), 354-368. https://doi.org/10.1016/j.jpdc.2010.12.006

Variant: op-based CmRDT with causal delivery guarantee.

### State shape

```
RGANode = {
    id: (LamportClock, ReplicaId),   // unique identifier
    value: char,
    deleted: bool,                   // tombstone, never removed
}

Rga = {
    nodes: Vec<RGANode>,   // maintains document order (insertion order, not id order)
    clock: LamportClock,
    replica: ReplicaId,
}
```

### Operations

```
Op::Insert {
    id: (LamportClock, ReplicaId),            // identifier of the new node
    after: Option<(LamportClock, ReplicaId)>, // insert after this node (None = head)
    value: char,
}

Op::Delete {
    id: (LamportClock, ReplicaId),  // mark this node as deleted (tombstone)
}
```

### Local insert

```
local_insert(rga, pos, char):
    rga.clock = tick(rga.clock)
    visible = [n for n in rga.nodes if not n.deleted]
    after = visible[pos - 1].id if pos > 0 else None
    op = Op::Insert { id: (rga.clock, rga.replica), after, value: char }
    apply(rga, op)
    return op
```

### apply (insert)

```
apply(rga, Op::Insert{id, after, value}):
    rga.clock = observe(rga.clock, id.lamport)

    // Find position to insert: immediately after 'after' node
    insert_pos = find_after(rga.nodes, after)  // index after the 'after' node

    // Concurrent inserts at same position: sort by (lamport DESC, replica_id DESC)
    // Higher lamport / higher replica_id wins the leftward (earlier) position
    while insert_pos < len(rga.nodes)
        and rga.nodes[insert_pos].id > id:
        insert_pos += 1

    rga.nodes.insert(insert_pos, RGANode { id, value, deleted: false })
```

Lines 261-265 in the paper describe this tiebreak loop. The key invariant: `id` ordering is total (Lamport + ReplicaId), so all replicas resolve the same winner without communication.

### apply (delete)

```
apply(rga, Op::Delete{id}):
    node = find_by_id(rga.nodes, id)
    if node:
        node.deleted = true
```

Delete is a no-op if node not found (safe: causal buffer ensures the insert arrived first).

### text

```
text(rga):
    return "".join(n.value for n in rga.nodes if not n.deleted)
```

### Causal delivery requirement

An `Op::Insert{id=(l, r), after=a}` must be delivered only after:
- The op that created node `a` has been applied (if `a` is `Some`).
- All prior ops from replica `r` with Lamport timestamp < `l` have been applied.

This is enforced by the causal buffer in `net/src/gossip.rs`.

### Convergence sketch

RGA is a CmRDT. It converges if:
1. All ops are eventually delivered to all replicas (transport guarantee).
2. Ops from the same replica are delivered in causal order (causal buffer).
3. Concurrent inserts are resolved by the same total order on ids at every replica.

The id sort `(lamport DESC, replica_id DESC)` is a total order, so condition 3 holds. Conditions 1-2 are enforced by the transport and causal buffer. See `docs/convergence-proof-sketch.md`.

### Complexity

- State size: O(total ops ever) - tombstones accumulate, no GC in v1.
- `apply(Insert)`: O(N) scan + O(N) shift. N = all nodes including tombstones.
- `text()`: O(N).
