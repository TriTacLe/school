---
type: review
project: idatt2104
created: 2026-05-04
modified: 2026-05-04
tags: [ntnu, idatt2104, reference]
---

# Past IDATT2104 voluntary projects — review

Cloned to `~/Desktop/ntnu/IDATT2104-Nettverksprogrammering/references/` inside the course repo. Gitignored — read-only reference, not own work. Inspect with file browser or `cd` for code reading. Not RAG-indexed (binary noise + size).

**Grades unknown.** GitHub doesn't publish grades. Quality signals below are inferred from scope, polish, README depth, CI/test presence, commit history. None of this is "what got an A" — it's "what looked solid."

## Top-tier scope (worth studying)

### `stun-eirsteir/` — STUN server + P2P client + signaling server
- **Team of 3** (Eirik Steira, Stian Mogen, Nicolay Schiøll Johansen) — same shape as Tri/Yazan/Shakti
- **Java + React/TS frontend**. Server in Java, p2p-client in React, signaling server separate
- **Aligned with RFC 5389**: parses STUN message header, MAPPED-ADDRESS + XOR-MAPPED-ADDRESS attributes, Binding Request/Response over UDP ports 3478/3479
- **CI/CD wired**: Azure Pipelines + Maven CI + GitHub Actions for the React client. Deployed.
- **Honest scope notes in README**: "We were not supposed to create a complete implementation". They picked subset, documented what was deferred. Lecturer-friendly framing.

**What's good:**
- RFC-anchored protocol work — exactly what lecturer rewards (low-level + standards-compliant)
- Three-server topology (STUN + signaling + client) shows distributed-systems thinking
- README explains *why* attributes were/weren't implemented — defense-ready

**What to copy:**
- Anchor any protocol project to an RFC, cite section numbers
- Split server roles into separate processes/repos within one umbrella
- README structure: Introduction → Implemented Functionality → Sections per RFC concern
- Bake CI from day 1 (their `.github/workflows/` proves it ran every commit)

### `onion-trthingnes/` — Tor-lite (single-author)
- **Solo project** (Tobias Thingnes), Kotlin, 34 .kt files
- **Two-part architecture**: SOCKS proxy + onion router. Either runnable independently. `ONION_ENABLED` flag in `Config.kt` toggles routing.
- **Test + lint workflow** in CI. JUnit + Ktlint. Dokka for javadoc.
- **README emphasis**: "implement functionality not already available in Java API myself, to learn as much as possible" — examiner-pleasing rationale
- **Demo-ready**: works with Firefox SOCKS5, curl example provided. Real protocols, not toy

**What's good:**
- Tight scope (2 weeks stated), but quality bar high
- Clean package layout: `socks/handshake/`, `socks/request/`, `onion/stream/`, `util/`
- Configurable demo path makes oral defense easy: flip flag, show traffic with/without onion

**What to copy:**
- One-flag demo toggle for live oral defense
- Existing-tool integration (SOCKS5 → Firefox/curl) instead of bespoke client. Saves frontend cost.
- Stated learning goal in README ("implement X myself") justifies scope vs reusing libraries

## Mid-tier (mandatory exercise archives, useful for P1-P6 reference)

### `archive-olakrhoff/` — full Spring 2021 archive
- 6 obligs (Oblig 1-6) + Datakommunikasjon notes + STUN-server prosjekt
- Norwegian-named dirs match historical course structure
- **Use as P1-P6 reference**: if your P-exercise spec is unclear, peek at how prior cohort interpreted it

### `archive-holybarrel/` — 6 obligs + Optional1.5
- C++/Java/Kotlin/HTML/JS/Dockerfile mix — confirms course allows lang freedom per oblig
- Has `Optional1.5/` — implies graded extra-credit existed mid-semester

### `archive-eposkk/` — minimal 6-oblig archive
- Only obligs, no voluntary. Useful for "what does a pure mandatory submission look like."

## Patterns across all five

1. **Lang freedom per deliverable**: Java, Kotlin, C++, JS all appeared. Pick per exercise.
2. **No glossy frontends**: STUN P2P React client is the exception. Most work is CLI/server.
3. **RFC anchoring wins**: STUN team explicitly cites RFC 5389. Lecturer cohort favors this.
4. **README depth ≈ project quality**: archive repos have one-line READMEs (just dumps). STUN + onion have multi-section READMEs (defense-ready).
5. **CI is signal**: serious projects have GitHub Actions + lint + tests. Archives don't.

## Implications for your voluntary project

- **Don't reimplement STUN/onion verbatim** — done well, lecturer has seen it
- **Differentiation paths**:
  - STUN+TURN+ICE chain (full NAT traversal stack, not just STUN binding)
  - QUIC-based P2P (UDP + TLS 1.3 + multiplexed streams in one)
  - Onion with post-quantum handshake (Kyber/Dilithium) — cutting-edge angle
  - Reliable UDP (custom ARQ + framing) — uncovered in the 5 archives I cloned
  - TLS-aware HTTP/1.1 reverse proxy — also uncovered, smaller scope, defense-clean
- **Anchor to an RFC** for whatever you pick — STUN 5389, QUIC 9000, TLS 8446, SOCKS 1928
- **CI day 1**: copy stun-eirsteir's GitHub Actions setup
- **One-flag demo toggle**: copy onion's `ONION_ENABLED` pattern for live defense
