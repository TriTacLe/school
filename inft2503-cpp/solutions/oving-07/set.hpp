// Oving 7 oppgave 2: an unordered integer set.
#pragma once

#include <iostream>
#include <vector>

class Set {
public:
    Set();                             // empty set
    Set(const Set &other) = default;
    Set operator+(const Set &other) const;  // union
    void add(int value);               // insert if not already present
    Set &operator=(const Set &other);
    friend std::ostream &operator<<(std::ostream &out, const Set &set);

private:
    std::vector<int> elements;
    bool contains(int value) const;
};
