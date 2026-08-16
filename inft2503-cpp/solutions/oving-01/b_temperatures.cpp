// Oving 1b: read temperatures from a file into an array, then count.
// read_temperatures is declared before main and defined after main.
#include <fstream>
#include <iostream>

using namespace std;

void read_temperatures(double temperatures[], int length);

int main() {
    const int length = 5;
    double temperatures[length];

    read_temperatures(temperatures, length);

    int below = 0;   // under 10
    int middle = 0;  // 10 to 20 inclusive
    int above = 0;   // over 20

    for (int i = 0; i < length; i++) {
        if (temperatures[i] < 10)
            below++;
        else if (temperatures[i] <= 20)
            middle++;
        else
            above++;
    }

    cout << "Antall under 10 er " << below << endl;
    cout << "Antall mellom 10 og 20 er " << middle << endl;
    cout << "Antall over 20 er " << above << endl;

    return 0;
}

void read_temperatures(double temperatures[], int length) {
    ifstream file("temperatures.txt");
    if (!file) {
        cerr << "Klarte ikke aa aapne temperatures.txt" << endl;
        return;
    }
    for (int i = 0; i < length; i++)
        file >> temperatures[i];
    file.close();
}
