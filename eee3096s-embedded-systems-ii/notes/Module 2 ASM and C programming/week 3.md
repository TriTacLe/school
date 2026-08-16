---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L06 Intro to ARM RISC
Outline: history of ARM, RISC vs CISC, alternatives to ARM, ARM cores and application areas, where ARM is used.
### History: Acorn to ARM
**Acorn Computers**
- Started 1978 as a subsidiary of Cambridge Processing Unit Ltd
- First project was a slot machine, developed on a tiny budget
- Very successful in 1980s and early 1990s
- Bought by Olivetti in 1985
**Acorn BBC Micro**
- From 1982, one of the best home computers of that decade
- Processor: Motorola 65002
**ARM history**
- 1983: Acorn begins design of a processor, the Acorn RISC Machine
- 1985: ARM1 launched, fabricated by VLSI Technology
- 1987: ARM processor debuts in a commercial product
- 1990: ARM Ltd spun off from Acorn, support from Apple (Apple + Acorn = ARM)
- 1991: ARM6 launch, ARM's first embeddable RISC core
- ARM = Advanced RISC Machine
### RISC vs CISC
- RISC = Reduced instruction set computer: fewer instructions, therefore needs more software
- CISC = Complex instruction set computer: more instructions, therefore needs less software
- Majority of today's microprocessors are RISC
**Characteristics of CISC**
- Large number of instructions (100 to 250)
- Some instructions perform specialized tasks, used only infrequently
- Many different addressing modes (5 or more)
- Variable-length instruction formats
- Possibly variable-length execution cycles (e.g. ADD taking more cycles than LOAD)
- Instructions that manipulate operands directly in memory (e.g. add value at address X to reg A)
**Characteristics of RISC**
- Small number of instructions (usually under 100), just enough types (close to minimal)
- Few addressing modes (maybe just two or three)
- Fixed-length instruction formats, easy to decode
- All instructions take the same number of clock cycles (typically)
- All ops (ADD, COMPARE, etc.) work only with registers, no memory access
- Memory access limited to LOAD and STORE instructions, no instruction manipulates operands in memory
- Often micro-programmed control (CPU instructions a set of even lower-level instructions)
**Powwow: why more RISC processors than CISC?**
- RISC processors are most affordable
### Alternatives to ARM
Beyond ARM flavours (STM, TI, NXP/Freescale, Intel), an ES developer should know PIC and AVR: essential for low-power, low-cost systems.

**Key features of PIC** (Peripheral Interface Controller)
- Developed by Microchip Technology (derived from PIC1650 by General Instrument), available since 1976
- Some use pure Harvard architecture (program memory protected), others Modified Harvard (program memory readable, sometimes writable)
- All models use flash memory for program storage
- Low cost, low power, easy reprogramming with built-in EEPROM
- Abundant development tools and application notes, often marketed as PICmicro
- Probably the most used microcontroller of all time
**Key features of AVR** (Alf and Vegard's RISC processor, an Atmel)
- Modified Harvard architecture 8-bit RISC
- Even lower power options, generally low cost (cheapest AVR maybe not as cheap as cheapest PIC)
- ATmega328P one of the most popular: very low power but fairly powerful
- Claim to fame: one of the first micros with on-chip flash instead of one-time programmable ROM or EEPROM hassle
	- On-chip flash vs one-time programmable ROM
		- ZIF 
- Conceived by two students at NTH Norway, Alf-Egil Bogen and Vegard Wollan
### Applications
**Thinking point: to ARM or not to ARM** (test practice, explaining why matters more than choosing which)
- Coffee percolator: PIC (simple, not much processing)
- ABS brakes: ARM or AVR (high speed, not simple, fair amount of processing)
	- Real-time, safety critical
- Radio control model airplane: PIC or AVR (simple, little processing)
- Car radio: PIC, for auto tuning feature at least
- Washing machine: probably ARM, maybe PIC for very basic version
- Portable battery game console: ARM
- Weather sensor: PIC (lowest power options, usually no speed need)
- Garage door opener: PIC or AVR, something cheap
- iPod type of thing: ARM (new iPod has Apple A10 SoC, 4x 64-bit cores)
- Burglar alarm: probably PIC, if not much signal processing
- Radar car speed sensor: probably DSP plus ARM or PIC for comms
- Wireless network switch: ARM or something super fast, like DSP
**Where are ARM cores used?**
- Highly reliable: ABS, hard drives
- Consumer: cameras, PDAs, smartphones (Nokia N series, Sony K series)
- Game systems: Nintendo DS, etc.
- Network systems: routers, switches, firewalls
**Companies that use ARM**
- Agere, AWS, Broadcom, Google, Fujitsu, Infineon, Intel, NEC, Nokia, Philips, Qualcomm, TI, Toshiba, Sega, Sony, Nintendo, Motorola, ...
- ARM licenses effectively used by all top semiconductor companies
## L07 ARM AArch32 fundamentals
Outline: ARM naming convention and Cortex, AArch32 fundamentals, data and instructions, 7 modes of operation, 4 states of operation, ARM registers and PSR, program counter, exception handling, endianness.
### ARM Cortex fundamentals
**Our focus: ARM Cortex**
- ARM Cortex range introduced in 2005
- Key features of the Cortex-M0: ARMv6-M architecture, high performance relative to power consumption, some Thumb instruction set support
- 3-stage pipeline
**ARM Cortex 3-Stage Pipeline**
- Stages: Fetch, Decode, Execute (instruction n executes while n+1 decodes and n+2 fetches)
- When resetting these stages are set to null

Risk processor
Time, multiple cycles
Instruction: ADD, SUB, CMP
### ARM naming convention and extensions
**ARM Core Naming Convention**
- `ARM | 91 | TDMI`: number is family + version (91 = family 9, version 1; ARM10 and ARM11 are separate families)
- Letters are extensions
**ARM Extensions**
- D: DSP instruction extensions 
- J: Jazelle, Java bytecode extensions. Can run java bytecode from memory
- S: Softcore, provided as synthesizable VHDL or Verilog
- T: Thumb, 16-bit operations supported 
**Why Thumb Instructions?**
- Thumb halves size of the instructions; uses 16-bit instructions on a 32-bit system
- System can load two Thumb instructions in one data word and process them in correct order
- But this at expense of complexity/functionality of the instruction set (i.e. less instructions to choose from)
- For many applications, code density can be nearly doubled using Thumb instructions, which can significantly increasing performance
**ARM32 vs ARM64**
- You might assume ARM64 uses double the address lines and can still run Thumb code, but you would be mistaken; the ARM64 designers were being realistic and sensible
- Generally ARM64 can swap to ARM32 but cannot swap mode in one execution block (should be separate 'basic blocks' at least)
- Cannot mix 64-bit and 32-bit instructions within the same exact execution thread or mode
- To swap, need to execute an exception and change of mode like an SVC or interrupt
  - SVC = 'Supervisor Call' (not as simple as SWI); SWI = Software Interrupt
**ARM64 vs ARM32**
- Instruction width:
  - ARM32 mixes 32-bit (ARM) and variable 16/32-bit (Thumb/Thumb-2) instructions
  - ARM64 uses a clean, fixed 32-bit (4-byte) instruction width everywhere
- No Thumb mode: ARM64 has no concept of "Thumb state" or switching execution modes to Thumb (but it can switch to ARM32 and then to using Thumb)
- Registers:
  - ARM32 has 16 general-purpose registers
  - ARM64 increases this to 31 general-purpose 64-bit registers (X0-X30), which can also be accessed as 32-bit registers (W0-W30)
- Remember: this course does not expect you to know ARM64 or how to switch to that state, only the basics in the two slides above
### AArch32 data and instructions
**Data and Instructions**
- ARM 32-bit architecture (termed 'AArch32')
- Support operations on bytes (8-bit), half-words (16-bit) and words (32-bit)
- All cores support 32-bit ARM instructions
- Most cores (ARM7 and later) support 16-bit Thumb instructions
- Some (Jazelle) cores support 8-bit Java bytecode
### ARM modes and states of operation
**ARM Mode of Operation**
- A processor (e.g. ARM Cortex) can have multiple 'modes of operation'
- A mode of operation is a distinct operating state or configuration that specifies the processor's privileges, access to system resources, and the types of instructions it can execute
- Modes of operation are crucial for maintaining system security, stability, and managing levels of software execution
- ARM processors generally have 7 modes of operation
**The 7 modes of operation**
- User Mode: restricted mode with limitations on register access and memory addressing; applications generally run in this mode
- Interrupt ReQuest (IRQ): used when a low priority interrupt is signalled
- Fast Interrupt reQuest (FIQ): used when a high priority interrupt is signalled; handled differently to a regular IRQ
- Supervisor: entered on system reset and on software interrupt instruction
- Abort: memory exceptions handled in this mode
- Undef: handles undefined instructions
- System Mode: privileged mode, similar to user mode but with fewer restrictions; used primarily by OS kernel code   
**The 4 states of operation**
- ARM64 state (64 bit addressing*, registers)
- ARM32 state (32 bit addressing, registers)
- Thumb state (16 bit instructions)
- Jazelle state (8 bit Java bytecode)
- Trade-offs between speed and memory between the states
### ARM registers
**ARM Registers**
- ARM has 37 x 32 bit registers
- 1 PC (Program Counter)
- 1 CPSR (Current Program Status Register)
- 5 SPSR (Saved Program Status Register)
- 30 GPR (General Purpose Register) r0 to r14
- Only 15 GPRs are explicitly available to the programmer, the rest are used for swapping out data when changing modes (e.g., FIQ has its own registers, i.e. to save response time)
**ARM Registers (cont.)**
- Any mode can access:
  - A certain set of registers (r0-r12)
  - It's own stack pointer (r13 or sp)*
  - It's own link register (r14 or lr)*
  - The program counter (pc)
- All modes, except user and system has an SPSR (Saved Program Status Register)
- The sp and lr registers can be used as GPRs
- User and System mode share sp and lr
- Register count per mode: User/System 17 + Supervisor 3 + IRQ 3 + FIQ 8 + Undef 3 + Abort 3 = 37 registers
**ARM Register Map**
- Visual map showing register layout across all modes
### Program status registers
**The Program Status Registers (PSR)**
- Only the CPSR is active
- SPSR holds value of CPSR immediately before the exception occurred
**The Program Status Registers**
- Bit fields: bits 0-4 mode; T=1 Thumb state; F=1 disable FIQ; I=1 disable IRQ; A=1 imprecise aborts; E endianness (1 big, 0 little); GE[3..0] used by Jazelle and others for byte access / extra flags; J=1 Jazelle state; Q sticky overflow (newer cores); bits 28-31 flags V (oVerflow), C (Carry), Z (Zero), N (Negative) from the ALU
**Program Counter Register**
- Called r15 or pc in most assembler
- Use of pc depends on current state:
  - In ARM state: PC values in bits 2..31 (bits 0 and 1 are ignored). Instructions are 32bit word aligned.
  - In Thumb State: PC values in bits 1..32 (bit 0 is ignored). Instructions are 16bits and half-word aligned.
  - In Jazelle State: Instructions are 8 bits, but processor reads 4 (32 bits) at a time.
### Exception handling
**ARM Exception Vector**
- Just 32 bytes in size
- Starts at address 0x00000000 (can be set to 0xFFFF0000 for Windows CE)
- Each entry point to the vector contains an ARM 32bit instruction
- 0x00 Reset, 0x04 Undefined Instruction, 0x08 Software Interrupt, 0x0C Prefetch Abort, 0x10 Data Abort, 0x14 Reserved, 0x18 IRQ, 0x1C FIQ
**ARM Exception Handling**
- On exception:
  - SPSR[mode] = CPSR (Save status register)
  - Changes to relevant exception mode
  - Changes to ARM state
  - Disables Interrupts
  - LR[mode] = PC (save return address)
  - PC = Address of relevant vector entry, resume execution there
**Return from Exception**
- Return from exception done by ISR:
  - Change to ARM state
  - CPSR = SPSR[mode]
  - PC = LR[mode]
  - Resume previous task
### ARM endianness
**Endianness 'Switchianess' of ARM**
- Two ways to interpret contents of registers (and memory):
  - Big Endian: Most significant byte first (e.g. Motorola 68000, SPARC, et al.)
  - Little Endian: Least significant byte first (e.g. Intel x86 et al.)
- ARM supports both and can switch on the fly
- Can cause massive confusion...
- My advice: choose one and stick to it!!! ... (for the entire project and perhaps forever more?!)
**Endianness (recap)**
- Big Endian: Most significant byte first
- Little Endian: Least significant byte first
- ARM supports both and can switch
- Visual diagram showing little-endian and big-endian byte ordering
## L08 ARM Assembly Programming 1 of 3
Outline: assembly thinking activity, introduction to the ARM instruction set, GAS syntax, conditional execution instructions, data processing instructions, load and store.
### Thinking activity: pseudo assembly coding
**Thinking Activity**
- Two-pass approach to learning assembly: first invent your own instructions and ordering for a program, then learn the real ARM syntax
**Consider a CPU and its instructions**
- Reflect back on digital logic experience
- You mind might be sparking ideas of e.g. ADDER, SHIFT REGISTER, COMPARATOR circuits
**CPU instructions**
- These are the building blocks of CPU instructions
- This learning assembly using pseudo assembly approach is a two pass process...
- Here is the first pass: Thinking about instructions to use, and how to order them, to run a program. (We haven't defined the instructions! But that's the point: think up your own ideas for them and their sequencing to achieve a program approach)
- Here's the program that we want to run...
**Program Description**
- We want to carry out the following processing:
```c
int a, b, avg, res;
a = 100;
b = 200;
avg = (a+b)/2;
if (a>avg)  res=1;     // a grater than avg
if (a<avg)  res=-1;    // a less than avg
if (a==avg) res=0;     // a same as avg
```
- Don't bother with that yet!
- View this C module `compaavg.c` in CODE.zip resources for this lecture (the completed ARM assembly version, compaavg.s, is included, don't look at that yet!)
**Solution ***
- Program wanted with annotations showing steps and pseudo code
- Pseudo solution with registers A, B, avg, res and operations: CPY A,100, CPY B,200; ADD AVG,A,B then SHR AVG,AVG,1 (shift right = /2 for ints); then CMP and conditional assignment
- Aiming to talk-through this, not so much as class activity (to save time)
- This is assembly pseudocode, not real ARM assembly. This done as a quick first attempt to avoid fussing with a specific syntax.
**Thinking Activity Done**
- First pass of learning assembly: making up your own realistic assembly commands
- Hopefully you know the general approach now of writing assembly (and may be convinced also why this approach is useful for designing processors)
- Now for second pass of learning ARM assembly specifically...
**Recommended learning resources**
- The following YouTube covers the essentials of assembly programming, and running the GCC assembler on a PC: https://www.youtube.com/watch?v=FV6P5eRmMh8
### ARM assembly language programming
**ARM Data and Instructions**
- We will focus on the ARM AArch32 state (see lecture L07 for alternate states)
- Instructions and data are 32bit words
- ARM uses Load/Store architecture; you cannot manipulate memory directly
- ARM is a RISC processor; the instruction set is not as rich as for the x86
- Data path: ALU / Processing / Coprocessors <-> Registers <-> Cache <-> Memory
**ARM Instruction Set**
- Instruction set divided into six types:
  1. Branch Instructions
  2. Data Processing instructions
  3. Status Register Transfer Instructions
  4. Load and Store Instructions
  5. Coprocessor Instructions
  6. Exception-generating Instructions
- Reference table with all instruction types and their descriptions
### GAS syntax
**GAS Syntax**
- GAS is the GNU Assembler, which comes with GNU binutils for a variety of platforms
- Syntax:
```
`[label:] <instruction> <suffix> [operands]`
```
- Notes:
  - label is optional - only needed if you want to refer to the instruction
  - Not all instructions have operands
  - Comments start with @
### Conditional execution
**Conditional Execution (AArch32)**
- Conditional execution reduces the need for branches and increases code density
- Many ARM instructions can be executed conditionally
- Each instruction has a 4-bit condition code field
- We will be focusing on AArch32 instructions, these are documented at: https://static.docs.arm.com/100076/0100/arm_instruction_set_reference_guide_100076_0100_00_en.pdf
- For full details on the ARM Cortex-35A processor, consult its Technical Reference Manual (available from https://developer.arm.com/documentation/100236/0002)
**Conditional Execution**
- Table showing mnemonic, condition, and CPU condition flags for EQ, NE, CS, CC, MI, PL, VS, VC, HI, LS, GE, LT, GT, LE
- Addition of Q flag in 64-bit state which indicates floating point saturation
### Branch instructions
**Branch Instructions**
- B : Branch
  - `B <address>` (eg `B main`)
  - Address relative to PC +/- 32Mbytes
  - Does not return
- BL : Branch and Link
  - `BL <subroutine>` (eg `BL sqrt`)
  - Program counter is put into the link register
  - To return mov pc, lr (note GAS operand order)
**Conditional Branching**
- Branches can be conditional
- The assembler equivalent of an if statement
- `B<suffix> <offset>`
  - Branch if suffix matches state of flag in the CPSR
  - Examples:
    - BEQ : Branch if equal or zero
    - BMI : Branch if the result is negative
    - BVS : Branch if an overflow occurred
- Table showing branch, interpretation, and normal uses for all branch types (B, BAL, BEQ, BNE, BPL, BMI, BCC, BLO, BCS, BHS, BVC, BVS, BGT, BGE, BLT, BLE, BHI, BLS)
### Data processing instructions
**Data Processing Instructions**
- Syntax `OP<suffix> <result>, <op1>, <op2>`
- ADD : Add without carry
  - result = op1 + op2
- ADC : Add with carry
  - result = op1 + op2 + carry
- SUB : Subtract without carry
  - result = op1 - op2
- AND, ORR, EOR, BIC work similarly to ADD
- For assignment, use MOV
  - MOV r1, r2 @ r1 = r2 (assignment)
  - MVN r1, r2 @ r1 = ~r2 (assignment with complement)
- For comparison, use CMP
  - CMP r1, r2 @ set condition flag on r1 - r2
  - Same as SUBS but result is discarded
**Data Processing Instructions**
- If you want to use flags, you must specify that the status register must be updated
- For example, to add two multi-word values:
```asm
ADDS R0, R4, R8    @ add, set flags
ADCS R1, R5, R9    @ add with carry, set flags
ADCS R2, R6, R10
ADC  R3, R7, R11   @ no need to update flags here
```
- AND, ORR, EOR and BIC work similarly to ADD
- For assignment, use MOV
  - MOV r1, r2 @ r1 = r2 (assignment)
  - MVN r1, r2 @ r1 = ~r2 (assignment with complement)
- For comparison, use CMP
  - CMP r1, r2 @ set condition flag on r1 - r2
  - Same as SUBS but result is discarded
**Data Processing: Shifting**
- A shift can be applied to the second source register
- Can shift by a constant or by a register
- LSR logical shift left (LSL for left)
- RRX rotate right with carry (no left versions)
- ROR rotate right without carry (no left versions)
- ASR arithmetic shift right (no left version)
- e.g.: ADD r1, r2, r3, LSL r4 @ r1 = r2 + r3*2^r4
### Status register transfer
**Status Register Transfer**
- Content of registers can be moved into and out of the status registers using MSR:
- MSR Move to status register
  - `MSR<suffix> <sr>, <reg>`
  - e.g. MSR cpsr, r10
- MRS Move from status register
  - `MRS<suffix> <reg>, <sr>`
### Load and store instructions
**Load and Store**
- Content of registers are moved from and to memory using LDR and STR respectively:
- LDR Load Register
  - LDR r1, [r2] @ r1 = mem[r2]
- STR Store Register
  - STR r1, [r3] @ mem[r3] = r1
**Index Addressing**
- Index addressing can make load / store operations more efficient, i.e. it adds an offset to the base address as part of the same instruction.
- Pre-index addressing
  - LDR r1, [r2, #4] @ r1 = mem[r2+4] (C: x = arry[i+1];)
- Auto Pre-index addressing
  - LDR r1, [r2, #4]! @ r1 = mem[r2+4]; r2 += 4 (C: x = arry[++i];)
- Auto Post-index addressing
  - LDR r1, [r2], #4 @ r1 = mem[r2]; r2+= 4 (C: x = arry[i++];)
**Load and Store of a 32-bit constant**
- GAS gives macros for easier loading and storing
- Example:
  - LDR r14, =addr @ Load value at address addr
- But how? You can't put a 32bit immediate (constant) into a 32bit instruction!
- The '=' macro allocates a word in mem and puts the 32-bit address there, i.e. it translates to:
```
LDR r14, =0xFFFE0100
Translates into:
LDR r14, [pc, #0x20]
...
lbl_0xFFFE0100: .dw 0xFFFE0100 @ 32-bit addr after the LDR
```
### Next lecture preview
- Next lecture (L09): ARM assembly activity, then interfacing C and assembly, program startup, runtime library, linking
