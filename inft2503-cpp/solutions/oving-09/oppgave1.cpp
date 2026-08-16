// Oving 9: STL algorithms find_if, equal and replace_copy_if, each with a lambda.
#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

ostream &operator<<(ostream &out, const vector<int> &table) {
    for (int e : table)
        out << e << " ";
    return out;
}

int main() {
    vector<int> v1 = {3, 3, 12, 14, 17, 25, 30};
    vector<int> v2 = {2, 3, 12, 14, 24};
    cout << "v1: " << v1 << endl;
    cout << "v2: " << v2 << endl;

    // a) first element in v1 greater than 15
    auto pos = find_if(v1.begin(), v1.end(), [](int x) { return x > 15; });
    if (pos != v1.end())
        cout << "Foerste element > 15: " << *pos << " (indeks " << (pos - v1.begin()) << ")" << endl;
    else
        cout << "Ingen element > 15" << endl;

    // b) "roughly equal" means the difference is at most 2
    auto roughly = [](int a, int b) { return abs(a - b) <= 2; };
    bool eq5 = equal(v1.begin(), v1.begin() + 5, v2.begin(), roughly);
    cout << "[v1[0..5), v2] omtrent like: " << (eq5 ? "ja" : "nei") << endl;
    bool eq4 = equal(v1.begin(), v1.begin() + 4, v2.begin(), roughly);
    cout << "[v1[0..4), v2] omtrent like: " << (eq4 ? "ja" : "nei") << endl;

    // c) copy v1, replacing every odd number with 100
    vector<int> result(v1.size());
    replace_copy_if(v1.begin(), v1.end(), result.begin(),
                    [](int x) { return x % 2 != 0; }, 100);
    cout << "Oddetall byttet med 100: " << result << endl;

    return 0;
}
