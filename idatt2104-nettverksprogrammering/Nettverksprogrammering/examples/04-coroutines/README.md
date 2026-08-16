# Coroutines examples

These examples demonstrate stackless [coroutines](https://en.wikipedia.org/wiki/Coroutine) added to
the C++20 standard. Coroutines extends subroutines by in addition having _suspend_ and _resume_
operations.

A more detailed, although slightly outdated, tutorial on coroutines can be found here:
[Coroutines Introduction](https://blog.panicsoftware.com/coroutines-introduction/).

Designing coroutines for C++ was especially hard. The C++20 standardization design principles was as
follows (from https://www.youtube.com/watch?v=j9tlJAqMV7U&t=449s):

- **Scalable** (to billions of concurrent coroutines)
- **Efficient** (resume and suspend operations comparable in cost to a function call overhead)
- Seamless interaction with existing facilities with **no overhead**
- **Open ended** coroutine machinery allowing library designers to develop coroutine libraries
  exposing various high-level semantics, such as generators, goroutines, tasks and more
- **Usable in all environments** where exceptions might be forbidden or not available

Overview of the examples:

- generator.\*: demonstrates the difference between regular functions (subroutine) and coroutines in
  C++ and JavaScript
- await: demonstrates calling asynchronous functions using callbacks and await.
  - await1-2.\* demonstrates callbacks in C++ and JavaScript
  - await3-4.\* demonstrates await in C++ and JavaScript
  - await5-6.js demonstrates promises in JavaScript

## Prerequisites

- MacOS, or Manjaro or another Linux distribution with newer packages

### Dependencies

The examples make use of the following libraries:

- A C++ library for network and low-level I/O programming:
  [Asio C++ Library](https://think-async.com/Asio/)
- Node.js to run JavaScript examples

Run the following commands to install these packages in Manjaro:

```sh
sudo pacman -S asio nodejs
```

## Compile and run

You need to clone this repository using `--recursive`.

Either use juCi++, or from terminal:

```sh
mkdir build
cd build
cmake ..
make
cd ..

# To run for instance generator example:
./build/generator

# To run for instance await1.js example:
node await1.js
```

## Temporary fix of compilation errors

You might need to remove every occurrence of `experimental/` and `experimental::` in
cppcoro/include/cppcoro/generator.hpp.
