import socket
import asyncio


async def handle_request(socket):
    event_loop = asyncio.get_event_loop()
    while True:
        message = (await event_loop.sock_recv(socket, 1024)).decode('utf8').rstrip()
        print("Server: recieved:", message)
        if message == "exit":
            print("Server: closing connection")
            socket.close()
            break
        else:
            print("Server: sending:", message)
            await event_loop.sock_sendall(socket, (message + "\r\n").encode("utf-8"))


async def run_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind(('127.0.0.1', 3000))
    server.listen()
    server.setblocking(False)

    event_loop = asyncio.get_event_loop()

    print("Server: waiting for connection")
    while True:
        socket_, address = await event_loop.sock_accept(server)
        print("Server: connection from", address)
        event_loop.create_task(handle_request(socket_))


asyncio.run(run_server())
