---
tags: [idatt2104, crdt, presentation, spring-2026]
deadline: 2026-05-29
---
---
## 0. Hook (30 sek) — Yazan

Hva skjer når to brukere redigerer samme tekst samtidig, uten en server som bestemmer?

Naiv tilnærming: siste skriver vinner. En bruker mister arbeidet sitt. Alternativt: locking, en bruker venter mens den andre skriver. Begge er uakseptable for ekte samarbeid.

Vi bygde en løsning som gir matematisk konvergensgaranti: alle noder ender i identisk tilstand, uansett nettverksforsinkelse, pakketap eller rekkefølge. Uten sentral tjener. Uten koordinering.
## 1. Kort om løsningen (2-3 min) — Yazan (Rust + libs) / Shakti (trådmodell)

### Programmeringsspråk: Rust
Valgt for tre konkrete egenskaper:
- **Kompileringstids-racegarantier.** Ownership-systemet gjør at to tasks ikke kan skrive til samme Document uten at en Mutex er låst. Det er ikke en konvensjon, det er en kompileringsfeil. I CRDT-merge-logikk der races gir stille datakorrupsjon er dette avgjørende.
- **Deterministisk latens.** Ingen garbage collector betyr ingen GC-pause. For en editor der en tastatur-hendelse skal propageres innen 500ms er uforutsigbare pauser uakseptable.
- **Zero-cost abstractions.** `async/await` kompilerer til tilstandsmaskiner på stack-frame-nivå, ikke heap-allokerte objekter. Samme ytelsesbunn som C.

Alternativ vurdert: Go har enklere goroutine-modell, men GC og svakere kompileringstids-garantier. C++ gir tilsvarende ytelse, men udefinert adferd i merge-logikk gir stille korrupsjon uten kompileringsfeil. Rust eliminerer hele den klassen ved kompilering.
### Biblioteker
**tokio** er en M:N asynkron runtime. N lettvektstasks fordelt på M OS-tråder via work-stealing scheduler. `tokio::spawn` er en korutine, ikke en OS-tråd. Uten blocking I/O blokkerer ingen peer andre peers. Alternativ: `async-std`, men tokio har bedre `select!`-semantikk og størst økosystem.

**serde + bincode** gir type-trygg serialisering via `#[derive(Serialize, Deserialize)]`. bincode er et kompakt binært format uten feltnavn-overhead og streng-encoding. Typisk 3-5x mindre meldinger enn JSON. Deterministisk byte-rekkefølge er viktig for fremtidig kryptografisk hashing.

**ratatui** er en retained-mode TUI med diff-rendering: kun endrede celler rendres, ikke hele skjermen. Non-blocking event-loop via crossterm. Alternativ: ncurses via FFI gir C-pekere inn i Rust, unødig risiko.

**tokio-util LengthDelimitedCodec** gir framing via en 4-byte big-endian lengde-prefix som isolerer meldingsgrenser fra TCP byte-strømmen. Uten framing kan to meldinger slås sammen. Grense: 8 MiB per frame.

**tracing** gir strukturerte span/event-baserte logger kompatible med tokios async-kontekst. Span følger en task på tvers av `.await`-punkt. Eksporteres til OpenTelemetry uten kodeendring.
### Trådmodell 
Asynkron, ikke-blokkerende. O(cpu_count) OS-tråder, O(n) lettvektstasks:
```
TUI-loop (main task)
  |-- msg_router task    <- lytter på TCP-innkommende og lokale ops
  |-- sync_tick task     <- sender VV Hello hvert 500ms til tilfeldig peer
  |-- autosave task      <- skriver snapshot til disk hvert 30s
  |-- tcp_peer tasks     <- en per peer, håndterer reconnect med backoff
```

Kommunikasjon via `tokio::mpsc`-kanaler (lock-free FIFO). `Arc<Mutex<Document>>` deles mellom transport-tasks. Backpressure via begrensede kanal-kapasiteter forhindrer minnebruk ved trege peers.

Alternativ forkastet: thread-per-client bruker O(n) OS-tråder og betaler kontekstbytte for hvert peer-steg. Med async: samme n peers, cpu_count tråder, kanaloperasjoner i stedet for OS-scheduling.
## 2. Implementert funksjonalitet (5-7 min) — Yazan (CRDT-typer) / Shakti (TUI) / Tri (transport)

### CRDT-typer (implementert fra bunnen, ingen bibliotek)

| Type | Beskrivelse |
|------|------------|
| **RGA** | Op-basert sekvens-CRDT. Concurrent inserts konvergerer via Lamport clock tiebreaking og tombstone-sletting |
| **Lamport clock** | Scalar logisk klokke. Inkrementeres på lokal op, max-oppdateres på mottak |
| **Version vector** | Per-replika op-tellere. Brukes til eksakt delta-beregning |
| **LWW register** | Last-write-wins register med Lamport-timestamp |
| **LWW map** | LWW-register per nøkkel |
| **OR-Set** | Observe-remove set med unike tags per element |

### Transport og nettverkslag — Tri

- **TCP-framing:** 4-byte length-prefix + bincode. Fan-out på hver lokal op til alle tilkoblede peers.
- **Kausal buffer:** Per-peer sekvenssporing. Buffrer out-of-order ops til gapet lukkes (happens-before-relasjon, Lamport 1978).
- **VV anti-entropi:** Utveksler version vectors hvert 500ms. Gapet beregnes eksakt, manglende ops sendes som delta. Nulltrafikk når alle er i sync. Reparerer droppede broadcasts innen ett tick.
- **mDNS:** Registrerer `_crdt-collab._tcp.local.`. Noder på samme nettverk finner hverandre automatisk uten `--peer`-flagg.
- **Atomisk snapshot:** write-to-tmp-then-rename + fsync(dir). Replay av op-loggen ved oppstart.

### TUI

- ratatui tekstedigeringsflate med støtte for insert, slett (Delete + Backspace), markørbevegelse (piler, Home, End) og **linjeskift (Enter)**.
- **Multi-dokument + doc picker:** Esc returnerer til pickeren. `n` oppretter nytt dokument, `r` gir det navn, `Enter` åpner.
- **Presence:** Statuslinja viser `{n} editing` per dokument. Viser nøyaktig hvor mange noder som redigerer akkurat dette dokumentet nå.
- Statuslinja: `ln {rad} col {kol} | {tegn} chars | {n} editing | synced/waiting`.
- Replika-ID i tittellinja. Doc-pickeren viser `peers: {n}`.

### Mangler og svakheter

| Svakhet | Forklaring |
|---------|-----------|
| Ingen tekstseleksjon / copy-paste | Utenfor MVP-scope |
| Ingen autentisering / kryptering | Bevisst scope-valg (se seksjon 4) |
| To Document-instanser | TUI-doc og transport-doc: kan i teorien divergere hvis kanal er full (deferred P2) |
| `ops_all()` sorterer ved hvert kall | Sort-cache mangler (deferred P5) |
## 3. Demonstrasjon (5-7 min) — alle tre

Se `demoplan.md` for copy-paste-kommandoer, scenario-beats og mDNS-fallback.

Kort:

1. `just demo` starter tre noder i tmux. mDNS kobler dem automatisk.
2. Skriv tekst på node A: propageres til B og C innen 500ms.
3. Alle tre skriver simultant: alle konvergerer til identisk tekst.
4. Drep node B, skriv på A og C, start B igjen: snapshot-replay + VV-delta fra peers.
5. Opprett et nytt dokument i doc-pickeren med `n`, gi det navn med `r`, åpne med `Enter`.
---
## 4. Tekniske valg forsvart (~4 min) — Yazan (RGA-valg + fra bunnen) / Tri (Rust/async/TCP/nett)

### Rust vs Go vs C++ — Tri

| Valg | Alternativ | Forkastet fordi |
|------|-----------|----------------|
| Rust | Go | GC-pauser i en latens-sensitiv editor; svakere kompileringstids-garantier |
| Rust | C++ | Udefinert adferd i merge-logikk = stille korrupsjon uten kompileringsfeil |

Avveining vi godtok: lengre kompileringstid og brattere læringskurve.

### async tokio vs thread-per-client — Tri

Tokio M:N: O(cpu_count) OS-tråder, O(n) tasks. Thread-per-client: O(n) OS-tråder med full stack-allokering og OS-kontekstbytte per peer. Med 50 peers betaler thread-per-client 50 stack-allokeringer og konstant OS-scheduling. Med async er overhead per peer kanaloperasjoner og en task-yield.

### RGA vs YATA vs Fugue vs counters/sets — Yazan

RGA (Roh et al. 2011) er det kanoniske referansedesignet for op-baserte sekvens-CRDTs. Concurrent inserts konvergerer via Lamport clock tiebreaking og tombstone-sletting. Riktig valg for 14-dagers scope og kursrelevans.

YATA (brukt av Yjs) fjerner tombstones, men er mer kompleks å implementere fra bunnen. Fugue/FugueMax (2023) eliminerer interleaving-anomalier, men er for kompleks for tidsrammen.

Counters og sets alene (G-Counter, PN-Counter, OR-Set, LWW-register) løser ikke sekvensproblem. En counter-CRDT konvergerer, men kan ikke representere tekst med stabile karakterposisjoner ved concurrent redigering. Å velge kun counters/sets er å demonstrere CRDT-teori uten å løse kjerneproblemet.

Avveining vi godtok: RGA har O(n) insert i verste fall. Akseptabelt for interaktive dokumenter.

### Raw TCP vs WebSocket — Tri

WebSocket (RFC 6455) er TCP + HTTP upgrade-handshake + WS-framing + obligatorisk payload-masking. Alt dette eksisterer av én grunn: nettlesere kan ikke åpne rene TCP-sokler. Vår klient er en native prosess (TUI). Vi trenger ikke HTTP-laget.

```
WebSocket:    TCP + HTTP upgrade + WS-header + masking (4-byte XOR per frame)
Vår løsning:  TCP + 4-byte length-prefix + bincode
```

Fordeler: lavere overhead, ren P2P uten sentral HTTP-tjener, bincode 3-5x mer kompakt enn JSON. Avveining vi godtok: ingen nettleser-demo.

Forsvarspunkt: "WebSocket er riktig valg når klienten er en nettleser. Vi valgte TCP direkte fordi alle noder er native prosesser i et P2P-nett uten sentral tjener."

### Op-log + VV delta vs broadcast-only vs state-sync — Tri

Broadcast-only: sender op til tilkoblede peers ved produksjon. Hvis en peer er frakoblet mister den ops permanent. Noder divergerer stille og brukeren ser det aldri.

State-sync: sender hele dokumenttilstanden. Enkel å implementere, men kostbar for store dokumenter og gir ingen delta-effektivitet.

Vår løsning: op-log + VV delta. Version vectors per replika. Hvert 500ms beregnes eksakt hvilke ops en peer mangler og sendes som delta. Nulltrafikk når alle er i sync. Formal garanti: **Strong Eventual Consistency (SEC)** (Shapiro et al. 2011). En node offline i timevis synkroniseres innen ett tick etter reconnect.

### Kausal buffer — Tri

TCP garanterer FIFO per forbindelse, ikke på tvers av forbindelser i et P2P-nett. Op seq=3 fra node A kan ankomme hos node B via én rute før seq=2 fra node A via en annen rute. Uten kausal buffer: seq=3 brukes på feil grunnlag og noden divergerer stille.

Kausal buffer sporer per-peer sekvensnummer og holder ops i kø til forgjengeren er bekreftet. Garanterer kausal konsistens (happens-before-relasjon, Lamport 1978) uten sentralisert koordinering.

Avveining: minnebruk for buffrede ops, begrenset til 4096 per peer som DoS-vern.

### Atomisk snapshot vs write-direct vs database vs ingen persistens — Tri

Ingen persistens: all tilstand tapes ved restart. Uakseptabelt for et system som skal demonstrere recovery.

Direkte filskriving: risiko for korrupt fil ved strømbrudd midt i skriving. Halvskrevet bincode-struktur er uleselig.

Database (Postgres o.l.): overkill for P2P-arkitektur uten sentral tjener. Introduserer en ekstern avhengighet som er en single point of failure.

Vår løsning: write-to-tmp-then-rename + fsync(dir). POSIX rename er atomisk på ext4/xfs/APFS. fsync på foreldrekatalogen sikrer at rename-operasjonen overlever strømbrudd. Siste gyldige snapshot er alltid konsistent. Replay av op-loggen gir full restore.

### Full-mesh P2P vs klient-server — Tri

Klient-server er enklere å implementere (én autoritativ kopi, klienter sender diffs), men serveren er single point of failure. Faller serveren, stopper all synkronisering.

Full mesh: alle noder er likeverdige og kommuniserer direkte. Nettverket forblir operativt så lenge to noder kan nå hverandre. Passer faget: vi demonstrerer P2P-nettverksprogrammering, ikke klient-server.

### mDNS vs manuelle adresser — Tri

Manuelle `--peer`-flagg krever at brukeren vet IP-adressen på forhånd. mDNS (`mdns-sd`, tjeneste `_crdt-collab._tcp.local.`) lar noder finne hverandre automatisk på samme nettverk. Deduplicering via replika-ID hindrer dobbelkobling. `--no-mdns` flagg for opt-out.

Avveining vi godtok: mDNS krever multicast-støtte på nettverksinterface. Fungerer ikke over eduroam med klient-isolering.

### Fra bunnen vs CRDT-bibliotek — Yazan

Kurskrav: alle CRDT-typer implementeres selv. `scripts/check-banned-crates.sh` håndhever dette i CI og blokkerer Automerge, Yrs, Loro, Diamond-types, Yjs.

Fordel: vi forstår hvert design-valg i detalj. Avveining: mer implementasjonstid.
## 5. Hvorfor vår løsning er sterkere enn vanlige tilnærminger (~2 min) — Tri

De fleste løsninger i dette rommet optimaliserer for et pent brukergrensesnitt eller produkt-funksjoner og lar et rammeverk eller en sentral tjener skjule nettverket. Vi optimaliserte for faget: transport- og konsistenslaget er bygd fra bunnen og er korrekt under feil.

### Vi løser den vanskelige CRDT-typen

Et sekvens-CRDT for tekst med concurrent insert/delete er det vanskelige tilfellet. Counter- og set-CRDTs konvergerer kommuterbart, men kan ikke representere tekst med stabile karakterposisjoner. En løsning som kun implementerer tellere og sett demonstrerer CRDT-teori uten å løse kjerneproblemet ved samarbeidende tekstredigering.

### Ingen single point of failure

Full-mesh P2P: alle noder kommuniserer direkte. En løsning med sentral tjener eller broker stopper å synkronisere i det øyeblikket tjeneren er nede. Det er klient-server, ikke P2P-nettverksprogrammering.

### Vi bygde transportlaget selv

WebSocket er TCP med HTTP-innpakning, der innpakningen eksisterer for nettlesere. En løsning som bruker WebSocket for nettleser-klienter gjør et legitimt valg for den arkitekturen. Men vi bygde en TUI der alle klienter er native prosesser. Da skjuler WebSocket nettverksprogrammeringen vi er satt til å lære. Vi implementerer framing selv: 4-byte length-prefix og bincode.

### Vi reparerer feil, vi sender bare ikke

Broadcast-only løsninger antar at alle noder mottar meldingene. Ved nettverksfeil forsvinner ops stille og noder divergerer permanent. VV anti-entropi beregner eksakt hvilke ops en peer mangler og sender kun det. En node offline i timevis synkroniseres fullt innen ett tick etter reconnect.

### Vi håndterer out-of-order levering

I et P2P-nett kan meldinger ankomme i feil rekkefølge. Uten kausal buffer brukes en op på feil grunnlag og noden divergerer stille. Kausal buffer garanterer happens-before per peer uten sentralisert koordinering.

### Vi overlever en krasj

De fleste mister all tilstand ved restart. De få som persister, skriver direkte til fil og risikerer korrupsjon ved strømbrudd, eller bruker en hel database. Vi bruker atomisk tmp+rename+fsync: siste gyldige snapshot er alltid konsistent, og noden replayer op-loggen og gjenopptar fra nøyaktig der den var.

### Minnesikkerhet i merge-logikken

Rust gir kompileringstids-garantier mot data races og use-after-free. Implementasjoner i C++ risikerer udefinert adferd i concurrent merge-logikk, stille korrupsjon uten kompileringsfeil. Implementasjoner i Java betaler GC-pauser i en latens-sensitiv editor.

### Hva vi bevisst utelot

**Nettleserklient.** En TUI er native og trenger ikke HTTP-laget. Å legge til en nettleser ville tvinge en sentral HTTP-tjener og reintrodusert single point of failure.

**Sentral tjener og database.** Overkill for P2P. Vår on-disk snapshot gir persistens uten ekstern infrastruktur som kan feile.

**Autentisering og deling.** Produkt-funksjoner utenfor fagets scope som ikke demonstrerer ny nettverksprogrammering.
---
## 6. Preempterte innvendinger (~1 min) — Tri

**"TUI ser mindre imponerende ut enn en webapp."**
Vi demonstrerer nettverksprogrammering, ikke webdesign. TUI viser protokollen direkte: du ser teksten propagere i sanntid uten nettleser-abstraksjon mellom deg og TCP-laget. En webapp ville skjult transportlaget vi implementerte.

**"Dere har ingen kryptering."**
Bevisst scope-valg. Riktig plass å legge til kryptering: TLS over TCP-laget via `tokio-rustls`. Det ville ikke endret ett eneste biblioteksdesign-valg vi tok. Alle protokollbeslutninger er krypteringsagnostiske.

**"Peer-antall vises ikke i editoren."**
`peers: {n}` vises i doc-pickeren. Editoren viser `{n} editing` som er en presence-teller per dokument. Replika-ID vises i tittellinja. `app.peer_count` oppdateres hvert loop-iterasjon og er live.

**"To Document-instanser kan divergere."**
TUI-doc og transport-doc er to separate instanser. De kan i teorien divergere hvis `remote_op_sender`-kanalen er full. I praksis er kanalen stor nok at dette ikke inntreffer under normale operasjoner. Det er et kjent deferred-problem (P2), ikke noe vi er uvitende om.

**"mDNS fungerer ikke på eduroam."**
Riktig. mDNS krever multicast på nettverksinterface. For demo på isolerte nettverk bruker vi `--peer`-flagg som manuell fallback. Begge mekanismer er implementert og testet.
## Notater til innspillingen

- Vis GitHub-repo og CI-pipeline tidlig: viser at løsningen er testet og verifiserbar, ikke bare en demo-stunt.
- Forklar two-doc-mønsteret: "TUI-doc er den du redigerer, transport-doc er det nettverkslaget ser."
- Demo kausal buffer visuelt via VV anti-entropi: drep en node, skriv, start opp igjen. Viser recovery.
- Pek på `{n} editing`-telleren i statuslinja og forklar at det er presence-tracking per dokument.
- Nevn at alle CRDT-typer er fra bunnen og at CI håndhever forbudet mot CRDT-biblioteker.
- Forklar VV anti-entropi med ord: "broadcast-only mister ops permanent, vi reparerer innen 500ms."
