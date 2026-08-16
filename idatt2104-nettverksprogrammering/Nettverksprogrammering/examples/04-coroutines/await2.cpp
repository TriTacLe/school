// Callbacks

#include <asio.hpp>
#include <iostream>

using namespace std;

asio::io_context event_loop(1); // Create event_loop optimized for running in one thread

void get_answer(std::function<void(int)> callback) {
  // Simulate heavy work
  auto timer = std::make_shared<asio::steady_timer>(event_loop, 5s);
  timer->async_wait([timer, callback](const error_code & /*ec*/) {
    callback(42);
  });
}

/// Using callbacks to get a result asynchronously
void event_loop_main() {
  get_answer([](int answer) {
    cout << answer << endl;
  });
}

int main() {
  asio::post(event_loop, event_loop_main);

  event_loop.run(); // Run event_loop in main thread
}
