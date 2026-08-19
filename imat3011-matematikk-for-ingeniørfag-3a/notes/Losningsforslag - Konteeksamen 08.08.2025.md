---
type: note
status: active
project: ntnu
course: IMAT3011
tags: [ntnu, matematikk, optimering, flervariabel, solutions]
---

## Løsningsforslag: `exams/Konteeksamen 2025.pdf`

### Advarsel om filen

Filen ligger i IMAT3011-rommet, men den hører ikke til dette faget. Forsida sier
**"Eksamensoppgåve i IMAx2023/VB6041 Matematikk for ingeniørfag 2C"**, dato
08.08.2025, tid 09.00 til 13.00, hjelpemiddelkode C, faglærere Bernt Tore Jensen
og Ute Alexandra Schaarschmidt. Maks 20 poeng. Oppgave 11 og 12 besvares på papir,
resten i Inspera.

Innholdet er flervariabel derivasjon, gradient, Hessian, Taylor-rest, LP-dualitet
og numerisk optimering. Overlappet mot IMAT3011 er reelt (gradientmetoden,
Newton, dualisering), så settet er brukbart som trening, men det er ikke et
IMAT3011-sett og bør ikke leses som en pekepinn på hva som kommer.

De tre andre filene som så ut som hull har alle fasit i seg selv:
`Eksamen desember 2025.pdf` starter med "Løsningsforslag eksamen i IMAx3011, Høst
2025", `Konteeksamen februar 2026.pdf` med "Løsningsforslag IMAA3011/IMAG3011/
IMAT3011, Eksamen 19. februar 2026", og `Konteeksamen mai 2026 LF.pdf` gjengir
hvert oppgavetekst før den løses. Dette settet var det eneste uten fasit.

Alle formler i PDF-en er bilder, ikke tekst, så `pdftotext` gir tomme sider.
Sidene er lest visuelt.

### Om nummereringen

Settet har to nummerserier. Tallet i venstre marg er Inspera-punktet og går fra
1 til 17. Oppgaveteksten trykker i tillegg "Oppgave/oppgåve N", og de to seriene
slutter å følge hverandre etter punkt 5. Overskriftene under bruker
Inspera-punktet, siden det er det som står ved svarboksen, og oppgir det trykte
nummeret i parentes der det finnes og avviker.

---

## Oppgave 1: partielle deriverte

`f(x,y) = y^2 sin(x) - 3y e^(y-3)`, punkt `(0,3)`.

`f_x = y^2 cos(x)` gir `f_x(0,3) = 9 * 1 = 9`.

`f_y = 2y sin(x) - 3 e^(y-3) - 3y e^(y-3) = 2y sin(x) - 3 e^(y-3) (1+y)`
gir `f_y(0,3) = 0 - 3 * 1 * 4 = -12`.

**Svar: `f_x = 9`, `f_y = -12`.**

Fella er produktregelen i andre ledd. `d/dy [3y e^(y-3)] = 3 e^(y-3) (1+y)`, ikke
`3 e^(y-3)`.

---

## Oppgave 2: retningsderivert

`f(x,y) = ln(x^2 + y^2)`, punkt `(5,0)`, retning `n = (3/5, 4/5)`.

`grad f = (2x/(x^2+y^2), 2y/(x^2+y^2))`, så `grad f(5,0) = (10/25, 0) = (0.4, 0)`.

`n` er allerede en enhetsvektor (`(3/5)^2 + (4/5)^2 = 1`), så ingen normering:

`D_n f = grad f . n = 0.4 * 0.6 + 0 * 0.8 = 0.24`.

**Svar: 0.24.**

---

## Oppgave 3: gjenkjenn funksjonen fra nivåkurvene

Alle nivåkurvene er rette linjer gjennom origo. Det betyr at `f` er homogen av
grad 0, altså at `f` bare avhenger av forholdet `y/x`. Kandidaten som passer er

**`f(x,y) = (x - y)/(x + y)`.**

Sjekk mot merkelappene i figuren:

| Nivå | Ligning | Linje |
|------|---------|-------|
| 0 | `x - y = 0` | `y = x` |
| 1 | `x - y = x + y` | `y = 0`, x-aksen |
| -1 | `x - y = -x - y` | `x = 0`, y-aksen |
| 2 | `x - y = 2x + 2y` | `y = -x/3` |
| 3 | `x - y = 3x + 3y` | `y = -x/2` |
| 5 | `x - y = 5x + 5y` | `y = -2x/3` |
| -2 | `x - y = -2x - 2y` | `y = -3x` |

Alle sju stemmer, og `x + y = 0` er den udefinerte linja som figuren hopper over.

---

## Oppgave 4: kritiske punkt og klassifisering

`f(x,y) = 2x^3 + y^2 - 6x + 5y + 1`.

`f_x = 6x^2 - 6 = 0` gir `x = ±1`. `f_y = 2y + 5 = 0` gir `y = -5/2`.

**a) Kritiske punkt: `(-1, -5/2)` og `(1, -5/2)`.**

Andrederiverte: `f_xx = 12x`, `f_yy = 2`, `f_xy = 0`, så
`D = f_xx f_yy - f_xy^2 = 24x`.

- `(-1, -5/2)`: `D = -24 < 0`, altså **sadelpunkt**.
- `(1, -5/2)`: `D = 24 > 0` og `f_xx = 12 > 0`, altså **lokalt minimum**.

**b) `(-1, -5/2)` sadel, `(1, -5/2)` lokalt minimum.**

Merk at det ikke finnes noe globalt minimum: `2x^3` går mot `-inf` når `x` går
mot `-inf`.

---

## Oppgave 5: maksimer volumet av en eske

Maksimer `xyz` under `2x + 4y + 5z = 240` med `x, y, z > 0`.

Lagrange: `yz = 2L`, `xz = 4L`, `xy = 5L`. Deler paret vis:
`(yz)/(xz) = 2/4` gir `x = 2y`, og `(xz)/(xy) = 4/5` gir `z = 4y/5`.

Setter inn: `2(2y) + 4y + 5(4y/5) = 4y + 4y + 4y = 12y = 240`, så `y = 20`,
`x = 40`, `z = 16`.

**Svar: `xyz = 40 * 20 * 16 = 12800`.**

Hintet i oppgaven vil at du skal substituere i stedet for å bruke Lagrange. Løs
bibetingelsen for `z`:

`z = (240 - 2x - 4y)/5`, så `V(x,y) = xy(240 - 2x - 4y)/5`.

`V_x = y(240 - 4x - 4y)/5 = 0` gir `x + y = 60`.
`V_y = x(240 - 2x - 8y)/5 = 0` gir `x + 4y = 120`.

Trekker fra: `3y = 60`, altså `y = 20`, `x = 40`, `z = 16`. Samme punkt.

Snarveien er AM-GM: produktet av tre ledd med fast sum er størst når leddene er
like. Her betyr det `2x = 4y = 5z = 240/3 = 80`, som gir samme punkt direkte.

---

## Punkt 6: hvilken funksjon løser ikke adveksjonsligningen

`u_t + C u_x = 0` har generell løsning `u = g(x - Ct)`, altså en profil som
flyttes med fart `C` uten å endre form. Alt som kan skrives som en funksjon av
`x - Ct` alene passerer.

**Svaret er `u = e^(-Ct) sin(x)`.**

`u_t = -C e^(-Ct) sin(x)` og `u_x = e^(-Ct) cos(x)`, så

`u_t + C u_x = C e^(-Ct) (cos(x) - sin(x))`,

som ikke er null. Den demper amplituden i stedet for å flytte profilen, og det er
ikke det adveksjonsligningen gjør.

---

## Punkt 7 (trykt Oppgave 8): Hessian til en kvadratisk form

`f(x,y) = a x^2 + b y^2` med `a, b > 0`.

`f_x = 2ax`, `f_y = 2by`, så Hessianen er

`H = [[2a, 0], [0, 2b]]`.

**Svar: Hessianen avhenger ikke av `x` og `y`.** Det er konstant, som alltid for
en kvadratisk form.

De andre påstandene, for ordens skyld:

- Gradienten i `(1,0)` er `(2a, 0)` og peker vekk fra origo, ikke mot.
- Den retningsderiverte i `(1,0)` er negativ i alle retninger med negativ
  x-komponent, så påstanden om at den alltid er positiv er feil.
- Origo er et minimum, ikke et maksimum, siden `a, b > 0`.
- Hvis `a = b` **er** nivåkurvene sirkler, så en påstand om at de aldri er det
  er feil.

---

## Punkt 8 (trykt Oppgave 9): restleddet i Taylor

`f(x) = 18 e^(x-3)`, andregrads Taylor om `a = 3`, intervall `[3, 3.1]`.

Lagrange-restleddet er `R2 = f'''(c) (x-a)^3 / 3!` for en `c` mellom `a` og `x`.

`f'''(x) = 18 e^(x-3)`, som er voksende, så maksimum på intervallet er
`f'''(3.1) = 18 e^0.1 = 19.8931`.

`(x-a)^3 <= 0.1^3 = 0.001`.

`|R2| <= 19.8931 * 0.001 / 6 = 0.0033155`.

**Svar: 0.00332.**

---

## Punkt 9 (trykt Oppgave 10): retningsderivert i Python

Funksjonen skal regne ut den retningsderiverte numerisk med foroverdifferanse.

**a) Linje 7 som mangler:**

```python
return (f(p + delta*v) - f(p)) / delta
```

Parameteren heter `f` inne i funksjonen. Å skrive `g` der ville låst rutina til
én bestemt global funksjon og gjort argumentet meningsløst.

**b) Partiellderivert med hensyn på `x`:**

```python
retningsderiverte(g, p, np.array([1, 0, 0]))
```

Den partiellderiverte er retningsderiverte langs den første basisvektoren.

---

## Punkt 10 til 12: dualisering av et lineært problem

Primalen er

```
max  4x1 - x2 + 2x3
s.t.  x1        + 2x3 >= -1
      x1 -  x2  -  x3 >=  2
      x1, x2 >= 0,  x3 fri
```

### Punkt 10 (a): blir dualen maksimert eller minimert?

**Minimert.** Dualen til et maksimeringsproblem er alltid et
minimeringsproblem, det er det svake dualitetsteoremet setter opp
(`c'x <= b'y` for alle tillatte par).

### Punkt 11 (b): sett opp dualen

Snu først ulikhetene til `<=`-form så de passer standardoppsettet
`max c'x` under `Ax <= b`:

```
-x1        - 2x3 <=  1
-x1 +  x2  +  x3 <= -2
```

Da er `A = [[-1, 0, -2], [-1, 1, 1]]`, `b = (1, -2)` og `c = (4, -1, 2)`.

Dualen blir

```
min  y1 - 2y2
s.t. -y1 -  y2 >=  4      (fra x1 >= 0)
            y2 >= -1      (fra x2 >= 0)
     -2y1 + y2 =   2      (fra x3 fri)
     y1, y2 >= 0
```

Verdt å legge merke til: denne dualen er ikke tillatt. Med `y1, y2 >= 0` er
`-y1 - y2 <= 0`, som aldri kan bli `>= 4`. Det henger sammen med at primalen er
ubegrenset: sett `x1 = t`, `x2 = 0`, `x3 = t - 2`. Begge bibetingelsene holder
for `t >= 1`, og målfunksjonen blir `4t + 2(t-2) = 6t - 4`, som går mot uendelig.

### Punkt 12 (c): fortegnsbetingelser på dualvariablene

**`y1 >= 0` og `y2 >= 0`.**

Regelen er at hver ulikhet i primalen gir en fortegnsbundet dualvariabel, mens
hver likhet gir en fri dualvariabel. Her er begge primalbetingelsene ulikheter,
så begge dualvariablene er ikke-negative. Motsatt vei: den frie primalvariabelen
`x3` gir en **likhet** i dualen, ikke en ulikhet, og det er den tredje linja over.

---

## Punkt 13: gradientmetoden med to iterasjoner

`f(x,y) = x^4 - 2x^2 + y^4 - y^2 + 10`, `grad f = (4x^3 - 4x, 4y^3 - 2y)`,
steglengde `alpha = 0.1`, start `(2, 1)`.

Kontroll av rad 0 i tabellen som er gitt: `f(2,1) = 16 - 8 + 1 - 1 + 10 = 18` og
`grad f(2,1) = (32 - 8, 4 - 2) = (24, 2)`. Stemmer.

Oppdatering er `x_ny = x - alpha * grad f(x)`.

| i | x | y | f | grad f |
|---|---|---|---|--------|
| 0 | 2 | 1 | 18 | (24, 2) |
| 1 | -0.400 | 0.800 | 9.475 | (1.344, 0.448) |
| 2 | -0.534 | 0.755 | 9.265 | |

Regnestykkene:

- `i=1`: `x = 2 - 0.1*24 = -0.4`, `y = 1 - 0.1*2 = 0.8`.
  `f = 0.0256 - 0.32 + 0.4096 - 0.64 + 10 = 9.4752`.
  `grad = (4(-0.064) + 1.6, 4(0.512) - 1.6) = (1.344, 0.448)`.
- `i=2`: `x = -0.4 - 0.1344 = -0.5344`, `y = 0.8 - 0.0448 = 0.7552`.
  `f = 0.08156 - 0.57116 + 0.32527 - 0.57033 + 10 = 9.2653`.

Legg merke til det store første spranget. Med `alpha = 0.1` og en gradient på 24
hopper iterasjonen forbi bunnen og lander på motsatt side av `x = 0`. Det er
typisk oppførsel for fast steglengde på en funksjon med bratt vekst.

---

## Punkt 14: dempet Newton

`f(x) = x^3 - cos(2x)`, `f'(x) = 3x^2 + 2 sin(2x)`,
`f''(x) = 6x + 4 cos(2x)`, demping `alpha = 0.5`, start `x0 = 1`.

Kontroll av rad 0: `f(1) = 1 - cos(2) = 1.4161`, `f'(1) = 3 + 2 sin(2) = 4.8186`,
`f''(1) = 6 + 4 cos(2) = 4.3354`. Stemmer med tabellen.

Oppdatering er `x_ny = x - alpha * f'(x)/f''(x)`.

| i | x | f | f' | f'' |
|---|---|---|-----|------|
| 0 | 1 | 1.4161 | 4.8186 | 4.3354 |
| 1 | 0.4443 | -0.5429 | 2.1445 | 5.1879 |
| 2 | 0.2376 | -0.8759 | | |

Regnestykkene:

- `i=1`: `x = 1 - 0.5 * 4.8186/4.3354 = 1 - 0.5557 = 0.4443`.
  `f = 0.08770 - cos(0.88855) = 0.08770 - 0.63056 = -0.5429`.
  `f' = 3(0.19738) + 2 sin(0.88855) = 0.59214 + 1.55237 = 2.1445`.
  `f'' = 6(0.44427) + 4(0.63056) = 2.66565 + 2.52224 = 5.1879`.
- `i=2`: `x = 0.4443 - 0.5 * 2.1445/5.1879 = 0.4443 - 0.2067 = 0.2376`.
  `f = 0.01341 - cos(0.47518) = 0.01341 - 0.88935 = -0.8759`.

Dempingen på 0.5 halverer hvert Newton-steg. Uten den ville steget vært det
dobbelte, og på denne funksjonen med `f''` som skifter fortegn litt lenger ned er
det dempingen som holder iterasjonen stabil.

---

## Punkt 15: Lagrangemultiplikatorer

Minimer `f(x,y) = xy` under `4x + y = 1`.

**Lagrangefunksjonen: `L(x, y, lambda) = xy + lambda (4x + y - 1)`.**

Stasjonærpunkt: `y + 4 lambda = 0` og `x + lambda = 0` gir `x = -lambda` og
`y = -4 lambda`. Bibetingelsen gir `-4 lambda - 4 lambda = 1`, altså
`lambda = -1/8`, `x = 1/8`, `y = 1/2`, `f = 1/16`.

Men dette er ikke et minimum. Sett `y = 1 - 4x` inn i målfunksjonen:

`f = x(1 - 4x) = x - 4x^2`,

som er en nedovervendt parabel. Toppunktet ligger i `x = 1/8` med verdi `1/16`,
og funksjonen går mot `-inf` i begge retninger.

**Konklusjonen: problemet har ikke noe minimum, og `lambda` er derfor ikke
veldefinert i noe minimum.** Multiplikatoren `-1/8` hører til maksimum.

Dette er standardfella med Lagrange. Metoden finner stasjonærpunkt, ikke
minimum. Klassifiseringen må gjøres etterpå, og her holder det å substituere.

---

## Punkt 16: blandete oppgaver

| | Påstand | Svar | Hvorfor |
|---|---------|------|---------|
| a | Snittet av to konvekse mengder er konveks | **Sant** | Ligger `p` og `q` i begge mengdene, ligger hele linjestykket mellom dem i begge, og dermed i snittet |
| b | `min norm(Ax-b)^2` og `min norm(Ax-b)` har samme løsning | **Sant** | `t -> t^2` er strengt voksende for `t >= 0`, så den bevarer rekkefølgen og dermed argmin |
| c | Ethvert globalt minimum er også et lokalt minimum | **Sant** | Omvendt gjelder ikke, et lokalt minimum trenger ikke være globalt |
| d | Rutesøk kan bare gjøres med et jevnt antall punkt | **Usant** | Antall punkt per akse er fritt valgt, det er ingen slik begrensning |
| e | Dualen har alltid færre variabler enn primalen | **Usant** | Dualen har én variabel per primalbetingelse, som kan være flere, færre eller like mange |

---

## Punkt 17: feil pythonkode

### a) Gradientmetode med to feil

Koden minimerer `f(x,y) = 3x^2 - xy + 2y^2 + 8x - 9y`. Oppgaveteksten skriver
andre ledd som `2x^2`, men `gradf` på linje 6 returnerer
`[6x0 - x1 + 8, -x0 + 4x1 - 9]`, som er gradienten til `2y^2`-versjonen. Det er
en trykkfeil i oppgaven, ikke i koden.

De to feilene, i stigende linjenummer:

**Linje 12:** `while feil < 0.0001:`

Betingelsen er snudd. Løkka skal kjøre så lenge feilen er **stor**, ikke så lenge
den er liten. Slik den står nå er `feil` rundt 14 ved start, testen er usann med
en gang, og løkka kjøres aldri. Skal være `while feil > 0.0001:`.

**Linje 14:** `x = x + alpha*grad`

Gradientmetoden for minimering skal gå **mot** gradienten. Med pluss går den
oppover og divergerer. Skal være `x = x - alpha*grad`.

**Svar: 12 og 14.**

### b) Newtons metode, antall iterasjoner

Her er implementasjonen riktig: `H = Hessf(x)` og `x = x - np.linalg.solve(H, g)`,
altså fullt Newton-steg uten demping, på samme `f` som i (a).

Målfunksjonen er kvadratisk, og Hessianen er konstant:

`H = [[6, -1], [-1, 4]]`, `det H = 24 - 1 = 23 > 0`, `H11 = 6 > 0`,

så `H` er positivt definitt og `f` er strengt konveks med ett globalt minimum.

**Newton på en kvadratisk funksjon treffer minimum i ett steg.** Den kvadratiske
modellen Newton bygger er ikke en tilnærming her, den er funksjonen selv.

Regnestykket fra `x0 = (1, 0)`:

`g = (6 - 0 + 8, -1 + 0 - 9) = (14, -10)`.

Løs `H d = g`: `d1 = (14*4 - (-1)(-10))/23 = 46/23 = 2`,
`d2 = (6(-10) - (-1)(14))/23 = -46/23 = -2`.

`x1 = (1, 0) - (2, -2) = (-1, 2)`.

Kontroll mot det eksakte minimumet: `6x - y + 8 = 0` og `-x + 4y - 9 = 0` gir
`x = -1`, `y = 2`. Samme punkt.

Ved neste test er `norm(g)` null bortsett fra avrundingsstøy i størrelsesorden
`1e-15`, altså godt under `0.0001`, og løkka stopper.

**Svar: `numIterations = 1`.**

Hintet i teksten om at algoritmen ikke nødvendigvis konvergerer gjelder generelt
(Newton kan divergere eller løpe mot et sadelpunkt når `H` ikke er positivt
definitt). I akkurat dette eksempelet gjør den det, og det tar ett steg.
