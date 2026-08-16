---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L01 Introduction to Embedded Systems
Outline: changing landscape of computing, industry context, embedded systems definitions, career perspectives, course objectives and content.
### Industry and context
**Changing Landscape of Computing**
- Cloud computing, cognitive computing all push more computing into physical devices.
- Embedded systems increasingly interconnected and autonomous.

**ES Career Outlook**
- Industry 4.0 reshaping workforce expectations for embedded systems professionals.
- Professional embedded systems engineers need breadth: hardware, software, systems thinking, real-time constraints.
- Curriculum focus: both surface learning (breadth of concepts) and deep learning (understanding why).
### Embedded systems definitions
**Definition (Dortmund)**
- A computer built into a larger device for a dedicated function.

**Definition (Berkeley)**
- Information processing embedded in physical systems that interact with the natural world.

**Definition (Brisbane)**
- Integration of computation, control, and communication (3Cs) into physical devices.

**Some Embedded Systems**
Common examples across industries: anti-lock brakes, automatic teller machines, automatic toll systems, automatic transmission, avionic systems, battery chargers, camcorders, cell phones, cordless phones, cruise control, digital cameras, disk drives, electronic card readers, electronic instruments, factory control systems, fax machines, home security systems, life-support systems, medical testing systems, microwave ovens, modems, MPEG decoders, network cards, network switches, pagers, photocopiers, point-of-sale systems, portable video games, printers, satellite phones, scanners, speech recognizers, stereo systems, televisions, temperature controllers, theft tracking systems, VCRs and DVD players, video game consoles, washers and dryers.

**Deciding if it's an Embedded System**
Borders between embedded and non-embedded systems are getting blurred as computing power increases. Traditional deciding factors:
- Task specific: system dedicated to a particular function, not general-purpose.
- Non-standard platform architecture: custom hardware design rather than off-the-shelf PC.
- Limited resources: constrained memory, processing power, or energy.

**Cyber-Physical Systems (CPS)**
- CPS = embedded system + physical environment.
- Computer senses and controls physical processes, so physical time matters: system is correct only if it reacts correctly and on time.

**Related terminology**
- **ES**: embedded system, computer built into larger device for dedicated function.
- **RTS**: real-time system, correctness depends on both result and time of delivery.
- **RTES**: real-time embedded system, the overlap. Most embedded systems are real-time to some degree.
### Team structures and ecosystems
**Development team organizations**
- Centralized: specialists (hardware, firmware, software) work in separate teams.
- Embedded: engineers embedded in product teams, need to understand full system.
- Elevator teams: small cross-functional groups with end-to-end ownership.

**Professional development**
- LinkedIn recommendations for embedded careers: systems thinking, communication, hardware knowledge, software patterns.
- Textbook foundation: "Embedded Systems: Introduction to Arm Cortex-M Microcontrollers" as reference.
## L02 Real-Time Systems, Hard and Soft Deadlines, Embedded Systems Optimization
Outline: real-time systems concepts, deadline classification, resource scarcity, optimization metrics, IoT and IIoT trends.
### Embedded vs Real-Time vs Real-Time Embedded Systems
**ES vs RTS vs RTES**
Three related but distinct categories exist in the computing landscape. Embedded Systems are special-purpose computers built into larger systems with limited resources. Real-Time Systems are platforms (often general-purpose computers or cloud-based) where timing correctness is critical. Real-Time Embedded Systems sit at the intersection: most modern computer systems and developers work somewhere in this overlap, creating systems that must be both resource-constrained and deadline-driven.

**Examples**
Real-Time Embedded: flight control systems, nuclear reactor control, safety-critical systems, GPS receivers, MP3 players, mobile phones, Airbus A320 flight control, particle detection triggers for physics experiments.
Real-Time but not Embedded: stock trading systems, Skype, Pandora streaming.
Embedded but not Real-Time: home temperature control, sprinkler systems, washing machines, refrigerators, blood pressure meters.
### Real-time systems fundamentals
**Characteristics of Real-Time Systems**
- **Event-driven**: reacts to stimuli from environment, not fixed input/output batch.
- **High cost of failure**: missed deadline can mean physical damage or loss of life.
- **Concurrency / multiprogramming**: many things happen in environment simultaneously, software runs several tasks concurrently.
- **Stand-alone / continuous operation**: runs unattended, often for years, no operator to restart.
- **Reliability / fault-tolerance requirements**: must keep working (or fail safely) when parts fail.
- **Predictable behavior**: worst case matters, not average case. Fast system that is sometimes slow is not real-time.

**Real-Time Terminology**
- **Hard real-time**: response must occur within required deadline, absolutely. Missed deadline = system failure. Example: flight control systems.
- **Soft real-time**: deadlines important, system still functions if deadlines occasionally missed. Late result loses value, not the system. Example: weather data logging.
- **Real real-time**: at least one hard real-time task with short response times (microseconds/milliseconds). Example: missile guidance.
- **Firm real-time**: soft real-time variant, but no benefit from late delivery.
### Static vs dynamic real-time systems
**Static Real-Time Systems**
- Task arrivals finely predicted.
- Allows static analysis, modelled precisely, analysed offline at compile-time or before runtime.
- Designed around well-balanced resource usage.
- Schedule fixed before system runs.

**Dynamic Real-Time Systems**
- Arrival times of tasks unpredictable.
- Static analysis often not possible, or too difficult or costly to model accurately.
- Processor utilization highly varied.
- Scheduling decisions made at runtime.
- More difficult to design and analyze.
### Periodic and aperiodic design
**Periodic (Synchronous) Design**
- Each task executes repeatedly at specific period (e.g. sample sensor every 10 ms).
- Well suited to hard RT, simplifies static analysis: known periods give known worst-case load.
- Matches character of many real problems (physical phenomena, control systems).
- **Single-rate**: all tasks share one period. Simplest approach.
- **Multi-rate**: tasks run at different periods, typically harmonics of base rate. Simplifies analysis compared to arbitrary periods.

**Aperiodic (Sporadic/Reactive) Design**
- Built around being asynchronous or reactive to events, not clock.
- Creates dynamic situation: periods between event and response vary.
- **Bounded arrival time intervals** (sporadic): known minimum gap between events, easier to handle, worst case can still be analysed.
- **Unbounded arrival time intervals**: impossible to handle on resource-constrained systems, no worst case exists to design for.
### Hard vs soft real-time systems comparison
| Dimension             | Hard RT                 | Soft RT               |
| --------------------- | ----------------------- | --------------------- |
| Response time         | required, hard deadline | desired               |
| Peak load performance | must be predictable     | can degrade           |
| Control of pace       | environment dictates    | computer can pace     |
| Safety                | often critical          | usually not           |
| Size of data files    | small, short-term       | can be large          |
| Redundancy type       | active redundancy       | checkpoint / recovery |
| Data integrity        | short-term              | long-term             |
| Error detection       | autonomous, fast        | can involve user      |

**Safety-Critical Systems**
- Systems whose failure could result in death or serious injury to people or loss or severe damage to equipment, property, or environment.
- Require autonomous, rapid error detection (cannot rely on human intervention).
### Resource scarcity and optimization
**Computing Resource Scarcity**
Resource availability shapes the whole design:
- **Abundance of resources**: desktop/cloud situation, throw hardware at problem.
- **Totally inadequate resources (TIS)**: cannot meet requirements, must redesign.
- **Sufficient but scarce resources**: typical embedded case. Enough to do job, but only with careful design and analysis.

**Embedded Systems Design Optimization Metrics**
Ten usual suspects (not in priority order):
1. **NRE cost**: non-recurring engineering cost, one-time labour cost of designing system.
2. **Unit cost**: monetary cost of manufacturing each copy, excluding NRE.
3. **Size**: physical footprint of system, measured in bytes for software or gates/transistors for hardware.
4. **Performance**: execution time, throughput.
5. **Power consumption**: determines battery life and cooling requirements.
6. **Flexibility**: ability to change functionality without incurring heavy NRE cost.
7. **Time-to-prototype**: time until working version exists, may be bigger/more expensive than final.
8. **Time-to-market**: time to develop system until release and sale. Main contributors: design time, manufacture time, thorough testing.
9. **Maintainability**: ability to modify system after initial release by designers who didn't originally design it.
10. **Correctness**: system does what it should. Cannot compromise for safety-critical.

**Optimization tradeoffs**
- Optimizing one metric often reduces another (e.g. more memory increases cost and power; less power means slower operation).
- Embedded systems engineers spend much time discussing optimization metrics and working out satisfactory compromises.
### IoT and Industrial IoT
**Internet of Things (IoT)**
- Billions of physical embedded devices worldwide connected to internet.
- All collecting and delivering data.
- Enabled by super cheap computer chips and ubiquity of wireless networks.
- Makes possible turning almost anything into part of IoT.

**Industrial IoT (IIoT)**
- Extension/specialization of IoT devices towards industry application.
- Main focus: Machine-to-Machine (M2M) communication, Big data, Machine learning to optimize industrial processes.
- Encompasses robotics, software-defined production processes, logistics, medical devices.
- Predominantly about enabling industries/businesses to have better monitoring, efficiency, control, and reliability in operations.
## L03 Development and Execution Environment, Cross-Compiling Toolchain, C Language
Outline: development vs execution environments, cross-compilation concepts, toolchain components, C language rationale, runtime system architecture.
### Development environment
**Development vs Execution Environment**
- Development environment: where development occurs.
- Execution environment: where target program actually runs (the device itself).

**Desktop Development Environment**
Development environment comprises:
- Equipment used for development.
- Tools used for development (compilers, linkers etc.).
- Other resources (manuals, datasheets etc.).

Tools depend on OS but not on particular machine. Benefits:
- Toolchain fully configured and optimized.
- Debugging made easy with IDE.
- Full set of support libraries available.
- Simply use tools and things work (usually).

**Embedded Development Environment**
Generally not well-defined:
- Tools depend on software vendor, hardware vendor, peripherals used, and limited combinations.
- Toolchain often built from scratch.
- Debugging needs special techniques.
- Few if any support libraries available.
- Significant time often spent preparing custom development environment.

Compared to PC developer, embedded developer must:
- Organize and maintain dev environment for target platform.
- Know more about dev tools and need to configure them.
- Know more about underlying hardware to configure tools and write drivers.
### Cross-compilation
**Host and Target**
- **Host**: machine where development happens (e.g. PC running x86 Linux).
- **Target**: embedded device where code actually runs (e.g. ARM Cortex-M microcontroller).

**Cross-compiler**
- Runs on host but generates machine code for target architecture.
- Needed because target usually cannot run compiler itself (too little memory, storage, or no OS).
- Toolchain naming convention encodes target, e.g. `arm-none-eabi-gcc` (ARM, no OS, embedded ABI).
### Toolchain and build flow
**From Source to Executable**

Stages:
1. **Preprocessor**: expands `#include`, `#define`, handles conditional compilation directives.
2. **Compiler**: converts C source to assembly language for target architecture.
3. **Assembler**: converts assembly to object files (`.o`), machine code with unresolved symbol references.
4. **Linker**: combines object files and libraries, resolves symbol references, places code and data at memory addresses according to linker script. Output: executable image in ELF format, often converted to `.bin` or `.hex` for flashing to target.

**Build automation**
- **make**: build automation tool. Makefile declares dependencies between source files and object files, so only changed files get recompiled.

**Standard C library**
- Full libc assumes OS underneath.
- Embedded targets use reduced variants (e.g. newlib) or avoid certain parts.

**GNU GCC Toolchain**
- GNU Compiler Collection: full source for GCC, documentation for porting to other processor architectures.
- Cross-compilers with similar runtime environment, consistent user interface.

**GCC Tools**
- cpp: C preprocessor for macros.
- cc1: compiler phase 1, performs semantic routines and translates C into assembly language.
- as: assembler, converts assembly to relocatable object files.
- ld: linker.
- Run `gcc -v` to see commands executed during compilation stages.

**GNU Binutils**
- Collection of binary tools used with GCC.
- Used for creating and managing: binary executable programs, object files, libraries, profile data, assembly code.
- Most commonly used: `ld` (GNU linker), `as` (GNU assembler).

**Key Binutils Commands**
- as: GNU Assembler (GAS), assembler.
- ld: linker.
- gprof: profiler.
- addr2line: convert address to file and line.
- ar: create, modify, extract from archives.
- c++filt: demangling filter for C++ symbols.
- dlltool: creation of Windows dynamic-link libraries.
- gold: alternative linker for ELF files.
- nm: list symbols in object files.
- objcopy: copy object files, possibly making changes.
- objdump: dump information about object files.
- ranlib: generate indices for archives.
- readelf: display content of ELF files.
- size: list total and section sizes.
- strings: list printable strings.
- strip: remove symbols from object file.
- windmc: generates Windows message resources.
- windres: compiler for Windows resource files.

**Executable file formats**

**a.out Format**
Unix a.out format: an early executable file format with significant limitations.
- Hardware Memory Manager Unit (MMU) required to run a.out binaries.
- No relocation at load time: addresses are absolute, not relocatable.
- Separate address spaces for code (instruction space or I-space) and data (D-space), each limited to 64KB maximum, severely constraining program size.
- File structure comprises: a.out header, text section (code), data section, text relocation table, data relocation table, symbol table, string table.
- Used primarily on early Unix systems but largely obsolete for modern embedded systems.

**ELF Format**
- Unix ELF format, designed to support cross-compilation, dynamic linking, modern system features.
- Three slightly different versions of object file:
  - Relocatable (usable as precompiled library).
  - Executable (can run directly on platform).
  - Shared object (compiled library or shared between programs).
- Provides: logical sections described by section tables (for compilers, assemblers, linkers) and segments described by program header table (for executable loaders).

**ELF file structure**
- ELF Header, Program Header Table (indicates segments).
- Sections: .plt, .text (read only), .got, .data (read/write), .bss.
- Section Header Table (ignored when running).
### Programming language choice
**Why ANSI (ISO) C for Embedded Systems**

**C History**
- Developed at AT&T Bell Labs 1960s-1970s, led primarily by Dennis Ritchie.
- First main version 1972.
- Developed as language to write Unix (thing many students don't know).
- Intended for system software development rather than application development.
- Needed to be high-level enough to be portable but low-level enough to get sufficient control over hardware.

**C Language Rationale**
- Powerful and flexible.
- Portable assembly: close to hardware, low-level abstraction compared to Java/Python (Java carries VM overhead).
- Lowest common denominator, simple without sacrificing flexibility.
- Offers embedded systems programmer just enough abstraction without sacrificing flexibility.
- Enough abstraction to write portable code.
- Enough abstraction to make writing and reading code simple.
- Not too much abstraction to allow efficient access to hardware without burdensome wrappings.
- Especially widespread and widely supported on nearly every micro-processor/controller.
- Powerful, flexible, expressive.

**C++ in Embedded**
- Not seen widespread use in embedded as has standard C.
- Contains lot of baggage and language constructs causing bloat.
- Programs less efficient than C programs (depending on style).
- Lacks same very wide compiler support for embedded platforms.
- Situation changing as compilers improve and memories get larger, C++ gaining mindshare.

**Alternative considerations**
- Rust emerging as alternative with memory safety guarantees.
- For most embedded contexts, ANSI C remains dominant choice.
### Runtime environment architecture
**Runtime Environment (RTEnv) vs Runtime System (RTS)**
- Runtime environment and runtime system not the same.
- RTS is core component inside RTEnv.

**Execution Environment (EE)**
- Term refers to components used together with application code to make complete computing system.
- Includes: processors, networks, operating systems etc.
- Programming language has computer-based environment (runtime environment or runtime system) for which resultant program is modelled.
- Runtime environment should more accurately be considered large part of execution environment.
- In reality, especially for large systems with multiple languages and processes (e.g. Python, C, CUDA), execution environment may comprise multiple runtime environments, making EE superset of RTEnv.

**Runtime System (RTS)**
- Support code that runs before and beneath main(): startup/reset handler, initializes stack pointer, copies initialized data from flash to RAM, zeroes .bss, then calls main().

**Runtime Environment (RTEnv)**
- Complete platform or sandbox where program executes.
- Provides all necessary components for code to run: hardware, startup code, libraries, possibly RTOS.
- Addresses various aspects:
  - How program starts.
  - How procedures/functions called and results returned.
  - Methods for passing parameters between procedures.
  - How program accesses or manipulates variables.
  - Management of application memory.
  - Ways to interface to operating system (if OS supports this).
  - Inter-process communication (if OS supports).
  - How to connect to peripherals or do I/O.
- Compiler makes assumptions depending on specific runtime system selected for executable generation.
- RTEnv usually (not always) has responsibility for setting up and managing stack and heap, and may include garbage collection, threads, or other dynamic features.
- For very basic compiler or assembler, essentially just converting assembly code to instructions and allocating blocks of memory, may explicitly implement stacks or heaps if application needs them.

**PC vs Embedded RTEnv**
- RTEnv well standardized for PC: POSIX, Win32, other API standards.
- Operating systems have ABI standards.
- Not so well defined on embedded systems:
  - Often no OS to provide neat API standard.
  - ABI depends on exact system configuration.

**Layers of Environments**
Three nested layers clarifying distinction:
- **Runtime System (RTS)**: platform with minimal set of supporting system code to get application running (not necessarily connecting to environment).
- **Execution Environment**: environment in which application operates, can run and do things (not necessarily target environment or context of use).
- **Runtime Environment (RTEnv)**: complete platform or sandbox where program executes, comprises all necessary components for code to run, including RTS, standard libraries, access to system resources.

**Java and JVM in Embedded**
- Question: could Java bytecode executed by Java Virtual Machine solve problem of needing different compilers for multiple processors?
- Answer depends largely on application concerned.
- Various limitations exist in Java VMs and bytecode structure.
- Embedded system usually more than just processors: need control peripherals and other parts it connects to. Even with standardized VM, would solve only part of problem.
- Processor standardization issues: Java performance unpredictability, difficulty writing low-level code, difficulty interfacing with peripherals, difficulty in optimization (especially if unknown specific VM implementation).
## L03 Takehome Activity: Thinking of Development and Execution Environment
Case study: Big Little Calculator, a cheap Microchip PIC16 calculator for corporate gifts, cost savings important.

**Calculator System Description**
- Components: 7-segment LCD display, keypad (14 keys), Microchip PIC16Fxx microcontroller.
- Operations: basic arithmetic (ADD, SUB, MUL, SHIFT, no divide), chain calculation mode (no brackets, no reverse-Polish notation).
- I/O: port-mapped IO via IN/OUT instructions.
- Memory: no external memory, uses PIC16's few Kbytes RAM for M+ accumulator and BCD storage of numbers.

**Testing model advantages**
- Reset button for quicker code testing than relying on programmer reset or power button.

**Execution environment considerations**
- May overlap with runtime environment.
- Power source switching between solar cells and battery, need mechanism to detect which active.

**Runtime environment considerations**
- Serial-controlled keypad scanned left-to-right, top-row to bottom-row.
- Key detection returns code for pressed key.

**Learning task**
- Make brief notes on what would be used or part of:
  - Run-time System
  - Run-time Environment
  - Development Environment
  - Execution Environment
