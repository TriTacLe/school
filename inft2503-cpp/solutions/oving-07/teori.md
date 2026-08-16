## Oppgave 1b

`5 - 3 - fraction1 - 7 - fraction2` is read left to right, since binary
`-` is left-associative. It groups as:

`((((5 - 3) - fraction1) - 7) - fraction2)`

Step by step, with the operator version used at each step:

1. `5 - 3` is `int - int`, the built-in integer minus, giving `2`.
2. `2 - fraction1` is `int - Fraction`, so the free function
   `operator-(int, const Fraction&)` runs.
3. `... - 7` is `Fraction - int`, so the member `Fraction::operator-(int)` runs.
4. `... - fraction2` is `Fraction - Fraction`, so the member
   `Fraction::operator-(const Fraction&)` runs.

The free function is needed for step 2 because the left operand is a plain
`int`, which cannot be the object a member function is called on.
