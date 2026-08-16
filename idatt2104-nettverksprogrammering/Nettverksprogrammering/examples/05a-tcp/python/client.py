import socket

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("Client: connecting")
socket.connect(("127.0.0.1", 3000))

message = "Hello"
print("Client: sending:", message)
socket.send((message + "\r\n").encode("utf-8"))

message = socket.recv(1024).decode("utf-8").rstrip()
print("Client: received:", message)

message = "exit"
print("Client: sending:", message)
socket.send((message + "\r\n").encode("utf-8"))
