## Hvordan bruke kunstig intelligens (KI)?
Kilde: Canvas, KJ1004, modul "Start her / Praktisk informasjon"

Verktøy som ChatGPT, Claude og Gemini kan være gode støtteressurser for å lære kjemi, men bare hvis du bruker dem riktig. Hvis du bruker KI til å bare gi deg fasiten på oppgaver, lærer du ingenting (og på obligatoriske oppgaver vil dette regnes som fusk). Vi vet ennå ikke sikkert hvordan KI-bruk påvirker læring, men tidlige studier antyder at det å «outsource» selve tenkingen til KI (såkalt kognitiv avlastning) kan svekke både læring og evnen til kritisk vurdering over tid. Det å streve litt med et problem bygger forståelse! Bruk derfor KI til å utfordre deg, ikke til å tenke for deg. Du kan for eksempel bruke KI til å sjekke dine egne utregninger og argumentasjon, eller instruere maskinen til å opptre som din egen læringsassistent (be den stille deg spørsmål, gi hint i stedet for svar, og påpeke hull i forståelsen din).

Under finner du noen ferdige prompter (instrukser) du kan kopiere rett inn i et KI-verktøy. Disse hjelper deg å bruke KI til å lære, ikke bare til å få svar. For informasjon om tilgang til NTNUs trygge KI-tjenester, [se nederst på siden](#viktig-om-ki). Du kan lese mer om KI på NTNUs sider om [Hvordan bruke kunstig intelligens som student?](https://i.ntnu.no/hvordan-bruke-kunstig-intelligens-som-student)

### 1. Øv med en tilpasset quiz

Denne prompten gjør om KI-en til en adaptiv quiz-mester. Den vil gi deg ett spørsmål av gangen, og hvis du svarer feil, vil den ikke bare si «feil», men forklare hvorfor du tenkte feil basert på typiske misoppfatninger i kjemi. (Prompten er på engelsk fordi det ofte gir mer presise instruksjoner til KI-en. Selve quizen kommer på norsk.)

Kopier teksten i boksen under og lim den inn i KI-en:

    You are an adaptive general-chemistry tutor running a diagnostic for a first-year university student. STOP. Do not start the quiz yet. Your job is to expose what the student does and does not understand, and turn every wrong answer into a teaching moment. Generate exactly ONE multiple-choice question per turn, calibrated to the requested topic and difficulty (1 = recall, 3 = core single-step, 5 = rigorous/synthesis), and aimed at the student's current weak spots. Use exactly 4 options with one correct; each distractor must embody a real common misconception (sign errors, unit confusion, reversed ratios, mixed-up trends), not random noise. Per-option feedback addresses the specific misconception behind that choice; the explanation teaches the reasoning in 2–4 sentences. Don't repeat asked stems. Use plain-text Unicode notation (H₂O, Na⁺, →, ⇌, Δ), never LaTeX.

    Important:

    1. Translate your persona and all interactions into Norwegian.

    2. Wait for the student to provide the topic and difficulty level before generating the first question. Do not generate the first question until the user has provided the topic and difficulty.

### 2. Feilsøk egne utregninger (når du står fast)

Sitter du med en regneoppgave og fasiten sier noe helt annet enn det du får? Du kan be KI-en løse oppgaven for deg og forklare stegene, men en variant du kan lære mye mer av, er å be KI-en forklare deg hvor din egen logikk sviktet.

Kopier teksten i boksen under, fyll inn din info, og lim inn i KI-en:

    Her er oppgaveteksten: **[Lim inn oppgaven her]**

Her er min utregning og mitt svar så langt: **[Skriv eller lim inn det du har gjort]**

Jeg får feil svar. IKKE gi meg hele fasiten eller den riktige utregningen ennå. Opptre som en veileder og pek nøyaktig på i hvilket trinn logikken min eller regnestykket mitt svikter. Gi meg et hint slik at jeg kan prøve å rette opp feilen selv.

### 3. Oppsummer og sjekk egne notater

I stedet for å be KI oppsummere «forelesningen om termokjemi», gjør det hele mer målrettet og be den gå gjennom dine egne notater med deg. Da kan du unngå at KI finner på innhold og samtidig få hjelp til repetisjon, struktur og å finne hull i forståelsen.

Kopier teksten i boksen under, fyll inn din info, og lim inn i KI-en:

    Her er notatene mine fra en forelesning i generell kjemi: **[Lim inn notatene dine]**

Lag en kort, strukturert oppsummering med de viktigste begrepene og sammenhengene. Pek deretter på hva som virker uklart eller ufullstendig i notatene mine, og still meg tre kontrollspørsmål jeg bør kunne svare på hvis jeg har forstått stoffet. Ikke finn på innhold som ikke står i notatene mine.

### 4. Forbered deg før forelesningen

Har du fått oppgitt tema eller notater før forelesningen? La KI lage en kort oversikt og noen spørsmål å lytte etter, så du møter bedre forberedt.

Kopier teksten i boksen under, fyll inn din info, og lim inn i KI-en:

    Tema/forhåndsnotater for neste forelesning: **[Lim inn tema, kapittel i læreboka, eller utdelte notater]**

Jeg skal snart på forelesning om dette. Gi meg en kort oversikt (maks 10 punkter) over de viktigste begrepene jeg kommer til å møte, forklart enkelt. List deretter opp 3–4 spørsmål jeg bør prøve å få svar på i løpet av forelesningen. Hold deg til temaet jeg har limt inn over – ikke legg til stoff som ikke hører hjemme her. Bruk vanlig tekst-notasjon (H₂O, Na⁺, →, ⇌, Δ), ikke LaTeX.

### 5. Få forklart et fenomen på tre nivåer

En god måte å bygge forståelse på er å be om en forklaring på de tre nivåene vi bruker gjennom hele emnet: makroskopisk, mikroskopisk (partikkelnivå) og symbolsk.

Kopier teksten i boksen under, fyll inn fenomenet, og lim inn i KI-en:

    Forklar **[skriv inn fenomen, f.eks. hvorfor bordsalt løses i vann]** på tre nivåer: 1) makroskopisk (det vi ser og måler), 2) partikkelnivå (hva atomene og molekylene gjør), og 3) symbolsk (formler og likninger). Hold forklaringen på nivå med et innføringskurs i generell kjemi, og bruk vanlig tekst-notasjon (H₂O, Na⁺, →, ⇌, Δ), ikke LaTeX.

### 6. Forklar selv og få tilbakemelding

Den beste testen på om du har forstått noe, er å forklare det med egne ord. Her snur du rollene fra forrige prompt: du forklarer, og KI-en vurderer forklaringen din og hjelper deg å forbedre den (med hint, ikke fasit).

Kopier teksten i boksen under, fyll inn din info, og lim inn i KI-en:

    Jeg skal teste min egen forståelse i generell kjemi. Be meg først forklare **[skriv inn begrep eller fenomen, f.eks. hvorfor ionebindinger dannes]** med egne ord, som om jeg forklarte det for en medstudent.

    Når jeg har svart: Vurder forklaringen min. Pek på hva som er riktig, hva som er upresist, og hva som mangler eller er feil. IKKE gi meg den fullstendige riktige forklaringen. Gi meg i stedet ett hint om gangen, og be meg forbedre forklaringen min. Gjenta dette til forklaringen min er presis og fullstendig – først da kan du oppsummere den endelige versjonen. Hold nivået til et innføringskurs i generell kjemi, og bruk vanlig tekst-notasjon (H₂O, Na⁺, →, ⇌, Δ), ikke LaTeX.

### 💡 Viktig om KI-bruk!

- **Vær kritisk:** KI-en kan «hallusinere» og høres ofte veldig overbevisende ut selv når den tar feil. Er du i tvil om en forklaring: Sjekk læreboken eller spør foreleser/øvingslærer!

- **Ikke lim inn tekst ukritisk i åpne KI-verktøy:** Åpne tjenester kan lagre og gjenbruke det du limer inn. Er du i tvil, bruk NTNUs egne tjenester:

                [Microsoft Copilot:](https://m365.cloud.microsoft/chat?auth=2) Tilgjengelig for studenter når du logger inn med NTNU-kontoen din, og er et tryggere alternativ enn de helt åpne tjenestene.

- [GPT NTNU (gpt.ntnu.no)](https://gpt.ntnu.no/): Logg inn med NTNU-kontoen din (Feide). Kjører på NTNUs og UiOs egne servere.

- **KI er ikke nødvendigvis så flink i regning:** Språkmodeller er eksperter på tekst, og de kan slite med utregninger. Be gjerne KI-en om fremgangsmåten, men kontrollregn alltid tallene selv med kalkulator.

 

[⬅️ Tilbake til Modul-oversikten](https://ntnu.instructure.com/courses/25816/modules/70666)
