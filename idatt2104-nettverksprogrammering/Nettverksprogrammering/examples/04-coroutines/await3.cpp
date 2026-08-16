// Awaitable and await

#include <asio.hpp>
#include <iostream>

using namespace std;

asio::io_context event_loop(1); // Create event_loop optimized for running in one thread

asio::awaitable<void> event_loop_main() {
  asio::steady_timer timer1(event_loop, 5s);
  co_await timer1.async_wait(asio::use_awaitable);
  cout << "After 5 seconds" << endl;

  asio::steady_timer timer2(event_loop, 5s);
  co_await timer2.async_wait(asio::use_awaitable);
  cout << "After 10 seconds" << endl;
}

int main() {
  co_spawn(event_loop, event_loop_main, asio::detached);

  event_loop.run(); // Run event_loop in main thread
}
