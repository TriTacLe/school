# INFT2503 solutions

Drafts for review. Every `.cpp` here compiles clean with `g++ -std=c++17 -Wall -Wextra`
and was run to check output. Norwegian strings keep proper æøå; where an exercise
gives expected output word for word, the program matches it exactly.

Delete any `build/` folder before tarring for Blackboard.

## Status per øving

| Øving | Oppgave | Status | Notes |
|-------|---------|--------|-------|
| 1 | a, b | done | file input via read_temperatures, counts by band |
| 2 | 1, 4, 5, 6 | done | pointers, references, find_sum; teori.md covers opg 2 og 3 |
| 3 | 1, 2, 3, 4 | done | Circle, Commodity (25% moms), std::string exercises |
| 4 | 1 | done | vector front/back/emplace/find |
| 4 | 2 | blocked | gtkmm GUI, needs gitlab ntnu-iini4003/gtkmm-example |
| 5 | 1 | done | King/Knight polymorphism, output matches spec |
| 6 | 1 | done | ChessBoardPrint with std::function callbacks set via lambdas |
| 6 | 2 | blocked | Simple-Web-Server, needs example6 third-party repo |
| 7 | 1 | done | Fraction - int / int - Fraction; teori.md for 1b |
| 7 | 2 | done | Set class (union, add, assign, print) |
| 8 | 1, 2 | done | equal() template + double specialisation, Pair template |
| 9 | a, b, c | done | find_if, equal, replace_copy_if, each with a lambda |
| 10 | - | blocked | needs gitlab ntnu-iini4003/game repo, open-ended |

## Blocked items need from you

- Øving 4 opg2, 6 opg2, 10: external gitlab starter repos not in Canvas. Point me at
  the repo (or clone it locally) and I can finish these.

## Compile commands

- Single file: `g++ -std=c++17 -Wall -Wextra oppgaveN.cpp -o out && ./out`
- Multi-file (øving 3, 7): compile the main together with its .cpp, e.g.
  `g++ -std=c++17 oppgave1_main.cpp fraction.cpp -o out`
