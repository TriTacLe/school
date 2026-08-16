#include <cppcoro/generator.hpp>
#include <iostream>
#include <vector>

using namespace std;
using namespace cppcoro;

/// Regular function (subroutine)
vector<int> fibonacci1(int length) {
  int prevprev = 0, prev = 1;
  vector<int> result;
  if (length > 0)
    result.emplace_back(prevprev);
  if (length > 1)
    result.emplace_back(prev);
  for (int i = 2; i < length; i++) {
    auto current = prevprev + prev;
    result.emplace_back(current);
    prevprev = prev;
    prev = current;
  }
  return result;
}

/// Coroutine example
generator<int> fibonacci2() {
  int prevprev = 0, prev = 1;
  co_yield prevprev;
  co_yield prev;
  while (true) {
    auto current = prevprev + prev;
    co_yield current;
    prevprev = prev;
    prev = current;
  }
}

int main() {
  for (auto num : fibonacci1(13)) {
    cout << num << endl;
  }

  for (auto num : fibonacci2()) {
    cout << num << endl;
    if (num > 100)
      break;
  }
  // The previous for loop is similar to:
  auto generator = fibonacci2();
  for (auto it = generator.begin(); it != generator.end(); it++) {
    cout << *it << endl;
    if (*it > 100)
      break;
  }
}
