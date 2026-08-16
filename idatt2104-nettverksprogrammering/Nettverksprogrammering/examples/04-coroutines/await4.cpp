// Awaitable and await

#include <asio.hpp>
#include <iostream>

using namespace std;

asio::io_context event_loop(1); // Create event_loop optimized for running in one thread

asio::awaitable<int> get_answer() {
  // Simulate heavy work
  asio::steady_timer timer(event_loop, 5s);
  co_await timer.async_wait(asio::use_awaitable);
  co_return 42;
}

/// Using co_await to get a result asynchronously
asio::awaitable<void> event_loop_main() {
  auto answer = co_await get_answer();
  cout << answer << endl;
}

int main() {
  co_spawn(event_loop, event_loop_main, asio::detached);

  event_loop.run(); // Run event_loop in main thread
}
