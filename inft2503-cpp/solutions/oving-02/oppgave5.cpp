// Oving 2 oppgave 5: pointer and reference to a double, three ways to assign.
#include <iostream>

using namespace std;

int main() {
    double number = 0.0;

    double *pointer = &number;   // pointer to number
    double &reference = number;  // reference to number

    // three ways to give number a value
    number = 1.5;        // 1) directly
    *pointer = 2.5;      // 2) through the pointer
    reference = 3.5;     // 3) through the reference

    cout << "number = " << number << endl;      // 3.5
    cout << "*pointer = " << *pointer << endl;   // 3.5
    cout << "reference = " << reference << endl;  // 3.5
    return 0;
}
