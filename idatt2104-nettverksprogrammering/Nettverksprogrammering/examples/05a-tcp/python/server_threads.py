import socket
import threading

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(("127.0.0.1", 3000))
server.listen()


def handle_request(socket):
    while True:
        message = socket.recv(1024).decode("utf-8").rstrip()
        print("Server: recieved:", message)

        if message == "exit":
            print("Server: closing connection")
            socket.close()
            break
        else:
            print("Server: sending:", message)
            socket.send((message + "\r\n").encode("utf-8"))


while True:
    print("Server: waiting for connection")
    socket, address = server.accept()
    print("Server: connection from", address)

    threading.Thread(target=handle_request, args=(socket, )).start()
