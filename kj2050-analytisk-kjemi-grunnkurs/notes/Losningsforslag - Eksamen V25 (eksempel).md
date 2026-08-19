---
type: note
status: active
project: ntnu
course: KJ2050
tags: [ntnu, kjemi, analytisk-kjemi, solutions]
---

## Løsningsforslag: KJ2050 eksamensoppgave V25

Gjelder `materials/Tidl. eksamensoppg./Eksamen_eksempel.pdf`, eksamen 14.05.2025.
Dette settet er det eneste i rommet uten fasit. Prøveeksamen har fasit i
`Fasitt_prøveeksamen.pdf` og `Fasit prøveeksamen, del 2.pdf`.

Settet er 18 vurderte oppgaver på til sammen 60 poeng, pluss opplasting av den
individuelle oppgaven som alene teller 40 poeng. Regnesvar er regnet ut på nytt
her, ikke hentet fra noen fasit.

### Oppgave 1: feiltyper (2 poeng, 0,5 per delsvar)

| utsagn | svar |
|---|---|
| feil som fordeler data symmetrisk rundt en middelverdi | **tilfeldig feil** |
| feil som gjør at gjennomsnittet avviker fra akseptert verdi | **systematisk feil** |
| feil uavhengig av prøvestørrelsen | **konstant feil** |
| feil som øker eller minker med prøvestørrelsen | **proporsjonal feil** |

Tilfeldig feil treffer presisjonen, systematisk feil treffer nøyaktigheten.
Konstant og proporsjonal er de to underklassene av systematisk feil, og skilles
på hvordan de oppfører seg når du endrer prøvemengden. Det er nettopp den
forskjellen oppgave 2 måler.

### Oppgave 2: konstant feil, relativt utslag (4 poeng)

Absolutt feil er 3,0 mg uansett prøve. Relativ feil er derfor

$$\frac{3{,}0}{60} \times 100 = \mathbf{5{,}0\ \%}, \qquad
\frac{3{,}0}{300} \times 100 = \mathbf{1{,}0\ \%}.$$

Poenget: en konstant feil blir mindre og mindre plagsom jo større prøve du tar.
Det er grunnen til at man oppdager konstante feil ved å analysere prøver av ulik
størrelse og se om resultatet i prosent driver.

### Oppgave 3: indirekte kompleksometrisk titrering (5 poeng)

EDTA binder Ca og Mg i forholdet 1:1.

- Tilsatt EDTA: $0{,}0250\ \mathrm{L} \times 0{,}0500\ \mathrm{M} = 1{,}25\ \mathrm{mmol}$
- Overskudd, funnet ved tilbaketitrering med Mg: $0{,}006\ \mathrm{L} \times 0{,}0500\ \mathrm{M} = 0{,}300\ \mathrm{mmol}$
- EDTA bundet til kalsium: $1{,}25 - 0{,}300 = 0{,}950\ \mathrm{mmol}$

$$c(\mathrm{Ca}) = \frac{0{,}950\ \mathrm{mmol}}{25{,}0\ \mathrm{mL}} = \mathbf{0{,}0380\ \mathrm{mol/L}}$$

### Oppgave 4: standardløsning av trijodid (2 poeng)

$$n(\mathrm{I}_3^-) = 0{,}500\ \mathrm{L} \times 0{,}01\ \mathrm{M} = 5{,}00 \times 10^{-3}\ \mathrm{mol}$$

Støkiometrien i $\mathrm{IO}_3^- + 8\mathrm{I}^- + 6\mathrm{H}^+ = 3\mathrm{I}_3^- + 3\mathrm{H}_2\mathrm{O}$
gir 3 mol trijodid per mol jodat, så

$$n(\mathrm{KIO}_3) = \frac{5{,}00\times10^{-3}}{3} = 1{,}667\times10^{-3}\ \mathrm{mol},
\qquad m = 1{,}667\times10^{-3} \times 214{,}001 = \mathbf{0{,}357\ \mathrm{g}}$$

Faktoren 3 er hele oppgaven. Glemmer du den får du 1,07 g, som er akkurat tre
ganger for mye. Molmassene for $\mathrm{IO}_3^-$ og KI er oppgitt, men brukes
ikke, KI er i overskudd.

### Oppgave 5: gravimetri (3 poeng)

$$n(\mathrm{Fe_2O_3}) = \frac{0{,}1125}{159{,}7} = 7{,}044\times10^{-4}\ \mathrm{mol}$$

To jern per formelenhet:

$$m(\mathrm{Fe}) = 2 \times 7{,}044\times10^{-4} \times 55{,}8 = 0{,}07862\ \mathrm{g} = 78{,}62\ \mathrm{mg}$$

$$c(\mathrm{Fe}) = \frac{78{,}62\ \mathrm{mg}}{0{,}0250\ \mathrm{L}} = \mathbf{3{,}14\times10^{3}\ \mathrm{mg/L}}$$

Den gravimetriske faktoren $2M_{\mathrm{Fe}}/M_{\mathrm{Fe_2O_3}} = 0{,}6989$ gir
det samme i ett steg. Merk formuleringen "antatt å kun være $\mathrm{Fe_2O_3}$".
Er glødingen ufullstendig sitter det igjen $\mathrm{Fe_3O_4}$ eller vann, og da
er hele svaret feil uten at regnestykket viser det.

### Oppgave 6: tilbaketitrering (2 poeng)

**Riktig: "utføres bl.a. når det ikke er noe god indikator for analytten."**

Tilbaketitrering brukes når direkte titrering ikke går: ingen brukbar indikator,
for langsom reaksjon mellom titrant og analytt, eller analytt som er tungt
løselig eller flyktig. Man tilsetter kjent overskudd av reagens, lar reaksjonen
gå ferdig, og titrerer overskuddet.

De tre andre beskriver henholdsvis en feil man har gjort, en omkjøring på grunn
av dårlig presisjon, og en blindtitrering. Ingen av dem er tilbaketitrering.

### Oppgave 7: indikator i syre/base-titrering (2 poeng)

**Riktig: "området for hvor en indikator skifter farge er avhengig av kolloide
partikler i løsningen."**

Omslagsområdet er ikke en naturkonstant. Det flytter seg med temperatur (fordi
$K_a$ for indikatoren er temperaturavhengig), med løsemiddel, med ionestyrke, og
med kolloider i løsningen fordi indikatormolekylene adsorberes på
partikkeloverflaten. De tre første alternativene påstår uavhengighet, og er
dermed gale hver for seg. Bare det siste er sant.

### Oppgave 8: fem feilkilder ved indirekte titrering av svak syre (5 poeng)

Oppsettet: overskudd NaOH tilsettes, overskuddet tilbaketitreres med sterk syre,
omslag observeres med indikator. Regnestykket er

$$n(\text{svak syre}) = n(\mathrm{NaOH})_{\text{tilsatt}} - n(\mathrm{H^+})_{\text{tilbake}}$$

så alt som får første ledd til å se for stort ut, eller andre ledd for lite, gir
positiv feil.

1. **Karbonat i natronlutstandarden.** NaOH trekker $\mathrm{CO_2}$ fra lufta og
   danner $\mathrm{Na_2CO_3}$. Standarden er da svakere enn den nominelle
   verdien, mens du regner med den nominelle. Første ledd blir for stort.
   **Positiv feil.**
2. **$\mathrm{CO_2}$ absorbert i prøveløsningen mens overskuddet av base står og
   venter.** Karbonsyren som dannes forbruker NaOH som du krediterer den svake
   syren. **Positiv feil.** Dette er grunnen til at man holder kolben lukket og
   ikke lar den stå.
3. **Indikator med omslag i feil pH-område.** Ved ekvivalens inneholder
   løsningen konjugatbasen $\mathrm{A^-}$, så det sanne endepunktet ligger i det
   basiske. Bruker du en indikator som slår om surt, for eksempel metylrødt,
   fortsetter du å tilsette syre og titrerer en del av $\mathrm{A^-}$ i tillegg.
   Andre ledd blir for stort. **Negativ feil.**
4. **Ufullstendig reaksjon eller ufullstendig oppløst prøve før
   tilbaketitreringen.** Da har mindre NaOH reagert med analytten enn du tror, og
   mer blir igjen til tilbaketitreringen. **Negativ feil.**
5. **Feil i standardiseringen av titrantene, eller volumetriske feil.** Feil
   konsentrasjon på NaOH eller på syra er en proporsjonal feil som slår rett inn
   i sluttsvaret, med fortegn etter hvilken vei standardiseringen bommet.
   Kalibreringsfeil på pipette og byrette, og temperaturforskjell mellom
   kalibrerings- og brukstemperatur, hører til samme kategori.

En sjette som ofte gir poeng: **indikatorblindprøve**, altså at indikatoren selv
er en svak syre eller base og forbruker titrant. Fortegnet følger av hvilken
titrant den forbruker, og feilen fjernes med blindtitrering.

### Oppgave 9: UV/VIS mot IR, kvantitativt (2 poeng)

**Usant.**

Påstanden er snudd på hodet. UV/VIS har molare absorptiviteter i størrelsesorden
$10^4$ til $10^5\ \mathrm{L\,mol^{-1}cm^{-1}}$, langt over det IR gir, og er
metoden man faktisk bruker til rutinemessig kvantifisering. IR har det verre med
Beers lov, ikke bedre: smale bånd i forhold til spaltebredden gir polykromatisk
stråling over båndet, kyvettene har kort og vanskelig definert veilengde, og
løsemiddelvinduet er trangt. IR er sterkest til kvalitativ identifikasjon.

### Oppgave 10: mettede bindinger i UV/VIS (2 poeng)

**Usant.**

Mettede bindinger gir bare $\sigma \rightarrow \sigma^*$-overganger, som krever
så mye energi at absorpsjonen ligger under omtrent 180 nm, altså i vakuum-UV der
vanlige instrumenter og luft ikke slipper til. Kromoforer i UV/VIS er umettede:
$\pi \rightarrow \pi^*$ og $n \rightarrow \pi^*$. Det er nettopp derfor mettede
løsemidler som heksan og etanol er brukbare i UV/VIS, de absorberer ikke.

### Oppgave 11: fotoceller (2 poeng)

**Riktig: "fotoceller har ingen innebygd forsterkning."**

En fotocelle, altså en fotovoltaisk celle, gir en strøm direkte proporsjonal med
lyset og har ingen intern forsterkning. Det er forskjellen fra et
fotomultiplikatorrør, der dynodekjeden gir en forsterkning på $10^6$ til $10^9$,
og fra en fotodiode med avalanche-effekt. Konsekvensen er at fotoceller er
robuste, billige og fine ved høye lysnivåer, men ubrukelige ved svak stråling.

De to andre alternativene beskriver monokromatorens spalter og en bølgevelger,
altså komponenter foran detektoren, ikke detektoren selv.

### Oppgave 12: globarlampe (2 poeng)

**Silisiumkarbid**, som stråler i **IR**-området.

SiC-staven varmes til rundt 1500 grader og gir kontinuerlig svartlegemestråling
gjennom hele midt-IR. Nernst-glower ($\mathrm{ZrO_2}$ med sjeldne jordarter) er
den andre klassiske IR-kilden, og sølvjodid og natriumklorid er
vindus- og kyvettematerialer, ikke strålingskilder.

### Oppgave 13: bly i blod med AAS (3 poeng)

Standardene ble behandlet på samme måte og i samme volum som prøven, så
ekstraksjonsutbyttet er felles og faller ut. Vanlig kalibreringskurve på de to
punktene:

$$\text{stigningstall} = \frac{0{,}599 - 0{,}396}{0{,}600 - 0{,}400} = 1{,}015\ \mathrm{ppm^{-1}}$$
$$\text{skjæring} = 0{,}396 - 1{,}015 \times 0{,}400 = -0{,}010$$
$$c = \frac{0{,}502 + 0{,}010}{1{,}015} = \mathbf{0{,}504\ \mathrm{ppm}}$$

Oppgaven ber om tre desimaler, som er hintet om at skjæringen ikke er null.
Regner du med rett forholdsregning fra ett punkt, $0{,}502/0{,}396 \times 0{,}400
= 0{,}507$, treffer du ikke. Beers lov ekstrapolert til null gjennom to
kalibreringspunkter er ikke det samme som en enkelt forholdsberegning.

Legg merke til hvorfor forsøket er lagt opp som det er: proteinfelling med
trikloreddiksyre, pH-justering og ekstraksjon med APCD i metylisobutylketon
skiller blyet fra blodmatriksen og konsentrerer det opp. Standardene må gjennom
nøyaktig samme sekvens, ellers sammenlikner du to forskjellige utbytter.

### Oppgave 14: fotodetektor (3 poeng)

"En fotodetektor produserer strøm eller spenning som resultat av **emisjon** av
**elektroner** fra en lysfølsom overflate når den treffes av **fotoner**."

Den ytre fotoelektriske effekten. Absorpsjon er det fotonene blir utsatt for,
ikke det detektoren produserer strøm av, og adsorpsjon er overflatekjemi og hører
ikke hjemme i setningen i det hele tatt.

### Oppgave 15: høyoppløselig ICP-MS (4 poeng)

**Hva det er.** Et sektorfeltinstrument med dobbeltfokusering, altså en
elektrostatisk analysator i serie med en magnetsektor, i stedet for en
kvadrupol. Oppløsningen $R = m/\Delta m$ kan settes til typisk 300, 4000 eller
10 000 ved å stramme inn inngangs- og utgangsspaltene. Hensikten er å skille
analyttionet fra polyatomære interferenser med samme nominelle masse.

Det klassiske eksemplet: $^{56}\mathrm{Fe^+}$ har masse 55,9349 og
$^{40}\mathrm{Ar^{16}O^+}$ har 55,9573. Differansen er 0,0224, som krever

$$R = \frac{55{,}9349}{0{,}0224} \approx 2500$$

Det er langt over kvadrupolens enhetsoppløsning, men godt innenfor det et
sektorinstrument klarer. Andre vanlige tilfeller er $^{40}\mathrm{Ar^+}$ på
$^{40}\mathrm{Ca^+}$, $^{38}\mathrm{ArH^+}$ på $^{39}\mathrm{K^+}$ og
$^{40}\mathrm{Ar^{12}C^+}$ på $^{52}\mathrm{Cr^+}$.

**Fordeler.** Fjerner spektrale interferenser istedenfor å korrigere for dem
matematisk. Svært lav bakgrunn og dermed deteksjonsgrenser ned mot ppt og lavere
ved lav oppløsning. Flate topper ved lav oppløsning gir god presisjon, som er det
isotopforholdsmålinger krever. Stort lineært dynamisk område.

**Ulemper.** Dyrt å kjøpe og dyrt å drive, og krever mer kompetent operatør.
Følsomheten faller kraftig når oppløsningen økes, gjerne en størrelsesorden fra
$R = 300$ til $R = 10\,000$, fordi spaltene slipper gjennom mindre. Magneten må
sveipes, så skanning over et bredt masseområde er tregere enn med kvadrupol, og
det gjør instrumentet dårligere egnet til raske transienter fra
laserablasjon eller kromatografi. For mange oppgaver er en kvadrupol med
kollisjons- eller reaksjonscelle et billigere svar på det samme problemet.

### Oppgave 16: hvorfor ICP passer til massespektrometri (3 poeng)

Tre riktige:

1. **Spekter som består av enkle serier av isotoptopper for hvert element.**
   Massespekteret er dramatisk enklere enn et atomemisjonsspekter, som har
   tusenvis av linjer per element.
2. **Høy temperatur som er gunstig for danning av ioner.** Plasmaet ligger på
   6000 til 10 000 K og ioniserer de fleste grunnstoffene tilnærmet fullstendig,
   noe som er hele forutsetningen for et massespektrometer.
3. **Lang oppholdstid i plasmaet som sikrer komplett fordamping.** Rundt 2 ms,
   vesentlig lenger enn i en flamme, så desolvatisering, fordamping og
   atomisering rekker å bli ferdig.

De tre gale: isotopene kommer som separate topper og ikke samlet i én topp,
kort oppholdstid er ikke fordelen her, og argonet gir tvert imot de polyatomære
interferensene som oppgave 15 handler om.

### Oppgave 17: kromatografi, sant eller usant (10 poeng)

| utsagn | svar | begrunnelse |
|---|---|---|
| ikke nødvendig med høyt trykk for mobilfasen i tynnfilmkapillærkolonner | **sant** | Åpne kapillærkolonner i GC har åpen gjennomstrømning og lavt trykkfall. Høyt trykk hører til pakkede HPLC-kolonner. |
| små molekyler eluerer alltid før større | **usant** | I størrelseseksklusjon er det motsatt: store molekyler kommer ikke inn i porene og eluerer først. "Uansett prosess" gjør utsagnet galt. |
| UV-detektoren har begrenset evne til å skille ulike organiske forbindelser i LC | **sant** | UV er en tilnærmet universaldetektor for kromoforer. Den sier hvor mye som eluerer, ikke hva. Til identifikasjon trengs MS eller diodearray med spektralsammenlikning. |
| metanol kan brukes i væske-væske-ekstraksjon av jod løst i vann | **usant** | Metanol er fullt blandbart med vann, så det blir aldri to faser. Man bruker for eksempel kloroform eller karbontetraklorid. |
| både topparealer og topphøyder kan brukes kvantitativt | **sant** | Areal er å foretrekke fordi det tåler variasjon i toppbredde, men høyde fungerer på skarpe, symmetriske topper. |
| kationbyttemateriale isolerer analyttioner ved å binde anioner | **usant** | En kationbytter har negativt ladde grupper og binder kationer. Definisjonen står i navnet. |
| fordelingskoeffisient 86 betyr 86 M i organisk fase når vannfasen er 1 M | **usant** | Se merknaden under. |
| retensjonstidene omtrent dobles når HPLC-kolonnen dobles i lengde | **sant** | Ved samme lineære hastighet dobles både dødtiden og alle retensjonstidene, siden $t_R = t_M(1+k)$ og $k$ ikke endres av lengden. |
| splitless brukes for å redusere mengden analytt på GC-kapillærkolonnen | **usant** | Splitless gjør det motsatte, det er metoden for sporanalyse der man vil ha mest mulig av prøven inn på kolonnen. Split er den som reduserer. |
| HPLC kan ikke analysere kjemikalier som ikke løses i vann | **usant** | Mobilfasen trenger ikke være vandig. Normalfase med heksan, eller omvendt fase med høy andel acetonitril eller metanol, håndterer vannuløselige stoffer fint. |

**Merknad om fordelingskoeffisienten.** Her er utsagnet verdt en setning ekstra,
for den formelle definisjonen $K = [\mathrm{I_2}]_{org}/[\mathrm{I_2}]_{aq} = 86$
gir bokstavelig talt 86 M hvis vannfasen er 1 M. Grunnen til at det likevel er
galt er at $K$ er et forhold mellom aktiviteter og bare er tilnærmet konstant i
det fortynnede området. 86 M jod er langt over løseligheten i noe løsemiddel, så
systemet mettes og faststoff feller ut i stedet. Regner du med en 1 M vannfase
har du dessuten allerede sprengt jods løselighet i vann. Konklusjonen holder,
men det er verdt å vite at det er fysikken og ikke algebraen som feller
utsagnet.

### Oppgave 18: potensiometri, sant eller usant (4 poeng)

| utsagn | svar | begrunnelse |
|---|---|---|
| responsen til ioneselektive elektroder er temperaturavhengig | **sant** | Nernst-hellingen er $RT/nF$, altså 59,2 mV per dekade for et enverdig ion ved 25 grader, og den endrer seg med temperaturen. Derfor termostateres eller temperaturkompenseres målingene. |
| $E_j$ kalles overgangspotensial og kan skyldes ulik diffusjonshastighet for kation og anion i saltbroen | **sant** | Nettopp derfor brukes KCl i saltbroen: $\mathrm{K^+}$ og $\mathrm{Cl^-}$ har nesten lik mobilitet, så $E_j$ blir liten. |
| TISAB brukes for å hindre at salt fra referanseelektroden endrer analyttkonsentrasjonen | **usant** | Det er ikke funksjonen. Lekkasjen fra referanseelektroden er dessuten liten mot totalvolumet. |
| TISAB brukes for å utjevne forskjeller i ionestyrke, siden ioneaktiviteten er ionestyrkeavhengig | **sant** | Kjernen i saken. Elektroden svarer på aktivitet, mens du vil ha konsentrasjon. Setter du samme høye ionestyrke i alle prøver og standarder, blir aktivitetskoeffisienten konstant og kalibreringen gyldig. |

TISAB gjør i praksis tre ting samtidig: fastsetter ionestyrken, buffrer pH, og
maskerer interferenter. Ved fluoridmåling kompleksbinder CDTA-komponenten
$\mathrm{Al^{3+}}$ og $\mathrm{Fe^{3+}}$ som ellers ville bundet fluoridet, og
pH-buffringen hindrer at fluoridet protoneres til HF.

### Oppgave 19: individuell oppgave (40 poeng)

Denne lastes opp som pdf og utgjør 40 av 100 poeng, altså mer enn hele
spørsmålsdelen over. Oppgaveteksten ligger ikke i dette dokumentet, den kommer
som eget vedlegg på eksamensdagen. Forsida presiserer to ting om den: kilder skal
være med etter oppgaveteksten, og den er et selvstendig arbeid som kan bygge på
et gruppeforarbeid slik at sammenfallende kilder tillates innenfor gruppenivå.

### Lenker

- [[README]]
- Fasit for prøveeksamen: `materials/Tidl. eksamensoppg./Fasitt_prøveeksamen.pdf`
  og `Fasit prøveeksamen, del 2.pdf`
