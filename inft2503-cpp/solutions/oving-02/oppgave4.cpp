// Oving 2 oppgave 4: fix all syntax errors. Original faulty block:
//   int a = 5;
//   int &b;        // error: a reference must be initialized
//   int *c;
//   c = &b;        // c should point at an int, &b is only valid once b is a real object
//   *a = *b + *c;  // error: a is an int, not a pointer, so *a is invalid; b is not a pointer either
//   &b = 2;        // error: cannot assign to an address
//
// Corrected version below with the reasoning in comments.
#include <iostream>

using namespace std;

int main() {
    int a = 5;
    int b = 0;    // a reference cannot be left uninitialised; here we make b a normal int instead
    int *c;
    c = &b;       // c now legally points at b
    a = b + *c;   // a and b are ints (use their values directly); *c dereferences the pointer
    b = 2;        // assign to the variable, not to its address

    cout << "a = " << a << ", b = " << b << ", *c = " << *c << endl;
    return 0;
}
