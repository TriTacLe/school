---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

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
- **De første 24 bit** er leverandørspesifikke (OUI – Organizationally Unique Identifier), tildelt av IEEE.
- **De siste 24 bit** er enhetsspesifikke, tildelt av produsenten.
- Det er nettverkskortet (adapteren) som har MAC-adressen, ikke selve verten. En maskin med flere nettverkskort har derfor flere MAC-adresser.
- Svitsjer har **ikke** MAC-adresser på sine porter – de opererer transparent.

**Tre typer MAC-adresser:**

| Type          | Adresse           | Forklaring                           |
| ------------- | ----------------- | ------------------------------------ |
| **Unicast**   | Unik MAC          | Sendes til én spesifikk enhet        |
| **Multicast** | 01:00:5E:x.x.x    | Sendes til en gruppe enheter         |
| **Broadcast** | FF:FF:FF:FF:FF:FF | Sendes til alle enheter på subnettet |
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
### Egenskaper
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
## 5. Kollisjonsdomene og kringkastingsdomene 
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
### RTS/CTS-mekanismen
- **RTS (Request to Send):** En enhet ber om reservert tidsluke.
- **CTS (Clear to Send):** AP kunngjør dette til alle innenfor sitt område.
- Effekten er at alle andre enheter «holder kjeft» i dette tidsrommet, noe som øker sjansen for vellykket overføring.
- Spesielt nyttig mot **skjult node-problemet**: To enheter som ikke kan høre hverandre, men begge kan høre AP.

### Skjult node-problemet
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

|Standard|Status|
|---|---|
|**WEP**|Utdatert og usikker – ikke bruk!|
|**WPA**|Utdatert – ikke bruk!|
|**WPA2**|Gjeldende standard. Oppkobling med autentisering, kryptering med AES (samme som brukes i TLS).|
|**WPA3**|Nyeste standard med forbedret sikkerhet.|

## 6.9 Overføringsmedier
**Fiber (glasskjerne)**
- **Singelmodus:** Tynn kjerne, lang rekkevidde, dyrere.
- **Multimodus:** Tykkere kjerne, kort rekkevidde, billigere.
- Frekvensmultipleksing (ulik farge/bølgelengde på lyset) – kalles WDM (Wavelength Division Multiplexing).

**Kopper (tvunnet trådpar)**
- Trådene tvinnes for å unngå antennevirkning (elektromagnetisk interferens).
- Skjermet med folie (STP) gir ekstra beskyttelse mot EM-støy. Uskjermet variant (UTP) er vanligst.
- Kapasiteten synker med lengden fordi pulsene «flates ut» (signaldempning).
- Kategorier: Cat 5e (opp til 1 Gbps), Cat 6 (opp til 10 Gbps over korte distanser).

**Luft (trådløst / Wi-Fi)**
- Frekvensbånd: 2,4 GHz, 5 GHz og 6 GHz.
- Kanalmultipleksing – deler frekvensbåndet i kanaler, tilsvarende FM-radiostasjoner.
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

## See also
- [[idatt2104-moc]]
