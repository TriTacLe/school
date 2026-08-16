// Oving 2 oppgave 1: pointers, addresses and contents.
#include <iostream>

using namespace std;

int main() {
    int i = 3;
    int j = 5;
    int *p = &i;
    int *q = &j;

    // a) print address and content of all four variables
    cout << "a)" << endl;
    cout << "&i = " << &i << ", i = " << i << endl;
    cout << "&j = " << &j << ", j = " << j << endl;
    cout << "&p = " << &p << ", p = " << p << ", *p = " << *p << endl;
    cout << "&q = " << &q << ", q = " << q << ", *q = " << *q << endl;

    // b) run the given block and check against the drawing
    *p = 7;        // i becomes 7
    *q += 4;       // j becomes 9
    *q = *p + 1;   // j becomes 8
    p = q;         // p now points at j
    cout << "b) " << *p << " " << *q << endl;  // 8 8

    return 0;
}
