---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

https://gitlab.com/ntnu-tdat2004/udp-tls-examples/-/tree/master?ref_type=heads
## UDP
```cpp
#include <asio.hpp> // nettverk, async I/O, sockets
#include <iostream>
#include <thread>

using namespace std;

// Max størrelse på UDP melding
const size_t max_udp_message_size = 0xffff - 20 - 8; // 16 bit UDP length field - 20 byte IP header - 8 byte UDP header



class EchoServer {
// Felt: Serveren har en UDP socket
  asio::ip::udp::socket socket;

public:
// Konstruktør: binder socket til port 3000. 
  EchoServer(asio::io_context &io_context) : socket(io_context, asio::ip::udp::endpoint(asio::ip::udp::v6(), 3000)) {} //udp::v6 betyr IPv6

// handle_request(): sender svar til client. Tar imot endpoint og message, sender message til samme klient med async_send_to()
  asio::awaitable<void> handle_request(asio::ip::udp::endpoint endpoint, string message) {
  
    // co_await venter til async sending er ferdig
    try {
      co_await socket.async_send_to(asio::buffer(message, message.length()), endpoint, asio::use_awaitable);
      cout << "Server: sent: " << message
           << ", to " << endpoint.address() << ":" << endpoint.port() << endl;
    } catch (const std::exception &e) {
      cerr << "Server error: " << e.what() << endl;
    }
  }

// server "main"
  asio::awaitable<void> start() {
    // Midlertidig lagring for innkommende UDP-pakke
    char buffer[max_udp_message_size];
    // evig løkke (serveren kjører hele tiden)
    for (;;) {
      try {
        asio::ip::udp::endpoint endpoint;
        // venter på UDP pakke og lagre data i buffer, fyller avsender adresse/port. Returnerer antall bytes mottatt.
        auto bytes_transferred = co_await socket.async_receive_from(asio::buffer(buffer, max_udp_message_size), endpoint, asio::use_awaitable);
		// lager string av mottatte bytes
        auto message = string(buffer, bytes_transferred);
        // logging
        cout << "Server: received: " << message
             << ", from " << endpoint.address() << ":" << endpoint.port() << endl;
		
		// Coroutine for å sende svar. Formål: sever kan motta nye pakker samtidig sende svar på gamle pakker
        co_spawn(socket.get_executor(), handle_request(std::move(endpoint), std::move(message)), asio::detached);
      } catch (const std::exception &e) {
        cerr << "Server error: " << e.what() << endl;
      }
    }
  }
};

// Client sender en melding og venter på svar
class EchoClient {
public:
  // henter executor asio sin motor for å kjøre async ops i riktig op_context
  asio::awaitable<void> start() {
    auto executor = co_await asio::this_coro::executor;
    // lager client-socket. Binder til IPv6 og port 0 (betyr velg ledig port - vanlig for client)
    asio::ip::udp::socket socket(executor, asio::ip::udp::endpoint(asio::ip::udp::v6(), 0));

    // Resolve host (DNS-lookup if needed): slår opp localhost og port 3000, får en liste med mulige adresser, tar første treff. Resultatet er serverens adresse + port.
    auto endpoint = (co_await asio::ip::udp::resolver(executor)
                         .async_resolve(asio::ip::udp::v6(), "localhost", to_string(3000), asio::use_awaitable))
                        .begin()
                        ->endpoint();

    std::string message("hello");
    auto bytes_transferred = co_await socket.async_send_to(asio::buffer(message, message.length()), endpoint, asio::use_awaitable);
    cout << "Client: sent: " << message
         << ", to " << endpoint.address() << ":" << endpoint.port() << endl;

	// Mottar svar fra sender, svar i UDP
    char buffer[max_udp_message_size];
    bytes_transferred = co_await socket.async_receive_from(asio::buffer(buffer, max_udp_message_size), endpoint, asio::use_awaitable);
    cout << "Client: received: " << string(buffer, bytes_transferred)
         << ", from " << endpoint.address() << ":" << endpoint.port() << endl;
  }
};

int main() {
  // Provides asynchronous I/O functionality
  asio::io_context event_loop(1);

  EchoServer echo_server(event_loop);
  co_spawn(event_loop, echo_server.start(), asio::detached);

  EchoClient echo_client;
  co_spawn(event_loop, echo_client.start(), asio::detached);

  event_loop.run();
}

```

## TLS
```cpp
#include <asio.hpp>
#include <asio/ssl.hpp>
#include <iostream>
#include <thread>

using namespace std;

class EchoServer {
  asio::awaitable<void> handle_request(asio::ssl::stream<asio::ip::tcp::socket> socket) {
    try {
      co_await socket.async_handshake(asio::ssl::stream_base::server, asio::use_awaitable);
      cout << "Server: handshake successful" << endl;

      std::string buffer;
      for (;;) {
        auto bytes_transferred = co_await asio::async_read_until(socket, asio::dynamic_buffer(buffer), "\r\n", asio::use_awaitable);
        auto message = buffer.substr(0, bytes_transferred - 2); // Strip \r\n at end of buffer
        cout << "Server: received: " << message << endl;
        // Close socket when "exit" is retrieved from client
        if (message == "exit") {
          cout << "Server: closing connection" << endl;
          // Connection is closed when socket is destroyed
          co_return;
        }
        bytes_transferred = co_await asio::async_write(socket, asio::buffer(buffer), asio::use_awaitable);
        cout << "Server: sent: " << message << endl;

        // Keep additional bytes from asio::async_read_until after \r\n if any
        buffer.erase(0, bytes_transferred);
      }
    } catch (const std::exception &e) {
      cerr << "Server error: " << e.what() << endl;
    }
  }

public:
  asio::awaitable<void> start() {
    try {
      auto executor = co_await asio::this_coro::executor;
      asio::ip::tcp::acceptor acceptor(executor, {asio::ip::tcp::v6(), 3000});

      cout << "Server: waiting for connection" << endl;
      asio::ssl::context ssl_context(asio::ssl::context::tlsv13_server);
      ssl_context.use_certificate_chain_file("server.crt");
      ssl_context.use_private_key_file("server.key", asio::ssl::context::pem);
      for (;;) {
        asio::ssl::stream<asio::ip::tcp::socket> socket(co_await acceptor.async_accept(asio::use_awaitable), ssl_context);
        cout << "Server: connection from " << socket.lowest_layer().remote_endpoint().address() << ':' << socket.lowest_layer().remote_endpoint().port() << endl;

        co_spawn(executor, handle_request(std::move(socket)), asio::detached);
      }
    } catch (const std::exception &e) {
      cerr << "Server error: " << e.what() << endl;
      exit(0);
    }
  }
};

class EchoClient {
public:
  asio::awaitable<void> start() {
    auto executor = co_await asio::this_coro::executor;
    asio::ip::tcp::resolver resolver(executor);

    // Resolve host (DNS-lookup if needed)
    auto resolver_results = co_await resolver.async_resolve("localhost", to_string(3000), asio::use_awaitable);

    asio::ssl::context ssl_context(asio::ssl::context::tlsv13_client);
    ssl_context.set_verify_mode(asio::ssl::verify_none);
    asio::ssl::stream<asio::ip::tcp::socket> socket(executor, ssl_context);
    co_await asio::async_connect(socket.lowest_layer(), resolver_results, asio::use_awaitable);
    cout << "Client: connected" << endl;

    co_await socket.async_handshake(asio::ssl::stream_base::client, asio::use_awaitable);
    cout << "Client: handshake successful" << endl;

    std::string message("hello");
    auto bytes_transferred = co_await asio::async_write(socket, asio::buffer(message + "\r\n"), asio::use_awaitable);
    cout << "Client: sent: " << message << endl;

    std::string buffer;
    bytes_transferred = co_await asio::async_read_until(socket, asio::dynamic_buffer(buffer), "\r\n", asio::use_awaitable);
    message = buffer.substr(0, bytes_transferred - 2); // Strip \r\n at end of buffer
    cout << "Client: received: " << message << endl;

    message = "exit";
    bytes_transferred = co_await asio::async_write(socket, asio::buffer(message + "\r\n"), asio::use_awaitable);
    cout << "Client: sent: " << message << endl;
  }
};

int main() {
  // Provides asynchronous I/O functionality
  asio::io_context event_loop(1);

  EchoServer echo_server;
  co_spawn(event_loop, echo_server.start(), asio::detached);

  EchoClient echo_client;
  co_spawn(event_loop, echo_client.start(), asio::detached);

  event_loop.run();
}
```
`openssl req`brukes for å lage sertifikat forespørsler og kan også lage self-signed sertifikater
```sh
openssl req -x509 -newkey rsa:2048 -nodes \
  -keyout server.key -out server.crt -days 365 \
  -subj "/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"
```
## Øving 4
### UDP 
**UDP-egenskaper:** UDP er en forbindelse-løs datagramprotokoll: ingen garanti for levering, rekkefølge eller duplikatfrihet. Retningslinjene for UDP-bruk sier eksplisitt at applikasjoner må ta hensyn til bl.a. pålitelighet, pakkestørrelser og egen congestion control.
**Design**
- En UDP-req inneholder begge vektorer
- Server svarer med svar eller feilmelding
- Idempotens via `request_id`, så client kan retry uten å skade (server kan cache svar)

**To approach**
- Binær format: mest utnyttelse av MTU (flest tall per pakke).
- Tekst format: lett å implementere, nyttig for feilsøking og logging, lesbart. Ta mye plass og krever mer robust parsing

Struktur:
- UDP server: Lag UDP-socket bundet til port, tar imot en UDP pakke med to vektorer, beregner dot produkt og sender svar tilbake som res.
- UDP client: lager UDP-socket, pakken med to vektorer, finn og sender til server, mottar svar, printer resultat

Konsepter:
- UDP socket
- endpoint
- Async receive and send
- Coroutine
- io_context (event loop)
- buffer

### TLS
Lag SSL context
Laster inn certificate + privat key
```bash
openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -nodes
```
wrapper socket med tls

## See also
- [[idatt2104-moc]]
