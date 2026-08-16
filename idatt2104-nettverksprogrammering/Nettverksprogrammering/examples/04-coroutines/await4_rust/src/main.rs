async fn get_answer() -> Result<i32, Box<dyn std::error::Error>> {
    // Simulate heavy work
    tokio::time::sleep(std::time::Duration::from_secs(5)).await;
    Ok(42)
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let answer = get_answer().await?;
    println!("{}", answer);
    Ok(())
}
