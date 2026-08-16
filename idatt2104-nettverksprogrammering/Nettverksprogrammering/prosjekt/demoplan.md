---
tags: [idatt2104, crdt, demo, spring-2026]
deadline: 2026-05-29
---

# crdt-collab - Demoplan og innspillingsplan

**Frist:** 29. mai 2026 kl. 23:59
**Varighet:** 15-20 min
**Deltakere:** Tri Tac Le, Yazan Samer Zarka, Shakti Om Sharma
---
## Tidslinje

| Dato | Steg |
|------|------|
| 24. mai | Feature freeze |
| 26. mai | Tag v1.0.0, portal submission |
| 27-28. mai | Innspilling |
| 29. mai | Videopresentasjon innlevert |
---
## Fordeling: hvem snakker om hva

Del etter hvem som bygde hva. Matchet mot crate-ansvar i `decisions.md`.

| Person | Seksjoner | Tidsbruk |
|--------|-----------|---------|
| **Yazan** | §0 Hook + §1 Rust+libs + §2 CRDT-typer + §4 RGA-valg + §4 fra bunnen | ca. 6 min |
| **Shakti** | §1 trådmodell + §2 TUI + §3 Demo (alle tre deltar) | ca. 6 min |
| **Tri** | §2 transport + §4 Rust/async/TCP/VV/buffer/snapshot/mesh/mDNS + §5 + §6 | ca. 6 min |

Yazan forklarer *hva vi bygde og hvorfor vi valgte RGA*. Shakti forklarer *app-arkitekturen og viser det live*. Tri forsvarer *nettverks- og arkitekturvalg og sammenligner*.
---
## Tidsbudsjett

| Tid | Seksjon | Hvem |
|-----|---------|------|
| 0:00-0:30 | Hook: problemet uten server | Yazan |
| 0:30-2:30 | Rust + biblioteker | Yazan |
| 2:30-3:30 | Trådmodell (task-topologi) | Shakti |
| 3:30-5:30 | CRDT-typer + transport | Yazan (CRDT) + Tri (transport) |
| 5:30-7:00 | TUI + multi-doc + presence | Shakti |
| 7:00-12:00 | Demo | alle tre |
| 12:00-14:00 | RGA-valg + fra bunnen vs lib | Yazan |
| 14:00-18:00 | Rust/async/TCP/VV/buffer/snapshot/mesh/mDNS | Tri |
| 18:00-19:30 | Hvorfor sterkere + innvendinger | Tri |
| 19:30-20:00 | Avslutning | alle |
---
## Forberedelser dagen før innspilling

- [ ] `cargo build --release` kjørt på alle tre maskiner
- [ ] LAN-IP notert på alle tre maskiner (`ip addr`)
- [ ] mDNS testet: start noder, bekreft `peers: {n}` stiger i doc-pickeren
- [ ] `--peer`-fallback testet med LAN-IP (ikke 127.0.0.1) i tilfelle mDNS feiler
- [ ] Alle tre kan se hverandres edits
- [ ] OBS Studio / SimpleScreenRecorder testet, 1080p
- [ ] Ekstern mikrofon tilkoblet og testet
- [ ] Terminal-font min 14pt for lesbarhet på opptak
---
## Demo-script

### Primær: mDNS (separat maskin per person, LAN)

Hver person kjører sin node på sin maskin. mDNS finner dem automatisk på samme LAN.

```sh
# Bygg (hver maskin)
cargo build --release

# Rydding (hver maskin)
rm -rf /tmp/crdt-demo

# Hver person starter sin node med unik port
./target/release/crdt-client --listen 0.0.0.0:4001 --journal /tmp/crdt-demo
```

mDNS kobler nodene automatisk. Sjekk `peers: {n}` i doc-pickeren.

Merk: mDNS krever multicast-støtte. Fungerer ikke på eduroam med klient-isolering. Bruk fallback under.

### Fallback: manuelle `--peer`-flagg (LAN, eksplisitt IP)

Finn LAN-IP på hver maskin (`ip addr` / `ifconfig`). Erstatt `192.168.x.x` med faktiske adresser.

```sh
# Maskin A (Shakti) - ingen --peer, venter på innkommende
./target/release/crdt-client --listen 0.0.0.0:4001 --journal /tmp/crdt-demo --no-mdns

# Maskin B (Yazan) - peer peker på A sin LAN-IP
./target/release/crdt-client --listen 0.0.0.0:4001 --journal /tmp/crdt-demo --no-mdns --peer 192.168.x.x:4001

# Maskin C (Tri) - peer peker på A sin LAN-IP
./target/release/crdt-client --listen 0.0.0.0:4001 --journal /tmp/crdt-demo --no-mdns --peer 192.168.x.x:4001
```

Alle kobler til A. A kobler tilbake (full mesh etableres automatisk).
---
## Scenario-beats (i orden)

### Beat 1: kobling og doc-picker

Alle tre noder starter i doc-pickeren. Pek på `peers: {n}` i doc-pickeren og forklar at noden har koblet til peers. Velg/opprett et dokument på alle tre.

### Beat 2: propagering

Skriv "hello " på node A. Pek på at teksten dukker opp på B og C innen 500ms. Vis statuslinja: `{n} editing` skal vise 3 på alle noder (alle redigerer samme doc).

### Beat 3: concurrent redigering

Alle tre skriver simultant. La dem skrive ulike tegn. Stopp og vis at alle tre viser identisk tekst. Forklar: RGA convergence garanterer dette uansett ankomstrekkefølge.

### Beat 4: linjeskift

Trykk Enter på node A. Vis at en ny linje propageres til B og C. (Bevisst beat fordi linjeskift er ikke åpenbart i en CRDT-editor.)

### Beat 5: offline recovery (VV anti-entropi)

Drep node B med Ctrl-C. Skriv ny tekst på A og C. Start node B igjen med samme journal:

```sh
# Samme kommando som ved oppstart, journal-dir er uendret
./target/release/crdt-client --listen 0.0.0.0:4001 --journal /tmp/crdt-demo
```

Node B replayer snapshot, VV Hello-tikk avslører hva den mangler, mottar delta fra A eller C. Innen ett 500ms-tikk er B fullt synkronisert. mDNS rekobler automatisk (eller bruk `--peer` igjen ved fallback). Pek på at recovery skjer uten manuell innblanding.

### Beat 6: multi-dokument

Trykk Esc på node A for å gå til doc-pickeren. Trykk `n` for å opprette nytt dokument. Trykk `r` for å gi det et navn. Trykk Enter for å åpne. Vis at presence-telleren på det nye dokumentet starter på 1 og stiger etter hvert som de andre nodene også åpner det.
---
## Kjente svakheter (ærlig oppgjør i presentasjonen)

| Svakhet | Forklaring |
|---------|-----------|
| Ingen tekstseleksjon / copy-paste | Utenfor MVP-scope |
| Ingen autentisering / kryptering | Bevisst (krypteringsagnostisk protokolldesign) |
| To Document-instanser (TUI + transport) | Kan i teorien divergere hvis kanal er full (deferred P2) |
| `ops_all()` sorterer ved hvert kall | Sort-cache mangler (deferred P5) |
---
## Innspillingsplan

- **Lyd:** ekstern mikrofon, ikke laptop-mic. Sjekk gain før innspilling.
- **Skjerm:** 1080p, OBS Studio eller SimpleScreenRecorder.
- **Font:** terminal-font min 14pt.
- **Klipp:** ett take per beat, monter til én fil. Ikke jump-cuts midt i forklaringer.
- **Struktur:** intro/CRDT/trådmodell (Yazan) + TUI/demo (Shakti) + forsvar (Tri). Kan spilles inn separat og monteres.
- **Første klipp:** vis GitHub-repo og CI-kjøring. Viser at løsningen er testet og verifiserbar.
