# Decision log

Append an entry here before the code lands. Format:

```
### YYYY-MM-DD - <topic>
**Author**: <Tri | Yazan | Shakti | group>
**Decision**: one sentence.
**Why**: constraints, tradeoffs, alternatives rejected.
**Revisit if**: signal that would change this call.
```

---

### 2026-05-12 - Language: Rust

**Author**: group (Tri initiated)
**Decision**: Use Rust 2024 edition for all crates.
**Why**: Course brief notes C++/Rust may give positive grade impact. Rust's ownership model prevents data races in the concurrent gossip layer, which matters for correctness at the oral defense. Strong ecosystem for async (`tokio`), serialisation (`serde`/`bincode`), and TUI (`ratatui`). Team has enough Rust exposure from prior coursework.
**Revisit if**: A team member cannot contribute due to Rust learning curve by 2026-05-14. Fallback: Go (loses grade bump, gains team velocity).

---

### 2026-05-12 - Serialisation: bincode 2.x

**Author**: Tri
**Decision**: Wire format uses `serde` + `bincode` 2.x. `serde_json` used only for debug dumps and the persistent state file.
**Why**: bincode is compact and deterministic - no schema versioning overhead for a course project. Version 2.x has a cleaner API than 1.x (`Encode`/`Decode` derive macros). JSON is human-readable but ~5x larger; fine for the on-disk state file (read at startup, not on hot path).
**Revisit if**: We need to interop with a non-Rust client (unlikely given scope).

---

### 2026-05-12 - Vector clock from scratch

**Author**: Tri
**Decision**: Implement `LamportClock` and `VectorClock` from scratch; do not import a clock crate.
**Why**: Vector clocks are explicit course content in IDATT2104. Using an external crate here would look like avoiding the hard part. The implementation is small (< 100 lines) and is a strong oral defense point.
**Revisit if**: Never. This is a deliberate show-your-work choice.

---

### 2026-05-12 - Testing strategy: proptest

**Author**: Yazan (owns CRDT primitives)
**Decision**: CRDT laws verified with `proptest` property-based testing. Min 256 cases in fast run, 1024 in CI (`-- --ignored` flag). No hardcoded test cases for lattice laws.
**Why**: Property tests generate random states and prove laws hold for arbitrary inputs. This is a stronger guarantee than example-based tests and is the standard approach in CRDT verification literature.
**Revisit if**: proptest runtime becomes a CI bottleneck (> 2 min). Mitigation: reduce default case count, keep high count behind `--ignored`.

---

### 2026-05-12 - CI pipeline

**Author**: Tri
**Decision**: GitHub Actions CI runs: `cargo fmt --check`, `cargo clippy -- -D warnings`, `cargo test --workspace`, `cargo audit`, `cargo tarpaulin` (coverage -> CodeCov), `cargo doc` (-> gh-pages).
**Why**: clippy `-D warnings` makes lint regressions fail the build. `cargo audit` catches known CVEs. Coverage on CodeCov makes the "tests" section of the README credible. Rustdoc on gh-pages satisfies the "API docs link" requirement in the brief.
**Revisit if**: tarpaulin is flaky on GitHub Actions (known issue with proc-macros). Fallback: llvm-cov via `cargo-llvm-cov`.

---

### 2026-05-12 - No TLS/auth (v1)

**Author**: group
**Decision**: No encryption or authentication in the gossip layer. Nodes are assumed trusted.
**Why**: Adding TLS and peer authentication would cost 3-4 days of the 14-day budget. The demo runs on loopback or a LAN. The threat model is stated in `ARCHITECTURE.md` and listed as future work.
**Revisit if**: Never for v1.

---

### 2026-05-12 - Anti-entropy: version-vector-only (SHA-256 dropped)

**Author**: group (Shakti raised, Tri conceded)
**Decision**: Anti-entropy uses version vector comparison only. No SHA-256 digest.
**Why**: Version vectors are small (N replicas * 8 bytes - at most 24 bytes for 3 nodes). SHA-256 computation requires hashing full CRDT state on every anti-entropy tick, which costs more CPU than the bandwidth it saves on a LAN. Simpler, fewer bugs.
**Revisit if**: Anti-entropy traffic becomes a measurable bottleneck. Not realistic for a 3-node demo.

---

### 2026-05-12 - TCP transport (iroh deferred)

**Author**: Tri
**Decision**: Transport is tokio TCP with 4-byte big-endian length prefix + bincode. iroh/QUIC deferred to stretch.
**Why**: TCP is simpler to debug and the demo runs on a LAN. iroh adds NAT traversal but is complex enough to risk blocking net development. The wire abstraction in `net/src/peer.rs` is designed so the transport can be swapped without touching gossip or anti-entropy.
**Revisit if**: Demo needs to work between machines on different networks (then swap to iroh).

---

### 2026-05-12 - Error handling crates: anyhow + thiserror

**Author**: Tri
**Decision**: Use `thiserror` for library error types in `rga` and `net`, `anyhow` for `tui`. No `unwrap()` in library code.
**Why**: `thiserror` generates typed errors at library boundaries so callers can match on variants. `anyhow` is ergonomic for binary-level propagation. Standard Rust idiom for this crate boundary pattern.
**Revisit if**: Never.

---

### 2026-05-12 - All-hands parallel work from t0

**Author**: group (Shakti raised, group agreed)
**Decision**: All three owners work in parallel from the moment `.impl-unlocked` is created. Each person has an ordered task list they self-pace.
**Why**: Day-based schedules impose artificial blocking. With three engineers of different availability patterns, task-list mode is more resilient. Real ordering dependencies are condition-based code gates (trait freeze, wire freeze, convergence green), not date-based.
**Revisit if**: A task list becomes blocked for more than 24 hours. Escalate in group channel, pick up unblocked tasks from another list.

---

### 2026-05-13 - Scope cut: RGA only, no PN-Counter or OR-Set

**Author**: group
**Decision**: Implement RGA as the sole CRDT. Drop PN-Counter and OR-Set from scope.
**Why**: One CRDT done excellently (with causal buffer, anti-entropy, proptest convergence, working demo) scores higher than three done partially. RGA alone demonstrates the full design space the course cares about: op-based CRDT, causal ordering, distributed clocks, convergence proof. PN-Counter and OR-Set are kept in docs as reference but not implemented.
**Revisit if**: Never. Scope is locked.

---

### 2026-05-13 - Crate names: rga / net / tui

**Author**: group (Tri proposed, group ratified)
**Decision**: Three crates named `rga`, `net`, `tui`. Not the earlier `crdt-core` / `crdt-net` / `crdt-demo` names.
**Why**: Short names match the crate's actual content. `rga` is only RGA logic. `net` is only networking. `tui` is only the terminal interface. `crdt-demo` implied a demo binary that could contain multiple CRDTs; `tui` is more accurate now.
**Revisit if**: Never. Crate names are in Cargo.toml and locked.

---

### 2026-05-13 - Ownership: Tri=net, Yazan=rga, Shakti=tui

**Author**: group
**Decision**: Tri owns `crates/net`, Yazan owns `crates/rga`, Shakti owns `crates/tui`.
**Why**: Align RGA (hardest CRDT, causal semantics, tombstone logic) with Yazan who has strongest CRDT background. Networking with Tri (strongest async/systems background). TUI with Shakti. Each person defends what they coded (Q1-Q12 / Q13-Q22 / Q23-Q35).
**Revisit if**: Owner becomes blocked for > 24h. In that case, unblocked tasks from the other lists are fair game.

---

### 2026-05-13 - CD: release binary workflow on tag push

**Author**: Tri
**Decision**: Add `cd.yml` GitHub Actions workflow triggered on `v*` tags. Matrix build for Linux/macOS/Windows, artifacts to GitHub Release.
**Why**: Examiner can download a pre-built binary without installing Rust. Demonstrates real delivery pipeline. Binary name is `tui` (matches crate name).
**Revisit if**: Never. One-time setup, permanent benefit for submission.

---

### 2026-05-13 - CI: two-workflow design (ci.yml + cd.yml)

**Author**: Tri
**Decision**: CI is two files: `ci.yml` (push/PR) and `cd.yml` (tag push, matrix build + release). No reusable `workflow_call` workflows.
**Why**: Three engineers, 14-day project, one repo. Two flat files are readable, debuggable, and complete.
**Revisit if**: Never for v1.
