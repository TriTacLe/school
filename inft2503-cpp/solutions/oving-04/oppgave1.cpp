// Oving 4 oppgave 1: vector, front/back/emplace and the find() algorithm.
#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<double> numbers = {3.0, 1.5, 9.2, 4.4, 7.7};

    cout << "front(): " << numbers.front() << endl;
    cout << "back():  " << numbers.back() << endl;

    // insert a value right after the first element
    numbers.emplace(numbers.begin() + 1, 42.0);
    cout << "front() etter emplace: " << numbers.front() << endl;

    cout << "vektor naa:";
    for (double n : numbers)
        cout << " " << n;
    cout << endl;

    // search with find()
    double target = 9.2;
    auto it = find(numbers.begin(), numbers.end(), target);
    if (it != numbers.end())
        cout << "fant " << *it << endl;
    else
        cout << target << " fins ikke i vektoren" << endl;

    return 0;
}
