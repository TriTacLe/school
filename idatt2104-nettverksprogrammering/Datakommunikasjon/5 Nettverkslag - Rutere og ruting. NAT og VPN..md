---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

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

| Prefiks | Antall Adresser |
| ------- | --------------- |
| /24     | 256             |
| /25     | 128             |
| /26     | 64              |
| /27     | 32              |
| /28     | 16              |
| /29     | 4               |
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

- [ ] **To hovedtyper:**
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


## See also
- [[idatt2104-moc]]
