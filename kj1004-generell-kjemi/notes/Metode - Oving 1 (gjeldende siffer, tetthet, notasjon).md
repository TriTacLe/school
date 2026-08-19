---
type: note
status: active
project: ntnu
course: KJ1004
tags: [ntnu, kjemi, metode]
---

## Metode for Øving 1: gjeldende siffer, tetthet og notasjon

**Dette notatet inneholder ikke svarene på Øving 1.** Øvingen er obligatorisk med
frist 30.08.2026 kl. 23:59, og emnesida sier det rett ut på sida "Hvordan bruke
kunstig intelligens (KI)": å bruke KI til å bare gi deg fasiten på obligatoriske
oppgaver regnes som fusk. Det som står her er reglene bak hver oppgavetype, og
gjennomregnede analoge oppgaver med andre tall. Bruk dem til å sjekke at metoden
sitter, og regn så din egen øving selv.

Øving 1 har 19 spørsmål fordelt på sju oppgavetyper. Under er hver type med
regelen, en analog oppgave, og de vanlige fellene.

### Type 1: tetthet som omregningsfaktor (spørsmål 1)

Tetthet er ikke noe du "setter inn i en formel", det er en omregningsfaktor
mellom masse og volum. Skriv den som en brøk og la enhetene stryke hverandre:

$$\rho = \frac{m}{V} \quad\Longrightarrow\quad m = \rho V, \qquad V = \frac{m}{\rho}$$

**Analog oppgave.** Etanol har tetthet 0,789 g/mL. Hvor mange gram er det i
62,4 mL?

$$m = 0{,}789\ \frac{\mathrm{g}}{\mathrm{mL}} \times 62{,}4\ \mathrm{mL} = 49{,}2336\ \mathrm{g} \approx \mathbf{49{,}2\ g}$$

Begge oppgitte tall har tre gjeldende siffer, så svaret får tre.

**Analog andre vei.** Hvor stort volum er 35,0 g etanol?
$V = 35{,}0/0{,}789 = 44{,}36\ldots \approx 44{,}4\ \mathrm{mL}$.

Feller: å gange når du skulle dividere. Sjekken er enhetene. Skal du ha gram, må
enheten mL stå én gang i teller og én gang i nevner. Og husk at 1 mL = 1 cm³
nøyaktig, det er ikke en måling og bidrar ikke med gjeldende siffer.

### Type 2: vitenskapelig notasjon (spørsmål 2 til 4)

Formen er $a \times 10^{n}$ der $1 \le |a| < 10$. Nøyaktig ett siffer foran
komma, og det sifferet kan ikke være null.

- Flytter du komma mot venstre, går eksponenten opp.
- Flytter du komma mot høyre, går eksponenten ned.

**Analoge:** $0{,}00487 = 4{,}87 \times 10^{-3}$, $91\,500 = 9{,}15 \times 10^{4}$,
$0{,}308 = 3{,}08 \times 10^{-1}$.

Merk det siste: et tall mellom 0,1 og 1 får eksponent $-1$, ikke 0. Det er den
vanligste slurvefeilen på denne typen.

Vitenskapelig notasjon gjør også antall gjeldende siffer entydig, og det er
grunnen til at neste oppgavetype kommer rett etter denne.

### Type 3: telle gjeldende siffer (spørsmål 5 til 12)

Reglene, i den rekkefølgen du bruker dem:

1. Alle siffer fra 1 til 9 teller alltid.
2. Nuller **mellom** siffer teller alltid. 485,89 og 169,0 og 734,01000, alle
   nullene inni er med.
3. Nuller **foran** det første siffer fra 1 til 9 teller aldri. De er bare
   plassholdere for kommaet. I 0,000300 er de fire første nullene ikke
   gjeldende.
4. Nuller **bakerst** teller hvis tallet har komma. 0,961000 har seks gjeldende
   siffer, og 0,000300 har tre. Nullene bakerst ville ikke stått der hvis de ikke
   betydde noe.
5. Nuller bakerst i et heltall **uten** komma er tvetydige. Er 7 750 000 000 målt
   til tre siffer eller til ti? Konvensjonen i dette emnet er å regne dem som
   ikke gjeldende, men den ordentlige løsningen er vitenskapelig notasjon:
   $7{,}75 \times 10^{9}$ sier tre siffer, $7{,}750 \times 10^{9}$ sier fire.

**Analog tabell**, tell selv før du ser fasiten til høyre:

| tall | gjeldende siffer |
|---|---|
| 0,00250 | 3 |
| 4008 | 4 |
| 62 000 | 2 (tvetydig, se regel 5) |
| 1,0900 | 5 |
| 0,04 | 1 |
| 300,0 | 4 |

Én til: en null helt foran hele tallet, som i skrivemåten 0290, er aldri
gjeldende. Den er ren pynt.

### Type 4: regning med gjeldende siffer (spørsmål 13 til 16)

To regler, og de er ikke vilkårlige. `Kapittel 1 – Stoff, måling og
problemløsning/KJ100X-Gjeldende-siffer.pdf` utleder begge fra samme prinsipp:
svaret skal ikke late som det vet mer enn den svakeste målingen bak det. Les den,
det er to sider og de er verdt tida.

**Addisjon og subtraksjon: tell desimaler.** Leddet med færrest desimaler
bestemmer.

$$8{,}213 + 0{,}04 + 12{,}7 = 20{,}953 \approx \mathbf{21{,}0}$$

12,7 har én desimal, så svaret får én. Legg merke til at svaret her har tre
gjeldende siffer selv om ett av leddene bare hadde ett. Det er desimalene som
teller, ikke sifrene.

$$15{,}60 - 9{,}8472 = 5{,}7528 \approx \mathbf{5{,}75}$$

**Multiplikasjon og divisjon: tell gjeldende siffer.** Faktoren med færrest
bestemmer.

$$7{,}82 \times 2{,}4155 = 18{,}88921 \approx \mathbf{18{,}9}$$

**Blandet uttrykk: regn i riktig rekkefølge, og bytt regel underveis.** Dette er
typen som feller folk.

$$(2{,}5 \times 10^{-3} \times 48{,}2) + 5{,}17$$

1. Gang først. $2{,}5\times10^{-3} \times 48{,}2 = 0{,}1205$. Her gjelder
   gjeldende siffer, og 2,5 har to, så produktet er kjent til to gjeldende
   siffer, altså 0,12.
2. Legg så sammen. Nå gjelder desimalregelen. Produktet 0,12 har to desimaler,
   5,17 har to, så summen får to desimaler.
3. $0{,}1205 + 5{,}17 = 5{,}2905 \approx \mathbf{5{,}29}$

Det viktigste trikset: **rund av bare til slutt.** Bruk hele kalkulatorverdien
0,1205 i addisjonen og rund først når du er ferdig. Runder du av til 0,12 midt i
regnestykket, samler du opp avrundingsfeil. Hold gjerne ett ekstra siffer i
mellomregningene og noter hvor mange siffer svaret skal ha til slutt.

### Type 5: SI-prefikser (spørsmål 17)

De du trenger, i orden:

| prefiks | symbol | faktor |
|---|---|---|
| giga | G | $10^{9}$ |
| mega | M | $10^{6}$ |
| kilo | k | $10^{3}$ |
| desi | d | $10^{-1}$ |
| centi | c | $10^{-2}$ |
| milli | m | $10^{-3}$ |
| mikro | µ | $10^{-6}$ |
| nano | n | $10^{-9}$ |
| piko | p | $10^{-12}$ |

Fra milli og nedover går det i sprang på tre tierpotenser. Desi og centi er
unntakene som bryter mønsteret, og det er nettopp derfor de er lette å blande med
milli.

**Analog:** hvor mange nanometer er 0,0045 mm?
$0{,}0045\ \mathrm{mm} = 4{,}5\times10^{-6}\ \mathrm{m} = 4{,}5\times10^{3}\ \mathrm{nm} = 4500\ \mathrm{nm}$.

### Type 6: masseprosent kombinert med tetthet (spørsmål 18)

Dette er en tostegs oppgave, og fella er å hoppe over det første steget. Prosenten
er **av massen**, men du har fått **volum**. Tettheten er broen mellom dem.

1. Volum til masse løsning: $m_{\text{løsning}} = \rho V$
2. Masse løsning til masse stoff: $m_{\text{stoff}} = \dfrac{\%}{100} \times m_{\text{løsning}}$

**Analog oppgave.** En glukoseløsning er 3,50 % glukose regnet på masse og har
tetthet 1,012 g/cm³. Hvor mange gram glukose i 275 mL?

$$m_{\text{løsning}} = 1{,}012\ \frac{\mathrm{g}}{\mathrm{cm^3}} \times 275\ \mathrm{cm^3} = 278{,}3\ \mathrm{g}$$
$$m_{\text{glukose}} = 0{,}0350 \times 278{,}3\ \mathrm{g} = 9{,}7405\ \mathrm{g} \approx \mathbf{9{,}74\ g}$$

Fornuftssjekk, som tipssida ber om: 3,5 % av knapt 280 g skal være rundt 10 g. Det
stemmer. Får du et svar i hundregramsklassen, har du glemt å dele på 100. Får du
noe i milligramklassen, har du delt to ganger.

### Type 7: fysisk eller kjemisk egenskap (spørsmål 19)

Skillet: en **fysisk** egenskap kan observeres uten at stoffet blir et annet
stoff. En **kjemisk** egenskap viser seg bare når stoffet reagerer og blir noe
annet.

- Fysisk: smeltepunkt, kokepunkt, tetthet, farge, hardhet, formbarhet,
  ledningsevne, løselighet i vann uten reaksjon, klang.
- Kjemisk: brennbarhet, det å ruste, reaksjon med syre, reaksjon med oksygen,
  giftighet, evne til å felle ut med et bestemt reagens.

Testen som nesten alltid avgjør: **er det et nytt stoff etterpå?** En metallstav
som bøyes er fortsatt samme metall, altså fysisk. Et metall som løses i syre og
utvikler gass er ikke lenger metall, gassen er hydrogen og metallet har blitt et
salt, altså kjemisk.

Vanlig felle: en faseovergang eller en overgang mellom to former av samme
grunnstoff er **fysisk**, selv om utseendet endrer seg dramatisk. At noe smuldrer,
skifter farge eller skifter fase betyr ikke i seg selv at det har skjedd en
kjemisk reaksjon.

### Sjekkliste før innlevering

Fra emnets egen tipsside, som øvingslæreren retter etter:

- Vis utregningen steg for steg, med enheter hele veien.
- Riktig antall gjeldende siffer i sluttsvaret, og rund av bare til slutt.
- Begrunn svaret, ikke bare tallet.
- Fornuftssjekk: er størrelsesordenen rimelig?
- Diskuter gjerne framgangsmåten i kollokvium, men skriv din egen besvarelse.

Oppgavenummereringen i pdf-en følger nummereringen i Canvas-innleveringen, så
svar i samme rekkefølge.

### Lenker

- [[README]]
- `materials/Kapittel 1 – Stoff, måling og problemløsning/KJ100X-Gjeldende-siffer.pdf`
- `materials/Øvinger/Noen generelle tips for innleveringsoppgaver i kjemi.md`
