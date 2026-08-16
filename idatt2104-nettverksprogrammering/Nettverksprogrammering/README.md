---
type: project-root
project: idatt2104
created: 2026-05-04
modified: 2026-05-04
tags: [ntnu, course, networking]
---

# IDATT2104 Network Programming

User-facing root for course material + personal notes. Everything for the course stays in this one tree: lecture notes at the root, voluntary project under `prosjekt/`, materials under `materials/`.

Code repos live on disk, not in vault: `~/Desktop/ntnu/IDATT2104-Nettverksprogrammering/`. Vault holds notes, materials, decisions, write-ups only.

Agent rules live in `claude/agents/{ntnu,idatt2104}.md`. Both trees RAG-indexed by `~/.claude/rag/index_vault.py`.

## Layout

- `1 ... 10 ....md` at the root - lecture notes, one file per session, Norwegian titles.
- `materials/` - lecturer slides (PDF + sibling `.md` for RAG).
- `examples/` - lecturer code drops (coroutines, tcp, udp-tls).
- `prosjekt/` - voluntary group project: scope, architecture, decisions, theory, dev log, demo plan, presentation. Code lives in the disk repo, not here.
- `notes/study/` - exam-prep notes. Datakom exam done; kept for re-sit reference.

## Course state

- **Datakom**: written exam done.
- **Nettverksprogrammering**:
  - P1-P6: mandatory exercises **done + lab-approved**.
  - Voluntary project: **only remaining work**. 30-40h/student, max 3 in group → team budget 90-120h with Yazan + Shakti.
- Final portfolio submission: 2026-05-26 14:00 (Inspera).

## Materials index

| File | Topic |
|---|---|
| `materials/01-threads.pdf` | Threads (Rust/C++ examples) |
| `materials/02-worker-threads-atomic.pdf` | Worker threads + atomic |
| `materials/05-websocket.pdf` | WebSocket protocol |
| `materials/06-atomic-parallel-processes.pdf` | Atomic types, parallelisation, processes |
| `materials/07-virtualization-sandboxing.pdf` | Virtualisation + sandboxing |
| `examples/04-coroutines/` | Coroutines: await/generator (C++/JS/Rust) |
| `examples/05a-tcp/` | TCP examples (c++/python/rust/javascript) |
| `examples/05b-udp-tls/` | UDP + TLS (CMakeLists, tls.cpp, udp.cpp) |

Lectures 3 + 4 PDF missing from drop. Lecture 4 = coroutines (covered by examples/04). Add slides if later distributed.

## Note-taking workflow

- **Lecture**: numbered file at the tree root, one per session. Wiki-link to `materials/<lecture>.md` for context.
- **Project**: everything under `prosjekt/`.
- **Study**: `notes/study/<topic>.md` - synthesis notes drawn from materials + lecture notes.
- Decision log stays in `prosjekt/decisions.md` (table form, exam + defense fuel).
