// Oving 7 oppgave 1a: test fraction - 5 and 5 - fraction.
#include "fraction.hpp"
#include <iostream>

using namespace std;

int main() {
    Fraction fraction1(1, 2);
    cout << "fraction1 = " << fraction1 << endl;
    cout << "fraction1 - 5 = " << (fraction1 - 5) << endl;
    cout << "5 - fraction1 = " << (5 - fraction1) << endl;

    // the chain from oppgave 1b
    Fraction fraction2(2, 3);
    Fraction c = 5 - 3 - fraction1 - 7 - fraction2;
    cout << "5 - 3 - fraction1 - 7 - fraction2 = " << c << endl;

    return 0;
}
