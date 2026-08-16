---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

## Hva er WebSocket?
WebSocket er en kommunikasjonsprotokoll som gir **toveis (full-duplex) kommunikasjon** mellom server og klient over en enkelt TCP-forbindelse. 

WebSocket ble utviklet som et alternativ til HTTP for bruk i nettlesere, fordi nettlesere ikke støtter vanlige TCP-sockets direkte. Med WebSocket kan både server og klient sende data når som helst, uten å vente på en forespørsel fra den andre parten.
## Hvorfor WebSocket? — Forskjellen fra HTTP

| Egenskap              | HTTP                                                                                             | WebSocket                                     |
| --------------------- | ------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| Kommunikasjonsretning | Request-response (halvdupleks)                                                                   | Full dupleks (begge veier samtidig)           |
| Forbindelse           | Ny forbindelse per request (HTTP/1.0), eller vedvarende men fortsatt request-response (HTTP/1.1) | Én vedvarende forbindelse som holdes oppe     |
| Hvem initierer data?  | Kun klienten sender request, server svarer                                                       | Begge sider kan sende data uavhengig          |
| Overhead per melding  | HTTP-headere ved hvert request/response                                                          | Minimal framing (2–14 bytes overhead)         |
| Bruksområde           | Hente dokumenter, API-kall, filopplasting                                                        | Chat, sanntidsoppdateringer, spill, live-data |
**Eksamensklassiker (V22):** "Hva er hovedforskjellen mellom HTTP og WebSocket?" **Svar:** WebSocket utnytter full dupleks kommunikasjon kontinuerlig over TCP, noe som betyr at begge sider kan sende data uten å vente på request fra den andre parten. Forbindelsen holdes oppe etter etablering.
## Handshake — Oppgradering fra HTTP
WebSocket-forbindelsen starter med en vanlig HTTP-forespørsel som ber om å oppgradere til WebSocket. Dette kalles **handshake**.
### Klient sender:
```http
GET / HTTP/1.1
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==
Sec-WebSocket-Version: 13
```
Viktige headere:
- `Upgrade: websocket` — ber om protokolloppgradering
- `Connection: Upgrade` — bekrefter at forbindelsen skal oppgraderes
- `Sec-WebSocket-Key` — en tilfeldig Base64-kodet nøkkel generert av klienten
- `Sec-WebSocket-Version: 13` — versjonen av WebSocket-protokollen
### Server svarer:
```http
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: HSmrc0sMlYUkAGmm5OPpG2HaGWk=
```
Statuskode **101 Switching Protocols** betyr at serveren godtar oppgraderingen.
## Sec-WebSocket-Key og Sec-WebSocket-Accept
Denne mekanismen brukes for å verifisere at serveren faktisk støtter WebSocket (og ikke bare er en tilfeldig HTTP-server).

**Formelen:**
```
Sec-WebSocket-Accept = Base64(SHA1(Sec-WebSocket-Key + "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"))
```
- `258EAFA5-E914-47DA-95CA-C5AB0DC85B11` er en **fast konstant** (magic string) definert i RFC 6455
- Klienten genererer `Sec-WebSocket-Key` og sender den
- Serveren konkatenerer nøkkelen med konstanten, hasher med SHA-1, og Base64-encoder resultatet
- Klienten verifiserer at svaret stemmer — dette bekrefter at serveren forstår WebSocket-protokollen

**Eksempel fra forelesning:**
```
Key = "x3JJHMbDL1EzLkh9GBhXDw=="
Accept = Base64(SHA1("x3JJHMbDL1EzLkh9GBhXDw==" + "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"))
       = "HSmrc0sMlYUkAGmm5OPpG2HaGWk="
```

> **Merk:** Dette er IKKE kryptering eller autentisering. Det er kun en bekreftelse på at serveren forstår WebSocket-protokollen.
## Meldingsformat (WebSocket Frame)
Etter handshake kommuniseres det via **frames** (rammer). Her er strukturen for en enkel melding:
```
81 83 b4 b5 03 2a dc d0 6a
```
### Byte-for-byte forklaring:
**Byte 1 (0x81): Opcode + FIN-bit**
- Binært: `1000 0001`
- Bit 0 (FIN): `1` = dette er siste (eller eneste) fragment
- Bit 4–7 (opcode): `0001` = tekstmelding
- Vanlige opcodes: `0x1` = tekst, `0x2` = binær, `0x8` = close, `0x9` = ping, `0xA` = pong

**Byte 2 (0x83): Mask-bit + lengde**
- Binært: `1000 0011`
- Bit 0 (MASK): `1` = meldingen er maskert
- Bit 1–7: `000 0011` = lengde 3 (bytes)
- For meldinger < 126 bytes angir de 7 minst signifikante bitene lengden direkte
- For lengde 126: de neste 2 bytene angir lengden (16-bit)
- For lengde 127: de neste 8 bytene angir lengden (64-bit)

**Byte 3–6 (maske-nøkkel):** `b4 b5 03 2a`
- 4 bytes som brukes til å av-/maskere meldingsinnholdet

**Byte 7+ (data):** `dc d0 6a`
- De maskerte meldingsbytene
### Maskering og avmaskering
Maskering fungerer som en enkel XOR-operasjon (symmetrisk "kryptering"):
```
avmaskert_byte[i] = maskert_byte[i] XOR maske[i % 4]
```
**Eksempel — avmaskering av første byte:**
```
dc XOR b4 = 68 = 'h'
d0 XOR b5 = 65 = 'e'
6a XOR 03 = 69 = 'i'
→ Meldingen er "hei"
```

**Viktige regler for maskering:**
- **Klient MÅ alltid maskere meldinger** som sendes til server
- **Server skal ALDRI maskere meldinger** som sendes til klient
- Masken er en tilfeldig 4-byte verdi som genereres for hver melding
## Dekoding i kode — JavaScript-eksempel fra forelesning
```javascript
let bytes = Buffer.from([0x81, 0x83, 0xb4, 0xb5, 0x03, 0x2a, 0xdc, 0xd0, 0x6a]);

let length = bytes[1] & 127;      // Maskerer bort MASK-biten, får lengde = 3
let maskStart = 2;                  // Masken starter på byte 2
let dataStart = maskStart + 4;      // Data starter etter 4 maske-bytes

for (let i = dataStart; i < dataStart + length; i++) {
    let byte = bytes[i] ^ bytes[maskStart + ((i - dataStart) % 4)];
    console.log(String.fromCharCode(byte));
}
// Output: h, e, i
```

## C++ implementasjon — WebSocket-server (grunnleggende)
Her er et praktisk eksempel på hvordan du kan implementere en enkel WebSocket-server i C++ med Boost.Asio (eller lignende), relevant for øvinger og prosjekter.
### Handshake-håndtering i C++

```cpp
#include <openssl/sha.h>
#include <string>
#include <sstream>
#include <iomanip>
#include <cstring>

// Base64-encoding (forenklet, bruk gjerne et bibliotek)
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/buffer.h>

std::string base64_encode(const unsigned char* data, size_t len) {
    BIO* b64 = BIO_new(BIO_f_base64());
    BIO* bmem = BIO_new(BIO_s_mem());
    b64 = BIO_push(b64, bmem);
    BIO_set_flags(b64, BIO_FLAGS_BASE64_NO_NL);
    BIO_write(b64, data, len);
    BIO_flush(b64);

    BUF_MEM* bptr;
    BIO_get_mem_ptr(b64, &bptr);
    std::string result(bptr->data, bptr->length);
    BIO_free_all(b64);
    return result;
}

std::string compute_accept_key(const std::string& client_key) {
    // Konstanten fra RFC 6455
    const std::string magic = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";
    std::string combined = client_key + magic;

    // SHA-1 hash
    unsigned char hash[SHA_DIGEST_LENGTH];
    SHA1(reinterpret_cast<const unsigned char*>(combined.c_str()),
         combined.size(), hash);

    // Base64-encode hashen
    return base64_encode(hash, SHA_DIGEST_LENGTH);
}
```
### Lese og avmaskere en WebSocket-frame
```cpp
#include <vector>
#include <cstdint>

struct WebSocketFrame {
    bool fin;
    uint8_t opcode;
    bool masked;
    uint64_t payload_length;
    uint8_t mask_key[4];
    std::vector<uint8_t> payload;
};

WebSocketFrame read_frame(const std::vector<uint8_t>& raw) {
    WebSocketFrame frame;
    size_t pos = 0;

    // Byte 1: FIN + opcode
    frame.fin = (raw[pos] & 0x80) != 0;
    frame.opcode = raw[pos] & 0x0F;
    pos++;

    // Byte 2: MASK + payload length
    frame.masked = (raw[pos] & 0x80) != 0;
    frame.payload_length = raw[pos] & 0x7F;
    pos++;

    // Utvidet lengde
    if (frame.payload_length == 126) {
        frame.payload_length = (raw[pos] << 8) | raw[pos + 1];
        pos += 2;
    } else if (frame.payload_length == 127) {
        frame.payload_length = 0;
        for (int i = 0; i < 8; i++) {
            frame.payload_length = (frame.payload_length << 8) | raw[pos + i];
        }
        pos += 8;
    }

    // Maske-nøkkel (kun hvis maskert)
    if (frame.masked) {
        std::memcpy(frame.mask_key, &raw[pos], 4);
        pos += 4;
    }

    // Payload (avmasker hvis nødvendig)
    frame.payload.resize(frame.payload_length);
    for (uint64_t i = 0; i < frame.payload_length; i++) {
        if (frame.masked) {
            frame.payload[i] = raw[pos + i] ^ frame.mask_key[i % 4];
        } else {
            frame.payload[i] = raw[pos + i];
        }
    }

    return frame;
}
```
### Sende en umaskert melding fra server
```cpp
std::vector<uint8_t> create_text_frame(const std::string& message) {
    std::vector<uint8_t> frame;

    // Byte 1: FIN=1, opcode=0x1 (tekst)
    frame.push_back(0x81);

    // Byte 2+: lengde (umaskert, fra server)
    if (message.size() < 126) {
        frame.push_back(static_cast<uint8_t>(message.size()));
    } else if (message.size() <= 65535) {
        frame.push_back(126);
        frame.push_back((message.size() >> 8) & 0xFF);
        frame.push_back(message.size() & 0xFF);
    } else {
        frame.push_back(127);
        for (int i = 7; i >= 0; i--) {
            frame.push_back((message.size() >> (8 * i)) & 0xFF);
        }
    }

    // Payload (umaskert fra server)
    frame.insert(frame.end(), message.begin(), message.end());
    return frame;
}
```
## WSS — WebSocket Secure
**WSS (WebSocket Secure)** er WebSocket over TLS, akkurat som HTTPS er HTTP over TLS.
- URL-skjema: `wss://` istedenfor `ws://`
- Gir **samme sikkerhet som HTTPS**: kryptering, autentisering via sertifikater, integritetsbeskyttelse
- Handshake skjer over TLS-tunnelen, slik at all WebSocket-trafikk er kryptert

**Eksamensklassiker (V22):** "Hvilken sikkerhet har vi med WSS?" **Svar:** Samme sikkerhet som HTTPS, dvs. HTTP sin bruk av TLS. Dette gir kryptering av data i transitt, autentisering av serveren via sertifikater, og integritetsbeskyttelse mot manipulering.
## Praktisk bruk — Når bør du bruke WebSocket?
**Gode bruksområder:**
- Sanntidskommunikasjon: chat, multiplayer-spill
- Live data-feeds: børskurser, sensordata, satellittdata-oppdateringer
- Samarbeidsverktøy: live-redigering (Google Docs-stil)
- Varslingssystemer: push-notifikasjoner fra server
- IoT: vedvarende forbindelser til enheter

**Når HTTP er bedre:**
- Vanlige API-kall (CRUD-operasjoner)
- Filnedlasting/-opplasting
- Sjeldne forespørsler der overhead av vedvarende forbindelse ikke lønner seg
## Oppsummering for eksamen
1. **WebSocket gir full dupleks** kommunikasjon over TCP — begge sider sender uavhengig
2. **Handshake starter med HTTP** og oppgraderes med `101 Switching Protocols`
3. **Sec-WebSocket-Accept** beregnes med `Base64(SHA1(Key + magic_string))` for å verifisere at serveren støtter WebSocket
4. **Meldingsformat**: Første byte = FIN + opcode, andre byte = MASK + lengde, deretter eventuelt maske-nøkkel og payload
5. **Klient maskerer alltid**, server maskerer aldri
6. **Avmaskering** = XOR med 4-byte maske-nøkkel (symmetrisk)
7. **WSS** = WebSocket over TLS, samme sikkerhet som HTTPS
8. RFC 6455 er standarden

## Øving 6
Client åpner siden
1. HTTP-server leverer HTML-side
2. JS på HTML-siden oppretter websocket til port 3001

Client kobler til websocket på port 3001 (wsServer.listen(3001))
1. handshake ikke gjort enda

 Første data event kommer
 1. Første req er HTTP Upgrade-req
 2. hanshake skjer og beregner accept-nøkkel og sender 101-svar
 3. Client blir registrert og lagt til samling av klienter

Client mottar 101-svar
1. hanshake er gjort og trengs ikke å gjøre igjen for denne klienten (nettleseren)
2. ws.onopen kjøres

Andre data event kommer 
1. Trenger ikke å gjøre handshake
2. Må dekode 
3. Broadcast sender dekodede meldingen til alle klienter som websocket frame

Client mottar frame
1. ws.onmessage kjøres da den kjøres på events

Client kobler fra (nettleser slås av)
1. connection.on("end") kjøres
2. Client fjernes fra klientsamlingen

## See also
- [[idatt2104-moc]]
