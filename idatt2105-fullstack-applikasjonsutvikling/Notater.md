---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## Buzzwords
Composables: js function that incapsles in reactive state and logic that is reusable through components

Bean: object that spring creates and manages inside its container (the applicationContext). How something becomes a bean:
- Annotate the class: `@Component`, `@Service`, `@Repository`, `@Controller`
- or define it in a config method: `@Bean`

Inject: give this class the objects (dependencies) it needs, instead of the class creating them itself with `new`.
- Only inject beans into beans
## Rest
swagger for API dokumentasjon

## Arkitektur, design patterns, og logging
Arkitektur
Design patterns
Rammverk
Bibliotek

3-lags-arkitektur og n-tier

## Springboot
![[Screenshot 2026-02-18 at 23.19.08.png]]![[Screenshot 2026-02-18 at 23.19.22.png]]
Presentasjonslaget: xxxController
- Tar imot svar klientene
- Kaller xxxService for å få utført oppgaver/få tak i data den vil ha
Businesslaget: xxxService, xxxRepo (avhengig av hvordan
man ser det) (og xxxFacade)
- xxxService fungerer som et mellomlag kontrolleren og «resten»
- Kaller xxxRepo for å få tak i data/objekter
- Merk: om vi hadde hatt integrasjon med tredjeparts-systemer, ville disse også ha skjedd her
Persistenslaget: xxxDao, xxxRepo
- Snakker med databasen og foretar mapping mellom ResultSet og VOer
Domeneobjekter/Value Ojects (VO) vil i de fleste tilfeller opprettes nede i en DAO
## Dependency Injection og Spring Boot

## JPA
JpaRepository: interface in Spring Data JPA 
Pagination: splitting data into pages and 
## Hvordan A?
**1. Funksjonalitet – Fungerende full-stack basis**
Dette prosjektet leverer en komplett, fungerende finn.no-klon ("Amazoom") med alle nøkkelfunksjoner som oppgaven krever: annonser med CRUD, kategorier, søk med filtrering (pris, tilstand, kategori, geografisk radius via `ST_Distance_Sphere`), bokmerker, chat mellom kjøper/selger, brukerregistrering med profil, og bildeopplasting via MinIO. De har i tillegg implementert **Vipps-integrasjon** for autentisering — en tredjeparts OAuth-flyt som er godt utover det forventede. DatabaseSeeder sørger for 100+ annonser, 50 brukere og realistisk testdata, noe som gjør at sensor umiddelbart kan teste applikasjonen uten manuelt oppsett. Kartvisning med Mapbox er også på plass. Alt dette tyder på at gruppen prioriterte riktig: først en solid full-stack base, deretter utvidelser.

**2. Kodekvalitet – Cohesion og separasjon**
Backend-koden i Kotlin er organisert etter domenedrevet design (DDD) med tydelige avgrensede kontekster: `auth`, `listing`, `bookmark`, `category`, `chat`, og `common`. Hver kontekst har sitt eget sett med entity, DTO, mapper, repository, service og controller. Dette gir høy kohesjon og lav kobling. Mapper-klasser (f.eks. `ListingMapper`) sørger for ren separasjon mellom entiteter og DTOer. Services har tydelig ansvar med KDoc-dokumentasjon på alle metoder. `ListingSpecification` viser avansert bruk av JPA Specifications med composable filtre — veldig rent og vedlikeholdbart. Frontend bruker Pinia for state management, typesikker API-klient generert fra OpenAPI-skjema (`openapi-fetch` + `schema.d.ts`), og Zod + VeeValidate for validering.

**3. Arkitektur og design**
Arkitekturen er gjennomtenkt. Backend følger en lagdelt arkitektur med controller → service → repository. Frontenden har en klar mappestruktur med `views`, `components/ui` (eget gjenbrukbart komponentbibliotek med shadcn/reka-ui), `stores`, `lib/api`, og `i18n`. De har laget arkitekturdiagrammer (Backend-overview.png, DB-ERD.png, Vipps-Auth-Flow.png) som viser at de har planlagt designet. Docker Compose orkestrerer hele stacken (app, MySQL, MinIO) med helsesjekker og riktige avhengigheter. Multi-stage Dockerfile med separate byggesteg for frontend og backend gir en slank produksjonsimage.

**4. Sikkerhet (OWASP)**
Sikkerheten er solid implementert. JWT-basert stateless autentisering med `JwtAuthFilter`, BCrypt passordhashing, rollebasert tilgangskontroll (ROLE_USER, ROLE_ADMIN) med `@PreAuthorize`-annotasjoner på metode-nivå (f.eks. `@PreAuthorize("hasRole('ADMIN') or @listingService.isListingOwner(#id, authentication.name)")`). Input-validering med Jakarta Validation på DTOer. CORS er konfigurert strengt for utviklingsmiljøet. Frontend har route guards som sjekker autentisering og admin-rolle. Automatisk token-refresh og redirect til login ved 401-respons. DOCS.md inneholder en grundig gjennomgang av sikkerhetstiltakene.

**5. Universell utforming**
Frontend bruker vue-i18n med norsk og engelsk oversettelse (lokalisering). Komponentbiblioteket er bygget på Reka UI (headless komponentbibliotek) som gir god tilgjengelighet (ARIA) ut av boksen. Bruken av semantiske HTML-elementer og `role`-attributter i E2E-testene (f.eks. `page.getByRole('link')`) antyder fokus på tilgjengelighet.

**6. Testing**
Her leverer prosjektet bredt. **Backend**: 15 testfiler med en blanding av unit-tester (med Mockito) og integrasjonstester (`@SpringBootTest` + `MockMvc` + H2 in-memory database). Testene dekker alle domener: listing, bookmark, category, auth. Unit-testene tester forretningslogikk (happy path + edge cases som `CategoryNotFoundException`, `ListingNotFoundException`, eiersjekk). Integrasjonstestene tester hele endepunktsflyten med reell JWT-autentisering. **Frontend**: 8 unit-tester for UI-komponenter (Vitest + Vue Test Utils) pluss 5 E2E-tester med Playwright som tester hjemmeside, søk, produktvisning og komponentbiblioteket. Det er en TestConfig og MockedMinIOService for å isolere tester fra eksterne avhengigheter.

**7. Test coverage**

Oppgaven krever minst 50%. Med 15 backend-testfiler som dekker alle domenene (listing, bookmark, category, auth) med både unit- og integrasjonstester, pluss 8 frontend unit-tester og 5 E2E-tester, er dette sannsynligvis godt over kravet. Mangelen på en eksplisitt JaCoCo-plugin i `build.gradle.kts` er en liten svakhet — det hadde gjort det enklere å dokumentere dekning kvantitativt.

**8. CI/CD**

GitHub Actions CI-pipeline med tre separate jobber: `build-backend` (Gradle build som inkluderer tester), `build-frontend` (pnpm build med type-checking), og `lint-frontend` (ESLint + oxlint). Pipeline kjøres på push til main og alle pull requests. Dette viser at CI/CD ble aktivt brukt under utviklingen.

**9. Prosjektstruktur**

Meget ryddig. Monorepo med backend i rot (`src/`) og frontend i `frontend/`. Tydelig separasjon med egne `.gitignore`, `.env.example`, og README-filer for frontend. Backend-pakkestrukturen følger DDD med domene-per-pakke. Frontend har en logisk struktur med `views`, `components/ui`, `stores`, `lib/api/queries`. Flyway-migreringer for databaseskjema. `justfile` for oppgaveautomatisering.

**10. Dokumentasjon**

README.md dekker oppsett, kjøring (Docker og lokalt), testing, bygging og API-dokumentasjon. DOCS.md er en grundig teknisk dokumentasjon på norsk som beskriver arkitektur, DDD-implementasjon, OWASP-sikkerhet, autentiseringsflyt (inkl. Vipps), databasedesign og distribusjonsarkitektur — alt med diagrammer. OpenAPI/Swagger-dokumentasjon er tilgjengelig på `/docs.html` (Scalar) og `/swagger-ui.html`. Frontend har egen DEV-NOTES.md. `.env.example` gjør det enkelt for sensor å komme i gang. DatabaseSeeder gir testdata automatisk.

**11. Prosjektpresentasjon**

Video er nevnt i oppgaven men finnes ikke i zip-filen (leveres separat).

---

**Oppsummering: Hvorfor A?**

Prosjektet treffer på _alle_ vurderingskriteriene — det er nettopp det "Merk1" i oppgaven fremhever som viktig. Gruppen har ikke bare laget mye funksjonalitet, men har gjort det med konsekvent høy kvalitet gjennomgående. Spesielt imponerende er:

1. **Helhetligheten** — alt henger sammen: Docker-compose one-liner for å kjøre hele stacken, automatisk testdata, API-docs, diagrammer.
2. **Vipps-integrasjonen** — en reell tredjeparts OAuth-flyt som viser at de går utover det forventede.
3. **Avansert søk** — JPA Specifications med geografisk radius-søk (`ST_Distance_Sphere`), kartvisning med Mapbox.
4. **Kodekvaliteten** — DDD-struktur, typesikker API-klient generert fra OpenAPI, clean mappers, proper exception handling med dedikerte exception handlers per domene.
5. **Testing i bredden** — unit, integrasjon og E2E, med mocked dependencies og realistisk testoppsett.
6. **Internasjonalisering** — norsk og engelsk støtte.

De få svakhetene (manglende JaCoCo-rapport, CSRF disabled uten dokumentert begrunnelse utover stateless JWT, noen E2E-tester som er litt overfladiske med `test.skip()` fallbacks) er små nok til å ikke trekke ned fra A-nivå. Totalinntrykket er et "særdeles godt" og helhetlig prosjekt som demonstrerer modenhet i fullstack-utvikling.

## See also
- [[idatt2105-moc]]
