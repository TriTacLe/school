// Oving 8 oppgave 2: a Pair class template.
// Assumes operator+ and operator> exist for both element types (used
// element-wise for +, and on the element sums for >).
#include <iostream>

using namespace std;

template <typename First, typename Second>
class Pair {
public:
    First first;
    Second second;

    Pair(First first, Second second) : first(first), second(second) {}

    Pair operator+(const Pair &other) const {
        return Pair(first + other.first, second + other.second);
    }

    bool operator>(const Pair &other) const {
        return (first + second) > (other.first + other.second);
    }
};

int main() {
    Pair<double, int> p1(3.5, 14);
    Pair<double, int> p2(2.1, 7);
    cout << "p1: " << p1.first << ", " << p1.second << endl;
    cout << "p2: " << p2.first << ", " << p2.second << endl;

    if (p1 > p2)
        cout << "p1 er størst" << endl;
    else
        cout << "p2 er størst" << endl;

    auto sum = p1 + p2;
    cout << "Sum: " << sum.first << ", " << sum.second << endl;

    return 0;
}
