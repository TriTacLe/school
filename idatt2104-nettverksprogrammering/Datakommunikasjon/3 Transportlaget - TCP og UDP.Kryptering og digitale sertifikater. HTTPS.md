---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## 3.1 Transportlagets oppgave
Transportlaget har to hovedoppgaver:
- **Ende-til-ende kommunikasjon:** Tilby kommunikasjon mellom porter (grensesnitt mot applikasjoner) på to ulike maskiner
	- Men det kan være flere parallell forbindelser
	- Avsender og mottaker er identifisert med portnummer på transportlaget. Porten er aktiv dersom programmet kjører, dsv "lytter" på porten. Det er portnummer som gjør at en kan få riktig kontakt med server
	- Maskinene som programmene kjører på er identifisert med IP-adresse.
- **Tjenestekvalitet:** Øke kvaliteten på overføringen. UDP og TCP tilbyr ulik tjenstekvalitet
## 3.2 Adressering på transportlaget
Transportlaget bruker *porter* for adressering. Porter er 16-bit, som gi 65536 mulige addresser. 

| Porttype               | Portnummer   | Beskrivelse                             |
| ---------------------- | ------------ | --------------------------------------- |
| Velkjente/systemporter | 0-1023       | Reservert for standardtjenester         |
| Registrerte porter     | 1024-49151   | Registrert for spesifikke applikasjoner |
| Dynamiske/private      | 499152-65535 | Kortlivde, klienttilkoblinger           |
- **Socket** = IP-addresse + Portnummer (entydig identifikator for en forbindelse)
- Porter er KUN aktiv dersom en app kjører (lytter på porten)
## 3.3 UDP - User Datagram Protocol
![[Pasted image 20260121211520.png | 600]]
UDP er en forbindelsesløs protokoll som tilbyr **upålitelig** overføring av uavhengige datapakker. er enkel og rask protokoll, ingen garantier. 

**Header**
- Source port number.
- Destination port number
- Total length: hvor langt datafeltet er
- Checksum: se om innholdet i pakken ikke har endret seg. 

**Egenskaper**
- Ingen oppkoblingsfase: sender data umiddelbart uten håndtrykk
- Ingen garanti for levering: Pakker kan gå tapt, dupliseres eller komme i feil rekkefølge
- Lav overhead: minimal pakkeheader (8 byte)
- Hastighet: optimalisert for sanntidsapplikasjoner
**Bruksområder**
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
### 3.4.1 Pålitelig overføring
Data overføring med kvittering så avsender vet hvor mye som har kommet frem

**Selve overføringen:**
1. Oppkobling: 3WHS 
2. Dataoverføring: kontinuerlig byte-strøm (i begge retninger) hvor hver byte telles og kvitteres.
3. Nedkobling: En av partene initierer med FIN-flagg

Flagg:
- *SYN* (Synchronize) - "jeg vil starte en forbindelse". Brukes utelukkende i oppkoblingsfasen for å synkronisere sekvensnumre mellom sender og mottaker
- *ACK* (ackknowledge) - "jeg har mottatt dataene dine". Bekrefter at data er mottatt. Etter oppkoblingen er ACK-flagget satt i nesten alle pakker
- *FIN* (final) - "Jeg er ferdig med å sende". Signaliserer at senderen vil avslutte forbindelse og frigjør buffere og andre ressurser.
- *ISN* (Initial Sequence Number) - Ikke et flagg, men startverdi for sekvensnummereringen. Det er et tilfeldig 32-bit tall som velges ved oppkobling. Wireshark viser det som "0" for lelsbarhet (relativt sekvensnummer), men den faktiske verdien er mye større.

TCP brukes en **treveis håndtrykkprosedyre** (3WHS) for pålitelig oppkobling:
1. *SYN:* Klient sender pakke med SYN-flagg=1 og tilfeldig sekvensnummer (ISN)
2. *SYN-ACK:* Server svarer med ACK-flagg=1, kvitteringsnr=ISN+1, eget SYN-flagg og egen ISN
3. *ACK:* Klient bekrefter med ACK-flagg=1 og kvitteringsnr=server-ISN+1

Viktig: begge parter oppretter sende- og mottakerbuffer under oppkoblingen

#### 3.4.1.1 Oppkopbling 3WHS
- TCP-kontrollpakker som sendes FØR data overføres
- En part tar initiativ og sender en SYN-pakke
	- Betyr at SYN-flagget er satt, og sender med sitt ISN som er initielt sekvensnummer
- Motparten svarer med sitt ACK-flagg, kvitterer at det er ok. Men det ønskes dataoverføring i begge retninger, sender derfor OGAÅ eget SYN-flagg + ISN
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
- *Acknowledge nummer* viser forventa sekvensnummer til første byte i neste mottatte pakke. Dermed er alle byte opp til dette nummeret i strømmen kvittert ok mottatt.
	- *Kvitteringsnummer* som sendes tilbake er summen av mottatte pakkets sekvensnummer (første posisjon) pluss lengden/størrelsen av nyttelasten i dette segmentet

**Data**
- Data fra applikasjon sendes i segmenter
- Typisk TCP nyttelast (Max Segment Size) er på 1460 byte, sjekk "options" i SYN-pakke i Wireshark 1460 + 20 (TCP header) + 20 (IP header) = 1500 byte til lenkelaget
	- Lenkelaget har tradisjonelt 1500 byte som max pakkestørrelse, men kan settes større hvis forbindelsen tillater det.
- ISN (Initial Sequence Number) 32-bit sekvensnummer (for hver byte som overføres) settes tilfeldig av sikkerhetsgrunner. ISN vises som "relativt 0" i Wireshark i pakkestrømmen
#### 3.4.1.3 Nedkobling
- TCP har ingen timeout, en av partene må aktivt foreta nedkopling (som regel serveren)
- Bruker FIN-flagget.
	- Motparten kvitterer med ACK og forbindelsen holdes til dette er mottatt
- Dette er i samsvar med HTTP-funksjonen "Keep-Alive" hvor partene er enige om å holde en TCP-forbindelse en viss stund, i påvente av flere overføringer fra websiden

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
| Checksum               | 2 byte        | Feildeteksjon                                                                                                                                        |
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

Ikke sende så mange pakker om gangen da risikerer man at pakker forsvinner. *Window size i* headeren brukes til å passe på at man ikke sender for mange pakker, hvort stort sliding windowe skal være. 

**Metningskontroll med glidende vindu**
- *Metning*, opphoping i nettet, som skjer når rutere ikke klarer å videresende alle pakker. Da hjelper det ikke å pøse på med retransmisjoner noe som vil sløse båndbredde
- TCP går inn i en "vær varsom" tilstand hvor det bare blir sendt én pakke og venter til den er kvittert 
- TCP reduserer window size drastisk
- Starter forsiktig med 1 segment, øker gradvis
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

**Merknad**
- AES, RSA og SHA kommer i ulike versjoner og kan ha ulik nøkkellengde. Derfor må partene avtale hvilke versjoner som skal brukes når forbindelsen opprettes
- Lengden (antall bit) for nøklene avtales og jo flere bit desto sikrere kryptering
- Krypteringsmetodene bruker "utfylling/padding" på meldinger, siden det er ikke så mange måter å kryptere et enkelt ord på
- AES og RSA er ikke bevist uknekkelige. Sikkerheten ligger i at sjansen for å finne rett nøkkel er ca 0.
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
- Sertifikatet er altså bare en liten pakke med data, og det er enkelt å «justere» litt på innholdet. Derfor hviler hele PKI-systemet på at man kan verifisere innholdet.
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

## See also
- [[idatt2104-moc]]
