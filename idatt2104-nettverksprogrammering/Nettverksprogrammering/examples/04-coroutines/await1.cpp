// Callbacks

#include <asio.hpp>
#include <iostream>

using namespace std;

asio::io_context event_loop(1); // Create event_loop optimized for running in one thread

void event_loop_main() {
  auto timer1 = std::make_shared<asio::steady_timer>(event_loop, 5s);
  timer1->async_wait([timer1](const error_code & /*ec*/) {
    cout << "After 5 seconds" << endl;

    auto timer2 = std::make_shared<asio::steady_timer>(event_loop, 5s);
    timer2->async_wait([timer2](const error_code & /*ec*/) {
      cout << "After 10 seconds" << endl;
    });
  });
}

int main() {
  asio::post(event_loop, event_loop_main);

  event_loop.run(); // Run event_loop in main thread
}
