use tokio::io::{AsyncReadExt, AsyncWriteExt};

// For easier error handling one can use https://docs.rs/anyhow/latest/anyhow/

async fn handle_request(
    mut socket: tokio::net::TcpStream,
) -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
    let mut buf = [0; 1024];

    loop {
        let n = socket.read(&mut buf).await?;
        if n == 0 {
            println!("Server: client closed connection");
            return Ok(());
        }
        let message = std::str::from_utf8(buf[0..n].trim_ascii_end())?;
        println!("Server: received: {}", message);

        if message == "exit" {
            println!("Server: closing connection");
            return Ok(());
        }
        socket.write_all(&buf[0..n]).await?
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let listener = tokio::net::TcpListener::bind("127.0.0.1:3000").await?;

    println!("Server: waiting for connection");
    loop {
        let (socket, _) = listener.accept().await?;
        println!("Server: connection from {}", socket.peer_addr()?);

        tokio::spawn(async move {
            if let Err(e) = handle_request(socket).await {
                eprintln!("Server error: {}", e);
            }
        });
    }
}
