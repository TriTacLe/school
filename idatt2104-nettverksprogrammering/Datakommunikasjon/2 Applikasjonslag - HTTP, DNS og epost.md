---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

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
**Request**
En HTTP-request består av tre deler:
1. *Request-linje:* Inneholder metode (GET, POST, HEAD, osv), URL og HTTP-version. Method SP request-target SP HTTP-version CRLF
2. *Headerlinjer:* Tilleggsinformasjon som Host, User-agent, Accept-language
3. *Body:* Eventuelle data (tom ved GET, brukes ved POST)

**Reponse**
En HTTP-respons har tilsvarende struktur:
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
For å spare tid og båndbredde lagrer nettleseren kopier av webobjekter lokalt. Trenger ikke å laste objekter på nytt hver gang - det er sløsing med tid og båndbredde. Ved neste forespørsel brukes headeren:
`If-Modified_since: Fri, 14 Jan 2026 12:26:16 GMT`
Serveren svarer enten med hele filen på nytt eller `304 Not Modified` hvis filen er uendret

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
SMTP brukes for sending av e-post - både klient til sever mellom servere. Protokollen er kjennetegnet ved handshaking (kontrollmeldinger) før selve e-posten overføres.
- Viktig: E-posten avsluttes med et punktum alene på en linje (.). 
- SMPT bruker US-ASCII (7-bit), som skaper utfordringer for vedlegg og nasjonale tegn

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

#### 2.5 Oppsummering
Tre mest brukte applikasjoner på internett - web, e-post og navnetjenesten, deler samme grunnstruktur: protokoller som sender meldinger mellom client og server. Disse protokollene ligger på applikasjonslaget og er standardisert slik at programvare fra ulike produsenter kan samarbeide

## See also
- [[idatt2104-moc]]
