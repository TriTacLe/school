#include "commodity.hpp"

const double sales_tax = 0.25;  // 25 % moms

Commodity::Commodity(const std::string &name, int id, double price)
    : name(name), id(id), price(price) {}

std::string Commodity::get_name() const { return name; }
int Commodity::get_id() const { return id; }

double Commodity::get_price() const { return price; }
double Commodity::get_price(double quantity) const { return price * quantity; }

double Commodity::get_price_with_sales_tax(double quantity) const {
    return price * quantity * (1.0 + sales_tax);
}

void Commodity::set_price(double price_) { price = price_; }
