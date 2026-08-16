---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## To hovedprinsipper i datakom
### 1. Pakkesvitsjing
**Pakkesvitsjing:** datamengden som overføres mellom applikasjoner kan deles opp i passe store blokkes og sendes hver for seg.
- Hver datapakke blir da en selvstendig enhet som kommer frem til rett mottaker ved hjelp av adressering
*Fordeler*
- Datapakker mellom flere avsendere og mottakere kan sendes over samme linjeressurs (båndbredde)
- Benytte alternative ruter hvis det oppstår linjebrudd
### 2. Bygd opp som en lagdelt modell
- Oppgavene på de ulike lagene utføres av protokoller som opererer på samme lag mellom enheter. 
- *Protokoller:* standardiserte sett av regler og prosedyrer for hvordan den ønskede kommunikasjonen skal utføres.
## Lagmodeller for datakommunikasjon - foreneklet 5-lags OSI
![[Screenshot 2026-01-07 at 09.58.17.png | 650 ]]
- *Applikasjonslaget*: Interface mot den distribuerte applikasjonen. Overfører data som meldinger mellom partene
- *Transportlaget:* Overfører meldingene som segmenter til rett applikasjonsprotokoll hos mottaker, gir oss ende-ende kommunikasjon mellom applikasjonene.
- *Nettverkslaget:* Sørger for at hver pakke rutes gjennom nettet til rett mottakers IP-grensesnitt
- *Lenkelaget:* Sørger for at pakkene overføres mellom tilstøtende noder (mellom to nettverkskort)
- *Fysisk lag:* Sender signaler over et transmisjonsmedium (luft, kopper fiber).
## Innpakkingsprinsippet og pakkehoder (header)
**Innpakkingsprinsippet**
- Data fra applikasjonene overlates til applikasjonslaget som formaterer og pakker dette inn som en melding
- Meldingen overlates til laget under som *nyttelast* for videre håndtering
- *For hver lag:* pakkes nyttelasten inn med et nytt header. Pakken øker i størrelse for hvert steg
![[Screenshot 2026-01-07 at 10.12.31.png | 600]]
**Protokollene styres av pakkehoder** 
- Protokollenes virkemåte er entydig gitt av innholdet i header og reglene for håndtering av disse
## Kryptert overføring
Sikker overføring kan skje på flere lag *samtidig* og uavhengig av hverandre
Transport: TSL/SSL
Nettverk: VPN
Lenkelag: WPA2
## Internett er en sammenkopling av IP-subnett 
**Et IP-subnett er kjennetegnet ved at**
- Subnettet har et unikt prefiks (egen adresse) på internett
- Nodene kan kommunisere direkte med hverandre, de har et felles kringkastingsdomene.
- Nodene i subnettet må gå via en ruter (Default gateway) for å kommunisere med andre subnett

IP-addresser og routing hører til i *nettvverkslaget*
*Lenkelaget* sørger for fysisk overføring av pakker mellom nettverkskortenes MAC-addresser på *lenkelaget*
## Adresser i datapakker
**Transportlaget:** PORTNUMMER
- 16 bit, addresserom 0-65575 (64k)
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


## See also
- [[idatt2104-moc]]
