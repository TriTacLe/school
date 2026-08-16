// Fraction class from the lesson, extended in oppgave 1 with subtraction
// against an int on either side (fraction - 5 and 5 - fraction).
#pragma once

#include <iostream>

class Fraction {
public:
    int numerator;
    int denominator;

    Fraction();
    Fraction(int numerator, int denominator);
    Fraction(const Fraction &other) = default;
    void set(int numerator_, int denominator_ = 1);
    Fraction operator+(const Fraction &other) const;
    Fraction operator-(const Fraction &other) const;
    Fraction operator*(const Fraction &other) const;
    Fraction operator/(const Fraction &other) const;
    Fraction operator-() const;
    Fraction operator-(int integer) const;  // fraction - int
    Fraction &operator++();
    Fraction &operator--();
    Fraction &operator+=(const Fraction &other);
    Fraction &operator-=(const Fraction &other);
    Fraction &operator*=(const Fraction &other);
    Fraction &operator/=(const Fraction &other);
    Fraction &operator=(const Fraction &other);
    bool operator==(const Fraction &other) const;
    bool operator!=(const Fraction &other) const;
    bool operator<=(const Fraction &other) const;
    bool operator>=(const Fraction &other) const;
    bool operator<(const Fraction &other) const;
    bool operator>(const Fraction &other) const;

private:
    void reduce();
    int compare(const Fraction &other) const;
};

// int - fraction: cannot be a member, so it is a free function
Fraction operator-(int integer, const Fraction &other);
std::ostream &operator<<(std::ostream &out, const Fraction &fraction);
