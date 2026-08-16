# Related work

Post-2020 literature survey. Each entry explains what the system does, why it is relevant to our project, and why we chose differently.

---

## Foundational (pre-2020, still load-bearing)

### Shapiro et al. (2011) - CvRDT/CmRDT taxonomy

Shapiro, M., Preguica, N., Baquero, C., & Zawirski, M. (2011). *A comprehensive study of convergent and commutative replicated data types* (RR-7506). INRIA.

The original CRDT paper. Defines the CvRDT/CmRDT split, strong eventual consistency (SEC), and provides reference designs for G-Counter, PN-Counter, OR-Set, 2P-Set, MV-Register, and RGA. Our RGA follows the op-based CmRDT design from this paper.

### Almeida et al. (2018) - Delta-state CRDTs

Almeida, P.S., Shoker, A., & Baquero, C. (2018). Delta state replicated data types. *Journal of Parallel and Distributed Computing*, 111, 162-173. https://doi.org/10.1016/j.jpdc.2017.08.003

Extends CvRDTs with delta propagation: instead of sending full state on every tick, a node sends only the "delta" (the part of state that changed since the peer's last known version). We implement full-state sync for v1; delta techniques are noted as future work for reducing anti-entropy bandwidth.

### Roh et al. (2011) - RGA

Roh, H.-G., Jeon, M., Kim, J.-S., & Lee, J. (2011). Replicated abstract data types: Building blocks for collaborative applications. *Journal of Parallel and Distributed Computing*, 71(3), 354-368. https://doi.org/10.1016/j.jpdc.2010.12.006

Introduces the Replicated Growable Array (RGA), our sequence CRDT. The key ideas are: unique identifiers on nodes, insert-after semantics, and total order on concurrent inserts via Lamport clock + tie-breaking. We implement this as-is.

---

## Post-2020 systems

### Automerge 2.0 (2023)

Goodwin, A., Kleppmann, M., & others. (2023). *Automerge: a JSON CRDT library*. GitHub. https://github.com/automerge/automerge

Automerge is a production-grade Rust/Wasm library for JSON CRDTs. v2 (2022-2023) introduced a columnar binary encoding that is 10-100x smaller than v1 and orders of magnitude faster to merge. It uses a YATA-inspired sequence algorithm (similar to RGA) and supports nested JSON documents.

Why not Automerge: (1) course rule bans external CRDT crates; (2) full JSON document CRDT is out of scope - we need a text buffer, not a document store; (3) Automerge's columnar encoding is impressive engineering but harder to explain at an oral defense than the straightforward RGA node list.

What we take from it: the idea of explaining tombstone accumulation as a known limitation and listing GC as future work (same framing Automerge uses).

### Diamond Types (2023)

Gentle, J. (2023). *Diamond types: A high-performance CRDT collaborative editing engine*. GitHub. https://github.com/josephg/diamond-types

A Rust sequence CRDT optimized for text editing. Uses a variant of the YATA algorithm with run-length encoding for compactness. Faster than Automerge in benchmarks (2-5x on large documents). Open-sourced in 2022 with the paper explaining the run-length encoded internal representation.

Why not Diamond Types: same course-rule block. Also: YATA and RGA produce equivalent results for text; RGA is more widely cited and easier to present formally. Diamond Types' run-length encoding is clever but adds implementation complexity without proportional grade benefit.

### Fugue / FugueMax (2023)

Weidner, M., & Kleppmann, M. (2023). *The art of the fugue: Minimizing interleaving in collaborative text editing* (arXiv:2305.00583). arXiv. https://arxiv.org/abs/2305.00583

Fugue is a new sequence CRDT (2023) that improves on RGA and YATA by eliminating "interleaving" - a class of convergence anomaly where concurrent insertions produce garbled output even though each individual insertion is valid. FugueMax is the maximal variant that provably avoids all interleaving.

Why not Fugue: published May 2023, very recent. Formal proofs are available but the implementation is more complex than RGA for similar user-visible behavior on short documents. Our demo does not operate at the document sizes where RGA interleaving becomes a practical problem. We note Fugue in the oral defense as "the current state of the art for sequence CRDTs."

### Loro (2024)

Chen, Z., & Ding, L. (2024). *Loro: A collaborative CRDT framework*. GitHub. https://github.com/loro-dev/loro

Loro is a Rust CRDT framework supporting rich text, movable lists, and tree structures. Uses a "contiguous" variant of RGA (similar to Diamond Types) plus a Columnar encoding. Focuses on real-time collaborative apps.

Why not Loro: course-rule block. Also notably complex; their movable tree alone is a separate paper-worthy contribution.

### Eg-walker (EuroSys 2025)

Gentle, J., & Kleppmann, M. (2025). Eg-walker: Better snapshots for CRDTs. In *Proceedings of EuroSys 2025*.

Eg-walker reframes the snapshot problem: instead of storing a full CRDT state, it stores "event graphs" (a DAG of edits) and computes the current state by replaying from the event graph. This compresses storage significantly for immutable history. Relevant to our disk journalling decision.

Why not Eg-walker: event graph approach trades computation at load time for storage savings. For a 14-day PoC with small documents, the tradeoff is not relevant. We journal full CRDT state snapshots instead.

### Kleppmann move-tree (2021)

Kleppmann, M. (2021). *A highly-available move operation for replicated trees* (arXiv:2103.04828). arXiv. https://arxiv.org/abs/2103.04828

Proposes a CRDT for tree structures where nodes can be moved (re-parented). The key challenge: concurrent moves can create cycles. The paper solves this with an undo/redo log. Relevant as a stretch goal for our project.

Why stretch, not core: the move-tree CRDT requires a more complex undo machinery than insert/delete. In 14 days with three people, RGA is the right sequence CRDT to ship and defend. The move-tree is listed as "future work: hierarchical document structure."

---

## Summary table

| System | Algorithm | Status relative to us |
|--------|-----------|----------------------|
| Shapiro et al. 2011 | CvRDT/CmRDT taxonomy, OR-Set, RGA | Foundation - RGA is the CRDT we implement |
| Almeida et al. 2018 | Delta-state, dot-context | Noted as future work for anti-entropy optimization |
| Roh et al. 2011 | RGA | We implement this directly |
| Automerge 2.0 (2023) | JSON CRDT, columnar encoding | Banned + out of scope |
| Diamond Types (2023) | YATA + run-length | Banned; similar to RGA |
| Fugue/FugueMax (2023) | Interleaving-free sequence | State of the art; too new to implement in scope |
| Loro (2024) | Rich-text + tree CRDT | Banned + out of scope |
| Eg-walker (EuroSys 2025) | Event-graph snapshots | Future: better disk journalling |
| Kleppmann move-tree (2021) | Cycle-free tree moves | Stretch goal |
