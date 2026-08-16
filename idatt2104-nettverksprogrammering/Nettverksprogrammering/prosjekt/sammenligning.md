---
tags: [idatt2104, crdt, sammenligning, spring-2026]
created: 2026-05-15
modified: 2026-05-25
---
Intern referanse. Kildeverifisert mot faktisk kildekode (ikke bare filtrær) på nyeste branch, mai 2026.
Ikke ment for presentasjonen direkte. Se `presentasjon.md` seksjon 5 for den anonyme videoversjonen.
## Fullstendig tabell (9 løsninger)

|                     | oss                   | kappern04                             | AlexElton        | ingvearnes        | Segward                  | LiamLande           | PirVis12              | dmtrang13           | edvargh    |
| ------------------- | --------------------- | ------------------------------------- | ---------------- | ----------------- | ------------------------ | ------------------- | --------------------- | ------------------- | ---------- |
| **Språk**           | Rust                  | Rust                                  | Rust+TS          | Rust              | C++                      | Rust                | Rust                  | C++/JS              | Java       |
| **Arkitektur**      | P2P full mesh         | P2P (TCP peers)                       | Sentral server   | P2P               | Sentral server           | Sentral server      | Sentral WS            | Sentral + Postgres  | Sentral WS |
| **Transport**       | Raw TCP + bincode     | JSON-Lines TCP (peers) + WS (browser) | WS + JSON (Axum) | Raw TCP + bincode | WS + JSON                | Sync threads + JSON | WS + JSON             | WS + JSON (Node.js) | WS         |
| **CRDT-type**       | RGA + LWW + OR-Set    | RGA                                   | RGA (tre-basert) | RGA               | text_rga (C++)           | PN-Counter + OR-Set | G/PN-Counter + OR-Set | RGA (C++)           | OR-Set     |
| **Sekvens-CRDT**    | **ja**                | **ja**                                | **ja**           | **ja**            | **ja**                   | nei                 | nei                   | **ja**              | nei        |
| **VV anti-entropi** | **ja**                | nei (full replay)                     | nei              | nei               | nei                      | primitiv            | nei                   | nei                 | nei        |
| **Kausal buffer**   | **ja (per-peer seq)** | nei (MissingAnchor retry)             | nei              | nei               | **ja (pending_changes)** | nei                 | nei                   | nei                 | nei        |
| **Persistens**      | **ja (atomisk)**      | **ja (JSON-Lines, ikke atomisk)**     | nei              | nei               | nei                      | nei                 | nei                   | **ja (Postgres)**   | nei        |
| **mDNS**            | **ja**                | nei                                   | nei              | nei               | nei                      | nei                 | nei                   | nei                 | nei        |
| **Async**           | **ja (tokio M:N)**    | **ja (tokio)**                        | **ja (tokio)**   | **ja (tokio)**    | nei (blocking)           | nei (std::thread)   | **ja (tokio)**        | nei                 | nei        |
## Analyse per løsning

### kappern04 (Rust, P2P TCP)

Nærmeste konkurrent. Har RGA (Vec-basert, korrekt tiebreaking). P2P TCP for peers (ws.rs er kun browser-bro, ikke peer-transport — tidligere feilidentifisert fra filtrær). JSON-Lines over TCP (ikke bincode): tekstbasert, overhead vs vår bincode. Sync: sender ALLE ops ved reconnect (bulk catch-up, ingen versjonsvektorberegning). `seq`-feltet er kun observability — mottakeren bruker det aldri til deduplicering eller kausal bestilling. `MissingAnchor` returneres ved manglende anker men ingen strukturert per-peer sekvenskø. Persistens: append-only JSON-Lines, flush() per op, ingen fsync, ingen atomisk rename — krasj ved OS-buffertflush kan tape siste op.

**Vs oss:** Lik P2P-arkitektur. Men JSON vs bincode, ingen VV delta (full replay = trafikkintensiv), ingen per-peer kausal buffer, ingen crash-safe persistens.

### AlexElton (Rust + TypeScript, sentral Axum server)

Sterkest CRDT-implementasjon av alle. RGA er tre-basert med DFS-traversal, korrekt sibling-ordering via `precedes()`, tombstones + `clear_tombstones()`. Har presence-tracking og garbage collection. Imponerende kodebase.

Arkitektur: sentral Axum WebSocket-server (single point of failure). Alle klienter kobler til én server som relayer ops. Klienter snakker ikke med hverandre direkte. Server ned = sync stopper. Transport: WebSocket + JSON (serde_json). React/TS nettleserklient.

**Vs oss:** Sterkere RGA og bedre UI. Men SPOF-arkitektur, WebSocket + JSON overhead, ingen P2P, ingen anti-entropi, ingen persistens.

### ingvearnes (Rust, P2P)

Veldig lik oss i transport: raw TCP + 4-byte length prefix + bincode. P2P peer-arkitektur med session/protocol-lag. Vec-basert RGA med korrekt kausal tiebreaking.

Mangler (synlig fra kode): ingen VV anti-entropi, ingen versjonsvektorer, ingen persistens, ingen mDNS, ingen multi-doc, ingen presence.

**Vs oss:** Nesten identisk transportlag. Men ingen recovery-mekanisme (noder offline divergerer permanent), ingen persistens, smalere scope.
### Segward (C++, sentral server)

C++ text_rga med `_pending_changes`-buffer og `retry_pending_changes()` — håndterer out-of-order ops via retry (ikke strukturert per-peer sekvenskø, men effekten er lik for enkel topologi). Sibling-sortering via leksikografisk string-ID. Sentral server + websocket + JSON.

**Vs oss:** Har kausal retry-mekanisme. Men C++ = undefined behavior i concurrent merge (ingen Rust compile-time garantier). Sentral SPOF. Ingen persistens, ingen anti-entropi.

### LiamLande (Rust, sentral TCP server)

Counters + sets (PN-Counter, OR-Set, LWW) for betting-domene — ikke tekstredigering. Interessant: `missing_for(&seen_operations)` i sync-serveren beregner hvilke ops som mangler og sender kun dem. Primitiv form for delta-sync basert på mottatt op-ID-liste (ikke versjonsvektorer). Men: sentral server, synkron `std::thread` per klient (blocking I/O), ingen async.

**Vs oss:** Primitiv delta-sync finnes, men counters/sets (ikke sekvens-CRDT), sentral SPOF, blokkerende tråder.

### PirVis12 (Rust, sentral WebSocket)

State-based CvRDT (ikke op-based). Serveren er eksplisitt "dumb": tar imot `SyncState`, merger via `CvRDT::merge`, broadcaster. Klienter sender hele tilstanden hvert kall — ingen delta-beregning. Counters og sets, ingen sekvens-CRDT.

**Vs oss:** State-based vs op-based (vi sender bare delta-ops), sentral SPOF, ingen sekvens-CRDT.

### dmtrang13 (C++/WASM, Node.js, Postgres)

C++ RgaText med LamportClock og `insert_after` kompilert til WASM. Node.js WebSocket backend + Postgres + autentisering + dokumentdeling. Bred produktfokus.

C++ UB-risiko. Sentral server+DB = SPOF + ekstern avhengighet. Ingen P2P.

**Vs oss:** Mer produkt-funksjoner (auth, sharing, Postgres). Oss: korrekt under nettverksfeil, P2P, ingen SPOF, ingen ekstern infrastruktur.

### edvargh (Java, sentral WebSocket)

OR-Set for todo-liste (ikke tekst). Java WebSocket-server (ToDoWebSocketServer.java) + JavaFX UI. GC-pauser er et problem for latens-sensitiv synkronisering. Annet domene.

**Vs oss:** Annet domene (todo vs tekst), ingen sekvens-CRDT, GC-pauser, sentral SPOF.

### christianremman (Rust, web API)

G-Counter, PN-Counter, LWW map/reg, MV-register, GSet, OR-Set, Two-PSet. Canvas-app + JS frontend. crdt-net har discovery-modul. Ingen sekvens-CRDT.

**Vs oss:** Counters/sets kun, ingen tekst-konvergens, web API (HTTP overhead).
## Vår styrke - kildeverifisert

1. **VV anti-entropi med eksakt delta.** Ingen andre har dette. kappern04 sender full op-dump ved reconnect. LiamLande har primitiv delta basert på op-ID-liste (ikke VV). Oss: beregner eksakt manglende ops via versjonsvektorer. Formal SEC-garanti (Shapiro et al. 2011). Nulltrafikk når i sync.
2. **Kausal buffer (per-peer sekvensnummer).** Bare oss og Segward. Segward: retry-basert i C++ uten Rust-garantier. Oss: strukturert per-peer FIFO med happens-before garanti (Lamport 1978).
3. **Atomisk crash-safe persistens.** Bare oss. kappern04 har persistens men append-only uten fsync. dmtrang13 har Postgres (ekstern SPOF). De fleste: ingenting.
4. **P2P full mesh uten sentral tjener.** Oss + ingvearnes (+ kappern04 for peers). Alle andre: sentral server = SPOF.
5. **mDNS zero-config discovery.** Bare oss (av P2P-løsningene).
6. **Bincode-framing.** Vi og ingvearnes. Alle andre: JSON (tekst-encoding, overhead).
7. **Multi-doc + presence.** Bare oss (av P2P-løsningene).
---
## Vår svakhet

1. Ingen nettleserklient (bevisst: ville tvunget sentral HTTP-tjener og WebSocket-lag).
2. TUI er ikke like visuelt imponerende som React/egui ved første øyekast.
