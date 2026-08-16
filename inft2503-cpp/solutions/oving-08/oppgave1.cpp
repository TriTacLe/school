// Oving 8 oppgave 1: an equal() template plus a double specialisation.
#include <cmath>
#include <iomanip>
#include <iostream>

using namespace std;

template <typename Type>
bool equal(Type a, Type b) {
    cout << "[template]" << endl;
    return a == b;
}

// special version for double: equal within a small tolerance
bool equal(double a, double b) {
    cout << "[double]" << endl;
    return fabs(a - b) < 0.00001;
}

int main() {
    cout << "3 == 3: " << equal(3, 3) << endl;
    cout << "3 == 4: " << equal(3, 4) << endl;

    double x = 0.1 + 0.2;  // not exactly 0.3 in floating point
    double y = 0.3;
    cout << setprecision(17);
    cout << "x = " << x << ", y = " << y << endl;
    cout << "x == y: " << equal(x, y) << endl;

    return 0;
}
