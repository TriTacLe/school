---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## 4.1 Nettverkslaget i lagmodellen
Har ansvar for ende-til-ende leveranse av pakker på tvers av forskjellige nettverk. 

**Alt over IP / IP over alt**
Dette prinsippet beskriver hvordan IP-protokollen er kjernen i moderne nettverk:
- **Alt over IP:** Alle høyere lag (applikasjonslag og transportlag) bruker IP
- **IP over alt:** IP kan kjøre over alle typer fysiske nettverk (Ethernet, WiFi, fiber, etc.)

**Adressering i lagmodellen:**
- **Applikasjonslag:** Ikke involvert i pakkeadressering
- **Transportlag:** Portnummer, ex: 80, 443, 22
- **Nettverkslag:** IP-adresser, ex: 192.168.1.1
- **Lenkelag:** MAC-adresser
- **Fysisk lag:** Fysiske signaler
## 4.2 IPv4 Adresser
IPv4 adresser er 32-bit adresser som identifiserer enheter unikt på nettverket
### 4.2.1 Format og struktur
**Format:**
- 32 bit totalt (4 bytes)
- Skrives i desimal notasjon med punktum mellom hver 8-bit blokk (oktet)
- Hver oktet: 0-255
- Eksempel: 192.168.1.1

**Adressestruktur:** En IP-adresse består av to deler:
- **Nettverksdel (prefiks):** Identifiserer hvilket nettverk enheten tilhører
- **Nodedel (host):** Identifiserer spesifikk enhet innenfor nettverket

### 4.2.2 CIDR-notasjon
- [ ] **CIDR (Classless Inter-Domain Routing):** Angir nettverksdelen med prefikslengde etter en skråstrek.

**Eksempel: 192.168.1.0/24**
- /24 betyr at de første 24 bit er nettverksdel
- De siste 8 bit er nodedel
- Gir $2^8 = 256$ adresser i dette nettverket

### 4.2.3 Utregning av nettadresse
**Metode:** for å finne nettadressen bruker man AND-operasjon mellom IP-adresse og nettmaske

**Eksempel 1: Finn nettadressen:**
```
Gitt: IP-adresse: 192.168.5.130
       Nettmaske:  255.255.255.128 (eller /25)

Steg 1: Konverter til binært
IP:      11000000.10101000.00000101.10000010  (192.168.5.130)
Maske:   11111111.11111111.11111111.10000000  (255.255.255.128)

Steg 2: AND-operasjon 
Resultat: 11000000.10101000.00000101.10000000

Steg 3: Konverter tilbake til desimal
Nettadresse: 192.168.5.128
```

**Eksempel 2: Er to IP-adresser på samme nett**
```
PC A: 192.168.1.45/24
PC B: 192.168.1.200/24

PC A nettadresse:
192.168.1.45    = 11000000.10101000.00000001.00101101
255.255.255.0   = 11111111.11111111.11111111.00000000
AND             = 11000000.10101000.00000001.00000000
                = 192.168.1.0

PC B nettadresse:
192.168.1.200   = 11000000.10101000.00000001.11001000
255.255.255.0   = 11111111.11111111.11111111.00000000
AND             = 11000000.10101000.00000001.00000000
                = 192.168.1.0

Konklusjon: PC A og PC B er på SAMME nett (192.168.1.0/24)
```
Eksempel 3: Forskjellige nett
```
PC A: 192.168.1.45/24   → Nettadresse: 192.168.1.0
PC C: 192.168.2.45/24   → Nettadresse: 192.168.2.0

Konklusjon: PC A og PC C er på FORSKJELLIGE nett
```
### 4.2.4 Adressetyper og reserverte områder
**Adressetyper:**
- *Offentlige adresser:* Globalt unike, rutbare på Internett
- *Private adresser:* Brukes internt i organisasjoner (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) bak NAT

**Reserverte IPv4-adresseområder**
*Private nettverk* 
- 10.0.0.0/8 
- 172.16.0.0/12
- 192.168.0.0/16
*Loopback* (brukes for testing på egen maskin)
- 127.0.0.0/8
*Link-Local* (autokonfigurering innenfor et subnett)
- 169.254.0.0/16
*Multicast* (kan sende en pakke til en gruppe mottakere)
- 224.0.0.0/4

### 4.2.1 IPv4 Pakkehode
**Viktig:** Headerfeltene er posisjonsbestemt, uten ledetekst, i motsetning til HTTP som bruker navn-verdi par.

IPv4-pakkehodet er *minimum* 20 bytes og inneholder følgende felt (kan være opptil 60 bytes med options):

| **Felt**                     | **Beskrivelse**                                                                                        |
| ---------------------------- | ------------------------------------------------------------------------------------------------------ |
| Version                      | 4 bit - angir IP-versjonen (IPv4 = 4)                                                                  |
| Internet Header Length       | 4 bit - lengden på header i 32-bit ord (minimum 5, som gir 20 bytes)                                   |
| Differentiated Services (DS) | 8 bit - brukes for QoS (Quality of Service), tidligere Type of Service                                 |
| Total Length                 | 16 bit - total lengde av IP-pakken (header + data)                                                     |
| Identification               | 16 bit - brukes til å identifisere fragmenter av samme pakke                                           |
| Flag                         | 3 bit - kontrollerer fragmentering (Don't Fragment, More Fragments)                                    |
| Fragment Offset              | 13 bit - posisjon av fragment i original pakke                                                         |
| Time-to-Live (TTL)           | 8 bit - antall hopp før pakken kastes. Dekrementeres ved hver ruter. Typisk startverdier: 64 eller 128 |
| Protocol                     | 8 bit - angir protokoll i neste lag (6=TCP, 17=UDP, 1=ICMP, 41=IPv6)                                   |
| Header Checksum              | 16 bit - feiloppdaging for header. Må beregnes på nytt ved hver ruter (pga TTL-endring)                |
| Source IP Address            | 32 bit - avsenderens IP-adresse                                                                        |
| Destination IP Address       | 32 bit - mottakerens IP-adresse                                                                        |
**Noen utvalgte felter IPv4 - Sjekk innhold i Wireshark**
*Source og destination IP:* 32 bit hver
*Time-to-live*: Hvor mange ruterhopp en pakke kan ha før den forkastes
*Protocol*: Forteller hvilken protokoll nyttelasten kommer følger
*Checksum:* Feildeteksjon i bitoverføring
*Fragment offset + fragment-flagg:* IPv4 kan dele nyttelasten i flere deler dersom lenkelaget ikke takler så store pakker. Må settes sammen igjen hos mottaker
## 4.3 IP Subnett
**Definisjon IP-subnett:**
- Subnetting er prosessen med å dele et IP-adresseområde i mindre nettverk (subnett) for bedre organisering og sikkerhet.
- Noder som har *felles prefiks* (betyr lik nettverksdel av IP-adressen)
- Prefikset bestemmes med IP-adressen og nettmasken

**Hva kjennetegner et IP-nett?**
- Felles nettadresse for alle noder
- Felles default gateway (ruter)
- Felles kringkastingsdomene (broadcast domain)
- Alle noder kan kommunisere direkte med hverandre
	- Direkte mellom nettverkskort (MAC-addresser) på lenkelaget
	- MAC-nodene på lenkelaget har et kringkastingsdomene, kalles et LAN
- Kommunikasjon med andre IP-subnett må gå via default gateway (ruter med et interface som inngår i IP-subnettet)
- Avgrenset av ruter

**Bruk av prefikset**
- PC bruker prefikset for å avgjøre om pakken skal sendes internt eller til annet IP-nett via ruter (default gateway)
- Rutere bruker prefikset for å finne veien gjennom Internett. Avgjør hvilken retning/utgang som passer best for å nå IP-destinasjonen

**Hvordan avgjøre om mottaker er på eget nett?**
PC gjør en AND-operasjon mellom nettmaske og både egen og mottakers IP-adresse. Hvis resultatet er likt er de på samme nett. Hvis resultatet er ulikt $\to$ forskjellige nett

### 4.3.1 Eksempel på subnetting
**Gitt adresserom**: 192.168.0.128/25

**Opprinnelig nett:**
- Prefiks: /25 (25 bit nettverksdel, 7 bit nodedel)
- Antall adresser: 2⁷ = 128 adresser
- Område: 192.168.0.128 - 192.168.0.255
- Nettverksadresse: 192.168.0.128
- Broadcast-adresse: 192.168.0.255

**Deling i to like store subnett:**
- Nytt prefiks: /26 (26 bit nettverksdel, 6 bit vertsdel)
- Antall adresser per subnett: 2⁶ = 64 adresser

**Subnett 1: 192.168.0.128/26**
- Nettverksadresse: 192.168.0.128
- Brukbare adresser: 192.168.0.129 - 192.168.0.190
- Broadcast-adresse: 192.168.0.191
- Antall brukbare: 62 adresser

**Subnett 2: 192.168.0.192/26**
- Nettverksadresse: 192.168.0.192
- Brukbare adresser: 192.168.0.193 - 192.168.0.254
- Broadcast-adresse: 192.168.0.255
- Antall brukbare: 62 adresser

**Viktig:** 
- Første adresse = nettverksadresse (ikke brukbar for host)
- Siste adresse = broadcast-adresse (ikke brukbar for host)
- Antall brukbare adresser = totalt - 2
## 4.4 IPv6
### 4.4.1 IPv6 adresseformat
IPv6 ble utviklet for å løse IPv4-adressemangelen og forbedre IP-protokollen.

**Format:**
- 128 bit totalt (16 bytes)
- Skrives som 8 blokker på 16 bit med kolon mellom blokkene
- Hver blokk skrives i heksadesimal (0-9, a-f)
- 64 bit prefiks

**Eksempel:**
- *Full format:* `fe80:0000:0000:0000:0005:73ff:fea0:0006`
- *Forkortet format:* `fe80::5:73ff:fea0:6`

**Forenklet skriveform:**
- Ledende nuller i hver blokk kan utelates
	- `0005 `$\to$ `5`
- Null-blokker (0000) kan erstattes med :: (kun én gang per adresse)
**Flere eksempler**
```
2001:0db8:0000:0000:0000:0000:0000:0001
↓
2001:db8::1

fe80:0000:0000:0000:0202:b3ff:fe1e:8329
↓
fe80::202:b3ff:fe1e:8329
```
### 4.4.2 IPv6 globalt prefiks
IPv6 angir nettverksdelen av IP-adressen med prefiks, på samme måte som CIDR i IPv4.

**Skriveform:** `2001:db8::/32`
- `2001:db8::/32` er reservert for dokumentasjon og eksempler
- Inneholder $2^{96}$ adresser

**NTNU sitt prefiks:** `2001:700:300::/44`
- Din globale IPv6 på NTNU-nettet starter alltid med dette prefikset
- NTNU er tildelt sitt prefiks av SIKT
- SIKT har prefikset `2001:700::/32`
### 4.4.3 IPv6 konfigurasjon på PC
En PC med IPv6 vil typisk ha flere IPv6-adresser samtidig:
- **IPv6 Address (Global):** Globalt unik adresse innenfor organisasjonens prefiks. Rutbar på Internett. Prefiks: `2000::/3`
- **Temporary IPv6:** Midlertidig adresse som lages for å gjøre nettverksaktivitet mindre sporbar. Endres over tid.
- **Link-local IPv6:** Opprettet automatisk innenfor eget subnett. Kommunikasjon innenfor eget subnett. Starter alltid med `fe80::/10.` Brukes kun på samme link (eget IP-subnett).
- **Default gateway:** Ruterens IPv6-adresse, definert innenfor eget subnett. Prefiks: link-local
- Ipv6 har alltid 8 blokker
Eksempel fra `ipconfig`:
```
IPv6 Address: 2001:700:300:1234::5678
Temporary IPv6: 2001:700:300:1234:a1b2:c3d4:e5f6:7890
Link-local IPv6: fe80::1234:5678:90ab:cdef
Default Gateway: fe80::something%en0
```
### 4.4.4 IPv6 Pakkehode
IPv6-pakkehodet er 40 bytes (fast størrelse) og har en enklere struktur enn IPv4:

| **Felt**               | **Beskrivelse**                                                         |
| ---------------------- | ----------------------------------------------------------------------- |
| Version                | 4 bit - angir IP-versjonen (IPv6 = 6)                                   |
| Traffic Class          | 8 bit - brukes for QoS og trafikk-prioritering                          |
| Flow Label             | 20 bit - identifiserer pakker i samme strøm for prioritering av trafikk |
| Payload Length         | 16 bit - lengden på nyttelasten (ikke header)                           |
| Next Header            | 8 bit - angir type av neste header (samme verdier som Protocol i IPv4)  |
| Hop Limit              | 8 bit - samme som TTL i IPv4, dekrementeres ved hver ruter              |
| Source IP Address      | 128 bit - avsenderens IPv6-adresse                                      |
| Destination IP Address | 128 bit - mottakerens IPv6-adresse                                      |
### 4.4.5 IPv6 endringer fra IPv4
IPv6 har gjort flere viktige endringer sammenlignet med IPv4:
- **Source og Destination IP på 128 bit:** Bøter på mangelen av IPv4-adresser (ca. 340 undecillion adresser)
- **Fjernet Checksum:** Avsender og mottaker må selv holde styr på tapte pakker (gjøres i transportlaget)
- **Fjernet Fragment-funksjon:** Avsender må holde styr på aksepterte pakkestørrelser (Path MTU Discovery)
- **Innført Flow Label og Traffic Class:** For å ha mulighet til prioritering av trafikk
- **Fast header-størrelse:** 40 bytes (mot variabel 20+ i IPv4), gjør prosessering raskere

**Headerfelt som er beholdt i IPv6**

| IPv4 navn          | IPv6 navn      |                                                                                                                                  |
| ------------------ | -------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| Protocol           | Next header    | Angir mottakerprotokoll<br>på transportlaget (Som<br>denne pakken skal leveres<br>til)                                           |
| Time-to-live (TTL) | Hop limit      | Antall rutere som kan<br>passeres (for å unngå<br>loop). Nedtelling til 0,<br>forkastes og sendes ICMP.<br>Testes med Traceroute |
| Source IP          | Source IP      | Senders IP-adresse                                                                                                               |
| Destination IP     | Destination IP | Mottakers IP-adresse                                                                                                             |

**Tips:** Sjekk innhold av headerfelter i Wireshark for å se forskjellene i praksis!
### 4.4.6 Overgang fra IPv4 til IPv6
Siden det ikke er mulig å bytte hele internett til IPv6 på én gang, brukes flere teknikker:

**1. Tunneling**
IPv6-pakker kan sendes gjennom IPv4-nettverk ved tunneling:
- IPv6-pakken pakkes inn i en IPv4-pakke
- IPv4-ruterne behandler den som en vanlig IPv4-pakke
- Ved mottaker pakkes IPv6-pakken ut igjen
- Protocol-feltet i IPv4-hodet settes til 41 for å indikere IPv6

**2. Dual Stack**
Noder og rutere som støtter både IPv4 og IPv6:
- Kan kommunisere med både IPv4- og IPv6-noder
- Velger protokoll basert på hva mottaker støtter

**Status i dag:**
- Ca. 25% av trafikken til Google bruker IPv6
- Over 1/3 av amerikanske regjeringsdomain er IPv6-aktivert
- Mobil-nettverk (3GPP) bruker IPv6 som standard
## 4.5 Sammenligning IPv4 vs IPv6

| **Egenskap**     | **IPv4**               | **IPv6**                   |
| ---------------- | ---------------------- | -------------------------- |
| Adressestørrelse | 32 bit                 | 128 bit                    |
| Antall adresser  | ~4,3 milliarder        | ~340 undecillion           |
| Header-størrelse | 20-60 bytes (variabel) | 40 bytes (fast)            |
| Checksum         | Ja (i header)          | Nei (fjernet)              |
| Fragmentering    | Støttes av rutere      | Kun av avsender            |
| QoS-støtte       | DS/ToS felt            | Traffic Class + Flow Label |
| Notasjon         | Desimal med punktum    | Heksadesimal med kolon     |
## 4.6 Nettverksfunksjoner fra terminalvindu
**Oversikt kommandoer**
- `ifconfig`/ `ipconfig` - vise nettverkskonfigurasjon
- `arp`- vise ARP-cache (IP til MAC-mapping)
- `netstat`- vise aktive forbindelser og porter
- `ping`- teste tilkobling og måle RTT
- `traceroute`/`tracert`- vise rute gjennom nettverket
### 4.6.1 ipconfig / ifconfig
**Formål:** vise IP-konfigurasjon på PC/undersøke configs for nettverkskort.
 - *Windows:* `ipconfig` eller `ipconfig /all`
 - *macOS/Linux:* `ifconfig` eller `ip addr`

**Viser:**
- IPv4-adresse og subnettmaske
- IPv6-adresser (Global, Temporary, Link-local)
- Default gateway
- MAC-adresse (fysisk adresse)
- DNS-servere

**Tips:** De første 3 byte av MAC-adressen angir produsent. Google på "network mac producer XX-YY-ZZ" eller bruk Wireshark.
### 4.6.2 arp
**Formål:** Address Resolution Protocol - brukes for å finne MAC-adresse fra IP-adresse på eget subnett.

**Kommando:** `arp -a`
- Viser ARP-cache med IP-adresser og tilhørende MAC-adresser.
- `hostname (IPv4) at MAC-adresse on interface`

**Hvordan ARP fungerer:** 
1. En IP-pakke overføres mellom to nettverkskort innenfor et IP-subnett
	- Samme IP DST nettadresse: Direkte til lokal host
	- Ulike IP DST adresse: Via default gateway (ruter)
2. Avsender må kjenne MAC-adressen til neste mottaker. 
3. Sender MAC-broadcast: "hvem har denne IP-adressen?"
4. Mottaker svarer, og i svarpakken ligger MAC-adressen
5. Avsender lagrer dette i ARP-cache

**Beslutning for sending**
- Samme IP-nett (samme nettadresse) $\to$ Direkte til lokal host
- Ulike IP-nett $\to$ via default gateway (ruter)
### netstat
**Formål**: Viser en oversikt over nettverkstilkoblinger og porter i bruk på egen PC.
**Kommando:** `netstat`
**Viser:**
- Aktive TCP-forbindelser
- Lokale og eksterne porter
- Status på forbindelser (ESTABLISHED, LISTENING, etc.)

**Nyttige flagg**
- `netstat -a` - Vis alle forbindelser og lyttende porter
- `netstat -n` - Vis numeriske adresser (ikke DNS-oppslag)
- `netstat -b` (Windows) - Vis hvilket program som bruker porten
### ping
**Formål:** Teste tilkobling med mottakers IP og måle hvor lang tid responsen tar
**Protokoll:** Bruker ICMP Echo Request/Reply 
**Kommando:** `ping <adresse>`
**Viser:**
- Round-Trip Time (RTT) - tiden det tar for pakken å gå fram og tilbake
- Pakketap - om noen pakker forsvinner underveis
- TTL - Time To Live verdi i svaret

**Tekniske detaljer fra labøving:**
- Standard nyttelast: 32 eller 56 bytes
- Innhold: Typisk alfabetet eller null-bytes
- Antall pakker: Ofte 4 pakker for å beregne gjennomsnittlig RTT
- Ved stor nyttelast (>MTU): Pakken fragmenteres
### tracerout / tracert
**Formål:** Viser veien (rutene) en pakke tar gjennom nettverket til destinasjonen.
**Kommando:**
- *Windows:* `tracert "adresse"`
- *macOS/Linux:* `traceroute "adresse"`

**Hvordan det fungerer:**
1. Benytter TTL i IP-header samt ICMP-protokollen på nettlaget
2. Sender pakker med gradvis økende TTL/Hop Limit verdier
	- Første pakke: TTL=1
	- Neste pakke: TTL=2
	- Osv.
	- Men TTL reduseres med 1 for hvert hopp altså for hver ruter pakken passerer.
3. Når TTL telles ned til 0: 
	- Ruteren dropper pakken 
	- Ruteren sender *ICMP Time Exceeded* tilbake til avsender
4. Ved å manipulere TTL kan avsender gå steg for steg gjennom nettet frem til mottakers adresse.
5. Dette avslører hver ruter på veien

**Fra labøving:**
- Antall pakker per ruter: Typisk 3 pakker
- TTL-endring: Øker med 1 for hver ruter

## See also
- [[idatt2104-moc]]
