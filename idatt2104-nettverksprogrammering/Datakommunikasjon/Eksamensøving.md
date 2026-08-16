---
type: area
status: evergreen
created: 2026-03-22
modified: 2026-03-22
tags: []
---

Lenkelaget
Kvittering

2
Nettverkslaget, Rutere
Lenkelaget, Ethernet-protokollen, rammer
Applikasjonslaget, DNS, tilstandsløs
Transportlaget, UDP, Datagram, 
Transportlaget

3
Bestemems av Ethernet MAC dest 

4
Lokal navnetjener, Rot-tjener, nasjonal domenetjener, Autorativ navnetjener

5
Bruker dette for raskere å kople opp ved senere oppslag på samme URL

6
15

7
/23
510

8
Kartlegge ruten til en destinasjon

9
Lenkelaget

10
Tilpasse mottakers klokkerate

11
det drøyer for lenge før avsender får kvittering

12
IP-adressen til default gateway kan dekke flere subnett
Noder på ulike subnett må kommunisere via default gateway 

13
Når pakkeenhet (PDU) blir sendt fra en node til en annen går den gjennom flere lag. Hvert lag er uavnehgig fra hverandre og ved hvert lag PDU-en går gjennom blir den pakket med pakkehode. Hvert lag overlater pakkeennheten som nyttelast til en protokoll i laget under. Pakkeenheten blir stlrre for Pakkehoden inneholder metadata som brukes av lagene når PDU er sendt til mottaker. Da skrelels av pakkehodet og pakkethodet inneholder info til demultipleksing og protokoll, altså hvilken protokoll som brukes i neste lag. 

14
Hovedtrekket for etablering av HTTPS forbindelse: RSA asymmetrisk kryptering ved nøkkeldistribusjon ved nøkkeldistruibusjon ved nøkkeldistruibusjon ved nøkkeldistruibusjon
AES symmetrisk kryptering ved dataoverføring
Klient sender SYN flagg for oppkobling port 443, omdirigeres fra port 80. Verifisere sertifikat: Tjener sender sertifikat med serverens pubkey + utsteders fingeravtrykt signert:  kryptert med SK til utsteder (CA) og shahashet.
Klient dekrypterer med utsteders pub key og kjører eget sha-hash av hele sertifikatet og sammenligner hash verdiene.
Klient lager dermed et hemmelig tall og krypterer med pub key til innehaver (tjener). Klient sender det til serveren og serveren dekrypterer med sin egen SK. Nå har klient og server samme sesjonsnøkkel og kan sende pakkerfritt.


15
Gjennom verifisering: man dekrypterer sjekksummen i sertifikatet med CA pub key. Deretter beregner man eget sha-hash av hele sertifikatet. Til slutt sammenligner man hash-verdiene. Hvis de er ulike er det ikke forfalsket, noe som gir integritet.

16
Dette er en utfordring da man ikke vet hvilken tjeneste man refererer til når man refererer til domene. Navnetjenesten har type felt i DNS Resource Records som fikser dette. Feltet viser hvilken tjeneste som brukes. MX Mail exchanger brukes til mail. CNAME brukes som alias. A og AAAA er IPv4 og IPv6 som brukes i weboppslag. NS for nameserver for navneoppslag 

17
SMTP sender data i form av 7-bit US ASCII. Dette støtter ikke nasjonale tegn. SMTP har ingen passord. Bruker da MIME til om kode 7-bit til 8-bit slik at filvedlegg, nasjonale tegnsett og HTML kan sendes over SMTP. Data blir 4/3 større. MIME brukes base64 til dette.     

IMAP POP3 mottar og lagrer mailen - begge har passord. IMAP lagrer bare hos klient, mens POP3 synkroniserer lagringen mellom tjener og klient

18
Mottakeren av segmentene sender kvitteringer tilbake til avsender som bekrefter at segmenten er motatt - mottakeren sender ACK tilbake til senderen må mottate data

Bruker 3WHS for oppkobling. Klient sender SYN og server sender SYN-ACK tilbake, og client sender til slutt ACK.

19
LLC: grensesnitt mot nettverkslaget. Multipleksing: Henter nyttelasten  fra ulike nettverksprotokoller (IPv4 og IPv6 samtidig) og gjør dem klar til å bli sendt til riktig overføringsmediet.
MAC: tilpasning til fysisk medium. Her ligger MAC-adressen, feilsjekk (CRC) og håndtering av den fysiske overføringen, samt aksessmekanismen CSMA/CD (kablet) eller CSMA/CA 

Formålet med denne inndelingen er å abstrahere lagene over og under for hverandre. Hvilke overføringsmediet som brukes skal ikke påvirke valg av protokoll.

## See also
- [[idatt2104-moc]]
