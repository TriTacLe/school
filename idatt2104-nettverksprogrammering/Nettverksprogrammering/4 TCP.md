---
type: area
status: evergreen
created: 2026-03-16
modified: 2026-03-16
tags: []
---

### Server
**Python**
```python
import socket
import asyncio

def handle_request(socket)	
	event_loop = asyncio.get_event_loop()	
	while True:
		message = await event_loop.sock_recv(1024).decode("utf-8).rstrip() // receive
		# message = socket.recv(1024).decode("utf-8").rstrip() 
		if message == "exit":
			socket.close()
			break
		else:
			await event_loop.sock_sendall((message + "\r\n).encode("utf-8))

async def run_server():
	server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	server.bind(("127.0.0.1", 3000))
	server.listen()
	
	event_loop = asyncio.get_event_loop()
	
	while True:
		socket, address = await event_loop.sock_accept(server)
		# socket, address = server.accept()
		event_loop.create_task(handle_request(socket_))
```

```bash
telnet localhost 3000
```
**Javascript**
```javascript
import net from 'net'

const server = net.createServer((socket)=>{
	socket.on('data', (data)=>{
		const message = data.toString().substring(0, data.length -2)
		if (message == 'exit'){
			socket.end()
		}
	})
	socket.on('end', ()=>{
	
	})
	socket.on('error', (error)=>{
	
	})
})

server.listen(3000, '127.0.0.1')
```
Burde bruke mye async await i python. Javascript ikke så farlig bruke dino, men kan bruke async await, men ikke krise om event basert
Cpp og rust bruker async await
Event basert og callback istedenfor async await
### Client
```python
import socket

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket.connect(("127.0.0.1"),3000)

message = "Hello"
print("Client: sending:", messsage)
socket.send(message).encode("utf-8)

message = socket.recv(1024).decode("utf-8").rstrip()
print("Client: received:", message)

message = "exit"
print("Client: sending:", message)
socket.send(message + "\r\n").encode("utf-8")
```

### Web server TCP
```javascript
const net = require("net");

const server = net.createServer((socket) => {
  socket.on("data", (data) => {
    const reqText = data.toString();
    
    // første linje i HTTP request - må parse
    const reqLines = reqText.split("\r\n");
    const [requestLine] = reqLines;
    const [method, path, version] = requestLine.split(" ");

	// routing
    let resBody;
    let statusLine = "HTTP/1.1 200 OK";

    if (method === "GET" && path === "/") {
      resBody = "<h1>/</h1>";
    } else if (method === "GET" && path === "/page1") {
      resBody = "<h1>/page1</h1>";
    } else if (method === "GET" && path === "/page2") {
      resBody = "<h1>/page2</h1>";
    } else {
      statusLine = "HTTP/1.1 404 Not Found";
      resBody = "<h1>fallback til 404 Not Found</h1>";
    }
	
	resHead = statusLine + "\r\n" +
      "Content-Type: text/html; charset=utf-8\r\n" +
      `Content-Length: ${Buffer.byteLength(responseBody)}\r\n` +
      "Connection: close\r\n" +
      "\r\n" +
	
	// send HTTP response
    const httpRes = resHead + resBody;

    socket.write(httpRes);
    socket.end();
  });
});

const PORT = 3000;
const HOST = "127.0.0.1"
server.listen(PORT, HOST, () => {
  console.log(`Server kjører på http://127.0.0.1:${PORT}`);
});
```

## Øving 4
TCP - transportlag
- Data kommer frem i riktig rekkefølge 
- All data kommer garantert
- Pålitelig forbindelse
```python
import socket 

# Opprette socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Socket opsjoner
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,1)

port = 3000
host = "localhost"

server.bind((host, port))
server.listen()

def handle_request(req):
	# Parse req
    lines = req.split("\n") 
    req_line = lines[0]
    method, path, _ = req_line.split()

    status = "HTTP/1.1 200 OK"
	
	# Routing
    if (method != "GET"):
        status = "HTTP/1.1 404 Not Found"
        body = "<h1>Not found </h1>"
    elif path == "/":
        body = "<h1>Path: /</h1>"
    elif path == "/page1":
        body = "<h1>Path; /page1</h1>" 
    elif path == "/page2":
        body = "<h1>Path: /page2</h1>"
    else:
        status = "HTTP/1.1 404 Not Found"
        body = "<h1>Not found </h1>"

    body_bytes = body.encode("utf-8") 
    content_type = "text/html; charset=utf-8" # Definerer type content, nå HTML kode som renders og definerer tegnsett. Andre typer er application/json
    content_len = len(body_bytes) # client (browser) vet når den har mottatt hele respons. Når socket lukkes tror client at forbindelsen er brutt midt overføring
    headers = f"Content-Type: {content_type}\r\nContent-Length: {content_len}"

    # CRLF carriage return + line feed as line terminators. HTTP standard
    res = f"{status}\r\n{headers}\r\n\r\n{body}" 

    return res

def get_connection():
    print(f"Server listenting on host {host} port {port}")
    print(f"running on {host}:{port}")
    
    try:
        while True:
            print("Server: waiting for connection")
            try:
                # client and 3WHS
                client_socket, client_address = server.accept()
                print("Server: connection from ", client_address)
            
                req = client_socket.recv(1024).decode("utf-8").rstrip() # opptil 1024 bytes fra socket, convert (decode) bytes til string
                print(f"Request received: \n{req}")
                    
                if not req:
                    print("Empty?")
                    client_socket.close()
                    continue

                res = handle_request(req)
                client_socket.sendall(res.encode("utf-8")) # send all bytes til client, string til bytes
                
                client_socket.shutdown(socket.SHUT_WR) # venter for at alle data er sent og ACK
                client_socket.close()
                print("Connectio closed")
            except Exception as error:
                print(f"error: {error}")
    except KeyboardInterrupt:
        print("\n\n Server shutting down by ctrl + C")
        server.close()
        print("\n server.close()")

if __name__ == "__main__":
    get_connection()
```

```python
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```
- `socket.AF_INET`: IPv4 adressefamilie
- `socket.SOCK_STREAM`: TCP (stream-basert, pålitelig)
```python
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR,1)
```
- `SO_REUSEADDR`: tillat gjenbruk av port umiddelbart. Uten dette må man vente omtrent 60 sek (TIME_WAIT) før porten kan brukes igjen
- 

## See also
- [[idatt2104-moc]]
