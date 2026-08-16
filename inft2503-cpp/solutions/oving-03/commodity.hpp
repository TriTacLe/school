#ifndef COMMODITY_HPP
#define COMMODITY_HPP

#include <string>

class Commodity {
public:
    Commodity(const std::string &name, int id, double price);

    std::string get_name() const;
    int get_id() const;

    // price per unit, or for a given quantity, without sales tax
    double get_price() const;
    double get_price(double quantity) const;

    // price for a given quantity including sales tax
    double get_price_with_sales_tax(double quantity) const;

    void set_price(double price);

private:
    std::string name;
    int id;
    double price;  // stored without sales tax
};

#endif
