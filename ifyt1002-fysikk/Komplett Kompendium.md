---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## Kap. 1: Enheter og målinger  

**SI-systemet**

| Basis-størrelser      | SI-enheter |
| --------------------- | ---------- |
| Lengde (L)            | m          |
| Masse (M)             | kg         |
| Tid (T)               | s          |
| Elektrisk strøm (I)   | A          |
| Temperatur ($\theta$) | K          |
| Stoffmengde (N)       | mol        |
| Lysintensitet (J)     | cd         |
**Dimensjonsanalyse**
1. Enhver fysisk størrelse A kan skrives som: $$[A]=L^a \cdot M^b \cdot T^c \cdot I^d \cdot \theta^e \cdot N^f \cdot J^g$$
der $a,..,g$ er positive eller negative heltall eller null
2. Enhver fysisk sammenheng/likning må ha samme dimensjon på begge sider av likhetstegnet

**Gjeldende siffer -** Indikerer presisjon i målinger:
- Ved multiplikasjon/divisjon: resultatet får samme antall gjeldende siffer som tallet med færrest gjeldende siffer
- Ved addisjon/subtraksjon: resultatet får samme antall desimaler som tallet med færrest desimaler

**Estimering -** grove overslag for å sjekke om svar gir mening
## Kap. 2: Vektorer  
**Skalarer:** størrelse uten retning (masse, temperatur, tid)
**Vektorer:** størrelse med retning (hastighet, kraft, akselerasjon)

**Komponentform**
I 2D: $\vec{A}=A_x\hat{i}+A_y\hat{j}$
- Størrelse: $|\vec{A}|=\sqrt{A^2_x+A^2_y}$
- Retningsvinkel: $\theta = tan^-1(A_y/A_x)$

Vektoroperasjoner
Vektorprodukt
## Kap. 3: Rettlinjet bevegelse  
### 3.1 Posisjon, posisjonsendring og gjennomsnittsfart

**Posisjon $x$**
- Beskriver objektets plassering langs en linje
- SI-enhet: meter (m)

**Posisjonsendring/forflytning ($\Delta x$)**
- Endring i posisjon: $\Delta x=x-x_0$
- Er en vektor (har retning)
- Kan være positiv eller negativ

**Tilbakelagt strekning**
- Total lengde av veien som tilbakelegges
- Alltid positiv

**Gjennomsnittsfart($\bar{v}$)**$$\bar{v}=\frac{\Delta x}{\Delta t}=\frac{x-x_0}{t-t_0}$$
### 3.2 Momentanfart
**Momentanfart $v$** 
- Farten i et bestemt tidspunkt
- Den deriverte av posisjonen med hensyn på tid $$v=\frac{dx}{dt}$$
**Momentan fart**
- Absoluttverdien av momentanfarten $|v|$
- Alltid positiv
### 3.3 Gjennomsnitts- og momentanakselerasjon
**Gjennomsnittsakselerasjon $\bar{a}$** $$\bar{a}=\frac{\Delta v}{\Delta t}=\frac{v-v_0}{t-t_0}$$
**Momentakselerasjon $a$**
- Akselasjonen i et bestemt tidspunkt
- Den deriverte av fart med hensyn på tid: $$a=\frac{dv}{dt}=\frac{d^2x}{dt^2}$$
**Ops:**
- Akselerasjonen er en vektor
### 3.4 Bevegelse med konstant akselerasjon
**Da gjelder bevegelseslikningene:**
1. $v = v_0 + at$
2. $x = \frac{1}{2}(v_0 + v)t$
3. $x = v_0t + \frac{1}{2}at^2$
4. $v^2 − v_0^2 = 2ax$
5. $x = vt$ (kun når farten er konstant)

**Når bruker du hvilken ligning?**
- Velg ligningen som inneholder de kjente størrelsene og den ukjente du søker etter

### 3.5 Fritt fall
**Fritt fall:**
- Bevegelse kun påvirket av tyngdekraft
- Konstant akselerasjon: $a = -g = -9.81 m/s^2$
*Viktig:*
- Brukt positiv retning oppover
- Ved maksimal høyde: $v=0$
- Samme bevegelseslikninger, men med $a=-g$
**Typiske likninger for fritt fall**:
- $v = v_0 + gt$
- $x = v_0t + \frac{1}{2}gt^2$
- $v^2 − v_0^2 = 2g(y-y_0)$
### 3.6 Finne fart of forflytning fra akselerasjon
Hvis akselerasjon $a(t)$ er kjent som funksjon av tid:
**Fart:**$$v(t)=v_0+\int_0^ta(t')dt'$$
**Posisjon:** $$x(t)=x_0+\int_0^tv(t')dt'$$
## Kap. 4: Krumlinjet bevegelse  
### 4.1: Posisjonsendring og fart som vektorer  
**Posisjonsvektoren $\vec{r}$**
- Vektor fra origo til objektets posisjon
- I 3D: $\vec{r}=x(t)\hat{i}+y(t)\hat{j}+z(t)\hat{k}$

**Forflytningsvektoren** $\Delta \vec{r}$$$\Delta \vec{r}=\vec{r}_2-\vec{r}_1$$
- Kortest vei mellom to punkter

**Momentanfart $\vec{v}$** $$\vec{v}=\frac{d\vec{r}}{dt}\hat{i}+\frac{dy}{dt}\hat{j}+\frac{dz}{dt}\hat{k}$$
- Fartsvektoren er alltid tangent til banen
- Komponentene: $v_x = \frac{dx}{dt}, v_y = \frac{dy}{dt}, v_z = \frac{dz}{dt}$
*Viktig*
- Bevegelse langs vinkelrette akser er uavhengig av hverandre

### 4.2: Akselerasjonsvektoren  
**Momentanakselerasjon $\vec{a}$**$$\vec{a}=\frac{d\vec{v}}{dt}=\frac{d^2\vec{r}}{dt^2}$$
**Komponentform:**$$\vec{a}=a_x\hat{i}+a_y\hat{j}+a_2\hat{k}$$
**Ved konstant akselerasjon:**
- $\vec{v}=\vec{v_0}+\vec{a}t$
- $\vec{r}=\vec{r}_0+\vec{v}_0t+\frac{1}{2}\vec{a}t^2$

### 4.3 Kastebevegelse
Hovedprinsipp: Bevegelser langs perpendikulære (vinkelrette) akser er uavhengige og kan analyseres separat. Vi deler bevegelsen i horisontal $(x)$ og vertikal ($y$) komponent.

| X-retning (konstant fart, $a_x=0$) | Y-retning (konstant akselerasjon , $a_y=-g$) |
| ---------------------------------- | -------------------------------------------- |
| $v_x​=v_{0x}​=v_0​\cosα$ (i)       | $v_y​=v_{0y}​+a_{y​t}=v_0​\sinα−gt$ (iii)    |
| $x=v_0\cos⁡ α\cdot t$ (ii)         | $y=v_0​\sin α\cdot t−\frac{1}{2}​gt^2$ (iv)  |
- (i) Hastigheten i $x$-retning er konstant gjennom hele bevegelsen
- (ii) Posisjonen øker lineært med tiden (ingen $t^2$-ledd)
- (iii) Hastigheten endres lineært med tiden pga. gravitasjon
- (iv) Posisjonen følger en parabel (inneholder $t^2$-ledd)

**Viktige formler**
Flygetid: $$t=\frac{2v_0\sin \alpha}{g}$$Maksimal høyde:$$h_{maks}=\frac{v^2_0\sin^2\alpha}{2g}$$Rekkevidde: $$R=\frac{v^2_0\sin2\alpha}{g}$$
### 4.4 Sirkelbevegelse med konstant banefart 
Hovedprinsipp: selv om farten er konstant, er det akselerasjon fordi hastighetsretningen endres kontinuerlig.
**Sentripetalakselerasjon**
Akselerasjon peker alltid mot sentrum av sirkelen: $$a_\bot=\frac{v^2}{r}=w^2r=\frac{4\pi^2r}{T^2}$$
- $v$ = banefart (m/s)
- $r$ = radius (m)
- $w$ = vinkelfart (rad/s)
- $T$ = omløpstid (s)

**Sentripetalkraft**
Fra Newtons 2. lov: $F = ma$
For sirkelbevegelse:
Sentripetalkraft: $$F_c = ma_c = m(v^2/r)$$
**Typiske situasjoner**
Horisontal sirkelbevegelse
Vertikal sirkelbevegelse
- I alle punkter virker to hovedkrefter på objektet: tyngdekraft ($G=mg$) - alltid nedover og normalkraft/snordragn ($N$ eller $T$) - fra banen/snoren inn mot sentrum
- Bunnen
	- $G$ peker nedover
	- $N$ peker oppover inn mot sentrum
	- $N>G$
- På siden
	- Tyngdekraften bidrar ikke til sentripetalkraft i dette punktet.
- Toppen
	- $N<G$. Normalkraft minst - kan bli null
Konisk pendel
Dosert sving
## Kap. 5: Newtons lover  
### 5.1: Krefter  
Kraft er en vekselsvirkning mellom to legemer. Krefter er en vektor med størrelse (mål i newton, N) og retning
**Krefter:**

| **Kraft**        | **Symbol/Formel**     | **Beskrivelse**                          |
| ---------------- | --------------------- | ---------------------------------------- |
| Tyngdekraft      | $G = mg$              | Virker alltid loddrett nedover           |
| Normalkraft      | $N$                   | Vinkelrett på kontaktflate               |
| Snordrag         | $S (\text{eller } T)$ | Langs snoren, bort fra legemet           |
| Statisk friksjon | $fs ≤ μsN$            | Motvirker glidning, parallell med flate  |
| Glidefriksjon    | $fk = μkN$            | Motvirker bevegelse, parallell med flate |
| Luftmotstand     | $FD = ½ρACv^2$        | Motsatt bevegelsesretning                |
### 5.2: Newtons 1. lov (Treghetsloven) 
**Loven:** Et legemet forblir i ro eller beveger seg med konstant fart i en rett linje med mindre det påvirkes av en ytre nettokraft

Viktig betingelse: Når $\sum F=0$ er akselerasjonen $a=0$. Legemet er enten i ro eller beveger seg med konstant hastighet (uniform rettlinjet bevegelse),  
### 5.3: Newtons 2. lov  
**Loven:** $\sum F=ma$ 
Nettokraft på et legemet er lik produktet av massen og akselerasjonen. Dette er en vektorlikning - husk å sette den opp i komponentform
**Fremgangsmåte:**
1. Tegn frilegeme-diagram med ALLE krafter
2. Velg koordinatsystem (ofte én akse langs bevegelsesretningen)
3. Sett opp $\sum F_x=ma_x$ og $\sum F_y=ma_y$
4. Løs likningen for ukjente
### 5.4: Masse og vekt  
Masse ($m$): Mål på et legemets treghet (motstand mot akselerasjon). Måles i kg. Er en skalar
Vekt ($G$): tyngdekraften på le gemet. $G=mg$ . Måles i newton ($N$). En vektor rettet nedover 

Masse er konstant uansett hvor man er. Vekt endres med tyngdeakselerasjon $g$
### 5.5: Newtons 3. lov (aksjon-reaksjon)
**Loven:** Når et legemet $A$ virker på legemet $B$ med en kraft $FAB$, virker legemet $A$ med en like stor og motsatt rettet kraft $FBA=-FAB$

**Viktige poenger:**
- Kreftene virker på FORSKJELLIGE legemer
- Kreftene er like stor og motsatt rettet
- Aksjon og reaksjon er av samme type (f.eks. begge er tyngdekrefter)
**Eksempel:** Person på badevekt i heis
Badevekta viser normalkraften $N$ fra underlaget på personen. Denne er like stor som kraften personen presser ned på vekta med (Newtons 3.lov). Ved akselerasjon oppover: $N>G$. Ved akselerasjon nedover: $N<G$
### 5.6: Vanlige typer krefter  
**Normalkraft $N$**: Kontaktkraft som virker vinkelrett på kontaktflaten. Normalkraft er IKKE alltid lik tyngdekraften. Den tilpasser seg at legemet ikke trenger seg gjennom underlaget
- På horisontal flate uten andre vertikale krefter: $N=mg$
- På skråplan: $N=mg~\cos{\alpha}$ (der $\alpha$ er skråplansvinkel)

**Friksjon** $f$

| Statisk friksjon                 | Glidefriksjon                    |
| -------------------------------- | -------------------------------- |
| $fs\leq \mu sN$                  | $fk=\mu kN$                      |
| Motvirker begynnende glidning    | Motvirker pågående glidning      |
| Kan variere fra $0$ til $\mu sN$ | Fast verdi $\mu kN$              |
| Vanligvis er $\mu s >\mu k$      | Alltid motsatt bevegelsesretning |

**Snordrag**
For ideell (masseløs og ustrekkbar) snor. Snordraget er lik overalt i snoren. For masseløs snor over friksjonsfri trinse: Snordraget er likt på begge sider. 

Når trinsa har masse, vil snordraget være forskjellige på hver side fordi trinsa må akselereres. Da må man bruke Newtons 2.lov for rotasjon.
### 5.7: Tegne frilegeme-diagram
**Fremgangsmåte**
1. Isoler legemet - tegn det for seg selv
2. Tegn tyngdekraften $G$ (alltid loddrett ned fra massesenter)
3. Identifiser alle kontaktpunkter - tegn normalkraft vinkelrett på flaten
4. Tegn friksjonskrefter parallelt med flaten (motvirker bevegelse/glidning)
5. Tegn snordrag langs snoren, bort fra legemet
6. ALLE kraft må ha navn ($G, N, f, S,$ etc)
7. Velg koordinatsystem og marker positiv retning
## Kap. 6: Anvendelser av Newtons lover  
### 6.1: Problemløsing med Newtons lover  
**Fremgangsmåte**
1. Identifiser systemet: legemet og kraftene som virker på legemet
2. Tegn frilegeme-diagram: tegn legeme, kraftene som virker på legemet og gi dem navn
3. Velg koordinatsystem: velg positiv retning (ofte langs bevegelsesretningen). For skråplan, velg x-akse langs planet og y-akse normalt på
4. Sett opp newtons 2.lov
5. Løs likningene

**Viktige prinsipper**
- Masseløse snorer: Snordraget er likt i begge ender og snora overfører kraft uten tap
- Masseløse trinser: Endrer kraftens retning. Snordraget er likt på begge sider av trinsen
- Systemer av legemer: Legemer koblet med snor har samme akselerasjon (i absoluttverdi). Analyserer hvert legemet separat med Newtons 2.lov
### 6.2: Friksjon  
To typer friksjon
**Statisk friksjon (hvilefriksjon) $f_s$**
- Virker når legemet er i ro relativt til underlaget
- Tilpasser seg for å hindre bevegelse
- Har en maksimal verdi: $$f_s\leq \mu_s N$$
  der $\mu_s$ er statisk friksjonskoeffisient og $N$ er normalkraft 

**Kinetisk friksjon (glidefriksjon) $f_k$**
- Virker når legemet glir på underlaget
- Har konstant størrelse: $$f_k=\mu_k N$$
  der  $\mu_k$ er kinetisk friksjonskoeffisient

Viktige egenskaper:
- $\mu_s > \mu_k$ (alltid)
- Friksjon virker alltid motsatt av bevegelsesretningen (eller tenkt bevegelse for statisk friksjon)
- Friksjonskraften er uavhengig kontaktarealet
- Friksjonskraften er proporsjonal med normalkraften
### 6.3: Sentripetalkraft  
Sentripetalkraft er kraften som holder et legeme i sirkelbevegelse. Kraften peker alltid inn mot sentrum av sirkelen

**Viktige formler**

| Sentripetalakselerasjon | $a_⊥ = v^2/r$       |
| ----------------------- | ------------------- |
| Sentripetalkraft        | $F = ma_⊥ = mv^2/r$ |
| Med vinkelhastighet     | $F = mω^2r$         |
| Sammenhengen v og ω     | $v = ωr$            |
| Periode                 | $T = 2πr/v = 2π/ω$  |
**Problemløsningstrategi**
- Tegn frilegeme-diagram med alle krefter
- Velg koordinatsystem (x mot sentrum, y tangent til banen)
- Sett opp Newtons 2. lov i x-retning, $\sum F_x=mv^2/r$
- Hvis kontant fart: Newtons 1.lov i y-retning: $\sum F_y=0$
- Bruk trigonometri for kraftkomponenter

**Typiske eksempler**
1. Kule i horisontal snor (konisk pendel)
	- Krefter: Tyngde $G=mg$ (ned), snordrag $S$ (langs snor)
	- Vertikalt: $S_y = mg \to S \cos θ = mg$
	- Horisontalt: $Sx = mv^2/r \to S \sin θ = mv^2/r$
	- Radius: $r = l \sin θ$ ($l$ = snorlengde)
2. Dosert sving (banked curve)
	- Krefter: Tyngde $G=mg$ (ned), normalkraft $N$ (vinkelrett på bane)
	- Vertikalt: $N_y = mg \to N \cos \alpha = mg$
	- Horisontalt: $N_x = mv^2/r \to N \sin α = mv^2/r$
	- Løsning: $v = \sqrt{gr \tan \alpha}$
3. Berg-og-dalbane (loop)
	- I toppen: $G + N = mv^2/r$ (begge peker nedover)
	- Minimumsbetingelse: $N ≥ 0 → mg + 0 = mv^2/r → v = \sqrt{gr}$
	- Med energibevaring fra høyde $h$: $mgh = \frac{1}{2}mv^2 + mg(2r)$
	- Minimumshøyde: $h = 5r/2$
**Vanlige feil å unngå**
- Sentripetalkraft er IKKE en egen kraft - det er summen av kreftene inn mot sentrum
- Husk at normalkraft alltid er vinkelrett på underlaget
- Bruk riktig radius (ofte må du finne den fra geometri)
- Husk trigonometri: $\sin θ =$ motstående/hypotenus, $\cos θ$ = hosliggende/hypotenus
### 6.4: Luftmotstand og terminalfart (unntatt: "The Calculus of Velocity-Dependent Frictional Forces")
Luftmotstand (drag) er en kraft som motvirker bevegelse gjennom luft. Ved høye hastigheter er luftmostanden proporsjonal med $v^2$

**Viktige formler**

| Kvadratisk luftmotstand  | $F_D = \frac{1}{2}ρACdv^2$     |
| ------------------------ | ------------------------------ |
| $ρ$ = lufttetthet        | 1.29 kg/m³ (ved havnivå, 15°C) |
| $A$ = frontareal         | $m^2$                          |
| $C_d$ = drag-koeffisient | Dimensjonsløs (typisk 0.5-1.5) |
| Terminalfart             | $v_t = \sqrt{2mg/(ρACd)}$      |
| Ved terminalfart         | $F_D = mg$                     |
**Terminalfart - konsept**
Terminalfart oppnås når luftmotstanden er lik tyngdekraften, slik at nettokraften blir null og legemet faller med konstant fart.
- Før terminalfart: $F_D < mg →$ akselerasjon nedover
- Ved terminalfart: $F_D = mg →$ akselerasjon $= 0$
- Etter terminalfart: $F_D > mg$ (hvis noe endres) $→$ akselerasjon oppover

**Problemløsningsstrategi**
- Finne terminalfart analytisk:
	- Sett opp kraftbalanse: $F_D = mg$
	- Sett inn formelen: $\frac{1}{2}ρACdvt^2 = mg$
	- Løs for $v_t$: $v_t = \sqrt{(2mg/(ρACd))}$
- Numerisk løsning med Eulers metode:
	- Newtons 2. lov: $ma = mg - F_D$
	- Akselerasjon: $a = g - (ρACd/(2m))v^2$
	- Oppdatering: $v(t + Δt) = v(t) + a·Δt$
	- Posisjon: $y(t + Δt) = y(t) + v·Δt$

**Python-kode tips**
- Drag-funksjon: return `0.5 * rho * A * C * v**2`
- Finne 98% av terminalfart: `np.argmax(v_liste > 0.98*v_terminal)`
- Velg passende tidssteg (typisk $Δ$t = 0.01-0.1 s)
## Kap. 7: Arbeid og kinetisk energi  
### 7.1-7.2: Arbeid  og kinetisk energi
**Viktige formler**

| Konsept                   | Formel                                                           | Beskrivelse                                                                                                                                                                                |
| ------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Arbeid (konstant kraft)   | $W = \vec{F}·\vec{s} = F \cdot s \cdot \cos \Phi$                | SI-enhet: $Nm=J$, joule                                                                                                                                                                    |
| Arbeid (varierende kraft) | $W = ∫_a^b F(x)dx$                                               |                                                                                                                                                                                            |
| Kinetisk energi           | $K = \frac{1}{2}mv^2$                                            |                                                                                                                                                                                            |
| Arbeid-energi-teoremet    | $W_{tot} = ΔK = K_2 - K_1=\frac{1}{2}mv_2^2 - \frac{1}{2}mv_1^2$ | Totalt arbeid, $W_{tot}$: summen av arbeidet utført av hver av kreftene som virker på et legeme. $K_1$ er kinesisk energi i startsituasjonen, $K_2$ er kinetisk energi i sluttsituasjonen. |
| Effekt (definisjon)       | $P = dW/dt$                                                      |                                                                                                                                                                                            |
| Momentan effekt           | $P = F·v$                                                        |                                                                                                                                                                                            |
| Gjennomsnittlig effekt    | $P = W/Δt$                                                       |                                                                                                                                                                                            |
**Viktige konsepter**
- *Arbeid:*
	- Arbeid er skalarproduktet av kraft og forflytning
	- Positivt arbeid: Kraften har komponent i bevegelsesretningen
	- Negativt arbeid: Kraften motvirker bevegelsen
	- Null arbeid: Kraften er vinkelrett på bevegelsen ($\Phi = 90°$)
- *Kinetisk energi:*
	- Alltid positiv (eller null)
	- Avhenger av referanseramme
	- For system: $K_{tot} = Σ(½mᵢvᵢ²)$
- *Arbeid-energi-teoremet:*
	- Totalarbeidet = endring i kinetisk energi
	- Meget nyttig når kraften er komplisert eller ukjent
	- Fungerer selv om banen ikke er rett

**Spesielle tilfeller**
- Tyngdekraft: $W = mgh$ ($h$ = vertikal forflytning nedover)
- Fjærkraft: $W = \frac{1}{2}k(x_1^2 - x_2^2)$
- Friksjon: $W = -f·s$ (alltid negativt)
- Normalkraft: $W = 0$ (alltid vinkelrett på bevegelsen)

**Eksempel:** en kloss med masse $m_1=0.20 kg$ sendes oppover et skråplan med neglisjerbar friksjon med en starthastighet $v_0=5,0m/s$. Skråplansets vinkel med horisontalplanet er $\alpha=20°$. Hva er klossens hastighet etter at den har beveget seg en strekning 0.50 oppover skråplanet
- Må bruke arbeid-energi-teoremet
### 7.3: Energi-arbeidteoremet  
### 7.4: Effekt
**Viktige konsepter**
- Effekt = arbeid per tid = energioverføring per tid
- Enhet: Watt (W) = $J/s$
- Momentan effekt: $P = F·v$ (kraft ganger fart)
- Gjennomsnittlig effekt: $P = \frac{\Delta W}{\Delta t}$
- Effekt i et bestemt tidspunkt $t$: $P(t) = \frac{dW(t)}{dt}$
- $dW=F\cdot dx=>p(t)=\frac{F\cdot dx}{dt}=F\cdot v$
**Typisk eksempel** 
- Tog akselererer fra ro til v = 80 km/h på t = 30 s. Finne effekten:
	- Arbeid = endring i kinetisk energi: W = ½mv²
	- Gjennomsnittlig effekt: P = W/t = ½mv²/t
	- Husk å konvertere km/h til m/s: v(m/s) = v(km/h)/3.6
## Kap. 8: Potensiell energi og energibevaring  
### 8.1: Potensiell energi for et system  
Arbeid utført av tyngekraften:$$W_G=mg(y_1-y_2)$$
Potensiell energi i tyngdefelt: $u=mgy$
$$W=mg(y_1-y_2)$$
$$= mgy_1-mgy_2 = u_1-u_2$$
Hvis kun tyngdekraften utfører arbeid:$$W_{tot}=\Delta K$$
Arbeid-energi-teoremet gir: $$W_G=W_{tot}=mg(y_1-y_2)=\Delta K=K_2-K_1$$
$$\to U_1-U_2=K_2-K_1$$
$$\to K_1+U_1=K_2+U_2$$
$$E_1=E_2$$
Vi har $K+U=E$
Total mekanisk energi er bevart når kun tyngdekrefter utfører arbeid
Dersom andre krefter gjør arbeid:$$E_1+W_{1\to 2}=E_2$$der $W_{1\to 2}$ er arbeidet utført av andre krefter mellom punkt $1$ og $2$

**Viktige formler**

| Gravitasjons potensial | $U = mgh$                           |
| ---------------------- | ----------------------------------- |
| Fjær potensial         | $U = \frac{1}{2}kx^2$               |
| Total mekanisk energi  | $E = K + U$                         |
| Energibevaring         | $E_2 = E_2 → K_2 + U_2 = K_2 + U_2$ |
| Med ikke-konservative  | $K_1 + U_1 + W_nc = K_2 + U_2$      |
**Viktige konsepter**
- Lagret energi som kan omdannes til kinetisk energi
- Nullnivå er valgfritt (velg det som gjør regningen enklest)
- Kun endringer i $U$ har fysisk betydning
- Kan være negativ (men $K$ er alltid $≥ 0$)

**Potensiell energi i kloss-fjær-system (elastisk potensiell energi)**
- Hookes lov. $|\vec{F}|=kx$
- $F'=-kx=F(x)$
- $W=\int_{x_1}^{x_2}F(x)dx=\frac{1}{2}kx_1^2-\frac{1}{2}kx_2^2$
	- $F(x)=-kx$
- Potensiell energi i fjær: $U=\frac{1}{2}kx^2$
- Kun fjærkraft gjør arbeid: 
	- Arbeid-energi-teoremet: $W_{tot}=\Delta K$
		- $W_{el}=U_1-U_2$
	- $\to U_1-U_2=K_2-K_1 \to K_1+U_1=K_2+U_2\to E_1=E_2$
	- Mekanisk energi er bevart!
- Når både tyngdekraft og fjærkraft gjør arbeid:
	- $E_1=U_{1, tyngde}+U_{1,fjær}+K_1$
	- $E_2=U_{2,tyngde}+U_{2,fjær}+K_2$
	- $E_1=E_2$
### 8.2: Konservative og ikke-konservative krefter  
**Konservative krefter**
- Arbeidet er uavhengig av banen
- Arbeid over lukket bane $= 0$
- Eksempler: Tyngdekraft, fjærkraft, elektrisk kraft
- Kan definere potensiell energi: $W = -ΔU$
**Ikke-konservative krefter**
- Arbeidet avhenger av banen
- Omdanner mekanisk energi til termisk energi
- Eksempler: Friksjon, luftmotstand
- Mekanisk energi bevares IKKE
### 8.3: Energibevaring  
**Hovedprinsipp:** Hvis kun konservative krefter gjør arbeid, er mekanisk energi bevart: $E = K + U = \text{konstant}$

**Problemløsningsstrategi**
1. Velg nullnivå for potensiell energi
	- Tips: Velg der en ukjent størrelse er null
2. Identifiser start- og sluttilstand
	- Ofte: Startpunkt med kjent høyde/fart, sluttpunkt med ukjent
3. Skriv opp energier i hver tilstand
	- Start: K₁ = ½mv₁², U₁ = mgh₁ (+ ½kx₁² hvis fjær)
	- Slutt: K₂ = ½mv₂², U₂ = mgh₂ (+ ½kx₂² hvis fjær)
4. Sett opp energilikningen
	- Uten friksjon: K₁ + U₁ = K₂ + U₂
	- Med friksjon: K₁ + U₁ = K₂ + U₂ + f·s
5. Løs for ukjent størrelse

**Typiske eksempler**
1. Sklir ned skråplan uten friksjon
	- Start: v₁ = 0, høyde h₁ = h
	- Slutt: v₂ = ?, høyde h₂ = 0
	- Energi: mgh = ½mv₂²
	- Løsning: v₂ = √(2gh)
2. Flipperspill med fjær
	- Start: Fjær komprimert x, v₁ = 0, h₁ = 0
	- Slutt: v₂ = 0, h₂ = h (akkurat når toppen nås)
	- Energi: ½kx² = mgh
	- Løsning: k = 2mgh/x²
3. Berg-og-dalbane (loop)
	- For å fullføre loopen: må ha v ≥ √(gr) i toppen
	- Energibevaring: mgh = ½mv² + mg(2r)
	- Setter inn v = √(gr): mgh = ½mgr + 2mgr
	- Minimumshøyde: h = 5r/2

**Vanlige feil å unngå**
- Glem ikke å ta med ALLE energiformer (K, U_gravitasjon, U_fjær)
- Vær konsekvent med nullnivået gjennom hele oppgaven
- Husk at normalkraft og sentripetalakselerasjon MÅ regnes med i toppen av loop
- Hvis det er friksjon: mekanisk energi bevares IKKE - bruk W_friksjon = f·s
### (8.4 og 8.5 er av orienterende art)

## Kap. 9: Bevegelsesmengde og kollisjoner  
### 9.1-9.2 : Bevegelsesmengde  og Impuls og kollisjoner  
**Viktige formler**

| Konsept                     | Formel                                            |
| --------------------------- | ------------------------------------------------- |
| Bevegelsesmengde            | $\vec{p}=m\vec{v}$                                |
| Impuls                      | $\vec{j}=\vec{F}\Delta t$                         |
| Impulsloven                 | $\vec{j}=\Delta \vec{p}=\vec{F} \Delta t$         |
| Newtons 2. lov (alternativ) | $\vec{F}=d\vec{p}/dt$                             |
| System av partikler         | $\vec{p}_{tot}=\sum{\vec{p}_i}=\sum m_i\vec{v}_i$ |
**Viktige konsepter**
- Bevegelsesmengde (momentum):
	- Vektororstørrelse: retning samme som farten
	- Enhet: kg·m/s
	- Stor masse eller stor fart → stor bevegelsesmengde
- Impuls:
	- Impulsen en kraft gir = kraft × tid
	- Impuls $j$ er endring i bevegelsesmengde eller kraft over tid
	- Samme enhet som bevegelsesmengde
	- Liten kraft over lang tid = stor kraft over kort tid (samme impuls)
### 9.3: Bevaring av bevegelsesmengde  
**Hovedprinsipp**
- Hvis ingen ytre krefter virker på systemet, er total bevegelsesmengde bevart: $\vec{p}_{\text{før}}=\vec{p}_{\text{etter}}$
**Viktig å huske**
- Indre krefter (krefter mellom objektene) endrer IKKE total bevegelsesmengde
- Bevegelsesmengde bevares ALLTID i kollisjoner (selv med friksjon)
- Må bevares i HVER retning separat (x og y)
- Gjelder bare hvis ingen ytre krefter (eller ytre krefter er neglisjerbare)
### 9.4: Forskjellige typer kollisjoner
**Elastisk kollisjon**
- *Definisjon:*
	- Både bevegelsesmengde OG kinetisk energi bevares
	- Objektene "spretter" fra hverandre
- *Formler (1D):*

| Konsept          | Formel                                                                                  |
| ---------------- | --------------------------------------------------------------------------------------- |
| Bevegelsesmengde | $m_1v_1 + m_2v_2 = m_1u_1 + m_2u_2$                                                     |
| Kinetisk energi  | $\frac{1}{2}m_1v_1^2 + \frac{1}{2}m_2v_2^2 = \frac{1}{2}m_1u_1^2 + \frac{1}{2}m_2u_2^2$ |
| Relativhastighet | $v_1 - v_2 = -(u_1 - u_2)$                                                              |
**Uelastisk kollisjon**
- *Definisjon:*
	- Bevegelsesmengde bevares, men kinetisk energi bevares IKKE
	- Noe energi går til deformasjon, lyd, varme
- *Fullstendig uelastisk:*
	- Objektene fester seg til hverandre (blir ett legeme)
	- Formel: m₁v₁ + m₂v₂ = (m₁ + m₂)u
	- Løsning: u = (m₁v₁ + m₂v₂)/(m₁ + m₂)
**Problemløsningsstrategi**
1. Tegn situasjonen før og etter
	- Merk alle masser og hastigheter (med retning!)
2. Velg positivretning
	- Hastigheter mot venstre/bakover er negative
3. Bevaring av bevegelsesmengde
	- Σp_før = Σp_etter (husk fortegn!)
4. Sjekk om elastisk
	- Beregn K_før og K_etter
	- Hvis K_før = K_etter → elastisk, ellers uelastisk
5. Løs ligningene

**Typiske eksempler**
1. Curlingsteiner (elastisk)
	- Før: $A$ med $v_A$ høyre, $B$ med $v_B$ venstre (negativ)
	- Etter: $A$ med $u_A$ venstre, $B$ med $u_B$ høyre
	- Bevaring p: $mv_A + m(-v_B) = m(-u_A) + mu_B$
	- Løs for $u_B,$ sjekk om elastisk ved å sammenligne $K$
2. Kule treffer kloss (fullstendig uelastisk)
	- Før: Kule m med v, kloss M i ro
	- Etter: Felleslegeme (m+M) med u
	- Bevaring p: mv = (m+M)u
	- Løsning: u = mv/(m+M)
3. Kule + kloss + pendel (kombinasjon)
	- Steg 1: Kollisjon → bevaring av p → finn u
	- Steg 2: Pendel svinger ut → energibevaring → finn maks høyde h
	- ½(m+M)u² = (m+M)gh → h = u²/(2g)

**Vanlige feil å unngå**
- Husk fortegn! Hastigheter i motsatt retning er negative
- Bevegelsesmengde bevares ALLTID, kinetisk energi kun i elastiske
- I fullstendig uelastisk: legemene har SAMME fart etter (u₁ = u₂ = u)
- Ikke bland bevegelsesmengde (p=mv) med kinetisk energi (K=½mv²)
- For å sjekke elastisk: sammenlign K_før og K_etter, ikke v-verdier
## Kap. 10: Rotasjon av stive legemer om fast akse  

**Rotasjon av stive legemer om fast akse**

Dette kapittelet utvider mekanikken fra translasjonsbevegelse (lineær bevegelse) til rotasjonsbevegelse. Du vil se at det er en nær parallell mellom de to typene bevegelse: hver størrelse i translasjon har en tilsvarende størrelse i rotasjon.
### 10.1 Beskrivelse av rotasjonsbevegelse

### Vinkelposisjon θ
Når et stivt legeme roterer om en fast akse, beskriver vi posisjonen ved hjelp av vinkelen θ (theta) målt fra en referanselinje. Vinkelen måles i radianer (rad).

| Størrelse          | Symbol      | Enhet          |
| ------------------ | ----------- | -------------- |
| Vinkelposisjon     | $θ$ (theta) | rad (radianer) |
| Vinkelforskyvning  | $Δθ$        | rad            |
| Vinkelfart         | $ω$ (omega) | rad/s          |
| Vinkelakselerasjon | $α$ (alpha) | rad/s²         |
### Vinkelfart ω
**Gjennomsnittlig vinkelfart:**
```
ω_gj = Δθ/Δt
```
**Momentan vinkelfart** (når Δt → 0):
```
ω = dθ/dt
```
### Vinkelakselerasjon α
**Gjennomsnittlig vinkelakselerasjon:**
```
α_gj = Δω/Δt
```
**Momentan vinkelakselerasjon:**
```
α = dω/dt = d²θ/dt²
```

---

### 10.2 Rotasjon med konstant vinkelakselerasjon
Når vinkelakselerasjonen α er konstant, kan vi bruke kinematiske ligninger som er analoger til de for lineær bevegelse med konstant akselerasjon.
### Rotasjonskinematiske ligninger

| Rotasjon (konstant α)     | Translasjon (konstant a) |
| ------------------------- | ------------------------ |
| **ω = ω₀ + αt**           | v = v₀ + at              |
| **θ = θ₀ + ω₀t + ½αt²**   | x = x₀ + v₀t + ½at²      |
| **ω² = ω₀² + 2α(θ - θ₀)** | v² = v₀² + 2a(x - x₀)    |
### 10.3 Sammenhengen mellom lineære og rotasjonsvariable
For et punkt på avstand $r$ fra rotasjonsaksen:
#### Buelengde og vinkel
$$s = rθ$$
der $s$ er buelengden (strekningen langs sirkelbanen).
#### Tangentiell fart
$$v_t = rω$$
Tangentiell fart $v_t$ er farten langs sirkelbanen.
#### Tangentiell akselerasjon
$$a_t = rα$$
Tangentiell akselerasjon a_t er akselerasjonen langs sirkelbanen.
#### Sentripetalakselerasjon
$$a_s = v^2/r = rω^2$$
Sentripetalakselerasjonen a_s er alltid rettet mot sentrum av sirkelen.

> **VIKTIG:** Den totale akselerasjonen for et punkt i rotasjon har to komponenter: tangentiell akselerasjon (langs banen) og sentripetalakselerasjon (mot sentrum). Disse står normalt på hverandre.
### 10.4 Treghetsmoment og kinetisk energi ved rotasjon
Treghetsmoment $I$ er et mål på hvor vanskelig det er å endre rotasjonstilstanden til et legeme. Det er rotasjonens analog til masse.

$K = \frac{1}{2}Iw^2$
**Treghetsmoment for punktmasse** $$I = mr^2$$
- For en punktmasse $m$ på avstand $r$ fra rotasjonsaksen.
**Treghetsmoment for kontinuerlig massefordeling** $$I = ∫ r^2 dm$$
- For et legeme med kontinuerlig massefordeling.
#### Treghetsmoment for diskrete legemer

| Legeme                    | Treghetsmoment I        |
| ------------------------- | ----------------------- |
| Tynn stang (om endepunkt) | $I = \frac{1}{3}ML^2$   |
| Tynn stang (om sentrum)   | $I = \frac{1}{12} ML^2$ |
| Massiv sylinder/skive     | $I = \frac{1}{2}MR^2$   |
| Hul sylinder              | $I = MR^2$              |
| Massiv kule               | $I = \frac{2}{5}MR^2$   |
| Hul kule (tynnvegget)     | $I = \frac{2}{3}MR^2$   |
### 10.5 Steiners sats (Parallell akse-teoremet)
Steiners sats lar oss finne treghetsmomentet om en akse som er parallell med en akse gjennom massesenteret.
$$I = I_{CM} + Md^2$$
der:
- $I$ = treghetsmoment om den parallelle aksen
- $I_{CM}$ = treghetsmoment om akse gjennom massesenteret
- $M$ = total masse
- $d$ = avstand mellom de to parallelle aksene

> **EKSEMPEL:** For en tynn stang med lengde L og masse M:
> - Om sentrum: $I_{CM} = 1/12 ML^2$
> - Om endepunkt $(d = L/2): I = 1/12 ML² + M(L/2)² = 1/12 ML² + 1/4 ML² = **1/3 ML²**$

#### Kinetisk energi ved rotasjon
$$K_{rot} = ½Iω²$$
Dette er rotasjonens analog til translasjonens kinetiske energi K = ½mv².
### 10.6 Dreiemoment
Dreiemoment $τ$: rotasjonens analog til kraft. Det beskriver evnen til en kraft å forårsake rotasjon.
### Definisjon av dreiemoment
$$τ = r_⊥ \cdot F = rF \sinθ$$
der:
- $τ$ = dreiemoment (enhet: $N·m$)
- $r_⊥$ = kraftarm (vinkelrett avstand fra rotasjonsaksen til kraftlinjen)
- $F$ = kraften
- $θ$ = vinkelen mellom $r$ og $F$
> **VIKTIG:** Kraftarmen $r_⊥$ er den korteste avstanden fra rotasjonsaksen til kraftlinjen (forlenget). En kraft som går gjennom rotasjonsaksen gir null dreiemoment!
### Fortegnskonvensjon
- **Positiv $τ$:** Rotasjon mot urviseren
- **Negativ $τ$:** Rotasjon med urviseren
### 10.7 Newtons 2. lov for rotasjon
Rotasjonens analog til $F = ma$ er:
$$∑τ = Iα$$
der:
- $∑τ$ = summen av alle dreiemoment (netto dreiemoment)
- $I$ = treghetsmoment
- $α$ = vinkelakselerasjon
> **Dette er den mest sentrale ligningen i rotasjonsdynamikk!** Den sier at netto dreiemoment gir vinkelakselerasjon, på samme måte som netto kraft gir lineær akselerasjon.
#### Sammenligning translasjon og rotasjon

| Translasjon    | Rotasjon             |
| -------------- | -------------------- |
| Kraft F        | Dreiemoment τ        |
| Masse m        | Treghetsmoment I     |
| Akselerasjon a | Vinkelakselerasjon α |
| $∑F = ma$      | $∑τ = Iα$            |
### 10.8 Arbeid og effekt ved rotasjonsbevegelse
#### Arbeid ved rotasjon
$W = τΔθ$
For konstant dreiemoment τ over vinkelforskyvning Δθ (målt i radianer).
#### Effekt ved rotasjon
$P = τω$
Momentan effekt produsert av dreiemoment τ ved vinkelfart ω.
Dette er analogt til $P = Fv$ for translasjon.
### 11.1 Rullebevegelse
Rullebevegelse er en kombinasjon av translasjon og rotasjon. Et hjul som ruller uten å gli har en spesiell sammenheng mellom lineær og rotasjonsbevegelse.
### Rullebetingelse
$$v_CM = ωr$$
$$a_CM = αr$$
der:
- $v_{CM}$ = fart til massesenteret
- $a_{CM}$ = akselerasjon til massesenteret
- $ω$ = vinkelfart
- $α$ = vinkelakselerasjon
- $r$ = radius
> **VIKTIG:** Rullebetingelsen gjelder bare når det ikke er glidefriksjon! Kontaktpunktet med bakken har momentan hastighet null.
### Kinetisk energi ved rullebevegelse
$$K_{total} = K_{trans} + K_{rot} = ½Mv²_{CM} + ½Iω²$$
Total kinetisk energi består av translasjon av massesenteret og rotasjon om massesenteret.
> **EKSEMPEL:** For en massiv sylinder ($I = \frac{1}{2}MR^2$) som ruller:
> $K_{total} = ½Mv²_{CM} + ½(½MR²)ω² = ½Mv²_{CM} + ¼Mv²_{CM} = ¾Mv²_{CM}$
> (brukte rullebetingelsen $v_{CM} = ωR$)
### Friksjon ved rulling
Når et objekt ruller uten å gli, er det statisk friksjon som virker ved kontaktpunktet. Denne friksjonen gjør null arbeid fordi kontaktpunktet har momentan hastighet null.
- **Statisk friksjon:** Hindrer glidefriksjon, gjør null arbeid
- **Kinetisk friksjon:** Oppstår når objektet glir, gjør negativt arbeid
---
### Oppsummering: Viktige formler kapittel 10

|Konsept|Formel|
|---|---|
|Vinkelfart|**ω = dθ/dt**|
|Vinkelakselerasjon|**α = dω/dt**|
|Kinematikk|**ω = ω₀ + αt, θ = θ₀ + ω₀t + ½αt²**|
|Lineær-rotasjon|**s = rθ, v_t = rω, a_t = rα**|
|Treghetsmoment|**I = ∫ r² dm** (punktmasse: I = mr²)|
|Steiners sats|**I = I_CM + Md²**|
|Kinetisk energi|**K_rot = ½Iω²**|
|Dreiemoment|**τ = r⊥ · F = rF sin θ**|
|**Newtons 2. lov**|**∑τ = Iα**|
|Arbeid|**W = τΔθ**|
|Effekt|**P = τω**|
|Rullebetingelse|**v_CM = ωr, a_CM = αr**|

---
# Kap. 5: Elektrisk ladning og felt  
### 5.1: Elektrisk ladning  
To typer ladning: Positiv og negativ
Ladning er *kvantifisert*: $Q=n \cdot e$, altså være et heltallsmultiplum av elementærladningen
**Elementærladningen** $$e=1.602 \times0^{-19}C$$
**Bevaringsloven for ladning**
I ethvert isolert system er den totale ladningen konstant. Ladning kan ikke skapes eller fjernes - bare flyttes
### 5.2: Elektriske ledere og isolatorer  
Forskjellen mellom en leder og en isolator handler om tilgjengeligheten av *frie ladningsbærere* - elektroner som kan bevege seg gjennom materialet.

I en metallisk leder sitter de ytterste elektronene (valenselektronene) løst og kan vandre fritt gjennom gitteret. I en isolator er alle elektroner bundet tett til sine atomer.

|Type|Mekanisme|Eksempler|
|---|---|---|
|**Leder**|Frie elektroner beveger seg fritt|Cu, Al, Fe, Au|
|**Isolator**|Ingen frie ladningsbærere|Gummi, glass, plast, tre|
|**Halvleder**|Begrenset fri bevegelse; styres av temp.|Si, Ge|
**Jordingsprinsippet**
Jord fungerer som et uendelig stort reservoar av ladning. Kobles en ladet leder til jord, vil ladning flyte inn eller ut inntil lederen er nøytral.

**Elektrostatisk induksjon**
En ladet gjenstand nær en leder kan omfordele ladning **uten fysisk kontakt**. Positiv ladning nær en leder vil trekke negative ladninger mot seg og skyve positive bort – lederen blir **polarisert**.

> [!note] Viktig distinksjon
> 
> - **Ladning ved kontakt** (konduksjon): ladning overføres direkte mellom gjenstander
> - **Elektrostatisk induksjon**: ladning omfordeles internt uten kontakt
### 5.3: Coulombs lov  
**Coulombs lov** beskriver den elektriske kraften mellom to punktladninger. Den er strukturelt identisk med gravitasjonsloven ($F=\frac{Gm_1m_2}{r^2}$), men elektrisk kraft kan være både tiltrekkende og frastøtende. 

Kraften mellom to punktladninger $q_1$ og $q_2$ med innbyrdes avstand $r$ $$|\vec{F}|=k \cdot \frac{|q_1 \cdot q_2|}{r^2}$$
- $k$: coulombs konstant, $k=8.99\times 10^9$ $Nm^2\over C^2$ $=\frac{1}{4\pi \epsilon_0}$, 
- $\epsilon_0 \text{(vacum permittividet)} = 8.85 \times 10^{-12}$ $C^2\over Nm^2$

**Retning** bestemmes av fortegnene:
- $q_1q_2>0$ (like fortegn) $\to$ *frastøtning* (kreftene peker vekk fra hverandre)
- $q_1​q_2​<0$ (ulike fortegn) $\to$ *tiltrekning* (kreftene peker mot hverandre)

**Superposisjonsprinsippet**
Dersom det er flere ladninger, er den totale kraften på en ladning *vektorsummen* av bidragene fra alle andre: $$\vec{F}_{tot}=\vec{F}_1+\vec{F}_2+...=\sum_i\vec{F}_i$$
> [!warning] Vanlig: feil Absoluttverdiene i Coulombs lov gjelder kun for **størrelsen** av kraften. Retning må alltid bestemmes separat basert på fortegnene. Bruk tegning!
### 5.4: Elektriske felter  
Det elektriske feltet $\vec{E}$ er et konsept som lar oss beskrive den elektriske påvirkningen i rommet uavhengig av om en testladning faktisk er der. Tenk på det som et "kart" over hvilken kraft en positiv testladning ville oppleve i hvert punkt. beskriver kraften per ladningsenhet i et punkt. $$\vec{E}=\frac{\vec{F_{}}}{q_{0}} \text{, }[N/C]=V/m]$$**E-felt fra en punkt ladning** $Q$ $$E=\frac{k|Q|}{r^2}$$
$r$ er avstand fra ladningen $Q$ til punktet man måler feltet
Retning
- Fra en positiv ladning: vekk fra ladningen (radielt utover)
- Fra en negativ ladning: inn mot ladning (radielt innover)
**Kraft på ladning $q$ i et felt $\vec{E}$** $$\vec{F}=q\vec{E}$$
- Positiv $q$: kraft i samme regning som $\vec{E}$
- Negativ $q$: kraft i motsatt retning av $\vec{E}$

**Superposisjon av E-felt** $$\vec{E}_{tot} = \vec{E}_1+\vec{E}_2+...\text{(vektoriell sum)}$$
### 5.6: Elektriske feltlinjer  
Feltlinjer er ikke fysiske gjenstander - de er et visuelt verktøy for å gi en intuitiv forståelse av feltet. Jo tettere linjene er, desto sterkere er feltet
**Regler:**
- Starter på *positive* ladninger, slutter på *negative* (eller i det uendelige)
- *Tangenten* til en feltlinje i et punkt gir retningen til $\vec{E}$
- *Tettheten* av feltlinjer er proporsjonal med $|\vec{E}|$
- Ingen feltlinjer *krysser* hverandre

| Konfigurasjon    | Feltmønster                         | Kjennetegn                      |
| ---------------- | ----------------------------------- | ------------------------------- |
| Enkelt $+q$      | Radielt utover                      | Symmetrisk, alle retninger      |
| Enkelt $−q$      | Radielt innover                     | Symmetrisk, alle retninger      |
| Dipol ($+q,−q$)  | Buede linjer fra $+$ til $−$        | Sterkt felt nær ladningene      |
| To like $+q$     | Linjer bøyer unna; nullpunkt mellom | Ingen linjer krysser midtlinjen |
| Platekondensator | Parallelle, uniforme linjer         | Uniformt felt mellom platene    |

> [!note] Feltlinjer $⊥$ ekvipotensialflater Elektriske feltlinjer er alltid **vinkelrette** på ekvipotensialflatene - mer om dette i kap. 7.

---
### (5.7 er av orienterende art)

# Kap. 7: Elektrisk potensial  
## 7.1: Elektrisk potensiell energi 
Arbeidet avhenger bare av start- og sluttpunkt, ikke av veien.
**Arbeid og energi i elektrisk felt**
Når en ladning $q$ flyttes fra punkt $A$ til $B$ i et elektrisk felt, gjør feltet arbeidet: $$W_{A\to B} = U_A−U_B=−\Delta U$$
**Potensiell energi mellom to punktladninger** $$\boxed{U = \frac{kq_1 q_2}{r}}​​​$$Referansen: $U=0$ når $r \to \infty$.

**Fortegnsregler**

| Ladninger     | $q_1q_2$ | $U$  | Fysisk tolkning                                 |
| ------------- | -------- | ---- | ----------------------------------------------- |
| Like fortegn  | $>0$     | $>0$ | Frastøtende; krever arbeid for å nærme dem      |
| Ulike fortegn | $<0$     | $<0$ | Tiltrekkende; systemet avgir energi ved nærming |
Et system med $U<0$ er et bundet system - man må *tilføre* energi for å separere partiklene.
> [!note] Analogi til gravitasjon $>U_\text{grav}=−Gm_1m_2/r$ er alltid negativ (alltid tiltrekkende). Elektrisk potensiell energi kan være **begge tegn** - avhenger av fortegnet til $q_1q_2$.

**Potensiell energi i et system av punktladninger (trekanteksempel)**

For flere ladninger beregnes total potensiell energi som summen av alle *par-interaksjoner*. Hvert par telles kun én gang.

```
            q₂ (+2μC)
            /\
       r₁₂ /  \ r₂₃
           /    \
          / • P  \
         /        \
q₁ (-1μC)──────────q₃ (+3μC)
              r₁₃
```

Tre ladninger $q_1$, $q_2$, $q_3$ i hjørnene av en trekant gir tre par:
$$\boxed{U_{\text{tot}} = k\left(\frac{q_1 q_2}{r_{12}} + \frac{q_1 q_3}{r_{13}} + \frac{q_2 q_3}{r_{23}}\right)}$$

**Potensial i punkt P**

Potensialet i et indre punkt $P$ er en skalar sum - ingen vektorregning:
$$V_P = k\left(\frac{q_1}{r_{1P}} + \frac{q_2}{r_{2P}} + \frac{q_3}{r_{3P}}\right)$$

Dersom en testladning $q_0$ plasseres i $P$:
$$U_{q_0} = q_0 \cdot V_P$$

Total energi for hele systemet (trekant + testladning) er da $U_{\text{tot}} + U_{q_0}$.

> [!tip] Fremgangsmåte - triangelproblemer
> 1. Tegn trekanten, merk av $r_{ij}$ (mellom hjørner) og $r_{iP}$ (hjørne til $P$)
> 2. Beregn $U_{\text{tot}}$ for trekanten - summer de 3 parene
> 3. Beregn $V_P$ som skalarsummen (husk fortegn på $q_i$)
> 4. Multipliser $q_0 \cdot V_P$ for energien til testladningen
> 5. Husk: negativt $U$ betyr bundet system - energi må *tilføres* for å separere

## 7.2: Elektrisk potensial og potensialforskjell  
Elektrisk potensial $V$ er potensiell energi *per ladningsenhet*. Det er en *skalar*, noe som gjør det enklere å jobbe med enn vektorfeltet $\vec{E}$. $$\boxed{V=\frac{U}{q}}$$
**Potensialforskjell (spenning)**
Spenning $\Delta V$ mellom to punkter er arbeid per ladningsenhet for å flytte ladning fra $A$ til $B$:$$\boxed{\Delta V=V_B-V_A=-\frac{W_{A\to B}}{q}}$$
**Relasjon mellom E-felt og potensial (uniformt felt)**
I et uniformt felt (f.eks. mellom parallelle kondensatorplater): $$\boxed{E=\frac{|\Delta V|}{d}}$$der $d$ er plateavstanden (langs feltretningen).

**Ekvipotensialflater:** En ekvipotensialflate er en flate der $V$ er konstant overalt:
- Alltid *vinkelrett* på elektriske feltlinjer
- *Ingen arbeid* gjøres langs en ekvipotensialflate ($\Delta V = 0 \Rightarrow W = 0$)
- Jo tettere ekvipotensialflatene er, desto sterkere er E-feltet

**Nyttige sammenhenger**

| Sammenheng           | Formel                                | Bruk                            |
| -------------------- | ------------------------------------- | ------------------------------- |
| Energi fra potensial | $U=qV$                                | Konverter mellom $U$ og $V$     |
| Arbeid av E-felt     | $W=q(V_A−V_B)$                        | Ladning flyttes fra $A$ til $B$ |
| Energibevaring       | $\frac{1}{2}mv^2 + qV = \text{kons.}$ | Partikkel akselereres i E-felt  |
| E-felt fra spenning  | $E = \Delta V / d$                    | Uniformt felt mellom plater     |
> [!tip] Spontan bevegelse av ladninger
> 
> - **Positive** ladninger beveger seg spontant fra **høyt** til **lavt** $V$ (som en ball som ruller nedoverbakke)
> - **Negative** ladninger (elektroner) beveger seg spontant fra **lavt** til **høyt** $V$
## 7.3: Beregninger av elektrisk potensial (til og med potensial fra system av punktladninger - dipolmoment og potensial fra kontinuerlige ladningsfordelinger er ikke pensum)  
**Potensial fra enkelt punktladning:** $$\boxed{V=\frac{kQ}{r}}$$Merk:
- $Q$ kan ha fortegn
- Faller som $1/r$ (mye langsommere enn E-feltet som faller som $1/r^2$)
- $V=0$ settes ved $r=\infty$
**Potensial fra system av punktladninger:** $$\boxed{V_{tot}=k\sum_i\frac{Q_i}{r_i}}$$Dette er en skalare sum - bare legg til tallene med riktig fortegn. Ingen vektorkomponent

**Nullpunkter: $V=0$ kontra $E=0$**
- Nullpunkt for $\vec{E} = 0$:
	- Krever at vektorbidragene kansellerer
	- Mulig mellom to like ladninger
	- Sett opp: $E_1 = E_2$​ (størrelser, begge peker mot punktet)

**Nullpunkt for $V=0$:**
- Krever at skalarsummen er null
- Mulig mellom to ulike ladninger
- Sett opp: $\frac{kQ_1}{r_1} + \frac{kQ_2}{r_2} = 0$

> [!warning] $V=0≠E=0$. Dette er en av de mest spurte konseptuelle forskjellene på eksamen. De to betingelsene er **fullstendig uavhengige**. En ladning kan befinne seg der $V=0$ og likevel oppleve en kraft (fordi $E \neq 0$).
## (7.4-7.6 er av orienterende art)

# Kap. 8: Kondensatorer og kapasitans  

> [!info] Pensum IFYX1002
> 
> **Eksamensvekt:** ~2–6 poeng per eksamen, men kondensatorer er også sentrale i RC-kretser (Kap. 10.5), som gir 5–10 poeng.

---
## 8.1 Kondensatorer og kapasitans
### Hva er en kondensator?
En kondensator er en komponent som lagrer elektrisk energi i form av ladning på to ledende plater, adskilt av et isolerende materiale (dielektrikum eller luft). Når en spenning $V$ påtrykkes, bygger det seg opp en ladning $+Q$ på den ene platen og $-Q$ på den andre.
### Definisjon av kapasitans
$$\boxed{C = \frac{Q}{V}}$$

| Symbol | Størrelse               | Enhet       |
| ------ | ----------------------- | ----------- |
| $C$    | Kapasitans              | farad (F)   |
| $Q$    | Ladning på én plate     | coulomb (C) |
| $V$    | Spenning mellom platene | volt (V)    |
> [!important] Kapasitans er en _geometrisk_ egenskap Kapasitansen $C$ avhenger kun av kondensatorens fysiske oppbygging (plateareal, avstand, materiale) — **ikke** av $Q$ eller $V$. Endrer du $V$, endres $Q$ proporsjonalt, men $C$ forblir den samme.
### Platekondensator
For en parallellplatekondensator med plateareal $A$ og plateavstand $d$:
$$\boxed{C = \varepsilon_0 \frac{A}{d}}$$
der $\varepsilon_0 = 8{,}85 \times 10^{-12}$ $F/m$ er permittiviteten til vakuum/luft.

**Fysisk intuisjon:**
- Større areal $A$ → mer plass til ladning → større $C$
- Mindre avstand $d$ → sterkere felt for samme $V$ → mer ladning → større $C$
### Elektrisk felt i platekondensator
Feltet mellom platene er homogent (uniformt):
$$\boxed{E = \frac{\Delta V}{d} = \frac{Q}{\varepsilon_0 A} = \frac{\sigma}{\varepsilon_0}}$$

der $\sigma = Q/A$ er overflateladningstettheten.

> [!tip] Viktig sammenheng Kombiner $C = \varepsilon_0 A/d$ med $C = Q/V$ og $E = V/d$ for å utlede alt du trenger. Disse tre relasjonene er ekvivalente.

---
## 8.2 Kondensatorer i serie og parallell

### Parallellkobling
Kondensatorer i parallell har **samme spenning** $V$ over seg.$$\boxed{C_{\text{eq}} = C_1 + C_2 + C_3 + \cdots}$$**Huskeregel:** Parallell = kapasitansene **adderes** (blir _større_).

**Hvorfor?** Parallellkobling gir effektivt et større plateareal, og $C \propto A$.

| Egenskap   | Parallellkobling                       |
| ---------- | -------------------------------------- |
| Spenning   | Lik over alle: $V_1 = V_2 = V$         |
| Ladning    | Fordeles: $Q_{\text{tot}} = Q_1 + Q_2$ |
| Kapasitans | Adderes: $C_{\text{eq}} = C_1 + C_2$   |
### Seriekobling
Kondensatorer i serie har **samme ladning** $Q$ på seg.
$$\boxed{\frac{1}{C_{\text{eq}}} = \frac{1}{C_1} + \frac{1}{C_2} + \frac{1}{C_3} + \cdots}$$
**Huskeregel:** Serie = _omvendt_ adderes (blir _mindre_).

For to kondensatorer i serie finnes snarvei-formelen:$$C_{\text{eq}} = \frac{C_1 C_2}{C_1 + C_2}$$

| Egenskap   | Seriekobling                                                               |
| ---------- | -------------------------------------------------------------------------- |
| Ladning    | Lik på alle: $Q_1 = Q_2 = Q$                                               |
| Spenning   | Fordeles: $V_{\text{tot}} = V_1 + V_2$                                     |
| Kapasitans | Omvendt adderes: $\frac{1}{C_{\text{eq}}} = \frac{1}{C_1} + \frac{1}{C_2}$ |

> [!warning] Merk: Oppfører seg _motsatt_ av motstander!
> 
> - Motstander i serie: $R_{\text{eq}}$ **øker** (adderes)
> - Kondensatorer i serie: $C_{\text{eq}}$ **minker** (omvendt adderes)
> - Motstander i parallell: $R_{\text{eq}}$ **minker**
> - Kondensatorer i parallell: $C_{\text{eq}}$ **øker** (adderes)
### Fremgangsmåte for sammensatte kretser
1. Identifiser hvilke kondensatorer som er i serie og hvilke som er i parallell
2. Forenkle innenfra og ut — start med den innerste kombinasjonen
3. Beregn $C_{\text{eq}}$ steg for steg
4. Bruk $Q = CV$ til å finne ladning/spenning på enkeltkomponenter ved å "folde ut" igjen
---
### Energi lagret i en kondensator

> [!note] Orienterende (8.4), men dukker opp indirekte på eksamen

$$\boxed{U_C = \frac{1}{2}CV^2 = \frac{1}{2}\frac{Q^2}{C} = \frac{1}{2}QV}$$
Tre ekvivalente uttrykk — velg det som passer ut fra hva du kjenner ($C$ og $V$, $Q$ og $C$, eller $Q$ og $V$).

---
### Dielektrikum (orienterende, men viktig for eksamen!)

> [!danger] Eksamensklassiker Selv om 8.3–8.5 er "orienterende", har kondensatorer med dielektrikum dukket opp som flervalg på **nesten alle** eksamenssett (A20, A21, V22, V23, V24...). Du MÅ kunne dette.

Når et dielektrisk materiale med dielektrisk konstant $\kappa$ settes inn mellom platene:

$$\boxed{C = \kappa C_0 = \kappa \varepsilon_0 \frac{A}{d}}$$

der $C_0$ er kapasitansen uten dielektrikum. Alltid $\kappa \geq 1$, så dielektrikum **øker** kapasitansen.
### To eksamenstyper med dielektrikum

#### Type 1: Dielektrikum deler plategapet (horisontalt delt) → SERIE

Isolatoren fyller halve gapet ($d/2$), luft fyller resten ($d/2$):

$$C_1 = \kappa \varepsilon_0 \frac{A}{d/2} = 2\kappa\varepsilon_0\frac{A}{d}, \qquad C_2 = \varepsilon_0 \frac{A}{d/2} = 2\varepsilon_0\frac{A}{d}$$

Seriekobling gir:

$$C_{\text{tot}} = \frac{C_1 C_2}{C_1 + C_2} = \frac{2\kappa}{(\kappa + 1)},\varepsilon_0\frac{A}{d}$$

#### Type 2: Dielektrikum deler platearealet (vertikalt delt) → PARALLELL

To materialer med $\kappa_1$ og $\kappa_2$, hver med halve arealet $A/2$:

$$C_1 = \kappa_1 \varepsilon_0 \frac{A/2}{d}, \qquad C_2 = \kappa_2 \varepsilon_0 \frac{A/2}{d}$$

Parallellkobling gir:

$$C_{\text{tot}} = C_1 + C_2 = \frac{(\kappa_1 + \kappa_2)}{2},\varepsilon_0\frac{A}{d}$$

> [!tip] Huskeregel for dielektrikum
> 
> - Delt **langs** feltet (lag oppå hverandre) → **serie** (ladningen må gjennom begge lag)
> - Delt **på tvers** av feltet (side ved side) → **parallell** (spenningen er lik over begge)

---

### Den kritiske eksamenssituasjonen: Tilkoblet vs. frakoblet batteri

> [!danger] Denne oppgavetypen har kommet på nesten alle eksamenssett

Når noe endres fysisk med kondensatoren (avstand, areal, dielektrikum settes inn), avhenger resultatet av om batteriet er tilkoblet eller frakoblet:
### Frakoblet batteri → $Q$ er bevart (konstant)

Ladningen har "ingen vei ut" — den sitter fast på platene.

| Endring                     | $Q$     | $C$                 | $V = Q/C$        | $E = V/d$        | $U = Q^2/(2C)$   |
| --------------------------- | ------- | ------------------- | ---------------- | ---------------- | ---------------- |
| $d \to 2d$                  | Uendret | Halveres            | **Dobles**       | Uendret          | Dobles           |
| Dielektrikum inn ($\kappa$) | Uendret | Øker $\times\kappa$ | Minker $/\kappa$ | Minker $/\kappa$ | Minker $/\kappa$ |
### Tilkoblet batteri → $V$ er bevart (konstant)
Batteriet holder spenningen konstant — ladning kan flyte til/fra platene via batteriet.

| Endring                     | $V$     | $C$                 | $Q = CV$            | $E = V/d$ | $U = CV^2/2$        |
| --------------------------- | ------- | ------------------- | ------------------- | --------- | ------------------- |
| $d \to 2d$                  | Uendret | Halveres            | **Halveres**        | Halveres  | Halveres            |
| Dielektrikum inn ($\kappa$) | Uendret | Øker $\times\kappa$ | Øker $\times\kappa$ | Uendret   | Øker $\times\kappa$ |
### Formler til formelarket (alt som er tilgjengelig på eksamen)

|Formel|Beskrivelse|
|---|---|
|$C = Q/V$|Definisjon av kapasitans|
|$C = \varepsilon_0 A/d$|Platekondensator|
|$C_{\text{par}} = C_1 + C_2 + \cdots$|Parallellkobling|
|$1/C_{\text{ser}} = 1/C_1 + 1/C_2 + \cdots$|Seriekobling|
|$C = \kappa C_0$|Med dielektrikum|
|$U_C = \frac{1}{2}CV^2 = \frac{1}{2}Q^2/C = \frac{1}{2}QV$|Lagret energi|
|$E = \Delta V / d = Q/(\varepsilon_0 A)$|E-felt i platekondensator|

---
### Eksamensstrategi for kondensatoroppgaver

> [!success] Sjekkliste for eksamen
> 
> 1. **Les oppgaven nøye:** Er batteriet tilkoblet eller frakoblet? → Bestemmer om $V$ eller $Q$ er bevart
> 2. **Identifiser serie/parallell:** Tegn om kretsen til du ser det tydelig
> 3. **Dielektrikum:** Delt langs feltet → serie; delt på tvers → parallell
> 4. **Serie:** Alle har samme $Q$; spenningen fordeles omvendt proporsjonalt med $C$
> 5. **Parallell:** Alle har samme $V$; ladningen fordeles proporsjonalt med $C$
> 6. **Sjekk enheter og grenseverdier:** $C_{\text{serie}}$ < minste enkelt-$C$; $C_{\text{parallell}}$ > største enkelt-$C$

> [!warning] Vanlige feller
> 
> - Glemme at $Q$ er bevart når batteriet er frakoblet
> - Forveksle serie/parallell-reglene med motstander (de er byttet om!)
> - Ved dielektrikum: ikke se at det er serie vs. parallell
> - Glemme å "folde ut" igjen for å finne ladning/spenning på enkeltkomponenter

---
### Kobling til andre kapitler

| Kapittel                         | Sammenheng                                                                                     |
| -------------------------------- | ---------------------------------------------------------------------------------------------- |
| **Kap. 7** (Elektrisk potensial) | $V = Q/C$; energibevaring $q\Delta V = \frac{1}{2}mv^2$ for partikkel akselerert i kondensator |
| **Kap. 9** (Strøm og resistans)  | $V = IR$; kondensator i krets med motstand                                                     |
| **Kap. 10.5** (RC-kretser)       | Oppladning/utladning av kondensator gjennom motstand — **den store eksamensoppgaven**          |

---
# Kap. 9: Strøm og resistans

> [!info] Pensum IFYX1002
> 
> **Eksamensvekt:** ~2–4 poeng direkte (resistivitetsoppgave som flervalg), pluss at Ohms lov og effekt brukes i _alle_ krets- og RC-oppgaver (5–10 p).

---
## 9.1 Elektrisk strøm
### Definisjon
Elektrisk strøm er netto ladningsflyt gjennom et tverrsnitt per tidsenhet:
$$\boxed{I = \frac{dQ}{dt}}$$

| Symbol | Størrelse         | Enhet       |
| ------ | ----------------- | ----------- |
| $I$    | Elektrisk strøm   | ampere (A)  |
| $Q$    | Elektrisk ladning | coulomb (C) |
| $t$    | Tid               | sekund (s)  |

For konstant strøm: $I = Q/t$, dvs. $1;\text{A} = 1;\text{C/s}$.

**Konvensjonell strømretning:** Definert som retningen _positive_ ladninger ville beveget seg — fra høyt til lavt potensial (fra $+$ til $-$ utenfor batteriet). I virkeligheten er det elektroner som beveger seg _motsatt_ vei.

### Strømtetthet

Strømtettheten $J$ beskriver strøm per tverrsnittsareal:

$$\boxed{J = \frac{I}{A}}$$

|Symbol|Størrelse|Enhet|
|---|---|---|
|$J$|Strømtetthet|A/m²|
|$A$|Tverrsnittsareal til lederen|m²|

---

## 9.2 Modell for elektrisk ledning i metaller

### Driftshastighet

I et metall finnes frie elektroner (ledningselektroner) med tetthet $n$ (antall per volum). Når et elektrisk felt påtrykkes, får elektronene en langsom netto bevegelse — **driftshastigheten** $v_d$:

$$\boxed{J = \frac{I}{A} = nqv_d}$$

der $q = e = 1{,}60 \times 10^{-19}$ C for elektroner.

**Løst for driftshastigheten:**

$$v_d = \frac{I}{nqA} = \frac{J}{nq}$$

> [!tip] Fysisk intuisjon Driftshastigheten er _ekstremt liten_ — typisk $\sim 10^{-4}$ m/s (mm/s-området). Elektronene "vandrer" sakte fremover mens de kolliderer med gitteret tusenvis av ganger per sekund. Det elektriske _feltet_ brer seg derimot med nær lyshastigheten gjennom lederen, og det er derfor lampen lyser umiddelbart.

### Sammenheng med resistivitet

Resistiviteten $\rho$ kobler det elektriske feltet $E$ i lederen til strømtettheten $J$:

$$\boxed{\rho = \frac{E}{J}}$$

Denne relasjonen er den mikroskopiske versjonen av Ohms lov.

---

## 9.3 Resistivitet og resistans

### Resistivitet — materialets egenskap

Resistiviteten $\rho$ er en **materialegenskap** som angir hvor mye materialet motstår strømflyt:

|Materiale|$\rho$ ($\Omega\cdot$m)|
|---|---|
|Kobber (Cu)|$1{,}68 \times 10^{-8}$|
|Aluminium (Al)|$2{,}65 \times 10^{-8}$|
|Jern (Fe)|$9{,}7 \times 10^{-8}$|

> [!note] Enheten til resistivitet $[\rho] = \Omega\cdot\text{m}$ (ohm-meter), **ikke** $\Omega/\text{m}$.

### Resistans — komponentens egenskap

For en sylindrisk leder (tråd) med lengde $L$ og tverrsnittsareal $A$:

$$\boxed{R = \rho\frac{L}{A}}$$

|Symbol|Størrelse|Enhet|
|---|---|---|
|$R$|Resistans|ohm ($\Omega$)|
|$\rho$|Resistivitet|$\Omega\cdot$m|
|$L$|Lengde på lederen|m|
|$A$|Tverrsnittsareal|m²|

**Fysisk intuisjon:**

- Lengre leder ($L\uparrow$) → mer motstand ($R\uparrow$) — flere kollisjoner langs veien
- Tykkere leder ($A\uparrow$) → mindre motstand ($R\downarrow$) — mer "plass" for strøm å flyte
- Høyere resistivitet ($\rho\uparrow$) → mer motstand ($R\uparrow$) — materialet leder dårligere

### Sirkulært tverrsnitt

Når oppgaven oppgir diameter $d$ i stedet for areal, bruk:

$$A = \pi r^2 = \frac{\pi d^2}{4}$$

Slik at:

$$R = \rho\frac{L}{A} = \rho\frac{4L}{\pi d^2}$$

> [!warning] Enhetskonvertering — vanlig felle! Tverrsnitt oppgis ofte i mm²: $1;\text{mm}^2 = 10^{-6};\text{m}^2$. Diameter oppgis ofte i mm: $1;\text{mm} = 10^{-3};\text{m}$. Glem aldri å konvertere til SI-enheter før du regner!

---

## 9.4 Ohms lov

### Grunnformelen

For en komponent med konstant resistans:

$$\boxed{V = IR}$$

|Symbol|Størrelse|Enhet|
|---|---|---|
|$V$|Spenning over komponenten|volt (V)|
|$I$|Strøm gjennom komponenten|ampere (A)|
|$R$|Resistans|ohm ($\Omega$)|

> [!important] Ohms lov gjelder for _ohmske_ komponenter Ohms lov er **ikke** en universell naturlov — den er en empirisk sammenheng som gjelder for materialer der $R$ er konstant (uavhengig av $V$ og $I$). Metalliske ledere ved konstant temperatur er et godt eksempel. Dioder og halvledere er _ikke_ ohmske.

### Omskrivinger

$$I = \frac{V}{R}, \qquad R = \frac{V}{I}, \qquad V = IR$$

Disse tre formene brukes konstant i kretsanalyse. Velg den formen som passer til hva du kjenner.

---

## 9.5 Elektrisk energi og effekt

### Effekt — generelt

Elektrisk effekt levert til (eller produsert i) en komponent:

$$\boxed{P = VI}$$

|Symbol|Størrelse|Enhet|
|---|---|---|
|$P$|Effekt|watt (W)|
|$V$|Spenning over komponenten|volt (V)|
|$I$|Strøm gjennom komponenten|ampere (A)|

### Effekt i en motstand

Ved å kombinere $P = VI$ med Ohms lov ($V = IR$):

$$\boxed{P = RI^2 = \frac{V^2}{R}}$$

Disse to uttrykkene er ekvivalente:

- $P = RI^2$: nyttig når du kjenner strømmen
- $P = V^2/R$: nyttig når du kjenner spenningen

> [!tip] Når bruke hvilken form?
> 
> - **Serie**krets: Strøm $I$ er lik i alle komponenter → bruk $P = RI^2$
> - **Parallell**krets: Spenning $V$ er lik over alle → bruk $P = V^2/R$

### Energi

Energien forbrukt over tid $t$:

$$W = Pt = VIt$$

---

## Motstander i serie og parallell

> [!note] Kap. 10.2 — Antas kjent fra fysikk 1 Disse reglene er formelt del av Kap. 10, men er forutsatt kjent og brukes allerede i Kap. 9-oppgaver.

### Seriekobling

Motstander i serie har **samme strøm** $I$:

$$\boxed{R_{\text{eq}} = R_1 + R_2 + R_3 + \cdots}$$

Spenningen fordeles: $V_{\text{tot}} = V_1 + V_2 + \cdots$, der $V_i = IR_i$.

### Parallellkobling

Motstander i parallell har **samme spenning** $V$:

$$\boxed{\frac{1}{R_{\text{eq}}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots}$$

For to motstander:

$$R_{\text{eq}} = \frac{R_1 R_2}{R_1 + R_2}$$

Strømmen fordeles: $I_{\text{tot}} = I_1 + I_2 + \cdots$, der $I_i = V/R_i$.

> [!warning] Husk: Motsatt av kondensatorer!
> 
> ||Serie|Parallell|
> |---|---|---|
> |**Motstander**|$R_{\text{eq}} = R_1 + R_2$ (adderes)|$1/R_{\text{eq}} = 1/R_1 + 1/R_2$ (omvendt)|
> |**Kondensatorer**|$1/C_{\text{eq}} = 1/C_1 + 1/C_2$ (omvendt)|$C_{\text{eq}} = C_1 + C_2$ (adderes)|

---

## Batteri med indre motstand

Et reelt batteri har en elektromotorisk spenning (ems) $\varepsilon$ og en indre resistans $R_i$:

$$\boxed{V_{\text{pol}} = \varepsilon - IR_i}$$

|Symbol|Størrelse|
|---|---|
|$\varepsilon$|Ems (ideell spenning, "tomgangsspenning")|
|$R_i$|Indre resistans|
|$I$|Strøm levert av batteriet|
|$V_{\text{pol}}$|Polspenning (det du faktisk måler mellom polene)|

**Fysisk intuisjon:** Noe av batteriets spenning "brukes opp" internt i batteriet selv. Jo høyere strøm batteriet leverer, desto lavere blir polspenningen.

**Total strøm i kretsen:**

$$I = \frac{\varepsilon}{R_i + R_{\text{ytre}}}$$

der $R_{\text{ytre}}$ er den ekvivalente ytre resistansen.

**Total effekt:**

$$P_{\text{tot}} = \varepsilon I = I^2(R_i + R_{\text{ytre}})$$

Fordelt på:

- Nyttig effekt i ytre krets: $P_{\text{ytre}} = I^2 R_{\text{ytre}}$
- Varmetap i batteri: $P_i = I^2 R_i$

---

## Gjennomregnede eksempler (øving + eksamen)

### Eksempel 1: Øving 10, oppgave 1 — Diameterforhold Cu vs. Al

**Oppgave:** Kobber ($\rho_{\text{Cu}} = 1{,}68\times10^{-8};\Omega\text{m}$) og aluminium ($\rho_{\text{Al}} = 2{,}65\times10^{-8};\Omega\text{m}$). Finn $d_{\text{Al}}/d_{\text{Cu}}$ for lik resistans per lengdeenhet.

**Løsning:** Resistans per lengdeenhet:

$$\frac{R}{L} = \frac{\rho}{A} = \frac{\rho}{\pi d^2/4} = \frac{4\rho}{\pi d^2}$$

Setter lik for begge materialer:

$$\frac{4\rho_{\text{Al}}}{\pi d_{\text{Al}}^2} = \frac{4\rho_{\text{Cu}}}{\pi d_{\text{Cu}}^2}$$

$$\frac{d_{\text{Al}}^2}{d_{\text{Cu}}^2} = \frac{\rho_{\text{Al}}}{\rho_{\text{Cu}}} \quad \Rightarrow \quad \frac{d_{\text{Al}}}{d_{\text{Cu}}} = \sqrt{\frac{\rho_{\text{Al}}}{\rho_{\text{Cu}}}} = \sqrt{\frac{2{,}65}{1{,}68}} \approx 1{,}26$$

### Eksempel 2: Øving 10, oppgave 2 — Resistansforhold mellom tverrsnitt

**Oppgave:** Samme materiale, $A_1 = 4{,}0$ mm² og $A_2 = 16$ mm². Finn $R_1/R_2$ per meter.

**Løsning:**

$$\frac{R_1/L}{R_2/L} = \frac{\rho/A_1}{\rho/A_2} = \frac{A_2}{A_1} = \frac{16}{4{,}0} = 4{,}0$$

Den tynnere kabelen har 4 ganger så stor resistans per meter.

### Eksempel 3: Øving 10, oppgave 4 — Batteri med indre motstand

**Oppgave:** $\varepsilon = 9{,}0$ V, $R_i = 1{,}0;\Omega$, $R_1 = 220;\Omega | R_2 = 330;\Omega$.

**a) Ekvivalent resistans:**

$$R_{\text{ytre}} = \frac{R_1 R_2}{R_1 + R_2} = \frac{220 \cdot 330}{220 + 330} = \frac{72600}{550} = 132;\Omega$$

$$R_{\text{tot}} = R_i + R_{\text{ytre}} = 1{,}0 + 132 = 133;\Omega$$

**b) Strøm:**

$$I = \frac{\varepsilon}{R_{\text{tot}}} = \frac{9{,}0}{133} = 0{,}0677;\text{A} \approx 68;\text{mA}$$

**c) Polspenning:**

$$V_{\text{pol}} = \varepsilon - IR_i = 9{,}0 - 0{,}068 \cdot 1{,}0 = 8{,}93;\text{V} \approx 8{,}9;\text{V}$$

> [!tip] Legg merke til at $R_i \ll R_{\text{ytre}}$, så polspenningen er nesten lik ems. Indre motstand betyr mest ved høy strøm (lav ytre motstand).

**d) Effekt:**

$$P = \varepsilon I = 9{,}0 \cdot 0{,}068 = 0{,}61;\text{W}$$

### Eksempel 4: Eksamen A21 — Lengdeforhold Cu vs. Al

**Oppgave:** Samme tverrsnitt $A$. Finn $L_{\text{Cu}}/L_{\text{Al}}$ for lik $R$.

**Løsning:**

$$R_{\text{Cu}} = R_{\text{Al}} ;\Rightarrow; \rho_{\text{Cu}}\frac{L_{\text{Cu}}}{A} = \rho_{\text{Al}}\frac{L_{\text{Al}}}{A}$$

$$\frac{L_{\text{Cu}}}{L_{\text{Al}}} = \frac{\rho_{\text{Al}}}{\rho_{\text{Cu}}} = \frac{2{,}65}{1{,}68} = 1{,}58$$

Kobber kan være 58 % lengre enn aluminium og fortsatt ha samme resistans.

### Eksempel 5: Eksamen A22 — Maks lederlengde for spenningsfall

**Oppgave:** Kobberleder ($\rho = 1{,}7\times10^{-8};\Omega\text{m}$, $A = 2{,}5$ mm²), batteri $V_0 = 12$ V, strøm $I = 10$ A. Spenningsfall maks 2,5 % av $V_0$.

**Løsning:** Maks spenningsfall: $\Delta V = 0{,}025 \cdot 12 = 0{,}30$ V.

Fra Ohms lov: $R = \Delta V / I = 0{,}30/10 = 0{,}030;\Omega$.

Fra $R = \rho L/A$:

$$L = \frac{RA}{\rho} = \frac{0{,}030 \cdot 2{,}5\times10^{-6}}{1{,}7\times10^{-8}} = 4{,}4;\text{m}$$

### Eksempel 6: Eksamen V23 — Kobberleder for spenningsreduksjon

**Oppgave:** 12 V-batteri skal levere 3,0 V til en enhet ved 0,50 A. Kobberleder ($\rho = 1{,}7\times10^{-8};\Omega\text{m}$, $A = 0{,}050$ mm²). Hvor lang leder?

**Løsning:** Spenningen som skal falle over lederen: $V_R = 12 - 3{,}0 = 9{,}0$ V.

Nødvendig resistans: $R = V_R/I = 9{,}0/0{,}50 = 18;\Omega$.

Lederlengde:

$$L = \frac{RA}{\rho} = \frac{18 \cdot 0{,}050\times10^{-6}}{1{,}7\times10^{-8}} \approx 53;\text{m}$$

### Eksempel 7: Eksamen V24 — Resistans avhenger av retning

**Oppgave:** Rektangulær motstandskloss ($2L \times L \times L$). Avhenger $R$ av strømretningen?

**Løsning:** Gjennom den lange sida: $L_{\text{strøm}} = 2L$, $A = L^2$, $R_1 = \rho\cdot 2L/L^2 = 2\rho/L$.

Gjennom den korte sida: $L_{\text{strøm}} = L$, $A = 2L\cdot L = 2L^2$, $R_2 = \rho\cdot L/(2L^2) = \rho/(2L)$.

$R_1/R_2 = 4$, så **ja** — koblingen i figuren til venstre (gjennom den lange sida) gir størst resistans.

---

## Formler til formelarket (alt tilgjengelig på eksamen)

|Formel|Beskrivelse|
|---|---|
|$I = dQ/dt$|Definisjon av strøm|
|$J = I/A = nqv_d$|Strømtetthet og driftshastighet|
|$\rho = E/J$|Definisjon av resistivitet|
|$R = \rho L/A$|Resistans for sylindrisk leder|
|$V = IR$|Ohms lov|
|$P = VI$|Elektrisk effekt|
|$P = RI^2 = V^2/R$|Effekt i motstand|
|$V_{\text{pol}} = \varepsilon - Ir$|Polspenning for batteri|
|$R_{\text{ser}} = R_1 + R_2 + \cdots$|Motstander i serie|
|$1/R_{\text{par}} = 1/R_1 + 1/R_2 + \cdots$|Motstander i parallell|

---

## Typiske eksamensoppgaver og strategi

> [!success] Oppgavetyper som alltid kommer

### Type 1: Sammenlign to ledere (2 p, flervalg)

Gitt to materialer eller to geometrier — finn forholdet mellom $R$, $L$, $A$ eller $d$.

**Strategi:** Skriv opp $R = \rho L/A$ for begge, sett lik det som skal være likt, og løs for forholdet. Husk $A = \pi d^2/4$ om diameter oppgis.

### Type 2: Spenningsfall over leder (2 p, flervalg)

Gitt $\rho$, $A$, $I$ og maks tillatt spenningsfall — finn maks lengde.

**Strategi:** $\Delta V = RI = \rho L I / A$ → løs for $L$.

### Type 3: Resistans avhenger av retning (2 p, flervalg)

Rektangulær kloss — strøm i to forskjellige retninger.

**Strategi:** Identifiser $L$ (strømveien) og $A$ (tverrsnittet vinkelrett på strømmen) for begge retninger.

### Type 4: Batteri med indre motstand (del av større oppgave)

Finn strøm, polspenning, effekt.

**Strategi:** $I = \varepsilon/(R_i + R_{\text{ytre}})$, deretter $V_{\text{pol}} = \varepsilon - IR_i$, $P = \varepsilon I$.

> [!warning] Vanlige feller
> 
> - Glemme å konvertere mm² til m² (faktor $10^{-6}$!)
> - Forveksle resistivitet $\rho$ ($\Omega\cdot$m) med massetetthet $\rho$ (kg/m³) — se på kontekst
> - Bruke diameter der det skal være areal: $A = \pi d^2/4$, **ikke** $\pi d^2$
> - Glemme indre motstand i totalresistansen: $R_{\text{tot}} = R_i + R_{\text{ytre}}$

---

## Kobling til andre kapitler

|Kapittel|Sammenheng|
|---|---|
|**Kap. 5/7** (Elektrisk felt/potensial)|$E = V/d$ i platekondensator; $\rho = E/J$ kobler mikro- og makroskopisk|
|**Kap. 8** (Kondensatorer)|$C$ og $R$ har "motsatte" serie/parallell-regler|
|**Kap. 10** (DC-kretser)|Kirchhoffs lover + Ohms lov for å analysere kretser; polspenning|
|**Kap. 10.5** (RC-kretser)|$\tau = RC$ — resistans bestemmer ladestrømmen; alle formler fra kap. 9 brukes|

---

_Sist oppdatert: IFYX1002 V25 — basert på pensum, formelark, øvinger og eksamenssett 2020–2025_
# Kap. 10: Likestrømskretser  

> [!info] Pensum IFYX1002
> 
> **Eksamensvekt:** Dette er det **høyest vektede** kapittelet i hele elmag-delen. RC-krets-oppgaven gir typisk **5–10 poeng** og dukker opp på _alle_ eksamenssett. I tillegg kommer 2–4 poeng fra enklere kretsspørsmål.

---

## 10.1 Elektromotorisk kraft (ems)

### Ideelt batteri

Et ideelt batteri opprettholder en konstant potensialforskjell $\varepsilon$ (ems) mellom polene, uavhengig av strømmen:

$$V = \varepsilon$$

### Reelt batteri — indre motstand

Et reelt batteri har en indre resistans $R_i$ som fører til spenningsfall internt:

$$\boxed{V_{\text{pol}} = \varepsilon - IR_i}$$

|Symbol|Betydning|
|---|---|
|$\varepsilon$|Ems — batteriets "ideelle" spenning (tomgangsspenning)|
|$R_i$|Indre resistans|
|$I$|Strøm levert av batteriet|
|$V_{\text{pol}}$|Polspenning — det du måler mellom polene under belastning|

**Totalstrøm i krets:**

$$I = \frac{\varepsilon}{R_i + R_{\text{ytre}}}$$

> [!tip] Spesialtilf eller
> 
> - **Tomgang** ($I = 0$): $V_{\text{pol}} = \varepsilon$ (du måler ems direkte)
> - **Kortslutning** ($R_{\text{ytre}} = 0$): $I = \varepsilon/R_i$ (maks strøm, all effekt i batteriet)

---

## 10.2 Motstander i serie og parallell

> [!note] Antas kjent — men repetert her fordi det brukes overalt

### Seriekobling — samme strøm

$$\boxed{R_{\text{eq}} = R_1 + R_2 + R_3 + \cdots}$$

### Parallellkobling — samme spenning

$$\boxed{\frac{1}{R_{\text{eq}}} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \cdots}$$

Snarvei for to motstander: $R_{\text{eq}} = \frac{R_1 R_2}{R_1 + R_2}$

Snarvei for $N$ identiske motstander $R$: serie gir $NR$, parallell gir $R/N$.

---

## 10.3 Kirchhoffs lover

> [!danger] Bossoppgaven på eksamen Kirchhoffs lover er verktøyet du bruker til å analysere alle kretser som ikke kan reduseres med enkel serie/parallell. På eksamen kombineres de alltid med RC-kretser.

### Kirchhoffs 1. lov — Strømloven (knutepunkt)

$$\boxed{\sum I_{\text{inn}} = \sum I_{\text{ut}}}$$

All strøm som flyter inn i et knutepunkt, må også flyte ut. Dette er bevaring av ladning.

### Kirchhoffs 2. lov — Spenningsloven (sløyfe)

$$\boxed{\sum V = 0 \quad \text{(rundt en lukket sløyfe)}}$$

Summen av alle spenningsstigninger og -fall rundt en lukket sløyfe er null. Dette er bevaring av energi.

### Fortegnsregler for sløyfelikningen

Når du går rundt en sløyfe i valgt retning:

|Komponent|Retning|Spenningsbidrag|
|---|---|---|
|**Batteri**|Fra $-$ til $+$ (med ems)|$+\varepsilon$|
|**Batteri**|Fra $+$ til $-$ (mot ems)|$-\varepsilon$|
|**Motstand**|Med antatt strømretning|$-IR$ (spenningsfall)|
|**Motstand**|Mot antatt strømretning|$+IR$ (spenningsstigning)|
|**Kondensator**|Fra $-$ til $+$|$+V_C = +Q/C$|
|**Kondensator**|Fra $+$ til $-$|$-V_C = -Q/C$|

> [!important] Om du velger feil strømretning Velg en vilkårlig retning for ukjente strømmer. Dersom svaret blir negativt, betyr det bare at strømmen i virkeligheten går _motsatt_ vei. Verdien er fortsatt riktig.

### Systematisk fremgangsmåte

1. **Tegn kretsen** og merk alle kjente verdier
2. **Definer strømmer** — gi alle ukjente strømmer et navn og en antatt retning
3. **Skriv knutepunktlikninger** (Kirchhoff 1) — du trenger $(k-1)$ likninger for $k$ knutepunkter
4. **Skriv sløyfelikninger** (Kirchhoff 2) — velg uavhengige sløyfer
5. **Løs likningssystemet** — du trenger like mange likninger som ukjente

### Forenkling: Parallellkobling med felles spenning

Når to greiner er direkte parallellkoblet over et batteri med spenning $V$, er strømmen i hver grein gitt direkte fra Ohms lov:

$$I_1 = \frac{V}{R_{\text{grein,1}}}, \qquad I_2 = \frac{V}{R_{\text{grein,2}}}$$

Dette er _mye_ raskere enn å sette opp Kirchhoff for slike kretser.

---

## 10.5 RC-kretser

> [!danger] Den viktigste enkeltoppgaven på eksamen Denne oppgavetypen gir 5–10 poeng og har dukket opp på _alle_ eksamenssett (V20, A20, V21, A21, V22, A22, V23, A23, V24, A24, V25). Mestre denne, og du sikrer deg nærmere en A.

### Tidskonstant

$$\boxed{\tau = RC}$$

|Symbol|Betydning|Enhet|
|---|---|---|
|$\tau$|Tidskonstant|sekund (s)|
|$R$|Resistans|ohm ($\Omega$)|
|$C$|Kapasitans|farad (F)|

Tidskonstanten angir "hastigheten" på opp- eller utladning. Etter $t = \tau$ har ladningen endret seg med en faktor $1 - 1/e \approx 63,%$.

> [!tip] Enhetssjekk $[\tau] = [R]\cdot[C] = \Omega \cdot \text{F} = \frac{\text{V}}{\text{A}} \cdot \frac{\text{C}}{\text{V}} = \frac{\text{C}}{\text{A}} = \frac{\text{C}}{\text{C/s}} = \text{s}$ ✓

### Oppladning (batteri $\varepsilon$ tilkoblet)

Kondensatoren starter uladet ($q(0) = 0$) og lades opp mot $Q_{\max} = C\varepsilon$:

$$\boxed{q(t) = C\varepsilon\left(1 - e^{-t/\tau}\right) = Q_{\max}\left(1 - e^{-t/\tau}\right)}$$

$$\boxed{I(t) = \frac{\varepsilon}{R},e^{-t/\tau} = I_0,e^{-t/\tau}}$$

$$\boxed{V_C(t) = \varepsilon\left(1 - e^{-t/\tau}\right)}$$

|Tidspunkt|$q/Q_{\max}$|$I/I_0$|$V_C/\varepsilon$|
|---|---|---|---|
|$t = 0$|0|1|0|
|$t = \tau$|0,63|0,37|0,63|
|$t = 2\tau$|0,86|0,14|0,86|
|$t = 5\tau$|0,993|0,007|0,993|

### Utladning (batteri frakoblet)

Kondensatoren starter med ladning $Q_0$ og spenning $V_0 = Q_0/C$:

$$\boxed{q(t) = Q_0,e^{-t/\tau}}$$

$$\boxed{I(t) = -\frac{Q_0}{RC},e^{-t/\tau} = -I_0,e^{-t/\tau}}$$

$$\boxed{V_C(t) = V_0,e^{-t/\tau}}$$

Minustegnet i strømmen betyr at ladningen _avtar_ (strømmen flyter "motsatt" vei sammenlignet med oppladning).

|Tidspunkt|$q/Q_0$|$V_C/V_0$|
|---|---|---|
|$t = 0$|1|1|
|$t = \tau$|0,37|0,37|
|$t = 2\tau$|0,14|0,14|
|$t = 5\tau$|0,007|0,007|

### Løse for tid $t$

**Oppladning — "hvor lang tid til $x,%$ av $Q_{\max}$?":**

$$q(t) = fQ_{\max} ;\Rightarrow; 1 - e^{-t/\tau} = f ;\Rightarrow; e^{-t/\tau} = 1 - f$$

$$\boxed{t = -\tau\ln(1-f)}$$

**Utladning — "hvor lang tid til $x,%$ av $Q_0$ gjenstår?":**

$$q(t) = fQ_0 ;\Rightarrow; e^{-t/\tau} = f$$

$$\boxed{t = -\tau\ln f}$$

> [!example] Øving 10, oppgave 3c Hvor lang tid til 80 % oppladning? $f = 0{,}80$: $$t = -\tau\ln(1 - 0{,}80) = -\tau\ln(0{,}20) = 1{,}609,\tau$$ Med $\tau = RC = 1{,}0\times10^6 \cdot 5{,}0\times10^{-6} = 5{,}0$ s: $t = 8{,}0$ s.

### Halveringstid

Tiden for at ladningen (eller spenningen) halveres under utladning:

$$q = \frac{Q_0}{2} ;\Rightarrow; e^{-t_{1/2}/\tau} = \frac{1}{2} ;\Rightarrow; t_{1/2} = \tau\ln 2 \approx 0{,}693,\tau$$

Omvendt: $\tau = t_{1/2}/\ln 2$.

---

## Den store eksamensoppgaven — steg for steg

> [!danger] Eksamensoppgaven som alltid kommer (5–10 p) Strukturen er nesten identisk hvert år. Her er oppskriften:

### Fase 1: Bryter lukket, kondensator fullt oppladet

Når kondensatoren er fullt oppladet, går det **ingen strøm gjennom den** — den oppfører seg som en åpen krets.

**Fremgangsmåte:**

1. Fjern kondensatoren fra kretsen (åpen krets)
2. Finn strømmene i resten av kretsen med Ohms lov / Kirchhoff
3. Finn spenningen over kondensatoren med Kirchhoff 2 rundt en sløyfe som inkluderer C

### Fase 2: Bryter åpnes, kondensator utlades

Når batteriet kobles bort, utlades kondensatoren gjennom motstandene.

**Fremgangsmåte:**

1. Fjern batteriet fra kretsen (og bryteren)
2. Finn den **ekvivalente resistansen** som kondensatoren "ser" — forenkle nettverket sett fra kondensatorens terminaler
3. Beregn $\tau = R_{\text{eq}} \cdot C$
4. Bruk utladningsformlene med $V_C(t) = V_0,e^{-t/\tau}$
5. Løs for tid $t$ om nødvendig

---

## Gjennomregnede eksempler

### Eksempel 1: Øving 10, oppgave 3 — Enkel RC oppladning

**Oppgave:** $R = 1{,}0;\text{M}\Omega$, $C = 5{,}0;\mu\text{F}$, $\varepsilon = 30$ V. Bryter lukkes ved $t = 0$.

**a) Tidskonstant:** $$\tau = RC = 1{,}0\times10^6 \cdot 5{,}0\times10^{-6} = 5{,}0;\text{s}$$

**b) Strøm ved $t = 10$ s:** $$I(10) = \frac{\varepsilon}{R},e^{-10/5{,}0} = \frac{30}{1{,}0\times10^6},e^{-2} = 30;\mu\text{A}\cdot 0{,}135 = 4{,}1;\mu\text{A}$$

**c) Tid til 80 % oppladet:** $$t = -\tau\ln(1 - 0{,}80) = -5{,}0\cdot\ln(0{,}20) = 5{,}0 \cdot 1{,}609 = 8{,}0;\text{s}$$

### Eksempel 2: Eksamen V21 — Den klassiske bossoppgaven (10 p)

**Oppgave:** Batteri $V_p = 10$ V, fire motstander $R_1 = 1{,}0;\Omega$, $R_2 = 8{,}0;\Omega$, $R_3 = 4{,}0;\Omega$, $R_4 = 2{,}0;\Omega$, kondensator $C = 1{,}0;\mu$F. To parallelle greiner: grein 1 har $R_1$–$C$–$R_3$ og grein 2 har $R_2$–$R_4$. Bryter har vært lukket lenge.

**a) Finn strømmene (2 p):**

Kondensator fullt oppladet → ingen strøm gjennom C → kretsen er to parallelle greiner over $V_p$:

$$I_1 = \frac{V_p}{R_1 + R_3} = \frac{10}{1{,}0 + 4{,}0} = 2{,}0;\text{A}$$

$$I_2 = \frac{V_p}{R_2 + R_4} = \frac{10}{8{,}0 + 2{,}0} = 1{,}0;\text{A}$$

**b) Spenning over C (3 p):**

Kirchhoff 2 rundt sløyfe gjennom $R_1$, $C$ og $R_2$:

$$V_C + I_1 R_1 - I_2 R_2 = 0$$ $$V_C = I_2 R_2 - I_1 R_1 = 1{,}0 \cdot 8{,}0 - 2{,}0 \cdot 1{,}0 = 6{,}0;\text{V}$$

**c) Utladningstid til 10 % (5 p):**

Bryter åpnes → batteri bort. Kondensatoren utlades gjennom motstandene. Sett fra C ser nettverket slik ut: $(R_1 + R_3)$ i parallell med $(R_2 + R_4)$:

$$R_{\text{eq}} = \frac{(R_1+R_3)(R_2+R_4)}{(R_1+R_3)+(R_2+R_4)} = \frac{5{,}0 \cdot 10}{5{,}0 + 10} = 3{,}33;\Omega$$

$$\tau = R_{\text{eq}} \cdot C = 3{,}33 \cdot 1{,}0\times10^{-6} = 3{,}33;\mu\text{s}$$

Tid til $V_C = 0{,}10 V_0$:

$$t = -\tau\ln(0{,}10) = -3{,}33\times10^{-6}\cdot(-2{,}303) = 7{,}7;\mu\text{s}$$

### Eksempel 3: Eksamen A24 — Parallellkoblede kondensatorer utlades

**Oppgave:** To parallellkoblede kondensatorer ($C$ hver) ladet til 12 V, kobles til motstand $R = 1{,}0;\text{M}\Omega$. Finn tid til $V = 6{,}0$ V.

**Løsning:** $$C_{\text{eq}} = 2C = 2 \cdot 1{,}0;\mu\text{F} = 2{,}0;\mu\text{F}$$

$$\tau = R \cdot C_{\text{eq}} = 1{,}0\times10^6 \cdot 2{,}0\times10^{-6} = 2{,}0;\text{s}$$

$$V(t) = V_0,e^{-t/\tau} = 6{,}0 ;\Rightarrow; e^{-t/2{,}0} = \frac{6{,}0}{12} = 0{,}5$$

$$t = -2{,}0\cdot\ln(0{,}5) = 2{,}0\cdot 0{,}693 = 1{,}4;\text{s}$$

### Eksempel 4: Eksamen V22 — Tidskonstant med flere motstander og kondensatorer

**Oppgave:** 4 identiske seriekoblede motstander ($R$) + 4 identiske parallellkoblede kondensatorer ($C$).

**Løsning:** $$R_{\text{eq}} = 4R, \qquad C_{\text{eq}} = 4C$$ $$\tau = R_{\text{eq}} \cdot C_{\text{eq}} = 4R \cdot 4C = 16RC$$

### Eksempel 5: Eksamen V25 — Halveringstid

**Oppgave:** Gitt halveringstiden $t_{1/2}$ for utladning av en kondensator. Finn $\tau$.

**Løsning:**

$$e^{-t_{1/2}/\tau} = \frac{1}{2} ;\Rightarrow; \frac{t_{1/2}}{\tau} = \ln 2 ;\Rightarrow; \tau = \frac{t_{1/2}}{\ln 2}$$

### Eksempel 6: Eksamen V23 — Finn R for gitt tidskonstant

**Oppgave:** $C = 1{,}0;\mu$F, ønsket $\tau = 1{,}0$ s.

**Løsning:** $$R = \frac{\tau}{C} = \frac{1{,}0}{1{,}0\times10^{-6}} = 1{,}0;\text{M}\Omega$$

### Eksempel 7: Prøveeksamen V20 — Kirchhoff med to ems-kilder

**Oppgave:** Krets med to batterier (begge ems $V$) og tre greiner. Sett opp likninger for $I_1$, $I_2$, $I_3$.

**Løsning:** Knutepunktlikning og sløyfelikninger:

$$I_1 = I_2 + I_3 \qquad \text{(Kirchhoff 1)}$$ $$V - I_2 R - I_1 R = 0 \qquad \text{(Sløyfe 1, Kirchhoff 2)}$$ $$V - I_3 R - I_1 R = 0 \qquad \text{(Sløyfe 2, Kirchhoff 2)}$$

---

## Nøkkelen til kondensatoren i kretser

> [!important] Kondensatoren har to "moduser"
> 
> **Fullt oppladet / stasjonær tilstand:** Ingen strøm gjennom kondensatoren — behandle den som **åpen krets** (brutt ledning). Beregn strømmene som om den ikke var der.
> 
> **Under oppladning/utladning:** Strøm flyter gjennom C, og du bruker RC-formlene. Kondensatoren oppfører seg da som en tidsavhengig spenningskilde.

---

## Formler til formelarket (alt tilgjengelig)

|Formel|Beskrivelse|
|---|---|
|$V_{\text{pol}} = \varepsilon - Ir$|Polspenning|
|$R_{\text{ser}} = R_1 + R_2 + \cdots$|Motstander i serie|
|$1/R_{\text{par}} = 1/R_1 + 1/R_2 + \cdots$|Motstander i parallell|
|$\sum I_{\text{inn}} = \sum I_{\text{ut}}$|Kirchhoff 1 (knutepunkt)|
|$\sum V = 0$|Kirchhoff 2 (sløyfe)|
|$\tau = RC$|Tidskonstant|
|$q(t) = C\varepsilon(1 - e^{-t/\tau})$|Oppladning — ladning|
|$q(t) = Q_0 e^{-t/\tau}$|Utladning — ladning|
|$I = \frac{\varepsilon}{R}e^{-t/\tau}$|Oppladning — strøm|
|$I = -\frac{Q_0}{RC}e^{-t/\tau}$|Utladning — strøm|

---

## Eksamensstrategi og sjekkliste

> [!success] Oppskrift for den store RC-oppgaven
> 
> 1. **Fase 1 — Stasjonær tilstand:** C fullt oppladet → fjern C → finn strømmer med Ohms lov
> 2. **Finn $V_C$:** Kirchhoff 2 rundt sløyfe som inneholder C
> 3. **Fase 2 — Utladning:** Fjern batteri → finn $R_{\text{eq}}$ sett fra C sine terminaler
> 4. **Beregn $\tau = R_{\text{eq}} \cdot C$**
> 5. **Løs for tid:** $V(t) = V_0 e^{-t/\tau}$, ta $\ln$ på begge sider

> [!warning] Vanlige feller
> 
> - **Glemme at C er åpen krets når fullt oppladet** → feilaktig strøm gjennom C
> - **Feil $R_{\text{eq}}$ for utladning** → du må finne resistansen _sett fra kondensatorens terminaler_, med batteriet borte. Ofte er to seriekoblinger i parallell
> - **Feil fortegn i Kirchhoff 2** → vær konsekvent med sløyferetningen
> - **Glemme ln** → $e^{-t/\tau} = f$ betyr $t = -\tau\ln f$, ikke $t = \tau/f$
> - **Enheter** → $1;\text{M}\Omega \cdot 1;\mu\text{F} = 10^6 \cdot 10^{-6} = 1;\text{s}$ (sjekk alltid at $\tau$ gir sekunder)
> - **Forveksle oppladning og utladning** → oppladning har $(1 - e^{-t/\tau})$, utladning har $e^{-t/\tau}$

---

## Kobling til andre kapitler

|Kapittel|Sammenheng|
|---|---|
|**Kap. 8** (Kondensatorer)|$C = Q/V$, serie/parallell for kondensatorer, $V_C$ i kretsen|
|**Kap. 9** (Strøm/resistans)|Ohms lov $V = IR$, resistivitet, effekt — brukes i alle kretsberegninger|
|**Kap. 5/7** (E-felt/potensial)|Potensialforskjell driver strømmen; energibevaring ↔ Kirchhoff 2|

---
# Kap. 11: Magnetiske krefter og felter

> [!info] Pensum IFYX1002
> 
> **Eksamensvekt:** ~4–8 poeng per eksamen. Sirkelbane-oppgaven (2 p flervalg) + dreiemoment på sløyfe (ofte 5–15 p stor regneoppgave) kommer **hver gang**.

---
## 11.1–11.2 Magnetisme og magnetiske felter

### Magnetfelt $\vec{B}$

Magnetfelt beskrives av den magnetiske flukstettheten $\vec{B}$, målt i **tesla** (T).

$$1;\text{T} = 1;\frac{\text{N}}{\text{A}\cdot\text{m}} = 1;\frac{\text{kg}}{\text{A}\cdot\text{s}^2}$$

Typiske verdier: jordas magnetfelt $\sim 50;\mu$T, kjøleskapmagnet $\sim 5$ mT, MRI-maskin $\sim 1{-}3$ T, partikkelakselerator $\sim 1{-}10$ T.

### Konvensjoner for feltretning i figurer

|Symbol|Betydning|
|---|---|
|$\odot$ (prikk)|Feltet peker **ut av** figurplanet (mot deg)|
|$\otimes$ eller **x**|Feltet peker **inn i** figurplanet (bort fra deg)|

---

## 11.3 Ladning i bevegelse i magnetfelt

### Magnetkraft på punktladning

$$\boxed{\vec{F} = q\vec{v} \times \vec{B}}$$

Absoluttverdien:

$$\boxed{F = qvB\sin\phi}$$

der $\phi$ er vinkelen mellom $\vec{v}$ og $\vec{B}$.

|Symbol|Størrelse|Enhet|
|---|---|---|
|$F$|Magnetkraft|newton (N)|
|$q$|Ladning|coulomb (C)|
|$v$|Fart|m/s|
|$B$|Magnetisk flukstetthet|tesla (T)|
|$\phi$|Vinkel mellom $\vec{v}$ og $\vec{B}$|rad|

### Nøkkelegenskaper ved magnetkraften

> [!important] Tre fundamentale egenskaper
> 
> 1. **Magnetkraften står alltid vinkelrett på farten** ($\vec{F} \perp \vec{v}$) — den gjør derfor **aldri arbeid** og endrer aldri partikkelens _fart_ (kinetiske energi), kun _retningen_
> 2. **Magnetkraften står alltid vinkelrett på feltet** ($\vec{F} \perp \vec{B}$) — den peker aldri langs feltretningen
> 3. **Kraften er null dersom $\vec{v} \parallel \vec{B}$** — en ladning som beveger seg langs feltlinjene påvirkes ikke

### Retningsbestemmelse — Høyrehåndsregelen

For **positiv** ladning: Pek fingrene langs $\vec{v}$, krøll dem mot $\vec{B}$ → tommelen peker i retning $\vec{F}$.

For **negativ** ladning (elektron): Bruk høyrehåndsregelen som for positiv ladning, og snu retningen 180°.

### Sirkelbane i homogent magnetfelt

Når $\vec{v} \perp \vec{B}$, blir magnetkraften en ren **sentripetalkraft**, og partikkelen beveger seg i en sirkelbane:

$$qvB = \frac{mv^2}{r}$$

**Sirkelbaneradius:**

$$\boxed{r = \frac{mv}{qB}}$$

**Omløpstid (perioden):**

Fra $v = 2\pi r/T$:

$$\boxed{T = \frac{2\pi m}{qB}}$$

> [!tip] Perioden er uavhengig av farten! Uansett hvor fort partikkelen beveger seg, er omløpstiden den samme. Raskere partikler får bare en større sirkelbane. Dette prinsippet brukes i syklotroner.

**Vinkelfart:**

$$\omega = \frac{2\pi}{T} = \frac{qB}{m}$$

### Proporsjonalitetsanalyse (eksamensklassiker)

Fra $r = mv/(qB)$ kan du raskt svare på "hva skjer med $r$ hvis...":

|Endring|Effekt på $r$|
|---|---|
|$B$ dobles|$r$ halveres|
|$m$ dobles|$r$ dobles|
|$v$ dobles|$r$ dobles|
|$q$ dobles|$r$ halveres|

### Hastighetsselektor ($\vec{E} \perp \vec{B}$)

Når en ladet partikkel beveger seg gjennom kryssede elektriske og magnetiske felt, passerer den rett gjennom kun dersom:

$$qE = qvB \quad \Rightarrow \quad \boxed{v = \frac{E}{B}}$$

---

## 11.4 Magnetisk kraft på strømførende leder

### Grunnformel

En rett leder med lengde $l$ som fører strøm $I$ i et ytre magnetfelt $\vec{B}$:

$$\boxed{\vec{F} = I\vec{l} \times \vec{B}}$$

Absoluttverdien:

$$\boxed{F = IlB\sin\phi}$$

der $\phi$ er vinkelen mellom strømretningen ($\vec{l}$) og $\vec{B}$.

|Situasjon|$\phi$|$F$|
|---|---|---|
|Strøm parallell med $\vec{B}$|$0°$ eller $180°$|$0$|
|Strøm vinkelrett på $\vec{B}$|$90°$|$F_{\max} = IlB$|

### Retningsbestemmelse

Bruk høyrehåndsregelen: Fingrene langs $I$ (strømretning), krøll mot $\vec{B}$ → tommelen gir $\vec{F}$.

> [!example] Øving 11, oppgave 3 — Skråplanstransport Metallplate på skinner i magnetfelt, frakt last oppover med konstant fart.
> 
> Kraftlikevekt langs skråplanet: $$IlB = mg\sin\theta$$ $$I = \frac{mg\sin\theta}{lB} = \frac{100 \cdot 9{,}81 \cdot \sin 30°}{2{,}0 \cdot 0{,}10} = 2450;\text{A}$$

> [!example] Øving 11, oppgave 4 — Rail gun Stang med masse $m$, lengde $l$, strøm $I$, felt $B$: $$a = \frac{IlB}{m}, \qquad s = \frac{v^2}{2a} = \frac{v^2 m}{2IlB}$$ Med tallverdier ($v = 11{,}2$ km/s): $a = 20$ m/s², $s = 3{,}1\times10^6$ m $\approx 3100$ km.

---

## 11.5 Kraft og dreiemoment på ledersløyfe

### Krefter på en rektangulær sløyfe i homogent felt

Betrakt en rektangulær sløyfe (sidekanter $a$ og $b$) som fører strøm $I$ i et homogent felt $\vec{B}$. La $\phi$ være vinkelen mellom sløyfas **normalvektor** $\vec{n}$ og $\vec{B}$.

**Kreftene på de fire sidene:**

- Sidene **parallelle med rotasjonsaksen** (lengde $a$, strøm $\perp$ $\vec{B}$): $F = IaB$ — disse gir **dreiemoment**
- Sidene **vinkelrette på rotasjonsaksen** (lengde $b$): kreftene kansellerer hverandre langs aksen

> [!important] Total nettokraft er alltid null I et _homogent_ magnetfelt er den totale nettokraften på en strømsløyfe alltid null — kreftene kansellerer parvis. Men de kan gi et **netto dreiemoment** som roterer sløyfa.

### Dreiemoment på strømsløyfe

$$\boxed{\tau = IAB\sin\phi}$$

|Symbol|Størrelse|
|---|---|
|$\tau$|Dreiemoment (Nm)|
|$I$|Strøm i sløyfa (A)|
|$A$|Sløyfas areal (m²)|
|$B$|Magnetisk flukstetthet (T)|
|$\phi$|Vinkel mellom $\vec{n}$ og $\vec{B}$|

**Spesialtilfeller:**

|$\phi$|Situasjon|$\tau$|
|---|---|---|
|$0°$ eller $180°$|$\vec{n} \parallel \vec{B}$ (planet $\perp$ $\vec{B}$)|$\tau = 0$ (likevekt)|
|$90°$ eller $270°$|$\vec{n} \perp \vec{B}$ (planet $\parallel$ $\vec{B}$)|$\tau_{\max} = IAB$|

> [!tip] Når er $\phi = 90°$? Når sløyfeplanet er **parallelt** med magnetfeltet (normalvektoren står vinkelrett på $\vec{B}$). Dette er startposisjonen i øving 11 og 12 — og det er der dreiemomentet er størst.

### Utledning av dreiemoment (eksamensfavoritt A24)

For en kvadratisk sløyfe med sidelengde $a$ ved $\phi = 90°$ (planet $\parallel$ $\vec{B}$):

1. Kraft på sidene parallelle med $\vec{B}$: $F = 0$ (strøm $\parallel$ felt)
2. Kraft på sidene vinkelrette på $\vec{B}$: $F = IaB$ på hver
3. Disse danner et **kraftpar** med arm $a/2$ fra aksen på hver side:

$$\tau = 2 \cdot IaB \cdot \frac{a}{2} = Ia^2B = IAB$$

For generell vinkel: momentarmen reduseres med $\sin\phi$, slik at $\tau = IAB\sin\phi$.

### Vinkelakselerasjon

Ettersom $\tau = IAB\sin\phi$ varierer med vinkelen, er vinkelakselerasjonen $\alpha = \tau/I_{\text{tregh}}$ **ikke konstant** — sløyfa roterer med **variabel vinkelakselerasjon**.

> [!note] Øving 11, oppgave 2b: Svar A Sløyfa roterer med variabel vinkelakselerasjon (fordi $\tau \propto \sin\phi$).

---

## Gjennomregnede eksempler (øving + eksamen)

### Eksempel 1: Øving 11, oppgave 1 — Proton i LHC

**Oppgave:** Proton ($m = 1{,}67\times10^{-27}$ kg, $q = +e$, $v = 3{,}0\times10^7$ m/s, $R = 4{,}3$ km). Finn $B$.

$$B = \frac{mv}{qR} = \frac{1{,}67\times10^{-27} \cdot 3{,}0\times10^7}{1{,}60\times10^{-19} \cdot 4300} = 7{,}3\times10^{-5};\text{T} \approx 0{,}073;\text{mT}$$

### Eksempel 2: Eksamen A22 — $B$ dobles, hva skjer med $r$?

Fra $r = mv/(qB)$: $r \propto 1/B$ → **$r$ halveres**.

### Eksempel 3: Eksamen A20 — Proton med gitt omløpstid

**Oppgave:** $r = 1{,}1$ km, $T = 0{,}28$ ms. Finn $B$.

$$B = \frac{2\pi m}{qT} = \frac{2\pi \cdot 1{,}67\times10^{-27}}{1{,}60\times10^{-19} \cdot 0{,}28\times10^{-3}} = 0{,}23;\text{mT}$$

### Eksempel 4: Eksamen V24 — Proton akselerert, deretter sirkelbane

Steg 1: $v = \sqrt{2q\Delta V/m}$ (energibevaring i E-felt)

Steg 2: $T = 2\pi m/(qB)$ — legg merke til at $v$ ikke inngår i $T$.

### Eksempel 5: Eksamen A24 — Strømsløyfe (15 p)

**Oppgave:** Kvadratisk sløyfe, $a$, $I$, $B$. Ved $t=0$ er planet $\parallel$ $\vec{B}$.

**a)** Tegn krefter: To sider har $F = IaB$ (danner kraftpar), to sider har $F = 0$.

**b)** $\tau(t=0) = Ia^2B$ (planet $\parallel$ felt → $\phi = 90°$)

**c)** $\tau = 10 \cdot 0{,}01 \cdot 0{,}50 = 0{,}050$ Nm

**d)** $\tau(\phi) = IAB\sin\phi$ — sinuskurve, null ved $\phi = 0, \pi, 2\pi$, maks ved $\phi = \pi/2, 3\pi/2$.

### Eksempel 6: Eksamen V20 — Hastighetsvelger + sirkelbane

$$v = \frac{E}{B} = \frac{1{,}0\times10^5}{0{,}10} = 1{,}0\times10^6;\text{m/s}$$

$$r = \frac{mv}{qB} = \frac{1{,}67\times10^{-27} \cdot 1{,}0\times10^6}{1{,}60\times10^{-19} \cdot 0{,}10} = 0{,}10;\text{m}$$

### Eksempel 7: Eksamen A21 — Påstander om magnetkraft

|Påstand|Riktig?|Forklaring|
|---|---|---|
|$\vec{F}$ har aldri retning langs $\vec{B}$|✓|$\vec{F} = q\vec{v}\times\vec{B}$ alltid $\perp$ $\vec{B}$|
|$\vec{F}$ kan ha retning motsatt $\vec{B}$|✗|Alltid $\perp$, aldri $\parallel$|
|$F$ uavhengig av $|q|$|
|Dobbel $q$, halv $v$ gir samme $F$|✓|$F = qvB$, så $2q \cdot v/2 = qv$|
|$\vec{F}$ langs $\vec{v}$|✗|Alltid $\perp$|

### Eksempel 8: Øving 11, oppgave 2c — B svekkes 5 %

$\tau_{\max} = IAB \propto B$. Hvis $B$ avtar 5,0 %, avtar $\tau_{\max}$ også **5,0 %**.

---

## Formler til formelarket (alt tilgjengelig på eksamen)

|Formel|Beskrivelse|
|---|---|
|$\vec{F} = q\vec{v}\times\vec{B}$, $F = qvB\sin\phi$|Magnetkraft på punktladning|
|$\vec{F} = I\vec{l}\times\vec{B}$, $F = IlB\sin\phi$|Magnetkraft på strømførende leder|
|$\tau = IAB\sin\phi$|Dreiemoment på strømsløyfe|

Utledede formler (følger direkte fra N2):

|Formel|Beskrivelse|
|---|---|
|$r = mv/(qB)$|Sirkelbaneradius|
|$T = 2\pi m/(qB)$|Omløpstid (uavhengig av $v$!)|
|$v = E/B$|Hastighetsvelger|

---

## Eksamensstrategi

> [!success] Sjekkliste

### Sirkelbane (2 p flervalg — alltid med)

1. Skriv N2: $qvB = mv^2/r$
2. Løs for ukjent ($r$, $B$, $v$, $T$)
3. $T = 2\pi m/(qB)$ uavhengig av $v$
4. Proporsjonalitet: $r \propto mv/(qB)$

### Kraft på leder (3–5 p)

1. $F = IlB\sin\phi$ (oftest $\phi = 90°$)
2. Retning: høyrehåndsregelen
3. Kombiner med N2 eller kraftlikevekt

### Dreiemoment på sløyfe (5–15 p — den store oppgaven)

1. Definer $\phi$ mellom $\vec{n}$ og $\vec{B}$
2. $\tau = IAB\sin\phi$
3. $\tau_{\max} = IAB$ ved $\phi = 90°$ (planet $\parallel$ $\vec{B}$)
4. Tegn krefter → vis kraftpar → utled $\tau$

> [!warning] Vanlige feller
> 
> - Forveksle $\phi$ (vinkel $\vec{n}$ vs. $\vec{B}$) med vinkelen mellom sløyfeplanet og $\vec{B}$ — komplementære!
> - Glemme at elektron avbøyes _motsatt_ vei av høyrehåndsregelen
> - Anta at magnetkraften gjør arbeid — den gjør **aldri** arbeid
> - Glemme enhetskonvertering: km → m, mT → T

---

## Kobling til andre kapitler

|Kapittel|Sammenheng|
|---|---|
|**Kap. 5/7**|Partikkel akselerert i E-felt ($v = \sqrt{2q\Delta V/m}$) → inn i B-felt|
|**Kap. 6**|$qvB = mv^2/r$ er N2 med sentripetalkraft|
|**Kap. 10**|$\tau = I_{\text{tregh}}\alpha$ for rotasjon av sløyfe|
|**Kap. 12**|Kilder til B-felt som produserer kreftene her|
|**Kap. 13**|Roterende sløyfe → fluks endres → Faradays lov|

---

_Sist oppdatert: IFYX1002 V25 — basert på pensum, formelark, øvinger og eksamenssett 2020–2025_
## Kap. 12: Kilder til magnetfelter  

## Kap. 13: Induksjon  

## See also
- [[ifyt1002-moc]]
