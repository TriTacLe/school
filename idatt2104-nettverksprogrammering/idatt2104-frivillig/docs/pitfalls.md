# Known pitfalls

Traps that burned time in similar projects. Read before each phase.

---

## 1. RGA: tombstone explosion

**Symptom**: `rga.nodes.len()` grows unboundedly. On a long-running demo, memory spikes and `text()` becomes O(total operations ever).

**Why**: RGA never physically removes nodes. A deleted character becomes `deleted = true` but stays in the list forever (tombstone). The list grows monotonically with all operations, not just current characters.

**Impact**: Noticeable at ~10,000 ops. For a 14-day demo with at most ~1,000 keystrokes per session, not a practical problem. But a benchmark will expose it.

**Mitigation**:
- Accept it for v1. Document in README "future work" as "tombstone GC."
- If benchmarks show a problem: cap demo session length, restart demo process between presentations.
- Don't design a GC protocol in scope - distributed GC requires all replicas to agree a node is unreachable, which is a separate paper-worthy contribution.

---

## 2. RGA: off-by-one in insert position

**Symptom**: Characters inserted at wrong position. Text looks jumbled after remote op arrives.

**Why**: `visible_nodes()` returns only non-deleted nodes, but `nodes` includes tombstones. Converting a user cursor position (index into visible text) to an `after` node id must account for tombstones.

**Correct**: cursor position `p` in visible text -> node id of `visible_nodes()[p - 1]` (or `None` for head).

**Wrong**: cursor position `p` in `nodes` (the raw list, including tombstones).

**Mitigation**:
- Always work with `visible_nodes()` for user-facing position math.
- Test: insert at position 1, delete position 0, insert at position 0 again - check result.
- Add an assertion: `assert!(insert_pos <= rga.nodes.len())` in `apply_op`.

---

## 4. Gossip storm

**Symptom**: Log fills with gossip messages. CPU spikes on all nodes. Each message triggers more messages.

**Why**: If OpBroadcast is re-broadcast when received (fanout to all peers including sender), and all peers do the same, op count grows exponentially with network size.

**Mitigation**:
- Track `seen: HashSet<(ReplicaId, u64)>` per node. Skip already-seen ops.
- Only send to peers who have not yet acknowledged the op (use version vectors).
- StateSync is periodic (2000ms timer), not triggered by receiving StateSync.
- Test with 3+ nodes: confirm op count in logs is O(nodes), not O(nodes^2).

---

## 5. Vector clock: missing-entry default

**Symptom**: `happens_before` returns wrong result. Causality check fails spuriously.

**Why**: When comparing two vector clocks, a missing entry for replica `r` must be treated as 0 (replica `r` has not been seen). If missing entries are treated as infinity or cause a key error, comparison is wrong.

**Correct**: `vc.get(r).unwrap_or(0)` in all comparisons.

**Mitigation**:
- Implement `VectorClock` as `HashMap<ReplicaId, u64>` with a `get_or_default` wrapper.
- Test: compare a clock with entry `{A: 1}` against a clock with entry `{A: 1, B: 2}`. Result: `B:2 happens_after A:1`, not concurrent.

---

## 6. iroh API churn

**Symptom**: `cargo build` fails with `no method found for...` or trait mismatch after pulling iroh update.

**Why**: iroh is pre-1.0. API changes between minor versions are common. The iroh-gossip API in particular changed significantly between 0.20 and 0.21.

**Mitigation**:
- Pin iroh to a specific version in `Cargo.toml`. Don't use `^` or `*` version constraints for iroh.
- Check go/no-go by 2026-05-14. If API is broken: activate TCP fallback (pre-designed, see `ARCHITECTURE.md`).
- `cargo update --precise <version>` to rollback if a transitive update breaks things.

---

## 7. bincode 2.x vs 1.x API mismatch

**Symptom**: `serialize` / `deserialize` not found. Compile error mentioning `Encode` / `Decode`.

**Why**: bincode 2.x has a completely different API from 1.x. The `serde` integration is also different (you need both `serde::Serialize` and `bincode::Encode` or use the `serde` feature of bincode 2).

**Mitigation**:
- Use `bincode::encode_to_vec(val, bincode::config::standard())` and `bincode::decode_from_slice(bytes, bincode::config::standard())`.
- Derive `bincode::Encode` and `bincode::Decode` (not just serde) on wire types.
- If it's confusing: add a single `wire.rs` test that round-trips a `Msg::Hello` value.

---

## 8. Lamport clock tie-break in RGA

**Symptom**: Two nodes produce different text after applying the same concurrent inserts in different order.

**Why**: If the tie-break on concurrent inserts is not consistent, two replicas resolve `(lamport, replica_id)` conflicts differently.

**Correct**: Sort concurrent inserts at same position by `(lamport DESC, replica_id DESC)`. Higher clock value wins; same clock -> higher replica_id wins. Must be identical at every replica.

**Mitigation**:
- The tie-break is in `apply_op(Insert)` - the `while` loop that advances `insert_pos`.
- proptest convergence test: two replicas apply same 5 ops in shuffled order, check `text()` matches.
- Double-check `ReplicaId` ordering is total (UUID v7 bytes have a natural total order).

---

## 9. Causal buffer deadlock

**Symptom**: Ops never applied. Causal buffer grows unboundedly. Demo stops updating.

**Why**: An op is buffered waiting for its causal predecessor. If the predecessor op was dropped (never delivered), the buffered op waits forever.

**Mitigation**:
- Log buffer size periodically. Alert if it grows above threshold.
- StateSync is the backstop: periodic full state merge will converge state even if individual ops are lost.
- For the demo: if the buffer is stuck, restarting the node causes a `Hello` exchange + StateSync which re-syncs state.

---

## 10. proptest: flaky CI due to random seeds

**Symptom**: Test passes locally but fails in CI (or vice versa). Rare failure mode that's hard to reproduce.

**Why**: proptest uses random seeds. By default, failing test seeds are persisted in `.proptest-regressions/`. If this file is gitignored, CI doesn't replay the seed that found the bug.

**Mitigation**:
- Commit `.proptest-regressions/` to git. Add to `prosjekt/.gitignore` only test artifacts, not regression seeds.
- If CI fails on a seed: copy the failing seed from CI output, run locally with `PROPTEST_CASES=1 PROPTEST_SEED=<seed>`.
- Separate fast (256 case) and thorough (1024 case) proptest runs. Fast run in pre-commit, thorough in CI.

---

## 12. RGA: wrong container type breaks convergence

**Symptom**: Two replicas apply the same ops in different orders and produce different text. Convergence test fails sporadically.

**Why**: RGA must maintain document order (visual order), not sort order. `HashMap<NodeId, Node>` has non-deterministic iteration, which breaks the tiebreaker loop. `BTreeMap<NodeId, Node>` iterates in `NodeId` sort order - that is Lamport-sorted, not insertion-position order - so `text()` would output characters sorted by clock, not by where they were inserted.

**Correct**: Use `Vec<Node>`. `Vec` preserves insertion position explicitly. The `apply(Insert)` tiebreak loop advances `insert_pos` while `nodes[insert_pos].id > id` - this works because Vec iteration is positional. See `rga/src/rga.rs` for the reference implementation.

**Mitigation**: Grep for `HashMap<NodeId` or `BTreeMap<NodeId` in the `rga` crate before and after any refactor. Add a proptest that applies the same ops in two orders and checks `text()` matches.

---

## 13. proptest: shrinking hangs on complex types

**Symptom**: proptest finds a failing case, then hangs for 10+ minutes trying to shrink it. CI times out.

**Why**: proptest's default shrinker recursively tries smaller inputs. For complex nested types (RGA state with many nodes, OR-Set with large causal context), the shrink tree is enormous.

**Mitigation**: Set `max_shrink_iters = 100` on tests for complex types:

```rust
proptest!(ProptestConfig { max_shrink_iters: 100, ..Default::default() }, |(s in any::<Rga>())| {
    // ...
});
```

For small RGA states, the default is fine.

---

## 14. Tokio task cancellation: state written but not persisted

**Symptom**: State is in memory, but the snapshot on disk is from an earlier point. After restart, ops are lost.

**Why**: If the Tokio runtime shuts down while a snapshot `spawn`ed task is in flight, the task is dropped at the next `.await` point. The atomic rename never happens. The on-disk state is the previous snapshot.

**Mitigation**:
- Use `tokio::task::spawn` (not `tokio::task::spawn_blocking`) for the snapshot write. It will complete before the runtime shuts down if shutdown is initiated with `runtime.shutdown_timeout(Duration::from_secs(2))`.
- On SIGINT / SIGTERM, do a final synchronous flush before exiting: `tokio::fs::write(path_tmp, state_bytes).await?; tokio::fs::rename(path_tmp, path).await?;`
- Test: send SIGTERM to a running node after 5 ops. Restart. Check the reloaded state has all 5 ops.

---

## 13. Trait freeze or wire freeze violated mid-sprint

**Symptom**: A PR adds a new field to `CvRDT` or a new `Msg` variant. Other open PRs fail to compile because their local branch doesn't have the change yet. Merge conflicts pile up.

**Why**: `crdt-core/src/traits.rs` and `crdt-net/src/wire.rs` are shared contracts. Every crate in the workspace depends on them. Changing them after freeze breaks in-flight work in other streams.

**Mitigation**:
- Trait freeze: no changes to `CmRdt` after `rga/src/traits.rs` is merged. If a change is truly necessary, post in the group channel, get explicit agreement from all three, and update any dependent code in the same PR.
- Wire freeze: new `Msg` variants after `net/src/wire.rs` is merged require bumping `protocol_version` in `Hello`. All nodes must be restarted after a wire-breaking change.
- Before opening a PR that touches either file: grep for all `impl CmRdt` and all `Msg::` match arms. List them in the PR description. Reviewer must confirm all are updated.
- If a freeze violation is discovered mid-sprint: fix forward (update all dependents in a single PR). Do not rebase open branches onto a broken state.

## 11. ratatui: panic on terminal resize

**Symptom**: Demo crashes with "ResizeEvent" panic or "width is 0" assertion.

**Why**: ratatui needs to handle `Event::Resize(w, h)` explicitly. If the terminal is resized and the handler is not registered, the frame dimensions become inconsistent.

**Mitigation**:
- Handle `Event::Resize(_, _)` in the main event loop: call `terminal.draw(|f| render(f, &state))` again.
- Clamp all layout widths to minimum 1.
- Test: resize terminal window during demo before presentation.
