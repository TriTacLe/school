// Oving 3 oppgave 4: practice with std::string.
#include <iostream>
#include <string>

using namespace std;

int main() {
    // a) read three words
    string word1, word2, word3;
    cout << "Skriv inn tre ord: ";
    cin >> word1 >> word2 >> word3;

    // b) join with spaces and a full stop
    string sentence = word1 + " " + word2 + " " + word3 + ".";
    cout << "sentence: " << sentence << endl;

    // c) lengths
    cout << "Lengde word1: " << word1.length() << endl;
    cout << "Lengde word2: " << word2.length() << endl;
    cout << "Lengde word3: " << word3.length() << endl;
    cout << "Lengde sentence: " << sentence.length() << endl;

    // d) copy
    string sentence2 = sentence;

    // e) replace characters 10-12 with x, if those positions exist
    if (sentence2.length() > 12) {
        for (int pos = 10; pos <= 12; pos++)
            sentence2[pos] = 'x';
    } else {
        cout << "sentence2 er for kort til aa bytte tegn 10-12" << endl;
    }
    cout << "sentence:  " << sentence << endl;
    cout << "sentence2: " << sentence2 << endl;

    // f) first five characters
    if (sentence.length() >= 5) {
        string sentence_start = sentence.substr(0, 5);
        cout << "sentence:       " << sentence << endl;
        cout << "sentence_start: " << sentence_start << endl;
    }

    // g) does sentence contain "hallo"?
    if (sentence.find("hallo") != string::npos)
        cout << "sentence inneholder \"hallo\"" << endl;
    else
        cout << "sentence inneholder ikke \"hallo\"" << endl;

    // h) all occurrences of "er"
    cout << "Forekomster av \"er\":";
    size_t pos = sentence.find("er");
    while (pos != string::npos) {
        cout << " " << pos;
        pos = sentence.find("er", pos + 1);
    }
    cout << endl;

    return 0;
}
