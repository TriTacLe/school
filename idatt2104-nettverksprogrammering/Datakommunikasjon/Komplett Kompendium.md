---
type: area
status: evergreen
created: 2026-04-08
modified: 2026-04-08
tags: []
---

# 1 Lagdelt kommunikasjonsmodell.Pakkeanalyse med Wireshark
### 1.1 Pakkesvitsjing
**Pakkesvitsjing:** datamengden som overføres mellom applikasjoner kan deles opp i passe store blokkes og sendes hver for seg.
- Hver datapakke blir da en selvstendig enhet som kommer frem til rett mottaker ved hjelp av adressering
*Fordeler*
- Datapakker mellom flere avsendere og mottakere kan sendes over samme linjeressurs (båndbredde)
- Benytte alternative ruter hvis det oppstår linjebrudd
### 1.2  Bygd opp som en lagdelt modell
- Oppgavene på de ulike lagene utføres av protokoller som opererer på samme lag mellom enheter. 
- *Protokoller:* standardiserte sett av regler og prosedyrer for hvordan den ønskede kommunikasjonen skal utføres.
- Pakkenhet PDU består av nyttelast (payload) fra laget over pluss lagets egen protokollinfomasjon.
- Protokoller virker mellom likestilte lagm horisontalt) og pakkeenheter overføres mellom lagene (vertikalt)
### Lagmodeller for datakommunikasjon - foreneklet 5-lags OSI
![[Screenshot 2026-01-07 at 09.58.17.png | 650 ]]
- *Applikasjonslaget*: Interface mot den distribuerte applikasjonen. Overfører data som meldinger mellom partene
- *Transportlaget:* Overfører meldingene som segmenter til rett applikasjonsprotokoll hos mottaker, gir oss ende-ende kommunikasjon mellom applikasjonene. Applikasjonene er identifisert med portnummer
- *Nettverkslaget:* Sørger for at hver pakke rutes gjennom nettet til rett mottakers IP-grensesnitt
- *Lenkelaget:* Sørger for at pakkene overføres mellom tilstøtende noder (mellom to nettverkskort). Lenkelagsadressen som identifiserer nettverkskortet kalles for MAC-adresser.
- *Fysisk lag:* Sender bit signaler over transmisjonsmedium (luft, kopper fiber).
## 1.3 Innpakkingsprinsippet og pakkehoder (header)
**Innpakkingsprinsippet:** Når en pakkeenhet beveger seg nedover i lagmodellen, dvs. når et lag overlater sin pakkeenhet som nyttelast til en bestemt protokoll på laget under, blir nyttelasten videre "pakket inn" med pakkeheader til den aktuelle protokollen.
- Data fra applikasjonene overlates til applikasjonslaget som formaterer og pakker dette inn som en melding
- Meldingen overlates til laget under som *nyttelast* for videre håndtering
- *For hver lag:* pakkes nyttelasten inn med et nytt header. Pakken øker i størrelse for hvert steg
![[Screenshot 2026-01-07 at 10.12.31.png | 600]]
**Protokollene styres av pakkehoder** 
- Protokollenes virkemåte er entydig gitt av innholdet i header og reglene for håndtering av disse

**PDU-navn per lag:**

| Lag               | PDU-navn         |
| ----------------- | ---------------- |
| Applikasjonslaget | Melding          |
| Transportlaget    | Segment/datagram |
| Nettverkslaget    | Pakke/Datagram   |
| Lenkelaget        | Ramme (Frame)    |
| Fysisk lag        | Bitstrøm         |

## 1.4 Kryptert overføring
Sikker overføring kan skje på flere lag *samtidig* og uavhengig av hverandre
- Transport: TSL/SSL
- Nettverk: VPN
- Lenkelag: WPA2
## 1.5 Internett er en sammenkopling av IP-subnett 
**Et IP-subnett er kjennetegnet ved at**
- Subnettet har et unikt prefiks (egen adresse) på internett
- Nodene kan kommunisere direkte med hverandre, de har et felles kringkastingsdomene.
- Nodene i subnettet må gå via en ruter (Default gateway) for å kommunisere med andre subnett

IP-addresser og routing hører til i *nettvverkslaget*
*Lenkelaget* sørger for fysisk overføring av pakker mellom nettverkskortenes MAC-addresser på *lenkelaget*

IP-adressen brukes mellom to maskiner hvor pakken kan måtte passere mange rutere
før den kommer frem. For hvert hopp blir det nye MAC-adresser (mellom nye
nettverkskort) mens IP-adressene er uendret. Når pakken er kommet frem til rett IP-
adresse er det portnummer som avgjør hvilken applikasjon nyttelasten skal overlates til.

Portnummer som knytter applikasjonene sammen og transportlaget sier derfor å ha ende-ende 
## 1.6 Adresser i datapakker
**Transportlaget:** PORTNUMMER
- 16 bit, addresserom 0-65535 (64k)
- F.eks: HTTP har portnummer 80
**Nettverkslaget:** IP-ADDRESSER
- IP-addressen inneholder både en nettadresse og en nodeadresse, disse skilles med nettmasken
- IPv4 32 bit, kan skrives 158.38.50.20
- IPv6 128 bit, kan skrives 2001:1002::1
**Lenkelaget:** MAC-ADDRESSER
- 48 bit, inneholder produsent og unik nodenummer
- Skrives på hex-format: 12:34:56:78:9A:BC

**Jo høyere opp i lagene, desto lengre er det mellom sender og mottaker**
![[Screenshot 2026-01-07 at 10.28.27.png | 600]]
## 1.7 Demultipleksing gjennom lagene - Protokollfelt-oversikt

> **Eksamensklassiker!** Spørsmål om hvilke headerfelt som tilhører hvilken protokoll har kommet på V22 og V24.


**Multipleksing:** Sender
**Demultipleksing**: prosessen der mottaker finner ut hvilken applikasjon innkommende pakke tilhører

Hvert lag bruker spesifikke felt i pakkehodet for å identifisere neste lags protokoll (demultipleksing):
```
Ethernet-ramme:  EtherType 0x0800  → IPv4   (0x86DD → IPv6, 0x0806 → ARP)
IPv4-header:     Protocol 6        → TCP    (17 → UDP, 1 → ICMP, 41 → IPv6)
IPv6-header:     Next Header 6     → TCP    (17 → UDP, 58 → ICMPv6)
TCP-header:      Dest. port 80     → HTTP   (443 → HTTPS, 53 → DNS)
```
**Oppslagstabell - Headerfelt → Protokoll:**

|Headerfelt|Tilhører protokoll|Lag|
|---|---|---|
|Host: <n>|HTTP|Applikasjonslag|
|Sekvensnummer (Sequence Number)|TCP|Transportlag|
|Source port / Destination port|TCP og UDP|Transportlag|
|Window size|TCP|Transportlag|
|Length|UDP|Transportlag|
|TTL (Time to Live)|IPv4|Nettverkslag|
|Hop Limit|IPv6|Nettverkslag|
|Protocol|IPv4|Nettverkslag|
|Next Header|IPv6|Nettverkslag|
|Header Checksum|IPv4|Nettverkslag|
|Preamble|Ethernet (802.3)|Lenkelag|
|MAC destination address|Ethernet (802.3) og 802.11|Lenkelag|
|EtherType|Ethernet (802.3)|Lenkelag|
|CRC|Ethernet (802.3)|Lenkelag|
|Type: AAAA|DNS (Resource Record)|Applikasjonslag|
## 1.8 Checksum-håndtering per lag

> **Eksamensklassiker!** V24 spurte spesifikt om hva som skjer ved feil sjekksum.

Checksum: tall som beregnes fra dataene som sendes, og brukes for å sjekke om noe har blitt ødelagt underveis

| Lag          | Protokoll | Sjekksum?         | Hva skjer ved feil?                                                                                    |
| ------------ | --------- | ----------------- | ------------------------------------------------------------------------------------------------------ |
| Transportlag | TCP       | Ja                | Pakken kastes **uten varsel** til avsender. Retransmisjon håndteres av TCP selv (timeout/duplikat-ACK) |
| Transportlag | UDP       | Ja (valgfri)      | Pakken kastes uten varsel                                                                              |
| Nettverkslag | IPv4      | Ja (kun header)   | Pakken kastes. Ingen ICMP-varsling ved sjekksum-feil                                                   |
| Nettverkslag | IPv6      | **Nei** (fjernet) | Avsender og mottaker håndterer tapte pakker selv via transportlag                                      |
| Lenkelag     | Ethernet  | Ja (CRC)          | Rammen forkastes stille – **ingen** bekreftelse sendes. Upålitelig overføring                          |
| Lenkelag     | 802.11    | Ja (CRC)          | Rammen forkastes, men **ACK** sendes normalt for vellykkede rammer (CSMA/CA)                           |

**Viktig:** Ingen av lagene _korrigerer_ bitfeil – de bare _oppdager_ og _forkaster_. Pålitelig levering er TCP sitt ansvar.

---
# 0 Nettverksprogrammering 
En **socket** er endepunkt for nettverkskommunikasjon. Socket = IP-adresse + Portnummer

**To typer sockets:**
- TCP socket (SOCK_STREAM): Forbindelsesorientert, pålitelig bytestrøm
- UDP socket (SOCK_DGRAM): Forbindelsesløs, upålitelig datagram

**HTTP vs WebSocket:**

| Egenskap             | HTTP                                                 | WebSocket                                   |
| -------------------- | ---------------------------------------------------- | ------------------------------------------- |
| Kommunikasjonsmodell | Request-response (halv dupleks)                      | Full dupleks, kontinuerlig                  |
| Hvem initierer       | Alltid klienten sender request                       | Begge parter kan sende når som helst        |
| Forbindelse          | Kobles opp og ned per forespørsel (eller Keep-Alive) | Holdes oppe kontinuerlig                    |
| Overhead             | Ny header for hver melding                           | Minimal header etter oppkobling             |
| Bruksområde          | Tradisjonelle websider, REST API                     | Chat, live-oppdateringer, gaming, strømming |
**Hvordan WebSocket etableres**
1. Klient sender en HTTP Upgrade-request (vanlig HTTP GET med spesielle headere)
2. Server svarer med HTTP 101 Switching Protocols
3. Fra dette punktet brukes WebSocket-protokollen over den eksisterende TCP-forbindelsen
4. Begge parter kan nå sende meldinger fritt uten å vente på request
**WebSocket frame-struktur**
- Opcode: type melding (tekst, binær, ping, pong, close)
- Masking: klient-til-server meldinger maskeres (XOR med nøkkel)
- Payload length: lengde på nyttelast
- Payload data: selve meldingen
**WSS (WebSocket Secure)**
- WSS er WebSocket over TLS 
- Kryptert forbindelse med TLS/SSL
- Servere trenger digitalt sertifikat 
- Bruker port 443
---
# 2 Applikasjonslag - HTTP, DNS og epost
## 2.1 Applikasjonslaget: webtjenesten
**Applikasjonslaget:** øverste laget i forenklede 5-lags ISO-modellen. 
- Laget har direkte grensesnitt mot nettverksapplikasjonene vi bruker daglig, som nettleser, epostklienter, og andre programmer som kommuniserer over nettverk
**Lagets rolle og funksjon**
- Applikasjonslaget benytter overføringstjenester fra transportlaget under seg. Betyr at applikasjonene ikke trenger å bekymre seg for hvordan data faktisk blir sendt over nettverk - det håndteres av de lavere lagene.  
- Applikasjonslaget fokuserer på *hva* som skal sendes og hvordan meldingene skal formateres
**Applikasjon vs protokoll**
- Applikasjonen (programmet du bruker) ikke regnes som en del av applikasjonslaget. 
- Applikasjonen er noe ulike produsenter utvikler 
- Det som er en del av applikasjonslaget er *protokollene*: standardiserte reglene for hvordan meldinger skal utveksles.
	- Browser må følge HTTP
	- Epostklienter må følge SMTP for sending og POP/IMAP for lesing
	- Alle programmer som trenger domenenavn må bruke DNS
- Disse protokollene gjør at programvare fra ulike produsenter kan fungere sammen. W3c og IETF 

**IETF og RFC**
- Internett-standarder utvikles av IETF (Internet Engineering Task Force)
- Bruker RFC (Request for Comments) som metode: frivillige brukergrupper diskuterer, tester og lager innstillinger
- Med fungerende kode og allmenn støtte er det en prosess fra foreslått standard til vedtatt standard
## 2.2 HTTP - HyperText Transfer Protocol
**HTTP:** protokollen som driver World Wide Web. Den spesifiserer hvordan request og responses skal utveksles mellom klient (nettleser) og tjener (webserver). HTTP er definert i flere RFC-dokumenter, primært RFC 7230-7235 for versjon 1.1

**Hva inngår i web-tjenesten?**
Klienten viser en HTML-side som kan være bygd opp av elementer fra flere Web-tjenere.
Nettleseren henter først index-filen (index.html) og skanner etter referanser til flere objekter som lastes ned i tur og orden.
- Klient: etterspørsel (request)
- Tjener: svar (response)
#### Grunleggende egenskaper
HTTP is a *stateless* application-level request/response protocol that uses extensible semantics and *self-descriptive message payloads* for flexible interaction with network-based hypertext information systems
**Stateless**
- HTTP er en tilstandsløs protokoll som betyr at hver request behandles uavhengig av tidligere requests. 
- Serveren "husker" ikke hvem du er mellom requests. 
- Dette forenkler serverdesign og gjør det mulig å håndtere tusenvis av samtidige tilkoblinger, men skaper utfordringer for funksjoner som netthandel og brukertilpasninger. Løsningen her: cookies (informasjonskapsler)
**Selv-descriptive message payloads**
- HTTP-meldinger er tekstbaserte og selvbeskrivende. 
- Hver headerlinje i meldingen har navn og innhold i klartekst, adskilt med kolon (kolonseparerte navn/verdi-par). 
- Gjør lesbar for menneske
- Meldingsheader har ikke fast lengde, dette gir mulighet for å legge til nye headerlinje for å støtte ny funksjonalitet
#### HTTP-meldingsformat
**Request** En HTTP-request består av tre deler:
1. *Request-linje:* Inneholder metode (GET, POST, HEAD, osv), URL og HTTP-version. Method SP request-target SP HTTP-version CRLF
2. *Headerlinjer:* Tilleggsinformasjon som Host, User-agent, Accept-language
3. *Body:* Eventuelle data (tom ved GET, brukes ved POST)

**Reponse** En HTTP-respons har tilsvarende struktur:
1. *Statuslinje:* HTTP-version, statuskode og statustekst. HTTP-version SP status-code SP reason-phrase CRLF
2. *Headerlinje:* Server-info, dato, innholdstype, lengde
3. *Body:* Selve innholdet (HTML, bilder, osv.)

Statuskoder: 200, 301, 304
- 304 Not modified betyr: "bruk kopi du har lagret i cache"
#### HTTP-metoder
- **GET:** henter ressurs fra webserveren
- **POST:** Sender data til webserveren
- **HEAD:** Som GET, men returnerer bare header (brukes for debugging)
- **PUT:** Laster opp en ressurs til en spesifikk plassering
- **DELETE:** Sletter en ressurs på webservern
#### Viktige mekanismer i HTTP
**Cookies (informasjonskapsler)**
Cookies løser problemet med at HTTP er tilstandsløs. De fungerer slik:
1. Når du besøker en nettside, oppretter webserveren en unik identifikator
2. Webserveren sender denne responsen med `set-cookie:1678`(serveren lager cookien)
3. Nettleseren lagrer cookien i en lokal fil (nettleser er klient)
4. Ved senere forespørsler sender nettleseren `cookie:1678`

**Lokalt mellomlager (cache)**
- For å spare tid og båndbredde lagrer nettleseren kopier av webobjekter lokalt. Trenger ikke å laste objekter på nytt hver gang - det er sløsing med tid og båndbredde. Ved neste forespørsel brukes headeren: `If-Modified_since: Fri, 14 Jan 2026 12:26:16 GMT`
- Serveren svarer enten med hele filen på nytt eller `304 Not Modified` hvis filen er uendret

**Vedvarende forbindelse (Keep-Alive)**
- HTTP/1.1 vil som standard kople ned TCP etter endt overføring
- For å spare tid (slippe å etablere ny TCP-forbindelse) kan klient be om å holde forbindelsen oppe
- Klient ber: `Connection: Keep-Alive`
- Server svarer: `Keep-Alive: timeout=5 (sek), max=100 (objects)`

**Webhotell (Web Hosting)**
- En webserver kan betjene mange ulike nettsider på samme IP-adresse.
- Problemet er at en TCP-tilkobling (socket) bare identifiserer IP og port, ikke hvilken nettside du vil ha. 
- Løsningen er at klienten sender med `Host: datakom.no`i HTTP-headeren. 

**HTTP/2 (RFC 7540) - Forbedringer**
- Header-komprimering: Reduserer datamengden i headeren
- Multipleksing: Flere samtidige overføringer på samme forbindelse
- Server push: Serveren kan sende ressurser før klienten ber om dem 

**HTTP/3 - HTTP/2 over QUIC**
- Bygges videre på HTTP/2 med headerkomprimering og oppdeling av objekter i små PDU som sendes om hverandre
- Bruker QUIC istedenfor TCP
- QUIC bruker UDP, slipper "omstendelig" TCP
- QUIC har innebygd kryptering, kontrollerer pakketap og trafikkflyt, og håndterer multiple strømmer (overfører flere objekter samtidig)
## 2.3 DNS
DNS: oversetter domenenavn (som datakom.no) til IP-addresser (som 129.241.160.10). Nettverket trenger IP-addresser for å rute pakker, men mennesker foretrekker navn som er lettere å huske

**Hvorfor DNS?**
- Domenenavn kan forbli stabile selv om underliggende IP-addresser endres
- DNS brukes også for verifisering gjennom reversoppslag (IP-domenenavn)

PDU - pakkedata enheter
#### Hierarkisk struktur
DNS er hierarkisk oppbygd, både i infrastrukur og forvaltning:
**Infrastruktur - typer navnetjenere**
- *Root servers:* 13 logiske 
- *TLD-servers (Top Level Domain):* Ansvarlige for toppnivådomener som .no, .com, .org 
- *Autoritative servers:* Har "fasiten" for spesifikke domener (f.eks. ntnu.no)
- *Lokale servers (rekursive):* Din ISP/organisasjon sin navnetjener som gjør oppslag på dine vegne og cacher svar 
**Forvaltning**
- ICANN: Overordnet ansvar internasjonal
- Regionale organer: f.eks. NORID for .no-domenet i Norge
- Registrere: Firmaer som selger domener til sluttbrukere som domeneshop.no
#### DNS Resource Records (RR)
DNS lagrer informasjon i Resource Records. Er en stor database hvor hver rad har et type-felt og en verdi

| Type  | Betydning      | Innhold                              |
| ----- | -------------- | ------------------------------------ |
| A     | Address        | IPv4-addresse for et domenenavn      |
| AAAA  | IPv6 Address   | IPv6-addresse for et domenenavn      |
| MX    | Mail Exchanger | IP/navn til e-posttjener for domenet |
| NS    | Name Server    | Navnetjener ansvarlig for domenet    |
| CNAME | Canonical name | Alias til et annet domenenavn        |
| PTR   | Pointer        | Reversoppslag: IP $\to$ domenenavn   |
#### Rekursive vs Iterative oppslag
- **Rekursivt:** navnetjeneren spør videre på vegne av klienten til den finner svaret. Din lokale navnetjener jobber rekursivt
- **Iterativt:** Navnetjeneren svarer bare med en henvisning til hvor det kan spørres videre. Root server og TLD server jobber iterativt.

**Hva gjør lokal navnetjener ved ukjent domenenavn?**
- Lokal nameserver jobber rekursivt: den spør videre på vegne av klienten helt til den får et svar.
- Viktig prinsipp: lokal nameserver spør alltid root-server først. 
- Root-server kjenner ikke enkeltdomener, men sender svar på hvilken TLD-server som kan spørres videre. 
- Lokal nameserver spør da videre helt til den får svar fra en server som vet
- Svaret kan da enten være lokalt lagret med gyldig levetid (cache) eller vil komme til syvende og sist fra autoritativ nameserver
#### DNSsec - sikkerhet
DNS var opprinnelig designet uten sikkerhet. DNSsec (DNS Security Extensions) løser dette:
- Beskyttet mot DNS-spoofing og man-in-the-middle-angrep
- Bruker offentlige nøkkelkryptering til å signere DNS-svar. DNSKEY 
- Klienter kan validere at svaret kommer fra riktig kilde
- Krever støtte i både DNS-servere og klienter
## 2.4 E-post - SMTP, MIME og POP/IMAP
**Tre protokoller**
- SMTP: sending av e-post. RFC 5321
- MIME: Formatering av innhold. RFC 2045
- POP3/IMAP4: Lesing av e-post. RFC 1939 / RFC 3501

**SMTP - Simple Mail Transfer Protocol**
SMTP brukes for sending av e-post - både klient til server mellom servere. Protokollen er kjennetegnet ved handshaking (kontrollmeldinger) før selve e-posten overføres.
- Viktig: E-posten avsluttes med et punktum alene på en linje (.). 
- SMPT bruker US-ASCII (7-bit), som skaper utfordringer for vedlegg og nasjonale tegn
- SMTP sender uten passord, men bør bruke kryptert overføring (port 587)

**MIME**
Siden SMTP kun støtter 7-bit US-ASCII, trengs MIME for å håndtere: filvedlegg, nasjonale tegnsett, HTML-formatert innhold

Base64-koding
- MIME bruker Base64-koding for å konvertere 8-bit data til 7-bit ASCII. Process:
	1. Ta 3 bytes (24 bit) av originaldata
	2. Del opp i 4 grupper 6 bit
	3. Map hver gruppe til et tegn i Base64-alfabetet
	4. Resultat: 33% økning i filstørrelse (3 bytes blir til 4 tegn)

**POP3 vs IMAP**
Begge protokollene brukes for å lese e-post fra sever, men med viktige forskjeller:
- *POP3 (Post Office Protocol):* Laster ned e-post til klienten og sletter den fra serveren. Enkel, men e-post er bare tilgjengelig på én enhet
- *IMAP (Internet Message Access Protocol):* Synkroniserer med serveren. E-post forblir på serveren og kan organiseres i mapper. Tilgjengelig fra flere enheter
- Viktig forskjell fra *SMTP*: POP3 og IMAP krever innlogging med brukernavn og passord. SMTP sender uten passord (men bør bruke kryptert overføring).
## 2.5 Oppsummering
Tre mest brukte applikasjoner på internett - web, e-post og nameserver, deler samme grunnstruktur: protokoller som sender meldinger mellom client og server. Disse protokollene ligger på applikasjonslaget og er standardisert slik at programvare fra ulike produsenter kan samarbeide
# 3 Transportlaget - TCP og UDP.Kryptering og digitale sertifikater. HTTPS
## 3.1 Transportlagets oppgave
Transportlaget har to hovedoppgaver:
- **Ende-til-ende kommunikasjon:** Tilby kommunikasjon mellom porter (grensesnitt mot applikasjoner) på to ulike maskiner
	- Men det kan være flere parallell forbindelser
	- Avsender og mottaker er identifisert med portnummer på transportlaget. Porten er aktiv dersom programmet kjører, dsv *lytter* på porten. Det er portnummer som gjør at en kan få riktig kontakt med server
	- Maskinene som programmene kjører på er identifisert med IP-adresse.
- **Tjenestekvalitet:** Øke kvaliteten på overføringen. UDP og TCP tilbyr ulik tjenestekvalitet
## 3.2 Adressering på transportlaget
Transportlaget bruker *porter* for adressering. Porter er 16-bit, som gi 65536 mulige addresser. 

| Porttype               | Portnummer   | Beskrivelse                             |
| ---------------------- | ------------ | --------------------------------------- |
| Velkjente/systemporter | 0-1023       | Reservert for standardtjenester         |
| Registrerte porter     | 1024-49151   | Registrert for spesifikke applikasjoner |
| Dynamiske/private      | 499152-65535 | Kortlivde, klienttilkoblinger           |
- **Socket** = IP-addresse + Portnummer (entydig identifikator for en forbindelse)
- Porter er KUN aktiv dersom en app kjører (lytter på porten)

**Viktige portnummer**

| Port   | Protokoll            |
| ------ | -------------------- |
| 80     | HTTP                 |
| 443    | HTTPS / WSS          |
| 53     | DNS                  |
| 25/587 | SMTP                 |
| 110    | POP3                 |
| 143    | IMAP                 |
| 67/68  | DHCP (server/klient) |
| 22     | SSH                  |

## 3.3 UDP - User Datagram Protocol
![[Pasted image 20260121211520.png | 600]]
UDP er en forbindelsesløs protokoll som tilbyr **upålitelig** overføring av uavhengige datapakker. er enkel og rask protokoll, ingen garantier. 

**Header**
- Source port number.
- Destination port number
- Total length: hvor langt datafeltet er
- Checksum: se om innholdet i pakken ikke har endret seg. Feil sjekker for pakkehodet og innholdet, som er valgfritt; IPv4 lar det være valgfritt, mens IPv6 krever dette. Dersom ubrukt, opptrer det som en rekke nuller. 

**Egenskaper**
- Ingen oppkoblingsfase: sender data umiddelbart uten håndtrykk
- Ingen garanti for levering: Pakker kan gå tapt, dupliseres eller komme i feil rekkefølge
- Lav overhead: minimal pakkeheader (8 byte)
- Hastighet: optimalisert for sanntidsapplikasjoner
**Bruksområder:** brukes hovedsakelig når det er ønskelig å redusere bruken av maskinressurser
- Sanntidsapplikasjoner (video/lyd-strømming)
- DNS-oppslag (port 53)
- DHCP (porter 67/68)
- Online gaming 
## 3.4 TCP - Transmission Control Protocol
TCP er en forbindelsesorientert protokoll som tilbyr **pålitelig** overføring av en bytestrøm

**Egenskaper**
- Forbindelsesorienterting: Må etablere forbindelse før dataoverføring
- Punkt-til-punkt: Alltid to endepunkter, ingen multicast
- Deler opp melding i segmenter som sendes hver for seg. Settes sammen igjen hos mottaker før meldingen overlates til applikasjonslaget
- Pålitelighet: Garanterer data uten bitfeil. tap eller duplisering
- Full-dupleks: data kan sendes i begge retninger samtidig
- Bytestrøm: kontinuerlig strøm av bytes, ikke diskrete meldinger
- Piggybacking: kvittering legges til datapakker for effektivitet
- Brukes når man trenger krav til korrekt innhold, typisk filoverføringer som web

**Hvordan oppnår TCP pålitelig overføring?**

> **Eksamensklassiker!** V24: "Hvordan oppnår TCP en pålitelig overføringstjeneste?" Svar: Ved at mottaker sender kvitteringer til avsenderen for mottatte data.
### 3.4.1 Pålitelig overføring
Data overføring med kvittering så avsender vet hvor mye som har kommet frem

**Selve overføringen:**
1. Oppkobling: 3WHS 
2. Dataoverføring: kontinuerlig byte-strøm (i begge retninger) hvor hver byte telles og kvitteres.
3. Nedkobling: En av partene initierer med FIN-flagg

**Flagg:**
- *SYN* (Synchronize) - "jeg vil starte en forbindelse". Brukes utelukkende i oppkoblingsfasen for å synkronisere sekvensnumre mellom sender og mottaker
- *ACK* (ackknowledge) - "jeg har mottatt dataene dine". Bekrefter at data er mottatt. Etter oppkoblingen er ACK-flagget satt i nesten alle pakker
- *FIN* (final) - "Jeg er ferdig med å sende". Signaliserer at senderen vil avslutte forbindelse og frigjør buffere og andre ressurser.
- *ISN* (Initial Sequence Number) - Ikke et flagg, men startverdi for sekvensnummereringen. Det er et tilfeldig 32-bit tall som velges ved oppkobling. Wireshark viser det som "0" for lelsbarhet (relativt sekvensnummer), men den faktiske verdien er mye større.

TCP brukes en **treveis håndtrykkprosedyre** (3WHS) for pålitelig oppkobling:
1. *SYN:* Klient sender pakke med SYN-flagg=1 og tilfeldig sekvensnummer (ISN)
2. *SYN-ACK:* Server svarer med ACK-flagg=1, kvitteringsnr=ISN+1, eget SYN-flagg og egen ISN
3. *ACK:* Klient bekrefter med ACK-flagg=1 og kvitteringsnr=server_ISN+1

Viktig: begge parter oppretter sende- og mottakerbuffer under oppkoblingen
#### 3.4.1.1 Oppkopbling 3WHS
- TCP-kontrollpakker som sendes FØR data overføres
- En part tar initiativ og sender en SYN-pakke
	- Betyr at SYN-flagget er satt, og sender med sitt ISN som er initielt sekvensnummer
- Motparten svarer med sitt ACK-flagg, kvitterer at det er ok. Men det ønskes dataoverføring i begge retninger, sender derfor OG eget SYN-flagg + ISN
- Initiativtaker kvitter mottatt med sitt ACK-flagg
#### 3.4.1.2 Dataoverføring
**Sending og mottak med kvittering**
Sekvensnummer viser posisjon til *første* byte i segmentet. Kvitteringsnummeret viser forventet startnummer til byte i neste segment. 
1. Klient (avsender) sender *sekvensnummer* = 1234 og størrelse = 100. 
2. Server (mottaker) sender *kvitteringsnummeret* 1334 (sekvensnummer + størrelse)

**Overføring er toveis**
- Et segment vil som regel inneholde BÅDE sekvensnummer og kvitteringsnummer fordi datastrømmen går begge veier
- ACK er et FLAGG (0/1) som viser at kvitteringsnummer er gyldig når det er satt
- Sekvensnummer og kvitteirngsnummer er TELLERE som holder styr på sendte data og mottatte kvitteringer

**Kvittering på mottatte data**
Pålitelig overføring krever kvittering
- *Sekvensnummer* viser startposisjon til *første* byte i pakkens nyttelast
- *Kvitteringsnummer* som sendes tilbake er summen av mottatte pakkets sekvensnummer (første posisjon) pluss lengden/størrelsen av nyttelasten i dette segmentet. Viser forventa sekvensnummer til første byte i neste mottatte pakke. Dermed er alle byte opp til dette nummeret i strømmen kvittert ok mottatt.

**Data**
- Data fra applikasjon sendes i segmenter
- Typisk TCP nyttelast (Max Segment Size) er på 1460 byte, sjekk "options" i SYN-pakke i Wireshark 1460 + 20 (TCP header) + 20 (IP header) = 1500 byte til lenkelaget
	- Lenkelaget har tradisjonelt 1500 byte som max pakkestørrelse, men kan settes større hvis forbindelsen tillater det.
- ISN (Initial Sequence Number) 32-bit sekvensnummer (for hver byte som overføres) settes tilfeldig av sikkerhetsgrunner. ISN vises som "relativt 0" i Wireshark i pakkestrømmen
#### TCP kvitterings-regneeksempler
**Eksempel 1:** A sender to segmenter på 100 byte hver til B (relativt ISN=1)

| Retning | Sekv.nr | Kvitt.nr | ACK | Nyttelast |
| ------- | ------- | -------- | --- | --------- |
| A → B   | 1       | 1        | 1   | 100 byte  |
| B → A   | 1       | 101      | 1   | 0 byte    |
| A → B   | 101     | 1        | 1   | 100 byte  |
| B → A   | 1       | 201      | 1   | 0 byte    |
**Eksempel 2:** klient sender tredje segment til webserver
```
Klient → Server:  Sekv.nr = 101, Payload = 619 byte, Kvitt.nr = X
Server → Klient:  Sekv.nr = 317, Payload = 17 byte, Kvitt.nr = Y
```
- **Y** = 101 + 619 = **720** (serveren kvitterer alle mottatte bytes fra klient)
- **X** = **317** (klienten forventer byte 317 som neste fra server, dvs. serveren har sendt 316 bytes tidligere)
**Formel:** `Kvitteringsnummer = Mottatt sekvensnummer + Mottatt payload-størrelse`
#### 3.4.1.3 Nedkobling
- TCP har ingen timeout, en av partene må aktivt foreta nedkopling (som regel serveren)
- Bruker FIN-flagget.
	- Motparten kvitterer med ACK og forbindelsen holdes til dette er mottatt
- Dette er i samsvar med HTTP-funksjonen "Keep-Alive" hvor partene er enige om å holde en TCP-forbindelse en viss stund, i påvente av flere overføringer fra websiden

**Hvorfor kobler vi ned?**
Ved pålitelig overføring blir det opprettet en tilkobling mellom sender og mottaker, denne tilkoblingen må lukkes akkurat som den må åpnes. Nedkobling sørger for at det ikke oppstår en låse-situasjon (hverken av endepunktene kan frakobles, da sende-vinduet er oppbrukt) mellom sender-mottaker, og frigir ressurser til neste overføring

**TCP bruker half-lose for nedkobling i hver retning**
1. En part sender segment med FIN-flagg
2. Mottaker kvitterer med ACK
3. Mottaker sender eget FIN når den er klar
4. Initiativtaker kvitterer med ACK
### 3.4.2 TCP header
![[Pasted image 20260121172535.png | 560]]
Mer overhead enn UDP

| **Felt**               | **Størrelse** | **Beskrivelse**                                                                                                                                      |
| ---------------------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Source/Dest Port       | 2+2 byte      | Avsender- og mottakerport                                                                                                                            |
| Sequence Number        | 4 byte        | Sier hvor langt i datastrømmen akkurat denne pakken er. Posisjon til første byte i nyttelast. Gjør det mulig å sette ting sammen i riktig rekkefølge |
| Acknowledgement Number | 4 byte        | Bekreftelse på hvor langt i datastrømmen vi har mottatt alle pakkene. Neste forventede byte fra mottaker.                                            |
| Data Offset            | 4 bit         | Headerlengde (i 32-bit ord)                                                                                                                          |
| Control Flags          | 9 bit         | SYN, ACK, FIN, RST, etc.                                                                                                                             |
| Window Size            | 2 byte        | Hvor mange pakker kan være på vei mellom de to stedene før de stopper opp å venter. Retningskontroll. Flytkontroll - bufferstørrelse                 |
| Checksum               | 2 byte        | Feildeteksjon for å forsikre at man har mottatt riktig data                                                                                          |
Optional packet header data sendes i SYN-pakken

**Sekvensnummer:** angir startsposisjon for første byte i nyttelasten (IKKE pakkernummer)
**Kvitteringsnummer:** Sekvensnummer + nyttelast = neste forventede byte

**Akkumulativ kvittering:** TCP kan kvittere flere pakker samtidig ved å sende kvittering for sist mottatte gyldige byte.
### 3.4.3 Sliding window
**Formål:** Effektivisere overføring ved å sende flere segmenter uten å vente på kvittering for hvert enkelt. Utnytte båndbredden bedre

**Hvorfor?**
- *Stop-and-wait:* sender én pakke, venter på kvittering $\to$ utnytter bare 5-50% av båndbredden
- *Glidende vindu:* sender flere pakker forløpende $\to$ kan utnytte 100% av båndbreddem

**Virkemåte:**
- Sender holder oversikt over sendte, men ukvitterte pakker
- Mottaker holder oversikt over mottatte, men ukvitterte pakker
- Pakker går fra sender til motakker. Kvitteringer går tilbake
- Vinduet "glir" fremover når kvitteringer mottas
- Vindustørrelsen påvirkes av RTT, flytkontroll og metningskontroll

Ikke sende så mange pakker om gangen da risikerer man at pakker forsvinner. *Window size i* headeren brukes til å passe på at man ikke sender for mange pakker, hvort stort sliding window skal være. 

**Metningskontroll med glidende vindu**
- *Metning*, opphoping i nettet, som skjer når rutere ikke klarer å videresende alle pakker. Da hjelper det ikke å pøse på med retransmisjoner noe som vil sløse båndbredde
- TCP går inn i en "vær varsom" tilstand hvor det bare blir sendt én pakke og venter til den er kvittert 
- TCP reduserer window size drastisk
- Starter forsiktig med 1 segment, øker gradvis

**Indikasjon på metning:** Pakkekvittering uteblir (timeout) eller duplikatkvittering på tidligere kvittert pakke.
### 3.4.4 Retransmisjon ved pakketap
- TCP med glidende vindu har sendt mange segmenter som ikke er kvittert enda
- TCP oppdager pakketap når kvittering uteblir (hvert segment har en timeout)
- Ved timeout eller duplikatkvittering må pakker sendes på nytt, elllrs er det ikke pålitelig overføring
To strategier:
- **Go-back-N:** Send alle pakker på nytt fra og med den som manglet. Enklere, men mindre effektiv
- **Selective Repeat:** Send bare den pakken som manglet. Krever SACK (avtales i 3WHS). Mer effektivt

Retransmisjon strategien avtales ved oppkopling, 3WHS, i SYN-pakkens options felt
### 3.4.5 TCP vs UDP
UDP er pakke-basert (datagrammer), ikke strøm-basert som TCP

| **Egenskap**     | **TCP**                    | **UDP**                |
| ---------------- | -------------------------- | ---------------------- |
| Forbindelse      | Forbindelsesorientert      | Forbindelsesløs        |
| Pålitelighet     | Pålitelig (kvitteringer)   | Upålitelig             |
| Rekkefølge       | Garantert                  | Ikke garantert         |
| Flytkontroll     | Ja                         | Nei                    |
| Metningskontroll | Ja                         | Nei                    |
| Header-størrelse | 20-60 byte                 | 8 byte                 |
| Hastighet        | Tregere (overhead)         | Raskere                |
| Bruksområde      | Web, e-post, filoverføring | Strømming, DNS, gaming |
**Hvordan vet IP hvilken protokoll pakken skal leveres til?**
Svar: IP har informasjon om dette i protollheader (Protocol-feltet i IPv4, Next Header i IPv6)
## 3.5 Kryptering og sikkerhet
### 3.5.1 CIA-triaden - Sikkerhetsfunksjoner

| Sikkerhetsfunksjon | Betydning                    | Nettverksløsning             |
| ------------------ | ---------------------------- | ---------------------------- |
| Konfidensialitet   | Beskyttelse av sensitiv info | Kryptering                   |
| Integritet         | Opprettholde korrekthet      | Sjekksum/hashing             |
| Autentisitet       | Pålitelig kilde, tillit      | PKI og digitale sertifikater |
Andre begreper bruk i sikkerhetssammenheng
- Tilgjengelighet
- Non-repudiation (ufraviselig)

Sikkerhetsfunksjonene kan anvendes alene eller i kombinasjon
- **Fildeling:** Man kan laste ned åpent tilgjengelige filer. Filens sjekksum står på nedlastingssiden (sammen med hvilken hashing-algoritme som er brukt). Mottaker beregner sjekksum og sammenlikner. Gir *integritet*
	- Men noen kan ha endret fil-innholdet og beregnet ny sjekksum som er lastet opp på websiden
- **Netttbank:** Man vil vite hvem man kommuniserer med, at det ikke er en falsk webside. Webserver har et digitalt sertifikat som en tiltrodd tredjepart går god for. Dette gir autensitet. Samtidig brukes sertifikatet også til å kryptere også til å kryptere data, det gir *konfidensialitet* i tillegg
	- Merk at websiden er åpent for alle, men alle får sin unikt krypterte forbindelse
### 3.5.2 Tre kryptografiske metoder
1. **Symmetrisk kryptering (AES)**
	- En felles nøkkel (kodemetode) for kryptering og dekryptering
	- Standard: AES (Advanced Encryption Standard). Metoden er kjent, nøkkelen hemmelig
	- Fordel: effektiv bruk av CPU, rask
	- Ulempe: nøkkeldistribusjon - hvordan overbringe nøkkel sikkert?
2. **Asymmetrisk kryptering (RSA)**
	- To nøkler: private og public
	- Det som krypteres med én nøkkel kan bare dekrypteres med den andre
	- Kan både kryptere/dekryptere med public og private key
		- Krypetere med private key, dekryptere med public key. Vite avsenderen
		- Kryptere med public key, dekryptere med private key. Når man sender pakken som bare de kan pakke krypterer man med public key og bare de kan dekryptere da bare de har private key
	- Standard: RSA (Rivest-Shamir-Adleman) er grunnlaget for PKI og digitale sertifikater
	- Fordel: Enkel distribusjon av public key
	- Ulempe: Krevende CPU-belastning
	- Kan bruke til å kryptere nøklene brukt i symmetrisk kryptering og deretter bruke symmetrisk kryptering
3. **Hashing (SHA)**
	- Beregner sjekksum (digitalt fingeravtrykk) av melding
	- Fast lengde, kan ikke reverseres for å finne meldingen. 
	- Enhver endring i melding gir totalt annerledes sjekksum
	- Standard: SHA (Secure Hashing Algorithm)

> Hva brukes hashing til? Svar: Kontrollere integritet og generere en sjekksum. IKKE kryptere innholdet, IKKE opprette sesjonsnøkler, IKKE sørger for konfidensialitet

**Merknad**
- AES, RSA og SHA kommer i ulike versjoner og kan ha ulik nøkkellengde. Derfor må partene avtale hvilke versjoner som skal brukes når forbindelsen opprettes
- Lengden (antall bit) for nøklene avtales og jo flere bit desto sikrere kryptering
- Krypteringsmetodene bruker "utfylling/padding" på meldinger, siden det er ikke så mange måter å kryptere et enkelt ord på
- AES og RSA er ikke bevist uknekkelige. Sikkerheten ligger i at sjansen for å finne rett nøkkel er ca 0.

> Hva benyttes AES og RSA til i en HTTPS-sesjon? Svar: RSA brukes ved oppkobling for å utveksle nøkkel sikkert. AES brukes deretter for selve datakrypteringen. RSA er for tungt for løpende kryptering, så man bruker RSA bare for å distribuere den symmetriske AES-nøkkelen.
### 3.5.3 Anvendelser av sikkerhetsfunksjonene, krypto i lagmodellen
Vi har de tre krypometoder, som gir de tre sikkerhetsfunksjonene

Anvendelser av sikkertsfunksjonene finner vi på ulike lag i 5-lags OSI-modellen. De fungerer uavhegngi av hverandre.

| **Lag**           | **Teknologi**                                             | **Funksjon**                   |
| ----------------- | --------------------------------------------------------- | ------------------------------ |
| Applikasjonslaget | Signering av dokumenter (PKI)                             | Autentisert e-post, dokumenter |
| Transportlaget    | Sikker kommunikasjon ende-ende (TLS/SSL)                  | HTTPS, sikker webtjeneste      |
| Nettverkslaget    | Sikker kommunikasjon mellom nett (IPsec/VPN)              | Virtuelle private nett         |
| Lenkelaget        | Sikker kommunikasjon mellom tilstøtende noder (WPA2/WPA3) | Kryptert trådløst nett         |
Eksempel: Gjør oppslag på HTTPS-webserver fra trådløst hjemmenett som er koplet mot NTNU med VPN

## 3.5.4 Digital sertifikat
**Hva er digitalt sertifikat?**
- Innholdet i sertifikatet følger et fastsatt format: X.509
- Hensikt: *autentiserer innehaver* og *distribuere innehavers* *public key*
- Samtidig må det forsikres om at:
	- Sertifikatet er gyldig og ekte
	- Sertifikatet er utstedt av en tiltrodd tredjepart (RA/CA)
- Sertifikatet er altså bare en liten pakke med data, og det er enkelt å «justere» litt på innholdet. Derfor hviler hele PKI (public key infrastructure)-systemet på at man kan verifisere innholdet.
- Til sertifikatet hører det en private key som er oppbevart separat fra sertifikatet. Hvor la jeg nøkkelen?

*Innhold i sertifikatet*
- Innehavers identitet og offentlige nøkkel
- Utsteders (CA) informasjon
- Gyldighetsperiode (fra-til dato)
- Kryptert sjekksum (avtrykk) - kryptert med utsteders private key
- Algoritmer brukt for hashing og kryptering

**Verifisering av et digitalt sertifikat**
- *Gyldighet*
	- Datosjekk, at sertifikatet er gyldig fra-til
	- At sertifikatet ikke er trukket tilbake

- *Ekthet*, at sertifikatet ikke er endret (forfalsket)
	- Vi har i sertifikatet: kryptert sjekksum, hvilke algoritmer som ble brukt for å regne sjekksum og for kryptering av denne (med utsteders private key), navn og adresse på sertifikatutsteder (RA/CA)
	- Det trenger vi: Sertifikatutsteders public key
	- Hva gjør vi: Henter utsteders sertifikat, dekoder sjekksum med utsteders public key, beregner egen sjekksum og sammenlikner disse

**Kontrollere sertifikat, repetisjon:**
Vi har i sertifikatet:
- Kryptert sjekksum av hele sertifikatet (avtrykk)
	- Kryptert med utsteders private nøkkel!
- Hvilke algoritmer som ble brukt for å lage avtrykk
- Navn og adresse på sertifikatutsteder (RA/CA)
Det trenger vi:
- Sertifikatutsteders offentlige nøkkel
Hva gjør vi:
- Henter utsteders sertifikat (for å få offentlig nøkkel)
- Dekoder avtrykk med utsteders offentlige nøkkel
- Beregner egen sjekksum og sammenlikner disse

**Henter utsteder sertifikat**
- Utesteders adresse står i innehavers sertifikat og kan (teoretisk) lastes ned derfra
- I praksis så er sertifikater fra klarerte utstedere også allerde installert på din maskin

**Signering av epost og dokumenter**
![[Screenshot 2026-01-21 at 22.22.37.png | 520]]
Vi har et dokument og et sertifikat. Vi ønsker å sende dokumentet åpent (ikke konfidensielt), men forsikre mottaker om at vi er avsender og at innholdet ikke er endret. 
*Prosedyre:*
- Vi beregner sjekksum av hele dokumentet og krypterer denne med vår private RSA-key. Algoritmene vi bruker (varianter av SHA og RSA) står i sertifikatet.
- Den krypterte sjekksummen (signatur, digitalt fingeravtrykk) sendes sammen med dokumentet og sertifikatet.
- Nå kan mottaker verifisere at dokumentet er uendret og at avsender er autentisert av tiltrodd tredjepart, på samme vis som selve sertifikatet verifiseres

**Steg 2:** `SHA_original = Dec(Signatur, pubCA)` → du pakker ut CA sin originale hash
**Steg 3:** `SHA_din = SHA(Sertifikatdata)` → du hasher **innholdsfeltet** i sertifikatet på nytt selv
**Steg 4:** Sjekk om `SHA_original == SHA_din`
## 3.6 HTTPS og TLS
HTTPS = HTTP over TLS. TLS ligger "mellom" HTTP og TCP
Kun serveren trenger sertifikat
### 3.6.1 TLS etablering
**Sikker kommunikasjon med TLS**
Bruker web HTTPS som eksempel. Brukerne, som ikke har egne sertifikat, ønsker sikker funksjonalitet mot en webtjener.
*Kortversjon av hvordan forbindelsen etableres*
- Klient ber om forbindelse. Tjener svarer med sitt sertifikat.
	- Dersom klient sender TCP-SYN på port 80 vil tjener omdirigere oppkopling til TCP port 443
- Klient kontrollerer sertifikat, genererer et secret tall som krypteres med sertifikatets public key og returnerer det. Dette er asymmetrisk kryptering (RSA)
- Tjener dekrypterer det secret tallet med sin private key. Begge parter er nå i besittelse av en felles, secret nøkkel.
- Denne kan brukes videre for symmetrisk kryptering (AES)
- $\to$ Dette er en elegant måte for å distribuere symmetriske keys

**En litt lengre versjon av TLS etablering**
- Oppkopling initieres og partene avtale hvilke algoritmer de skal bruke (Sterkeste algoritmer som begge parter støtter)
- Tjener sender sitt sertifikat, klienten kontrollerer dette
- Begge parter genererer sine hemmelige tall og oppretter en simpleks-forbindelse i hver retning med symmetrisk kryptering.
	- Dette er mer sikkert når det er ulike nøkler i hver retninger
	- Slettes etter bruk, i tilfelle datainnbrudd på utstyret
- «Hemmelige tall» utveksles med Diffie-Hellman algoritmen, enklere prosess enn «full» RSA-kryptering hvor mottaker må «finne» sin private nøkkel
### 3.6.2 Nøkkelutveksling
Formål: etablere felles secret tall uten å måtte kryptere informasjonsutvesklingen
Brukes til: session keys for symmetrisk kryptering
**Metode 1 (Tradisjonell RSA):**
- Klient genererer tilfeldig tall (symmetrisk nøkkel)
- Krypterer med tjenerens offentlige nøkkel
- Tjener dekrypterer med sin private nøkkel
- Begge har nå samme symmetriske nøkkel

**Metode 2 (Diffie-Hellman - TLS 1.3):**
![[Screenshot 2026-01-21 at 22.27.12.png | 300]]
- Partene utveksler tall uten å måtte kryptere
- Genererer ulike nøkler i hver retning (mer sikkert)
- Sesjonsnøkler slettes etter bruk

# 4 Nettverkslaget - IPv4 og IPv6
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
- **CIDR (Classless Inter-Domain Routing):** Angir nettverksdelen med prefikslengde etter en skråstrek.

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

### 4.2.5 IPv4 Pakkehode
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
- Første adresse = cresse (ikke brukbar for host)
- Siste adresse = broadcast-adresse (ikke brukbar for host)
- Antall brukbare adresser = totalt - 2

**Subnett størrelser:**

| Prefiks | Antall Adresser | Brukbare |
| ------- | --------------- | -------- |
| /24     | 256             | 254      |
| /25     | 128             | 126      |
| /26     | 64              | 62       |
| /27     | 32              | 30       |
| /28     | 16              | 14       |
| /29     | 8               | 6        |
| /30     | 4               | 2        |
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

| IPv4 navn          | IPv6 navn      |                                                                                                                                                      |
| ------------------ | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Protocol           | Next header    | Angir mottakerprotokoll<br>på transportlaget (Som<br>denne pakken skal leveres<br>til)                                                               |
| Time-to-live (TTL) | Hop limit      | Antall rutere som kan<br>passeres (for å unngå<br>loop). Nedtelling til 0,<br>forkastes og sendes ICMP.<br>Testes med Traceroute                     |
| Source IP          | Source IP      | Senders IP-adresse                                                                                                                                   |
| Destination IP     | Destination IP | Mottakers IP-adresse                                                                                                                                 |

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
### 4.6.3 netstat
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

**Rutingtabell på PC:**
- Kolonner: Destinasjon, Nettmaske, Gateway, Interface, Metric
- Rutingtabellen viser: Hvilket IP-grensesnitt som brukes for å nå en bestemt gateway, og hvilke IP-adresser som kan rutes direkte uten å gå via ruter
### 4.6.4 ping
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
### 4.6.5 tracerout / tracert
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

> **Eksamenstips!** Sensorveiledningen sier: "Må nevne BÅDE TTL og hop limit for full score" (V22). TTL er IPv4-navnet, Hop Limit er IPv6-navnet.
# 5 Nettverkslag - Rutere og ruting. NAT og VPN.
## 5.0 Eksamensrelevante teamer
**Basert på tidligere eksamener (V16-V23) er disse spørsmålstypene vanlige:**
- Hvordan avgjør en PC om mottaker er på eget IP-nett?
- Hvordan jobber en ruter?
- Forklar virkemåten til Traceroute
- Hva kjennetegner autonome systemer (AS)?
- Hvilket lag kan benytte VPN? (Flervalgsspørsmål)
- Hvordan fungerer ARP/DHCP?
## 5.1 IP-subnetting 
Subnetting handler om å dele opp et IP-adresserom i mindre deler. Ved å øke nettmasken 1 bit blir adresserommet halvert

**Eksempel**
Et nett a.b.c.0/24 har 256 adresser. Det er gitt et krav om å ha 10 noder i eget IP-nett, resten er "vanlige" brukere. 
- Et eget subnett (lik prefiks) for 10 brukere krever nettmaske /28. Dette gir 16 adresser, og kan ha 14 brukere.
- Øvrige brukere kan fordeles på de resterende subnetta. Det vil minst være 4 andre subnett til innenfor a.b.c.0/24, men disse kan også subnettes videre
- IP-subnett (med ulike prefiks) må kommunisere med hverandre gjennom default gateway (ruter)

**Subnett størrelser**

| Prefiks | Antall Adresser | Brukbare |
| ------- | --------------- | -------- |
| /24     | 256             | 254      |
| /25     | 128             | 126      |
| /26     | 64              | 62       |
| /27     | 32              | 30       |
| /28     | 16              | 14       |
| /29     | 8               | 6        |
| /30     | 4               | 2        |
- Antatt adresser halveres når prefiks øker med $1$
## 5.2 Samspill mellom Nettverkslaget (L3) og lenkelaget (L2) 
Nettverkslaget bruker lenkelaget for å sende IP-pakker ett hopp om gangen
**Nettverkslaget (L3)**
- Kommunikasjon mellom IP-grensesnitt
- bruker logiske IP-adresser
- Et subnett er angitt med et prefiks, det vil si at IP-nodene har felles nettverksdel av IP-adressen
**Lenkelaget (L2)**
- Kommunikasjon mellom nettverkskort
- Bruker fysiske MAC-adresser, knyttet til nettverkskortet
- I et LAN er nodene koplet på samme "LINK", og har derfor et *kringkastingsdomene* (kan kommunisere direkte med hverandre)
Et LAN sørger for at noder i dette IP-subnettet dermed kan kommunisere direkte med hverandre

**Er mottakers IP-adresse innenfor eller utenfor eget subnett?**
Når en node skal sende en pakke, må den avgjøre om mottaker er på eget subnett. 
- Det som avgjør om mottakers IP-adresse er innenfor eget subnett eller ikke er om prefiksene (nettverksdelen av IP-adressen) er like. 
1. Dette bestemmes med å utføre logisk OG-operasjon med nettmasken på begge IP-adressene
	- Utfør `egen IP-adresse AND nettmaske` → egen nettadresse
	- Utfør `mottakers IP-adresse AND nettmaske` → mottakers nettadresse
2. Sammenlign resultatene (prefiksene)
- Lik prefiks $\to$ Mottaker på eget subnett $\to$ pakke overføres direkte $\to$ Bruk mottakers MAC-adresse
- Ulike prefiks $\to$ Mottaker utenfor subnett $\to$ pakke sendes via default gateway (bruk ruterens MAC-adresse, ruteren er første hopp)

MAC-adresser finnes med ARP-protokollen

## 5.3 ARP - Address Resolution Protocol
**Hva benyttes ARP til?**
- ARP brukes til å finne MAC-adressen til en node med kjent IP-adresse

**Hvordan ARP fungerer:** Finne MAC-adresse til mottakers IP for å sende pakker på eget IP-nett
1. PC sender MAC-broadcast (FF:FF:FF:FF:FF:FF) med spørsmål: "Hvem har denne IP?"
2. Hvis det finnes en node med den etterspurte IP-adressen, svarer noden med "Det er meg"
3. I svarpakken ligger MAC-adressen vi søkte etter
	- IP-pakken kan da pakkes inn i lenkelagets ramme og sendes til mottakers MAC-adresse
**ARP-tabell**
- Lagres lokalt på hver PC
- Vises med kommando `arp -a`
- Inneholder statiske og dynamiske MAC/IP-koblinger
- Dynamiske koblinger slettes etter en viss tid - nye ARP-forespørsler sendes ved behov

**Viktig:** ARP brukes også for å finne MAC til egen ruter når mottaker er på eksternt IP-nett
## 5.4 Ruting og rutingtabell
**Rutere** bygger opp en **rutingtabell** som angir hvilke utganger (interfaces) som IP-pakker må sendes ut på for å komme til en bestemt destinasjon

**Hvordan jobber en ruter?**
En ruter utfører følgende steg når den mottar en IP-pakke:
1. Sjekke bitfeilt (sjekksum i IP-header)
2. Er pakken til ruteren selv? Hvis ja, lever til høyere lag
3. Hvis nei: Oppslag i rutingtabell for å bestemme utgang
4. Dekrementere TTL (Time To Live)
5. Videresende pakken ut riktig interface

**Typer ruter i rutingtabellen:**

| **Kode** | **Type**  | **Beskrivelse**                           |
| -------- | --------- | ----------------------------------------- |
| C        | Connected | Direkte tilkoplet subnett (automatisk)    |
| L        | Local     | Ruterens egen IP-adresse i subnettet      |
| S        | Static    | Manuelt konfigurert rute                  |
| D/O      | Dynamic   | Generert av rutingprotokoller (OSPF, BGP) |
Når en pakke skal videresendes, velges ruten
- *Direkte tilkoplet subnett* legges inn i tabellen automatisk. Her er ruterens interface en node idet tilkoplede subnettet
- Fjerntliggende destinasjoner kan legges inn manuelt som *statiske ruter*, eller som *dynamiske ruter* generert av rutingprotokoller

**Longest Prefix Match**:
Når en pakke skal videresendes, velges ruten med lengst prefiks som matcher mottakers IP-adresse. Dette sikrer at den mest spesifikke ruten brukes.

**Rutingtabell på egen PC:**
- En PC har som regel bare ett aktivt interface mot LAN
- En PC kan også ha *både trådløs og kablet tilkopling* samtidig. Da kan PC ha to ruter i rutingtabellen. 
	- Kablet tilkopling har som regel preferanse
- Med VPN blir virtuelt nettverkskort også oppført
- Vis med: `netstat -rn -f inet`
- Kolonner: 
	- Destinasjon og Nettmaske: brukes til å finne hvilken rute i tabellen som passer best 
	- Gateway: Til default gateway (10.24.20.1) eller til lokal link
	- Interface: Ut på eget interface (10.24.21.58) eller loopback (127.0.0.1)
	- Metric
- Loopback (127.0.0.1) og Multicast (224.0.0.0) har egne oppføringer
## 5.5 Software Defined Network (SDN)
Ruter har to hovedoppgaver som tradisjonelt håndteres lokalt:
- **Kontrollplanet:** Bygge og oppdatere rutingtabeller
- **Dataplanet:** Videresender pakker basert på rutingtabellen
SDN flytter kontrollplanet til en sentral enhet som konfigurerer alle rutere i nettverket. Dette gir bedre oversikt og enklere administrasjon av komplekse nettverk.

## 5.6 Autonomes systemer (AS) og sammenkobling av ISP-nettverk
**En autonomt system (AS) er:**
- En samling rutere og overføringslinjer under felles administrasjon, typisk eid av en ISP
- F.eks. Uninett, Telenor
- Alle rutere i AS bruker samme rutingprotokoll internet
- Hver AS har et unikt AS-nummer

Hvordan AS koples sammen - to metoder
1. Internet Exchange (IX)
	- Svitsjer plassert på sentrale steder
	- Åpen for alle AS
	- flere NIX-punkter for redundans
2. Peering
	- Direkte kopling mellom to ISP-er
	- Basert på avtaler

**Nøkkelbegreper**
- *Kantruter (Border gateway):* Ruter som kopler et AS mot andre AS
- *NIX (Norwegian Internet Exchange):* Åpen sammenkopling for alle AS i Norge
- *Peering:* Direkte kopling mellom to ISP-er basert på avtales

**Rutingprotokoller**
- *BGP (Border Gateway Protocol):* Brukes mellom AS (kantrutere). Deler informasjon om hvilke nettadresser hvert AS kan nå
- *OSPF (Open Shortest Path First):* Typisk brukt internt i et AS

**Viktig:** Hvis et AS mister forbindelsen til NIX, kan brukere internt fortsatt kommunisere med hverandre, men ikke ut på resten av Internett.

**Flow**
- En ISP kan eie en del av internett. Ansvar for utbygging, drift og intern ruting i et AS mot alle sine tilkoplede kunder
- Alle AS må koples sammen for at brukere skal kommunisere på tvers av AS
- Ruteren fra et AS som koples mot andre AS (NIX eller peering) kalles "kantruter" (Border gateway)
- Alle kantrutere må bruke samme protokoll for å informere hverandre: Border Gateway Protocol (BGP)
	- Informasjonen forteller hvilke nettadresser et AS har tilgang til
- Innenfor et AS må også rutere bruke samme protokoll, men er det flere å velge mellom. Typisk OSPF

## 5.7 VPN - Virtual Private Network
**VPN** sender kryptert innhold over åpne nett som internett. Kommunikasjonen går i en "tunnel" mellom to definerte punkter 

**To hovedtyper:**
1. LAN-til-LAN: Krypteres i rutere på hver ende. Transparent for brukere og ingen konfigurering hos brukere
2. PC-til-LAN: Krypteres via virtuelt nettverkskort på PC (f.eks. Cisco AnyConnect)

**Hvordan VPN fungerer på PC**
1. VPN-klient oppretter et virtual nettverkskort
2. PC får en ny IP-adresse i VPN-nettverket
3. Original IP-pakke krypteres via det virtuelle kortet
4. Pakkes i ny IP-header med VPN-adresse som avsender
5. Sendes ut via det fysiske nettverkskortet
Test med: `ipconfig` og `route print` med og uten VPN for å se forskjellen

**Uten VPN:** har bare trådløs tilkopling
**Med VPN** kommer et virtuelt adapter i tillegg 

> **Eksamensklassiker!** V22 og V24: "Hvilket lag kan benytte VPN?" Svar: **Nettverkslaget**. "Hvilket lag kan benytte WPA2?" Svar: **Lenkelaget**.

**VPN og Wireshark**
- Med VPN-tilkobling blir IP-pakken først kryptert gjennom det virtuelle nettverkskortet, og deretter overført via det fysiske nettverkskortet.
- På mottakersiden av tunellen blir innholdet pakket ut igjen
- Wireshark kan brukes til å fange pakker både på virtuelle nettverkskort (VPN) og ordinære nettverkskort (NIC). Da kan man se hvordan innholdet krypteres og adressene i det "ytre" IP-pakkehodet settes![[Screenshot 2026-02-04 at 13.21.12.png | 550]]
## 5.8 NAT - Network Address Translation
NAT oversetter mellom private og offentlige IP-adresser, slik at flere interne enheter kan dele én offentlig IP-adresse. NAT kan oversette mellom to nettadresser, ikke bare privat/offentlig

**Private IP-adresseområder:**
- 10.0.0.0/8 (10.0.0.0 - 10.255.255.255)
- 172.16.0.0/12 (172.16.0.0 - 172.31.255.255)
- 192.168.0.0/16 (192.168.0.0 - 192.168.255.255)

**Offentlige IP-adresser:** Alt som ikke er reserverte adresseområder

**Hvordan NAT fungerer**
- Pakkes sendes ut på internett: bytter avsenders private IP med ruterens offentlige IP. Lagre kobling i NAT-tabell 
- Pakkes kommer inn fra internett: Slå opp i NAT-tabell basert på portnummer. Bytter mottakers adresse fra ruterens IP til intern privat IP
- NAT-tabell: Holder oversikt over oversettelser (bruker ofte portnummer som nøkkel)

**NAT-egenskaper**
- Private adresser er ikke rutbar på internett
- Man kan ikke pinge internet PC-er utenfra
- Portforwarding: Statiske åpninger for å nå interne tjenester
	- Eks: SYN-pakker til ruters port 80 $\to$ intern IP port 8080
## 5.9 DHCP - Dynamic Host Configuration Protocol
**DHCP** automatiserer nettverkskonfigurasjon av PC-er, slik at manuell konfigurasjon unngås

**DSCH konfigurerer:** 
- IP-adresse
- Nettmaske
- Default gateway (ruter)
- DNS-server
- Diverse "Options" (domenenavn, lease-tid, etc.)
**DORA-4 pakke hanshake over UDP:**

| **Pakke**   | **Betydning**                       |
| ----------- | ----------------------------------- |
| Discover    | Klient: Jeg ønsker IP-konfigurasjon |
| Offer       | Tjener: Her er et tilbud            |
| Request     | Klient: Ja, jeg ønsker å ta det     |
| Acknowledge | Tjener: OK, det er bekreftet        |
**Porter:** 67 (server) og 68 (klient) - UPD 
- Nullstille konfiguerering (merk: mister internett) `ipconfig /release` 
- Be om ny konfigurering med DHCP: `ipconfig /renew`
## 5.10 ICMP og Traceroute
### 5.10.1 ICMP - Internet Control Message Protocol
**Plassering:** Nettverkslaget (L3)
**Egenskaper:**
- Støttefunksjonen for IP, primært brukt mellom rutere. 
- Protokollen opererer på nettverkslaget og har ikke nyttelast fra transportslag eller applikasjonslag.

**Typiske ICMP-meldinger**
- Echo Request / Echo Reply: brukes av ping
- Destination Unreachable: Målet kan ikke nås
- Time Exceeded: TTL utløpt (brukes av traceroute)
- No such service: Maskin fins, men ingen tjeneste kjører på port. Ex: Åpne nettside og ser at IP fins, men ingen webserver.
### 5.10.2 Traceroute
**Traceroute** utnytter TTL-feltet i IP-headeren for å kartlegge ruten pakker tar gjennom nettet. Kartlegge hvilke rutere en pakke passerer på vei til destinasjon. 
- Hver ruter so en pakke passerer teller ned TTL for å unngå nettverkslooper
	- Dersom TTL telles til $0$ vil pakken forkastes og samtidig sender ruter et varsel tilbake om at det har skjedd (ICMP-protokollen). I dette varselet ligger ruters avsenderadresse. Dermed kan man "spore" pakker gjennom nettet.
	- Vanligvis settes TTL til 32 eller 64 
- I IPv6 heter felte "hop limit"
- Bruker TTLF-feltet i IP-header
- Bruker ICMP-protokollen for feilmeldinger

**Hvordan traceroute fungerer - utnytter TTL og ICMP**
1. Sender pakke med TTL = 1
2. Første ruter dekrementerer TTL til $0$ og forkaster pakke
3. Ruteren sendes ICMP "Time Exceeded" tilbake med sin avsenderadresse
4. Traceroute noterer ruterens IP og øker TTL til $2$ $\to$ andre ruter "avsløres"
5. Gjentas til pakke når destinasjon
# 6 Lenkelaget Ethernet, trådløst nett, svitsjer
**Bindeleddet mellom IP-grensesnitt og den fysiske overføringen over et medium.**
## 6.1 Hva skjer på lenkelaget
Lenkelaget sørger for at IP-pakker klargjøres for å kunne sendes ut som elektromagnetiske signaler på ulike fysiske overføringsmedium (luft, kobberkabel, glassfiber). Ulike medier krever ulik innpakking, og derfor har lenkelaget en *todelt struktur*

Pakkene (PDU-er, Protocol Data Units) overføres til et nabo-nettverkskort. 
- IP-destinasjonsadressen avgjør om pakken skal sendes videre eller ikke.
- Adressene som brukes på lenkelaget kalles **MAC-adresser** (Media Access Control), og er på *48 bit.*
### 6.1.1 Lenkelagets todelte struktur: LLC og MAC

> **Eksamensklassiker!** Spørsmål om LLC/MAC-inndelingen har kommet på eksamen i 2023 (V23, 10 poeng) og 2024 (V24, 8 poeng).

Lenkelaget er funksjonelt delt i to sublag:

**LLC (Logical Link Control):**
- Gir et felles grensesnitt fra lenkelaget mot nettverkslaget (IP).
- LLC kan ta imot nyttelast fra ulike protokoller på nettverkslaget (multipleksing), f.eks. både IPv4 og IPv6, og sende disse ut på det mediet som nettverkskortet støtter.

**MAC (Media Access Control):**
- Gir tilpasning til ulike fysiske medier: kablet, trådløs eller fiberbasert kommunikasjon.
- Disse har ulik signaloverføring, pakkeformater og fysiske grensesnitt.
- Her ligger MAC-adressen, feilsjekk (CRC), og generell håndtering av den fysiske overføringen.

**Hvorfor denne inndelingen er hensiktsmessig:** Fordelen ved å ha LLC som et overbygg over ulike medier er at nettverkslaget slipper å forholde seg til alle de ulike fysiske mediene. Man bare overlater nyttelasten til lenkelagets LLC-sublag, som igjen sender den videre til riktig MAC-implementasjon. Dette gir en ren abstraksjon der nettverkslaget er helt uavhengig av det underliggende mediet.
## 6.2. MAC-adresser
MAC-adresser er 48 bit lange og skrives i heksadesimalt format, f.eks. `12:34:56:AB:CD:EF`.
- **De første 24 bit** er leverandørspesifikke (OUI – Organizationally Unique Identifier), tildelt av IEEE.denden endelige mottakerens. IP-destinasjonsadressen forblir den endelige mottakerens IP. 
- **De siste 24 bit** er enhetsspesifikke, tildelt av produsenten.
- Det er nettverkskortet (adapteren) som har MAC-adressen, ikke selve verten. En maskin med flere nettverkskort har derfor flere MAC-adresser.
- Svitsjer har **ikke** MAC-adresser på sine porter – de opererer transparent.

**Tre typer MAC-adresser:**

| Type          | Adresse           | Forklaring                           |
| ------------- | ----------------- | ------------------------------------ |
| **Unicast**   | Unik MAC          | Sendes til én spesifikk enhet        |
| **Multicast** | 01:00:5E:x.x.x    | Sendes til en gruppe enheter         |
| **Broadcast** | FF:FF:FF:FF:FF:FF | Sendes til alle enheter på subnettet |
|               |                   |                                      |
### 6.2.1 ARP – Address Resolution Protocol 

> **Eksamensklassiker!** ARP har blitt spurt om gjentatte ganger.

ARP brukes for å finne MAC-adressen til en gitt IP-adresse på eget IP-nett. Alle noder er konfigurert med en IP-adresse, men man trenger MAC-adressen for å sende en pakke til riktig nettverkskort.

**Virkemåte:**
1. En IP-pakke skal sendes til et nabo-nettverkskort innenfor et IP-subnett.
2. Avsender må kjenne MAC-adressen til neste mottaker.
3. Avsender sender en **ARP-request** som broadcast (FF:FF:FF:FF:FF:FF): «Hvem har denne IP-adressen?»
4. Mottakeren med riktig IP svarer med en **ARP-reply** som inneholder sin MAC-adresse.
5. Avsender lagrer koblingen (IP → MAC) i sin **ARP-tabell** for fremtidig bruk.
6. De dynamiske koblingene slettes etter en viss tid, og da må det ARP-es på nytt.

**Viktig poeng:** Dersom destinasjons-IP er på et annet subnett, sender man pakken til default gateway (ruteren). Da brukes ARP for å finne ruterens MAC-adresse – ikke den endelige mottakerens. IP-destinasjonsadressen forblir den endelige mottakerens IP, men MAC-adressen er ruterens. Se `arp -a` kommandoen for å vise ARP-tabellen.
## 6.3. Ethernet – Kablet overføring
Ethernet er den dominerende kablet LAN-teknologien. I dag bruker man som regel å koble enheter til svitsjer, der enhetene kommuniserer med **full dupleks** – de kan sende og motta samtidig uten kollisjon, fordi sending og mottak skjer på to forskjellige trådpar.
### 6.3.1 CSMA/CD (legacy) 

> **Eksamensklassiker!** Aksessmekanisme på delt Ethernet.

Dersom flere enheter/noder var koblet på samme port/link (f.eks. via en hub), måtte man ha en aksessmekanisme for tilgang til mediet. Denne kalles **CSMA/CD** – Carrier Sense Multiple Access with Collision Detection.

**Virkemåte:**
1. **Carrier Sense:** Lytter på mediet om det er ledig før sending.
2. **Multiple Access:** Flere enheter deler mediet.
3. **Collision Detection:** Hvis to enheter sender samtidig, oppdages kollisjonen.
4. Ved kollisjon: Avbryt sendingen, vent en **tilfeldig tid** (binær eksponentiell backoff), og prøv igjen.

**Merk:** I moderne svitsjet Ethernet brukes ikke CSMA/CD, fordi hver enhet har sin egen dedikerte kabel til svitsjen (ingen delt medium).
### Ethernet-rammer (Frame Structure) 
Ethernet-rammen har følgende struktur:
```
| Preamble | Dest. MAC | Source MAC | EtherType/Size | Payload | CRC |
| 8 bytes  | 6 bytes   | 6 bytes    | 2 bytes        | 46-1500 | 4 B |
```
**Feltene forklart:**
- **Preamble (8 byte):** Rammesynkronisering – våkne-signal for mottakerens nettverkskort. De første 7 bytene er `10101010`, den siste byten er `10101011` (Start Frame Delimiter). Synkroniserer klokkene slik at mottaker kan sample bitene korrekt.
- **Destination MAC (6 byte):** MAC-adressen til mottakeren. Dersom denne matcher mottakerens MAC, eller er broadcast (FF:FF:FF:FF:FF:FF), aksepteres rammen. Ellers forkastes den.
- **Source MAC (6 byte):** MAC-adressen til avsenderen.
- **EtherType/Size (2 byte):** Indikerer hvilken nettverkslagsprotokoll nyttelasten tilhører. Brukes til demultipleksing. Eksempler: `0x0800` = IPv4, `0x86DD` = IPv6, `0x0806` = ARP.
- **Payload (46–1500 byte):** Selve IP-datagrammet. MTU (Maximum Transmission Unit) for Ethernet er 1500 byte. Minimum er 46 byte – dersom nyttelasten er kortere, fylles det på med «stuffing».
- **CRC (4 byte):** Cyclic Redundancy Check – sjekksum for feildeteksjon. Utføres i maskinvarelogikk på nettverkskortet. Mottaker beregner sin egen CRC og sammenlikner med den medfølgende. Dersom de ikke matcher, forkastes rammen uten noen varsling til avsender.
**Viktige egenskaper ved Ethernet:**
- **Forbindelsesløs (connectionless):** Ingen handshake mellom sender og mottaker.
- **Upålitelig (unreliable):** Ingen bekreftelse (ACK) sendes tilbake. Dersom en ramme feiler CRC-sjekk, forkastes den stille. TCP på transportlaget håndterer eventuell retransmisjon.
## 6.4. Svitsjer (Switches) 
Svitsjer opererer på **lenkelaget (lag 2)** og videresender rammer basert på **MAC-adresser** (i motsetning til rutere som bruker IP-adresser på lag 3).

**Egenskaper**
- Hver enhet kobles på hver sin port («kontakt»), og disponerer overføringsmediet alene. Man slipper å dele overføringsmediet med andre enheter, noe som gir bedre båndbredde.
- Svitsjer er **selvlærende** – de registrerer hvilke MAC-adresser som er tilkoblet hvilken port etter hvert som pakker kommer inn.
- Svitsjer virker «med en gang du slår på strømmen» – ingen manuell konfigurasjon nødvendig (plug-and-play).

### 6.4.1 Svitsjens videresendingstabell (Switch Table)
Tabellen inneholder: **(1)** MAC-adresse, **(2)** porter (interface), **(3)** tidsstempel.

**Selvlæring:** Når en ramme ankommer, registrerer svitsjen avsenderens MAC-adresse og porten den kom inn på.

**Videresending – tre scenarier:**
1. **Ukjent destinasjon:** Ingen oppføring i tabellen → svitsjen sender rammen ut på **alle porter** (unntatt den den kom inn på) – dette kalles flooding.
2. **Destinasjon er på samme port som avsender:** Rammen forkastes (filtrering) – den har allerede nådd sitt segment.
3. **Destinasjon finnes i tabellen på en annen port:** Rammen videresendes kun til den spesifikke porten.

### 6.4.2 To metoder for videresending

|Metode|Beskrivelse|
|---|---|
|**Store-and-Forward**|Hele rammen mottas og kontrolleres for bitfeil (CRC) før den videresendes. Sikrer integritet, men gir litt høyere latens.|
|**Cut-through**|Rammen begynner å videresendes så snart destinasjon-MAC er lest inn (etter 6 bytes). Lavere latens, men ingen feilsjekk.|

### 6.4.3 Fordeler med svitsjer
- **Eliminerer kollisjoner:** Hver port er sitt eget kollisjonsdomene. Svitsjen sender aldri mer enn én ramme på et segment samtidig.
- **Heterogene linker:** Ulike porter kan operere med ulik hastighet og over ulike medier (fiber, kopper).
- **Full dupleks:** Svitsj og enhet kan sende til hverandre samtidig.
- **Enkel administrasjon:** Selvlærende, plug-and-play.

### 6.4.4 Svitsjer vs. rutere

| Egenskap          | Svitsj                        | Ruter                             |
| ----------------- | ----------------------------- | --------------------------------- |
| **Lag**           | Lag 2 (lenkelaget)            | Lag 3 (nettverkslaget)            |
| **Adressering**   | MAC-adresser                  | IP-adresser                       |
| **Konfigurasjon** | Selvlærende (plug-and-play)   | Krever konfigurasjon (IP, ruting) |
| **Broadcast**     | Videresender broadcast-rammer | Avgrenser broadcast-domener       |
## 6.5 Kollisjonsdomene og kringkastingsdomene 
**Kringkastingsdomene (Broadcast domain):**
- Alle noder på eget IP-nett som mottar broadcast-meldinger.
- Alle tilkoplede enheter er mottakere.
- Avgrenset av rutere – rutere videresender **ikke** broadcast.

**Kollisjonsdomene (Collision domain):**
- Kan oppstå der transmisjonsmediet (lag 1) er delt mellom flere nettverkskort.
- Trådløst nett er alltid et delt medium – lufta er for alle.
- Kablet Ethernet har kollisjonsdomene dersom flere noder er elektrisk sammenkoblet (f.eks. gjennom en hub).
- Svitsjer brukes nettopp for å unngå delt medium og dermed eliminere kollisjoner.

**Viktig sammenheng:**
- En **hub** oppretter ett stort kollisjonsdomene – alle porter deler mediet.
- En **svitsj** deler nettverket i separate kollisjonsdomener (én per port), men holder det som ett kringkastingsdomene.
- En **ruter** deler nettverket i separate kringkastingsdomener.

**Forskjellen mellom kollisjon og kringkastingsdomene**
https://www.guru99.com/no/collision-broadcast-domain.html
## 6. Trådløst nett (Wi-Fi / IEEE 802.11)
### 6.6.1 Aksesspunkter (AP), BSS og ESS 

> **Eksamensklassiker!** BSS vs ESS har kommet på eksamen.

**Aksesspunkter (AP):**
- Enheten som sender og mottar radiosignaler – typisk «boksen på veggen».
**BSS (Basic Service Set):**
- Ett felles aksesspunkt for alle enheter.
- Typisk hjemme-WiFi: alle enheter deler samme nettadresse, kanal og nettverkspassord.
- Utgjør ett IP-nett og ett kollisjonsdomene (alle deler samme frekvens/kanal).

**ESS (Extended Service Set):**
- Sammenkobling av _flere_ BSS (flere aksesspunkter) til et felles nettverkssegment.
- BSS-ene kobles sammen «i bakkant» til en ruter, slik at hele ESS-et utgjør ett IP-nett.
- Brukere kan bevege seg mellom aksesspunkter (**roaming**) men fortsatt holde nettverksforbindelsen.
- ESS er et **kringkastingsdomene**, mens hver enkelt BSS er et **kollisjonsdomene**.
### 6.6.2 Aksessmekanisme WLAN: CSMA/CA 
Trådløst nett bruker **CSMA/CA** (Carrier Sense Multiple Access with Collision **Avoidance**) – ikke CD (Detection) som i kablet Ethernet.

**Hvorfor ikke Collision Detection?**
1. Det er teknisk vanskelig og dyrt å sende og lytte samtidig trådløst (styrkeforskjell mellom sendt og mottatt signal).
2. Selv om man kunne det, ville man ikke kunne detektere alle kollisjoner pga. **skjult node-problemet** og signalsvinn (fading).

**CSMA/CA virkemåte:**
1. **Carrier Sense:** Lytter om delt medium er ledig.
2. **Collision Avoidance:** Hvis mediet er opptatt, vent en tid. To strategier:
    - A. Prøv på nytt etter en tilfeldig ventetid (binær eksponentiell backoff med DIFS).
    - B. Bruk RTS/CTS for å få tildelt en «tidsluke» fra AP.
3. **Kvittering (ACK):** AP sender bekreftelse (ACK) for vellykket mottak – dette gjøres fordi trådløse kanaler har høyere feilrate enn kablede. Hvis ACK ikke mottas, retransmitteres rammen.

**Viktig forskjell fra CSMA/CD:** I 802.11 sendes hele rammen ferdig selv om kollisjon oppstår (det finnes ingen abort-mekanisme). Derfor er det ekstra viktig å _unngå_ kollisjoner i utgangspunktet.
### 6.6.3 RTS/CTS-mekanismen
- **RTS (Request to Send):** En enhet ber om reservert tidsluke.
- **CTS (Clear to Send):** AP kunngjør dette til alle innenfor sitt område.
- Effekten er at alle andre enheter «holder kjeft» i dette tidsrommet, noe som øker sjansen for vellykket overføring.
- Spesielt nyttig mot **skjult node-problemet**: To enheter som ikke kan høre hverandre, men begge kan høre AP.

### 6.6.4 Skjult node-problemet
Aksesspunktet må høre alle, men ikke alle hører hverandre. Når man ikke hører andre noder, kan man ende opp med å sende samtidig og forårsake kollisjoner som verken sender oppdager. RTS/CTS løser dette ved at AP koordinerer tilgangen.
## 6.7 Kanaler og frekvenser
Trådløse nettverk opererer i tre frekvensbånd:

| Frekvensbånd | Egenskaper                                                                                              |
| ------------ | ------------------------------------------------------------------------------------------------------- |
| **2,4 GHz**  | Eldst. Lengst rekkevidde, men mest forstyrret (mange enheter). Få ikke-overlappende kanaler (1, 6, 11). |
| **5 GHz**    | Høyere bitrate, kortere rekkevidde. Flere tilgjengelige kanaler, mindre forstyrrelse.                   |
| **6 GHz**    | Nyeste. Høyest bitrate, kortest rekkevidde. Enda flere kanaler.                                         |
**Anbefaling:** Bruk 5 GHz eller 6 GHz hvis mulig – de gir bedre ytelse.

Hvert frekvensbånd er delt inn i **kanaler** (frekvensmultipleksing). Kanalenes frekvensområder overlapper hverandre i noen grad, så man bør velge kanaler som er minst mulig forstyrret av naboer. For 2,4 GHz-båndet er kanal 1, 6 og 11 de eneste som ikke overlapper.

**Verktøy:** inSSIDer (https://www.metageek.com/products/inssider/) kan brukes til å analysere aktive kanaler.
## 6.8 Wi-Fi-kryptering
Kryptering skal hindre inntrengere å komme inn «bak brannmuren» på det trådløse nettverket.

| Standard | Status                                                                                         |
| -------- | ---------------------------------------------------------------------------------------------- |
| **WEP**  | Utdatert og usikker – ikke bruk!                                                               |
| **WPA**  | Utdatert – ikke bruk!                                                                          |
| **WPA2** | Gjeldende standard. Oppkobling med autentisering, kryptering med AES (samme som brukes i TLS). |
| **WPA3** | Nyeste standard med forbedret sikkerhet.                                                       |
## 6.9 Overføringsmedier

> **Eksamensklassiker!** V23 (6 poeng): "Hva er vesentlige kjennetegn for kopper, fiberoptisk og trådløst overføringsmedium?"

All dataoverføring på transmisjonsmedier skjer med elektromagnetiske signaler. Avhengig av mediet kalles signalene lys, radiobølger eller elektriske pulser.

**Fiber (glasskjerne)**
- Tynn glassfiber som leder elektromagnetisk signal (lys)
- **Singelmodus:** Tynn kjerne, lang rekkevidde, dyrere.
- **Multimodus:** Tykkere kjerne, kort rekkevidde, billigere.
- Frekvensmultipleksing (ulik farge/bølgelengde på lyset) – kalles WDM (Wavelength Division Multiplexing).

**Kopper (tvunnet trådpar)**
- To par tråder som tvinnes for å redusere signaltap og EM-forstyrrelser (antennevirkning/elektromagnetisk interferens).
- Skjermet med folie (STP) gir ekstra beskyttelse mot EM-støy. Uskjermet variant (UTP) er vanligst.
- Rask degradering av signal pga elektrisk motstand - pulsene flates ut, noe som begrenser lengde/hastighet (jo lengre kabel desto lavere bitrate). 
- Enkelt å oppdage kollisjon (CSMA/CD)
- Kategorier: Cat 5e (opp til 1 Gbps), Cat 6 (opp til 10 Gbps over korte distanser).

**Luft (trådløst / Wi-Fi)**
- Radiosignaler som stråler i alle retninger, svekkes raskt
- Påvirkes av fysiske hindringer (vegger, møbler)
- Vanskelige å oppdage signalkollisjon - krever CSMA/CA
- Frekvensbånd: 2,4 GHz, 5 GHz og 6 GHz med kanalmultipleksing.
- Kanalmultipleksing - deler frekvensbåndet i kanaler, tilsvarende FM-radiostasjoner.
- Skjult node-problemet er en utfordring spesifikk for trådløs overføring.
## 6.10 Demultipleksing gjennom lagene – helhetlig bilde
Et viktig konsept er hvordan hver protokollheader peker til neste lag:
```
Ethernet-ramme:  EtherType 0x0800  → IPv4
IPv4-header:     Protocol 6        → TCP
TCP-header:      Dest. port 80     → HTTP
```
På lenkelaget bruker Ethernet **EtherType**-feltet for å vite hvilken nettverkslagsprotokoll nyttelasten tilhører. Dette er et eksempel på demultipleksing – hvert lag bruker spesifikke felt til å identifisere neste lags protokoll.
## 6.11 Oppsummering – Typiske eksamensoppgaver

| Tema                          | Hva du bør kunne                                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------------------------- |
| **LLC vs MAC**                | Forklare oppgavene til hvert sublag og hvorfor inndelingen er hensiktsmessig. Fullstendige setninger! |
| **MAC-adresser**              | 48 bit, heksadesimalt format, leverandør + enhet, forskjell fra IP-adresser                           |
| **ARP**                       | Formål og virkemåte, broadcast-request → unicast-reply, ARP-tabell                                    |
| **Ethernet-ramme**            | Alle feltene, spesielt Preamble, EtherType, CRC                                                       |
| **CSMA/CD**                   | For delt kablet medium, carrier sense → send → collision detect → backoff                             |
| **Svitsjer**                  | Selvlærende, switch table, flooding ved ukjent MAC, store-and-forward vs cut-through                  |
| **Kollisjon vs kringkasting** | Definisjoner, hub vs svitsj vs ruter                                                                  |
| **BSS vs ESS**                | BSS = ett AP + kollisjonsdomene, ESS = flere BSS + kringkastingsdomene + roaming                      |
| **CSMA/CA**                   | Trådløs aksessmekanisme, hvorfor ikke CD, RTS/CTS, ACK                                                |
| **Skjult node**               | Problemet og hvordan RTS/CTS løser det                                                                |
| **Kanaler/frekvenser**        | 2.4/5/6 GHz, overlappende kanaler, valg av kanal                                                      |
| **Kryptering**                | WEP/WPA usikre, WPA2 med AES                                                                          |

**Eksamenstips:**
- Svar med fullstendige setninger – ikke stikkord.
- Vis at du forstår _hvorfor_ ting fungerer som de gjør, ikke bare _hva_.
- Tegn gjerne figurer der det er relevant (Ethernet-ramme, LLC/MAC-struktur, BSS/ESS).
- Koble konsepter på tvers av lag (f.eks. ARP binder lenkelaget til nettverkslaget).
# 7 Eksamens-sjekkliste
## 7.1 Lagfunksjoner (flervalgsfavoritt)

| Spørsmål                                                         | Svar               |
| ---------------------------------------------------------------- | ------------------ |
| Hvilket lag gir ende-ende forbindelse mellom applikasjoner?      | **Transportlaget** |
| Hvilket lag overfører mellom tilstøtende noder/innenfor subnett? | **Lenkelaget**     |
| Hvilket lag kan tilby pålitelig overføring?                      | **Transportlaget** |
| Hvilket lag kan benytte VPN?                                     | **Nettverkslaget** |
| Hvilket lag kan benytte WPA2?                                    | **Lenkelaget**     |
| Hvilket lag ligger under applikasjonslaget?                      | **Transportlaget** |
| Hvilket lag ligger over fysisk lag?                              | **Lenkelaget**     |
## 7.2 Protokoller per lag

| Lag               | Protokoller                           |
| ----------------- | ------------------------------------- |
| Applikasjonslaget | HTTP, SMTP, DNS, MIME, POP3, IMAP     |
| Transportlaget    | TCP, UDP                              |
| Nettverkslaget    | IPv4, IPv6, ICMP                      |
| Lenkelaget        | Ethernet (802.3), Wi-Fi (802.11), ARP |
## 7.3 Typiske oppgaver å øve på
1. **Subnetting:** Beregn nettadresse, broadcast, brukbare adresser
2. **TCP sekvensnummer:** Beregn kvitteringsnummer gitt sekv.nr + payload
3. **Sertifikat-verifisering:** Beskriv steg for steg
4. **TLS-etablering:** Forklar hele flyten (sertifikat → nøkkelutveksling → symmetrisk kryptering)
5. **Trådsikkerhet:** Forklar race condition og mutex med C++-eksempler
6. **WebSocket vs HTTP:** Full dupleks vs request-response, WSS = TLS
7. **LLC/MAC:** Forklar begge sublag og **hvorfor** inndelingen er hensiktsmessig
8. **CSMA/CD vs CSMA/CA:** Forskjellene og hvorfor trådløst bruker CA
9. **Traceroute:** Forklar med TTL/Hop Limit OG ICMP
10. **ARP:** Formål og virkemåte, broadcast-request → unicast-reply

## See also
- [[idatt2104-moc]]
