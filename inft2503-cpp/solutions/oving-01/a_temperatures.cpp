// Oving 1a: count temperatures in three intervals, read from user.
// No arrays, no own functions.
#include <iostream>

using namespace std;

int main() {
    const int length = 5;

    int below = 0;   // under 10
    int middle = 0;  // 10 to 20 inclusive
    int above = 0;   // over 20

    cout << "Du skal skrive inn " << length << " temperaturer." << endl;
    for (int i = 0; i < length; i++) {
        double temperature;
        cout << "Temperatur nr " << i + 1 << ": ";
        cin >> temperature;

        if (temperature < 10)
            below++;
        else if (temperature <= 20)
            middle++;
        else
            above++;
    }

    cout << "Antall under 10 er " << below << endl;
    cout << "Antall mellom 10 og 20 er " << middle << endl;
    cout << "Antall over 20 er " << above << endl;

    return 0;
}
