#include "set.hpp"

using namespace std;

Set::Set() {}

bool Set::contains(int value) const {
    for (int e : elements)
        if (e == value)
            return true;
    return false;
}

void Set::add(int value) {
    if (!contains(value))
        elements.push_back(value);
}

Set Set::operator+(const Set &other) const {
    Set result = *this;
    for (int e : other.elements)
        result.add(e);
    return result;
}

Set &Set::operator=(const Set &other) {
    elements = other.elements;
    return *this;
}

ostream &operator<<(ostream &out, const Set &set) {
    out << "{";
    for (size_t i = 0; i < set.elements.size(); ++i) {
        out << set.elements[i];
        if (i + 1 < set.elements.size())
            out << ", ";
    }
    out << "}";
    return out;
}
