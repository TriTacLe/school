import net from 'net';

const server = net.createServer((socket) => {
  console.log('Server: connection from', socket.address());

  socket.on('data', (data) => {
    const message = data.toString().substring(0, data.length - 2);
    console.log('Server: received:', message);

    if (message == 'exit') {
      console.log('Server: closing connection');
      socket.end();
    } else {
      socket.write(message + '\r\n', (error) => {
        if (!error) console.log('Server: sent: ' + message);
      });
    }
  });

  socket.on('end', () => {
    console.log('Server: client closed connection');
  });

  server.on('error', (error) => {
    console.log('Server: error:', error);
  });
});

server.listen(3000, '127.0.0.1');
console.log('Server: waiting for connection');
