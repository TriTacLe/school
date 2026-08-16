---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

### Atomic typer
**Hvorfor atomic-typer?**
- Flere tråder skal lese og skrive til samme variabel samtidig, får vi normalt race conditions. Vanligvis bruker man mutex, men det er tregt og komplisert. Atomic-typer løser dette ved å gjøre operasjoner på variabelen *atomisk*: Hele operasjonen skjer i "ett steg" uten at andre tråder kan komme i mellom. 

**Funksjoner**
- Bruker `std::atomic<T> 
- Spesielle funksjoner som `compare_exchange_strong()` at vi slipper å bruke mutex selv om vi write/read til state.
- `fetch_sub()

**Referansetelling** 
- Det er en smart måte å håndtere minne på når flere tråder deler objekter:
	- Hver gang noen kopierer pekeren til objektet, øker `count
	- Når noen slutter å bruke objektet, reduseres `count
	- Når `count` når $0$, frigjøres
- `std::shared_ptr`gjør dette automatisk med atomic operasjoner, så det er trådsikkert.

**Referansetelling:** En form for garbage collection der et objekt blir frigjort når det ikke lenger blir brukt
- Brukes i trådprogrammering der en ikke vet i hvilken tråd et objekt brukes for siste gang
- Eksempler: 
	- C++: `std::shared_ptr` 
	- Referansetelling, men ikke trådsikker
- Ikke trådsikker
	- Race condition: 
	- Dobbelt destruksjon
- Trådsikker
	- atomic  
	- fetch_sub: gir et "snapshot" av verdien før vi endret den, så vi kan ta beslutninger basert på konsistent tilstand
### CPU/GPU parallellisering
*Parallellisering:* dele opp en oppgave i flere deler som kan kjøres samtidig i stedet for etter hverandre (sekvensielt)

**Arkirkitekturforskjell**
- *CPU:* 
	- Få kraftige kjerner (4-16stk). 
	- Store cacher (L1, L2, L3)
	- God til komplekse oppgaver
- *GPU:* 
	- Hundrevis/tusenvis av små kjerner. 
	- Optimalisert for enkle operasjon på masse data samtidig (SMID - Single Instruction, Multiple Data)
	- Mindre cache per kjerne
Utviklingen i parallellisering:
1. Manuell threading
	- Tungvint og feilutsatt
2. OpenMP (Open Multi-Processing)
	- Kompilator-direktiv system. Legger til spesielle kommentarer,`#pragma`, i koden, og kompilatoren genererer parallell kode automatisk
3.  
	- `execution::par

**GPU-programmering**
OpenCL
- Må allokere minne på GPU
- Kopiere data fra CPU til GPU
- Skrive "kernel"-kode
- Kopiere resultat tilbake
### Prosesser
Tråder vs Prosesser
- Tråder: deler minne, rask kommunikasjon, en kræsj -> hele programmet kræsjer, lettere å lage bugs (race conditions)
- Prosesser: separate minneområder, tregere kommunikasjon, isolerte kræsj, sikrere

**Hvorfor prosesser?**
- Tenk på en nettleser: hver fane er en egen prosess. Hvis en fane kræsj, påvirker det ikke de andre. Dette er mye sikrere enn tråder

Kommunikasjon med prosesser
- `tiny-process-library


## See also
- [[idatt2104-moc]]
