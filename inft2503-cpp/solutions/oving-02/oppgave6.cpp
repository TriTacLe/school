// Oving 2 oppgave 6: sum elements of an array through a pointer.
#include <iostream>

using namespace std;

int find_sum(const int *table, int length);

int main() {
    const int size = 20;
    int table[size];
    for (int i = 0; i < size; i++)
        table[i] = i + 1;  // 1, 2, 3, ... 20

    cout << "Sum of first 10: " << find_sum(table, 10) << endl;       // 55
    cout << "Sum of next 5:   " << find_sum(table + 10, 5) << endl;   // 65
    cout << "Sum of last 5:   " << find_sum(table + 15, 5) << endl;   // 90
    return 0;
}

int find_sum(const int *table, int length) {
    int sum = 0;
    for (int i = 0; i < length; i++)
        sum += table[i];
    return sum;
}
