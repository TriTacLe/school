---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L04 Selection Process, Golden Measures, Intro to Benchmarking
Outline: selection process and need for benchmarking, golden measures, benchmarking basics and pitfalls, code reviews as industry practice.
### Selection Process and the Need for Benchmarking
**Overview**
- The selection process: selecting parts and other things from which you will build your embedded system
- Important for profit, can reduce production cost so no money wasted on unused features
- Lower non-recurring engineering costs: development cheaper with good tools
- Better reliability and maintainability
**Selection Process**
- Selecting parts and other things from which you will build your embedded system
- Includes choosing processor(s), hardware components, software and code to incorporate and/or code or design aspects to reuse
- A significant part of the embedded design process
- Involves selecting the best software and hardware choices for the required functionality
- Correct selection is critical to profit
- Can greatly lower production costs
- Lower non-recurring engineering costs: development cheaper with good tools
- Better reliability and maintainability
### Golden Measures
**Golden Measure concept**
- A baseline benchmark solution focused on accuracy rather than speed
- Originates from the theory of a gold standard measure: a benchmark available under reasonable conditions, not necessarily a perfect test, but the best available one that has a standard with known results
- Especially important when faced with the impossibility of direct measurements
- Do not confuse with notion of a perfect physical measure (e.g. perfect meter), which is about getting a perfect instance of the thing you want to compare against
- A golden measure in computing can be a solution that may run slowly and is not optimized, but you know it gives numerically excellent results
- Examples: a solution written in MatLab, verified using graphs or exhaustive testing, or checking by hand with calculator, etc.
### Benchmarking Basics
**Benchmarking**
- Benchmarking is the process of measuring performance of a system (an embedded computer system in our case)
- It is a program or systematic approach that quantitatively evaluates performance, cost and hardware and software resources of a computing solution
- Benchmark suite: a set of benchmark programs designed to get a comprehensive view of the performance of a computer system for executing a variety of representative processing operations
**Wall Clock Time**
- Generally the most accurate: use a built-in timer, which is directly related to real time
- Example: if the timer measures 1 second elapsed, then 1 second elapsed in the real world
- Technique: capture start time, do processing, capture end time, output the time measurement (end-start), or save it to an array if printing will interfere with the times
- To avoid overflow, use unsigned variables
**StdC: gettimeofday**
- Very portable, part of the StdC library
- Should be available on any Linux system
- Returns time in seconds and microseconds since midnight January 1 1970
- Uses struct timeval comprising tv_sec (number of seconds) and tv_usec (number of microseconds)
- Converting to microseconds will use huge numbers, rather work on differences
- Word of caution: some implementations always return 0 for the usec field. On Cygwin, the resolution is only in milliseconds, so tv_usec in multiples of 1000. Not provided in DevC++ on Windows
**gettimeofday example**
- Includes: stdio.h, sys/time.h, time.h
- Create struct timeval variables for start and end time
- Call gettimeofday at start and end of code section
- Calculate total time: (end_time.tv_sec - start_time.tv_sec) * 1000000 + (end_time.tv_usec - start_time.tv_usec)
- Print the result in microseconds
**Clock Wrapping**
- Clock wrapping occurs when a counter reaches max and resets to zero
- Problem when using a high-resolution time of limited length that might wrap (go from high value to low value) in the code section timed, assuming unsigned integer is being used
- Solution is doing the time duration calculation using AND or modula: elapsed = (end - start) & MAXINT
- Can use UINT32_MAX = 0xFFFFFFFF for 32-bit uint or uint32_t
### Benchmarking Pitfalls
**The Easiest, Usual Suspects for Benchmarking Software Processor Performance**
- These concepts link to the pracs for this course and also link later to the project
**Pitfalls: What is Wrong About Using Only Wall Clock Time**
- Can provide a false impression of how effective your solution is, or rather more correctly it at least does not give a full picture of performance
- Recommended tips for using wall-clock time:
  - Typically do tests after the system has warmed up (cache loaded) by running the same data multiple times
  - May show the solution is quicker, but at what costs? (e.g. speed improved but accuracy sacrificed, development effort vs. execution speed improvement, resource costs for upgrading vs. costs saved by remaining with the old version, power usage, does the new solution need more power per execution or on average including idle time, maintainability - is the new version more complex, environment impact - does the upgrade result in waste that could be environmentally detrimental)
**Benchmarking: What Can Be Benchmarked**
- For DSPs or embedded micros: compiler, processor, OS, platform, applications
- Compiler: converts high level language to assembly language thus we benchmark compiler efficiency (how efficient is the generated assembly code)
- The processor: code in hand-crafted/inspected assembly (to make comparisons fair)
- Operating system: interrupt latencies, overhead of operating system calls, limits on devices, kernel size, availability of services and facilities such as support for virtual memory and paged memory
- Platform: scalability of memory, peripheral limits, interfaces supported, power use, power saving features, OS's supported
- Applications: (benchmark what your application actually does)
**Benchmarking: What is Usually Measured**
- For embedded and DSP systems we typically benchmark:
  - Cycle count
  - Data and program memory usage
  - Execution time
  - Power consumption (has recently become a common thing to report on)
**Issue #1: Processor Performance**
- This is usually talked about the most, and is often the most important design decision
- Particularly: is the processor/controller/DSP we are planning be fast enough?
- Performance measuring tools are available to analyze this, at least roughly, particularly:
  - MIPS (Million Instructions Per Second)
  - FLOPS (Floating Point MIPS)
  - Dhrystone Benchmark
- Important point to note: processor manufacturer might optimize their toolchains to get better benchmark results using these common tools, so it is usually best to use some more representative tests for your particular application
**Examples of Standard Benchmarks: Dhrystone**
- Developed in 1984 by R. Wecker
- Tests integer performance only
- No I/O, no OS calls, no floating point
- Good for estimating integer performance
- Dhrystone score is the number of times a small program can run per second
- Like all benchmarks, applicability of dhrystone varies (may be totally irrelevant to your specific application)
- Do not get too comfortable using a common very general purpose benchmarking tool like Dhrystone
**Meaningful Benchmarking**
- How will the processor perform with our application?
- Including complex factors: interrupt handling, task switching, memory performance
- Even more important for Real Time applications: context switching time is critical (save registers, change mode, etc.)
**EEMBC (Not Examined)**
- EDN Embedded Micro Benchmark Consortium
- 46 test split into 5 suites: automotive, consumer, networking, office automation, telecommunications
- Advantages: speed and size statistics, tailored to real application domains, well designed, tested and documented
- Disadvantages: expensive
**Running Custom Benchmarks**
- Typically use evaluation boards
  - Save costs of designing support hardware
- Evaluation boards: single board computers
  - Include a selection of common peripherals
- Some manufacturers sell Hot Boards
  - Specifically designed to boost benchmarks
  - Watch out for these boards
**Bad News About Benchmarks**
- Benchmarks do not consider all design factors which have an effect on performance, such as power consumption, physical size, board layout
- Do not rely entirely on benchmark results for processor selection
- Your benchmark results may look high and mighty and sit above the rest of flock, but in reality you might just have seen part of the story; it may spend most time lower down
### Code Review Introduction
**The Code Review**
- An ingredient of a professional engineer
- These are things you should be aware of, and helps with thinking and being prepared for pracs or projects
- In 2024 no EEE3096S project, but is project for EEE3095S
**What is a Code Review**
- It is a practice (e.g. meeting or regular team-link up) of reviewing code developed for a project
- It follows generally a systematic practice (formulate your own initiative method for now)
- It is about managing quality of code and ways to assess this, e.g. consider:
  - How to spot and log any defects
  - How many or common are the defects
  - Methods to use, such as (not necessarily all of these, not necessarily used in every review) are: unit testing, function testing, integration testing, how can this be improved
**Why Mention Code Reviews**
- A best practice, commonly used in industry
- Might also improve the mark you get for assignments
## L05 Compiler Optimization
Outline: essentials of optimizing compilers, three performance optimization invariants, optimizing approaches, some optimizations to know about, GCC compiler optimization flags.
### Compiler Optimization Essentials
**Brief Background to Compiler Optimization**
- Before we discuss the GCC optimization flags, it is appropriate for you to know a little about how an optimizing compiler, such as GCC, works
**Compiler Optimization Essentials (What an Embedded Systems Engineer Should at Least Know of This)**
- GCC is an optimizing compiler
**Inside an Optimizing Compiler**
- Input high-level language (HLL) such as C, C++, Java, Fortran, etc.
- Frontend: parses the HLL
- Intermediate Representation (IR): similar to assembly but may be a bit more high-level and interconnected
  - IR is not planned to be human readable, but planned around capturing more of the semantic characteristic and associations to other program elements that will make it easier to generate optimize code
- Code generator: translates the IR into lower-level / assembly code (note that this lower-level come is sometimes just C, and this is fed into a more basic, non-optimizing compiler)
- Output lower-level language (LLL) such as ARM assembly
**Inside an Optimizing Compiler: The Optimizing Engine**
- The optimizing engine is where the incoming IR is reworked, maintaining data dependences and correct operation, etc., to produce a better optimized IR, possibly using the same or different IR language
- This is then fed into the code generator that translates the revised IR into lower-level / assembly code
- This is where the magic of computer-based automatic optimization happens
**Control Flows (Typical Used With IR)**
- The way the compiler sees or works on your program is typically through the use of control graphs or control flows
- The IR syntax may incorporate the control graph structure
- Basic block: a group of sequential instructions with a single entry point and a single exit point
- Example IR showing how sequential instructions are organized into basic blocks connected by branches
### Three Performance Optimization Invariants
**Three Performance Optimization Invariants**
- You probably know the term invariants (an invariant is a function, quantity, or property which remains unchanged when a specified transformation is applied)
- The three main performance optimization invariants that an optimizing compiler should maintain are the following:
  - Though shalt preserve correctness: the speed of an incorrect program is likely still worse than a slow one that works correctly
  - Though shalt improve performance on average: optimized may be worse than original if unlucky on some pieces but overall it should be better otherwise it is not an optimization
  - Though shalt be worth it: if through the optimizations, the code becomes more fragile, or debugging more difficult, among any other potential drawbacks, then one needs to consider if it is worth it either as a user or as the compiler developer
### Overarching Approach: Minimize NOI and CPI
**Overarching Approach: Minimize NOI and CPI**
- The thing to keep in mind is: execution_time = NOI * CPI
- Where: CPI = cycles per instruction, and NOI = number of instructions
- Fewer cycles per instruction: sequence instructions to avoid dependencies and pipelining (e.g. avoid having the next instruction blocking due to it waiting for a result from the previous instruction), improve cache/memory behaviour (e.g. improving locality, relative addressing, use registers or stack more)
- Fewer instructions: make better use of the available instruction on the target processor (e.g. specialized instructions)
### Optimizing Approaches
**Optimizing Approaches**
- Efficient mapping of program to the architecture
  - Get rid of minor inefficiencies
  - Ensure efficient code selection and ordering
  - Optimize the register allocation (e.g. sometimes it might be better to have more memory accesses in parts if it means other parts, e.g. a loop has less)
- Allow options for programmer to select best overall algorithm (do not optimize out what the programmer is trying to do)
  - When in doubt, compiler must be conservative
### Programmer Responsibilities in Using an Optimizing Compiler
**Dos and Don'ts**
**Responsibility of Programmer: Don't Dos**
- To don't dos:
  - Smash and grab dirty coding: just because your compiler optimizes things, do not write messy code that is woefully inefficient like duplicating lines instead of using a for-loop
  - Do not write nasty difficult to read code
**Responsibility of Programmer (User): To Dos**
- To dos:
  - Write readable and maintainable code (very NB)
  - Select the best algorithm (you know of or can find): some optimizers might be able to do that behind the scenes but rather put in efficient code
  - Use procedures if possible (optimizers are better with this) or recursion
  - Eliminate optimization blockers (i.e. things the optimizer has difficulty understanding and likely will not be able to optimization, even though the larger problem may be obvious to a human)
  - Focus on inner loops (this is usually the crux of the problem and you can rely on the compiler to use things like loop unrolling to optimize the looping)
  - Put some effort into manually optimizations the code, particularly parts executed repeatedly
### Some Optimizations to Know About
**Some Optimizations to Know About**
- This is not a compilers course, so you will not be expected to know much about code optimization techniques
- However, as an embedded systems engineer, there are two things you should know about:
  1. Small Function In-lining (SFI)
  2. Loop Unrolling (LUR)
- These two essential ingredients are among the many strategies used in GCC's optimization level 2 (invoked with the -O2 flag discussed later)
**Small Function In-lining (SFI)**
- Example scenario showing three stages: original code with a function addDC, in-lining of simple functions into main, and further optimizing with dead-code elimination and constant folding
- Main benefits:
  - Code size: can be decreased, and reduce calling overhead, if small procedure body are simply brought into the calling procedure (i.e. 2nd step above)
  - Performance: eliminates call/return overhead, and can expose the potential further for optimizations (see 3rd step above)
  - Tradeoff: can also eat up more instruction memory (trading space for speed)
**Optimization: Loop Unrolling (LUR)**
- Example scenario: original code with a while loop, transformed to loop unrolling where the loop body is repeated and j increments by 2
- Note: the 2nd version has 1/2 the iterations
- Some processors, like ARM, allows the memory address to be added and incremented in one instruction, these instructions are independent so this is better filling up the pipeline with memory reads and writes, that do not depend on each other. This might speed up the loop something like 2x (depending on the pipelining, width of memory bus to cache etc.)
- Main benefits:
  - Reduce looping overhead: fewer adds to update j, and fewer loop condition tests
  - Allows more aggressive instruction scheduling, i.e. more instructions for scheduler to move around
### Controlling Optimizations of the GCC Compiler
**Controlling Optimizations of the GCC Compiler**
- Mainly this is further reading and to experiment with as part of pracs
**GCC Optimization Flags**
- There are a great many options and optimization settings that you can set in GCC, a full list can be seen at: https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
- Essential flags most commonly used:

| Flag | Description |
|------|-------------|
| -g | Include debug information, no optimization |
| -O0 | Default, no optimization |
| -O1 | Do optimizations that do not take too long. Including (look these up if interested): CP (constant propagation), CF (constant folding), CSE (common sub-expression elimination), DCE (dead code elimination), LICM (loop invariant code motion), ISF (in-lining of small functions) |
| -O2 | Take longer optimizing, more aggressive scheduling |
| -O3 | Make space/speed trade-offs: loop unrolling, more in-lining |
| -Os | Optimize program size |

- To use these, simply use e.g.: gcc -O1 main.c -o myprog
## L04X Code Reviews
**Reasons for code review**
- Mitigate challenges of large code base (ES is often large code bases) and sustain quality
- Maintainable code
- Readable code
- Bug-free code
- Exchangeable and portable code
- Managing quality of code
- Average defect detection rate in various testing:
  - Unit test
  - Function/functionality test
  - Integration test: test flow of functions together
  - How can this be improved
- This is important for the aspect of getting products certified/approved and purchased
**Code review practice**
- Constructive review
- May require sign-off from another team member before developer is permitted to merge changes
- Analogy to doing a group project report:
  - Do all the group members understand the purpose and aim of the task
  - Is it well structured?
  - Is the grammar good and spelling checked?
  - Are all the pieces in place? Nothing missing?
  - Are the results and conclusions clear and correct?
**Who, What, When (wowawe)**
- Who is responsible? Who was the original developer? Who is the reviewer?
- What was found/needs review? What suggestions or feedback? Feedback leads to refactoring, followed by a 2nd code review. Eventually code gets approved, archives and development process proceeds
- When is the code checked, due dates, etc. LOC
**Why is code review important**
- Ensures more than one person has seen every piece of code
- The potential of someone reviewing your code
- It forces the authors of the code to explain the decisions clearly
- Help beginner coders/new recruits
  - Learning experience for beginners without degrading quality of main code assets
  - Helps in pairing new employees with appropriate experienced developers
- Encourage members of a large team to interact and know about other parts of the system
- Reduce redundancy
- Enhance overall understanding
- Share responsibility
**Code review variants**
- Inspection: formalized code review with defined roles usually assigned (e.g. author, moderator, reviewer, scribe, etc.), several reviewers often look at the same piece of code to ensure thoroughness, checklist of flaws or issues to look for
- Walkthrough: less formal discussion of code between author and reviewer(s)
- Code reading: reviewer(s) look at code by themselves, possibly without having a formal meeting, maybe just emailing suggestions
**Concluding points on code reviews**
- Used frequently in industry, both in smaller and certainly in massive companies
- Code review regarding this course is quite excessive
