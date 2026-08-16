import socket
import selectors
import types

selector = selectors.DefaultSelector()

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(("127.0.0.1", 3000))
server.listen()
server.setblocking(False)

selector.register(server, selectors.EVENT_READ, data="accept")

print("Server: waiting for connection")
while True:
    events = selector.select(timeout=None)
    for key, mask in events:
        if key.data == "accept":
            socket, address = server.accept()
            print("Server: connection from", address)
            selector.register(socket, selectors.EVENT_READ, data="read")
        else:
            socket = key.fileobj
            if mask & selectors.EVENT_READ:
                message = socket.recv(1024).decode("utf-8").rstrip()
                print("Server: recieved:", message)

                if message == "exit":
                    print("Server: closing connection")
                    selector.unregister(socket)
                    socket.close()
                else:
                    print("Server: sending:", message)
                    socket.send((message + "\r\n").encode("utf-8"))
selector.close()
