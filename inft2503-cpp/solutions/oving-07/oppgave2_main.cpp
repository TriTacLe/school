// Oving 7 oppgave 2: test the Set class.
#include "set.hpp"
#include <iostream>

using namespace std;

int main() {
    Set a;
    a.add(1);
    a.add(4);
    a.add(3);
    a.add(4);  // duplicate, ignored
    cout << "a = " << a << endl;

    Set b;
    b.add(4);
    b.add(7);
    cout << "b = " << b << endl;

    Set c = a + b;  // union: {1, 4, 3, 7}
    cout << "a + b = " << c << endl;

    return 0;
}
