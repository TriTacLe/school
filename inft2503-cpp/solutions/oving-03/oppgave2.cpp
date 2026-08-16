// Oving 3 oppgave 2: the given client with the blanks filled in.
#include <iostream>

using namespace std;

const double pi = 3.141592;

class Circle {
public:
    Circle(double radius_);
    int get_area() const;
    double get_circumference() const;

private:
    double radius;
};

Circle::Circle(double radius_) : radius(radius_) {}
int Circle::get_area() const { return pi * radius * radius; }
double Circle::get_circumference() const { return 2.0 * pi * radius; }

int main() {
    Circle circle(5);
    int area = circle.get_area();
    cout << "Arealet er lik " << area << endl;
    double circumference = circle.get_circumference();
    cout << "Omkretsen er lik " << circumference << endl;
    return 0;
}
