import net from 'net';

const socket = new net.Socket();
socket.connect(3000, '127.0.0.1', () => {
  console.log('Client: connected');

  socket.write('hello\r\n', (error) => {
    if (!error) console.log('Client: sent: hello');
  });
});

socket.on('data', (data) => {
  const message = data.toString().substring(0, data.length - 2);
  console.log('Client: received:', message);

  socket.write('exit\r\n', (error) => {
    if (!error) console.log('Client: sent: exit');
  });
});

socket.on('end', () => {
  console.log('Client: server closed connection');
});

socket.on('error', (error) => {
  console.log('Client: error:', error);
});
