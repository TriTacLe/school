// Oving 3 oppgave 1: corrected Circle class. Errors fixed, one per note.
#include <iostream>

using namespace std;

const double pi = 3.141592;

class Circle {
public:
    Circle(double radius_);            // constructor name must match the class (was "circle")
    int get_area() const;
    double get_circumference() const;

private:                              // "private" needs a colon
    double radius;
};                                    // class definition needs a terminating semicolon

// Implementation of the class Circle
Circle::Circle(double radius_) : radius(radius_) {}  // init the member from the parameter

int Circle::get_area() const {        // declared const, so the definition must be const too
    return pi * radius * radius;
}

double Circle::get_circumference() const {  // return type double was missing
    double circumference = 2.0 * pi * radius;  // circumference must be declared
    return circumference;
}

int main() {
    Circle circle(5);
    cout << "Arealet er lik " << circle.get_area() << endl;
    cout << "Omkretsen er lik " << circle.get_circumference() << endl;
    return 0;
}
