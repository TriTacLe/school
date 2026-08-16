---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L18 CPU architecture and datapath 1
Outline: Practical Examination, Terminology moment on Datapath, Computer Design Fundamentals, Explaining the digital logic.
### Temporal and Spatial Computation
**Temporal Computation vs Spatial Computation**
- Temporal: the traditional paradigm typical of programmers, things done over time steps. Example: A = input; B = input; C = input; X = A + B * C; Y = A - B * C
- Spatial: suited to hardware, possibly more intuitive, things related in a space. Shows data dependencies as a graph with operations as nodes and data flows as edges. Can provide clearer indication of relative dependencies.
- Question posed: "Which do you think is easier to make sense of?"
### Terminology Moment: Datapath
**Datapath: An essential concept for processor and computer design**
- These slides relate to: Course Notes Section 2.5 Computer Architecture
- Datapath is described metaphorically as something like a railway (or underground) transport system, where one has schedules, ways to move people (data), ways people are admitted to the network, board the path, time it takes to move from one place to another (transport happening at similar speed)
- Definition: data path or datapath is the set of functional units that carry out data processing operations for a computer system
- The datapaths, together with a control unit and ALU, make up the CPU of a computer
- Larger datapath (or composite datapaths) can be created by joining more than one together using (e.g.) multiplexers
- Reconfigurable datapaths: datapaths that can be re-purposed at run-time using a programmable fabric (e.g. may allow for more efficient processing and substantial power savings for particular types of application)
- Reconfigurable datapaths are nowadays generally found only for FPGA-based designs. Examples include: VECTIS Dataflow Processing Units (DPUs) allowed for adjustable datapaths in parts of its CPU, cache and memory integration (but these are not longer made); Power PC (used in Sony PlayStation 3) allowed configuration of memory access (but this was not exactly a reconfigurable datapath, more option of static paths that could be selected)
- Reference: https://en.wikipedia.org/wiki/Datapath
### Datapath & Control
**Datapath and Control as distinct components**
- A processor design comprises two main elements: Datapath and Control
- Datapath: moving data and signals around the system
- Control: making decisions (e.g., whether to execute an operation) and coordinating operations (e.g., adding two registers)
- The control channel may be separate from the datapath; for example, signals requesting data transmission may be distant from the channel that actually transfers the data
### Computer Design Fundamentals
**Approach to Computer Design**
- The specification of a computer is provided by defining its appearance to the programmer at its lowest level, its Instruction Set Architecture (ISA) level
- From the ISA the computer architecture is developed
- Computer architecture development essentially involves deciding its datapath and control
- Is also an effective approach for designing a processor/CPU or designing a special-purpose application accelerator or co-processor
- Note: you are not limited to using instructions as the means to design a computer; but it is the regular practice used for computer design. Also, the instructions do not necessarily have to run in sequence, they could be parallel or collaborative/interdependent
### Explaining the Digital Logic
**But what exactly is the Datapath?**
- Datapaths most generally refers to the registers, processing units, and interconnections (busses) that are used to process and transfer data in a computer system
- Datapath comprises:
  - A set of registers (that store data)
  - Microoperations to perform operations on data stored in the registers
  - Control interfaces (for sequencing and arbitrating operations)
- Recommended video: "How a datapath works inside a computer system". Available at: https://youtu.be/ibYYqvp9FmU
### Let's Design a Computer Processor!
**A simple 4-register RISC Harvard CPU**
- Reminder on memory architectures:
  - Von Neumann architecture: uses the same memory for both instructions and data
  - Harvard: has separate memory for instructions and for data
- Harvard is often preferred for embedded systems as it can be more robust and secure having instructions and data separate (but changing the program instruction memory while running may be blocked)
- We're going to use a Harvard design for our processor
### Instruction Set Architecture (ISA) Planning
**ISA for our 4RR**
- We're going to do a 4-Register RISC processor design (code named 4RR, pronounced "fourrrrr")
- ISA for our 4RR:
  - Basic set of operations (e.g. ADD, AND, JMP, MOV, NOT, OR, SUM)
  - Syntax: `<OP> R_dest, R_s1, R_s2`
  - E.g.: ADD r1, R2, R3 // R1 = R2 + R3
- `<OP>` above is the name for an 'Op Code' or 'Operation Code' e.g. 0010_2 -> ADD
- Don't worry too much about the assembly, yet. We will get to that later. We cover just some basics of instructions and assembly first, and only later in term 2 do we get to specifics of actual ARM instructions and using ARM assembly.
### Datapath - 1st pass
**The 4-Register RISC "4RR" Processor**
- Datapath design is largely about the circuitry to store data and to select and connect data to be transferred between processing units in a processor
- A briefly run through the parts:
  - 4x registers available in this arch
  - Select destination and source for data
  - Connections between the parts
  - Move result or shifted value to destination
- Onwards to....
- NB: will recap the digital logic designs of the parts next
- Based on CH8 Fig. 8-1 of Logic and Computer Design Fundamentals, Fifth Edition, by Mano, Kime & Martin. Pearson. 2016.
- Example datapath diagram shows: Load enable signals, Write/D data input, Register selection via decoder, Loading data into registers (R0, R1, R2, R3), Multiplexer for selecting A and B operands, Arithmetic Logic Unit (ALU) and flags (V, C, N, Z), Output from ALU to register file via multiplexers, Address output and data output paths
### Brief Refresher - Processor Pieces
**Main digital components used**
- Decoder: "fans out bits", i.e. converts m-bit input to activating one of 2^m output signals. This is used for decoding an instruction, to chip select one of multiple operations
- Register: stores values. Basically a D-type flip flop that can be enabled (load)/disabled (read)
- Multiplexer: m-input sel line to select 1 of 2^m input lines (I) to connect through to the output line (Y)
- We will quickly go through each of these with examples connected to the 4RR processor
### Working of The Decoder
**The decoder digital logic circuit**
- Basically converts its binary bus input to an activation of output lines. It doesn't do any operation besides setting high or low output lines for a given input
- The output is undefined while the input is changing. There may be a clock line (or synchronization of output line changes) for which outputs change at a clock edge
- A standard decoder that simply sets output bit A_0 A_1 high and all other bits low
- E.g. ADD R_d, R_s1, R_s2; ADD: 01 -> 0010
  - A 2-bit decoder input shows: bits A_1 A_0 = 01 -> output D_1 is high, all other bits low
  - Output used to select the ADD operation and activate it via an operation selector
### Working of The Register
**The register**
- The register is sent data (Data lines). A positive edge on the Load line transfers the bits on Data to the register's memory. A flip-flop provides the memory; the power has to remain on to maintain the memory (i.e., it is SRAM)
- RS Flip-flop = Reset/Set flip-flop
- Each line can be multiple bits
- RS Flip-flop truth table: Hold (S=0, R=0, no change); Reset (S=0, R=1, reset or cleared to 0); Set (S=1, R=0, set to 1); Prohibited (S=1, R=1, do not use)
- Register in ISA: write data with set/reset, read data out; register logic symbol for RS flip-flop
### Working of The Multiplexer
**The multiplexer**
- The multiplexer can be consider something of a slide-switch, where one of multiple input lines can be switched over to one output line. The input lines can be busses as apposed to just single wires. The select line ('sel' line in diagram) selects which of the inputs are forwarded to the output
- Slide-switch equivalent shows multiple inputs i_3, i_2, i_1, i_0 with a 4x1 multiplexer selecting one
- MUX 4x1 Truth Table: S1 S2 Y -> (0 0 -> i_0); (0 1 -> i_1); (1 0 -> i_2); (1 1 -> i_3)
- MUX 4x1 digital circuit with logic gates
- A digital circuit like that on the left would work... it is inefficient in terms of footprint, resources and power use. Instead transmission gates (like transistors or NMOS or PMOS FETs) are used and activated in parallel from an enable
- Transmission gate circuit symbol shown
## L19 CPU architecture and datapath 2
Outline: Computer Design Fundamentals, Building the Instruction Set, The Function Unit in a CPU, The ALU in a CPU, Datapath pass 2, Deciding the instruction set for a given processor design (PCP design activity).
### Instruction Set Architecture (ISA)
**General Computer Architecture comprises**
- Instruction Set Architecture*: specifies the instructions available
- Storage Resources:
  - Instruction memory
  - Data memory
  - Register file
  - Program counter
- Datapath: runs the instructions and activates processes
- Instruction Set Architecture (ISA) =
  - Instruction format: how the instructions are structured, how the bits of the instruction link to operations/data
  - Instruction specification: describe each of the available instructions that the system can execute
- Based on CH8 Fig. 8-15 of Logic and Computer Design Fundamentals, by Mano, Kime & Martin. Pearson. 2016
- Block diagram of a single cycle computer showing: Instruction Register (IR) from instruction memory; Branch Control; Program Counter; Extend bits to 32-bit Jump Address; Address to Instruction Memory; Register file and arithmetic unit; Data to memory; data in from memory
### Building The Instruction Set
**General Computer Architecture is designed around/comprises**
- Instruction Set Architecture*
- Storage Resources:
  - Instruction memory
  - Data memory
  - Register file
  - Program counter
- Datapath: runs the instructions and activates processes
- Instruction Set Architecture (ISA) =
  - Instruction format: how the instructions are structured, how the bits of the instruction link to operations/data
  - Instruction specification: describe each of the available instructions that the system can execute
- Example instruction format for arithmetic/logic operations on a RISC processor: bits 15-9 is Opcode, bits 8-6 is Destination register (DR), bits 5-3 is Source register A (SA), bits 2-0 is Source register B (SB)
- We delve into detail later in the course; Based on CH8 Fig. 8-15 of Logic and Computer Design Fundamentals, by Mano, Kime & Martin. Pearson. 2016
### The Function Unit
**Function Unit (FU) (or execution unit)**
- Carries out the operations
- Could be structured in various ways
- Typically: FU = ALU + CU
- And possibly: FU_main = sum (FU_subunits), for a multi-processor system
- The FU has two input registers, A and B, that it operates on
- There is a Function selector (FS) input used to chose the operation to perform. When this operation is performed, the result output is latched to F and updates status flags V, C, N, Z
- The MD (memory data) select can bypass the FU if the instruction is loading from memory
- Block diagram of a single cycle computer showing the Function Unit with input from register file to A and B inputs, status flags output (V, C, N, Z), and result output (F) feeding to data memory; also MD select that can bypass the FU if instruction is loading from memory
### The ALU
**The Arithmetic/Logic Unit (ALU)**
- Arithmetic operations: + - * /
- Logic operations: and, or, xor, not
- The ALU has:
  - Inputs to provide data to be processed as well as
  - Input for type of operation to be performed (e.g. if it needs to do an ADD or AND, etc.)
  - Has outputs that provide the results of the operation (G output in figure)
  - Output flags, e.g. carry (C) output flag that stores status information of the operation (e.g. carry flag set) or error states (divide by zero)
- An n-Bit ALU shown with inputs A (Data input A), B (Data input B), C_in (Carry input), operation select (S_0, S_1, S_2 for Mode select), outputs G (Data output G), C_out (Carry output)
- Based on CH8 Fig. 8-2 of Logic and Computer Design Fundamentals, by Mano, Kime & Martin. Pearson. 2016
### The Control Unit
**Control Unit (CU)**
- The CU is the part of the CPU that directs the working of the processor
- The CU coordinates the computer's memory, ALU and its input and output devices, making these parts respond to program instructions
- Sometimes the control unit is not shown in the design of a computer (or cannot be shown as a distinct subsystem) as it may be distributed through the system, closely integrated within other components; this is particularly the case for highly complex pipelined architectures where it is difficult to have a separate component to arbitrate the system
- Control Unit: can be abstracted as the circuitry used to sequence and control the system (this simplification obviously hides many aspects such as memory and IO)
- Diagram shows: IR (Instruction Register) input, outputs to Register Set, Control Signals to ALU
- The control unit may be the most complex part of a CPU architecture, especially in deeply pipelined designs
### Datapath - 2nd pass
**We've looked at the datapath to connect the pieces, the register file, the ALU, the FU, the CU**
- Now you hopefully have an inkling of how the pieces work together to:
  1. Get data to the FU inputs
  2. Grab results from FU
  3. Move FU results/memory to register or memory address
- Don't be too worried yet: we are going to run through the process a little slower
- Based on CH8 Fig. 8-1 of Logic and Computer Design Fundamentals, Fifth Edition, by Mano, Kime & Martin. Pearson. 2016
### Processor Pieces - ALU Example
**A simple ALU Example**
- This is a simplified ALU example, where there are two input operands (a, b), a carryIn bit and a carryOut bit. The Operation line (a 2 bit bus here) selects which operation (AND, OR or +) is applied
- Arithmetic Logic Unit [ALU] diagram: carryIn and operation select inputs to multiplexer logic, AND and OR logic gates, addition circuit, output selected by multiplexer to Result output, carryOut output
- Operation: 0 -> AND result; 1 -> OR result; 2 -> addition result
### Deciding Processor Instructions
**Deciding Processor Instructions**
- You can either decide the instructions and their names first, or do that after you have the processor designed
- Let us apply the second approach (not yet having named instructions) to illustrate the process or deciding instructions
- The ALU has only three operations: AND, OR, +
- Thus we don't yet know how many registers in the register bank, we don't yet need that
- Let's just say there are 4 registers called R1, R2, R3, R4; these could link to a, b or Result
- ...
- We can then decide for this ISA, we have three instructions, that we can name: ADD, OR and ADD
- Since they draw data from or move data to one of the registers, the instructions could be represented as:
  - AND R1, R2, R3 // R1 = R2&R3
  - OR R1, R2, R3 // R1 = R2|R3
  - ADD R1, R2, R3 // R1 = R2+R3
### Connecting the Parts
**The program, comprising instructions to run, is stored in the memory**
- The PC (program counter) points to an address in memory where the next instruction is fetched
- The control unit coordinates the fetching of the next instruction from memory, and then selects source data to applied to the operation, and where the result of the operation is sent. (see next slide)
### Basic Processor Overview
**Illustration of the main parts of a processor and sequencing of the data movement**
- Diagram shows: Program Counter pointing to Address in Instruction Memory, Instruction determining what values are placed on A and B operands for ALU, output from the ALU stored in the Data Memory or written back into a registers in the register bank
- Using Modified Harvard Architecture in this example
- 1. Program Counter points to the Address of an Instruction in the Instruction Memory
- 2. Instruction determines what values are placed on A and B operands for ALU
- 3. Output from the ALU stored in the Data Memory or written back into a registers in the register bank
### Where to Later with ISA
**Getting into ARM processor fundamentals and RISC vs. CISC design**
- This builds on ISA
- We look at real instructions for a standard ARM architecture, e.g.:
  - BRANCH instructions: J address, jump to address
  - STATUS instructions: MSR, move status register flags
  - DATA PROCESSING instructions: ADD R1, R2, R3 @ R1 = R2 + R3; CMP R1, R2 @ compare R1 and R2; SWP R1, R2 @ swap value of R1 and R2
  - LOAD and STORE instructions: LDR R1, address @ load from memory; STR R1, address @ store to memory
  - EXCEPTION instructions: SWI @ cause software interrupt
### Plans for Last Two Weeks of Term
- Solidifying your understanding of Computer Processor Architecture
- Memory and its integration with a processor
- Miniscule processor design activity (skip?)
- Prepare for exam (prep task)
- Assembly and more complex issues of the ARM processor were covered 'Module2 ARM'
## L19 PCP activity
Outline: Design Simple Peripheral Controller Processor (PCP).
### Introduction and Scenario
**The Mission: Design Simple Peripheral Controller Processor (PCP)**
- In this activity, you will delve into the world of computer architecture and ISA design by creating a simplified peripheral controller, given the code-name PCP (so as not to confuse this with the more sophisticated PIC Peripheral Interface Controller family of microcontrollers that have been around for a long time)
- The PCP controller will be responsible for forwarding input data from one source to a destination, demonstrating a fundamental concept in computer systems
- Scenario: Imagine a scenario where you need to read data from an 8-bit parallel port and transmit it serially to another device. You'll design a processor with a minimal instruction set to accomplish this task efficiently
- The processor can be considered as awesomely fast, like nanosecond propagation delays (i.e. GHz clock). It runs in parallel to larger, more complex host processor(s) on the computer mainboard
- The PCP is mainly intended for transferring data from one source, such as an ADC connected to a microphone input and moves this data to another point such as an input buffer that the host processor reads
### Sample Program
**Converting data received on 8-bit input port sent out serially to serial line**
- Listing 1: PCP assembly program
  - Set up ports: SETIN #0x10, SETOUT #0x20
  - MAINLOOP: WAITIN, IN A, #0x10
  - Stream parallel input as sequence of serial bits (low endian): SET B, #128
  - LOOP: AND A, B; OUTZ #0, #0x20 (if zero), OUTNZ #1, #0x20 (if not zero), SHR B, JNZ #LOOP
  - Jump back: J #MAINLOOP
- This program probably takes 11 instructions. Would perhaps take 6ns x 8 loops + 3ns for one iteration of the whole program, thus 51ns for one iteration
- Max transfer speed: 51 ns = 5.1 * 10^-8 seconds; Time to transfer one byte = 5.1 * 10^-8 seconds; Transmission speed = 8 bits / (5.1 * 10^-8 seconds) = 156,862,745 bps = 156.86 Mbps
- Can handle USB1.1 (12Mbps) but not USB2 (480 Mbps)
### PCP Design Tasks
**Tasks for you to do**
- Task 1: Instruction Set Definition
  - Carefully analyze the sample program and identify the essential instructions required for its execution
  - Create a comprehensive list of these instructions, considering their operands, addressing modes, and potential side effects
  - Brainstorm additional instructions that might enhance the processor's capabilities or simplify programming
- Task 2: Instruction Encoding
  - Decide on a suitable instruction encoding scheme, determining the bit patterns representing each instruction and its operands
  - Strive for an efficient encoding that minimizes instruction size while maintaining clarity and ease of decoding
- Task 3: Processor Block Diagram
  - Develop a more refined high-level block diagram illustrating the major components of your PCP processor:
    - ALU (Arithmetic Logic Unit)
    - Registers (and its Register Bank)
    - Control Unit
    - Instruction Decoder
    - Memory Interface
    - I/O Interface
  - Show the data flow between these components and how instructions are fetched, decoded, and executed
- Task 4: Mind Mapping/Connections
  - Utilize mind mapping or other visual techniques to explore the relationships between instructions, data flow, and processor components
  - This exercise can help solidify your understanding of the processor's internal workings and potential design trade-offs
- Task 5: Partial Design Presentation
  - Prepare a concise presentation summarizing your processor design, including:
    - Instruction set overview
    - Instruction encoding scheme
    - Processor block diagram
    - Key design decisions and justifications
### PCP System Integration
**Visualization: Block diagram showing how PCP is integrated into larger computer system**
- PCP: Peripheral Control Processor (the PCP-CPU part would include the ALU, control unit, etc.)
- Connects to: Instruction Memory, Register Bank
- Contains: port_addr, is_data, read_data, write_data signals
- Connects to ILS: Interface Lines Selection Module that connects to IO lines, or busses on computer motherboard or to connection ports
- Controlled by: System Controller (reset, enable signals)
- The PCP is essentially itself a peripheral that is connected to a host processor
- Could consider it something like a DMAC (Direct Memory Access Controller), but a DMAC is more complex and task-specific type of processor which focuses on transferring data to or from memory
- The PCP, in contrast, does not 'talk' to its host processor, it merely shifts data from one place to the other
- PCP is in reality a type of processing element sometimes needed in real designs, for instance in FPGA solutions where you may need to capture data from possibly many different sources, possibly at the same time, and forward the data on in a suitably structured manner to a host processor or pc
## L19 PCP activity
Sample solution.
### Task 1 Solution: Instruction Set Definition
**Essential Instructions (based on the sample program)**
- SETIN: Sets a specified port as an input port. Yes, this processor has a whole lot of tristate IO pins, which can be set as either an input or an output. It is up to the designer that is incorporating the processor into a host system to ensure there are no cases where an output links to an output, that could cause a meltdown; input to input is generally not a problem (e.g. multiple devices reading pins on shared bus)
- SETOUT: Sets a specified port as an output port
- WAITIN: Waits for input on an input line
- IN: Reads data from a specified input port into a register. These are 8-bit ports, although not all the pins necessarily need to connect to anything
- OUTZ: Outputs a constant value (in the example given, it was constant 0, the # emphasises a constant) to a specified port only if a condition is met (for Z this implies zero flag is set, e.g. for previous instruction the ALU returned zero)
- OUTNZ: Outputs a constant value (in the given example, #1) to a specified port if a condition is met (non-zero flag)
- AND: Performs a bitwise AND operation between two registers
- SHR: Shifts the bits in a register to the right
- JNZ: Jumps to a specified label if a condition is met (non-zero flag)
- J: Unconditionally jumps to a specified label

**Additional Instructions (for enhanced functionality)**
- ADD: Adds the values of two registers (and possibly save to a third register)
- SUB: Subtracts the value of one register from another
- LOAD: Loads a constant value into a register. This instruction is often called MOV instead as it is moving a value as opposed to load a value form memory, as the constant is in the simple processor can only be in the instruction
- STOREM: Stores the value (byte) of a register into memory, e.g. a small scratch area, some additional registers, perhaps further from the CPU than the main registers. Maybe connects to external memory, if it is decided to actually give the processor some external RAM, but to keep things simply might not want that or interfacing to external memory
- LOADM: Loads a byte from scratch memory. Could utilize the STOREM and LOADM for a small stack to enable calling functions
- CMP: Compares the values of two registers
- NOP: Does nothing
### Task 2 Solution: Instruction Encoding
**Fixed-length instruction format scheme**
- Opcode: 6 bits (allows for up to 64 instructions)
- Operand 1: 5 bits (destination register or memory address)
- Operand 2: 5 bits (source register, destination address, or immediate value)
- A 16-bit instruction length is suggested. It would support 64 instructions, quite a few, but some of them may just be different alternates of the same type of operation (e.g. MOV immediate value to register, or MOV register to immediate value, the immediate value could be limited)
- Diagrammatically: bits 15-9 are Opcode, bits 8-4 are Dest, bits 3-0 are Src (showing 0: bits ordering from MSB to LSB)
- Sample solution: Diagram of PCP instruction format
### Task 3 Solution: Processor Block Diagram
**The CPU design can be largely along the lines as per the explanations given in L11 and 12**
- Instruction Register (IR): Stores instruction from program memory to execute
- Control Unit: Fetches, decodes, and executes instructions
  - Instruction Decoder: This can be considered within the CU, it translates instructions into control signals
- Register set: Stores register data used in computations
- ALU: Performs arithmetic and logical operations
- Memory Control Unit (MCU) or memory interface: Handles data transfer between the processor and memory. You will find out soon, in lecture 13, about the MCU. The diagram shows the MCU connecting directly to the register set, that would of course need some intervention form the control unit; in this case accessing memory and IO is via registers
- I/O Control Unit (ICU): Manages data transfer between the processor and external devices
- Block diagram shows: IR (Instruction Register), Control Unit receiving instruction and sending control signals to Register Set and ALU, Register Set interfacing with ALU and feeding to ALU inputs, MCU and ICU connecting to the Register Set
### Task 4: Mind Mapping/Connections
**Guidance for visualization of connections**
- You could just sketch ideas and add annotations to links or components to show how they relates, or ideas for how the connections or design aspects would be implemented
- In terms of software to consider, XMind is recommended (if using on a PC), there are lots of alternate apps for smartphone or tablet (a decent size tablet is rather useful for this activity)
### Task 5: Partial Design Presentation
**Final design synthesis**
- Having written up responses to Tasks 1-4, the "partial design presentation" is effectively done
- The idea is that Tasks 1-4 basically guide your thinking and strategizing for deciding an effective design for PCP
- You don't need to worry with writing it up as a more formal document or presenting it (e.g. using slides) to classmates (although that would be a good idea and enhance the activity, bringing in some profcomms, but we don't really have time for that)
- If you do have any design approaches or want to get my opinion and review on an approach you were considering, then by all means let me know and I'd be happy to review and discuss that
### Conclusion of PCP Activity
**The aim of completing this activity**
- You will gain valuable insights into the intricacies of computer architecture and ISA design, albeit it provided to just a simple processor
- You will learn to translate high-level program requirements into concrete hardware implementations, laying a strong foundation for further exploration in this exciting field
- This PCP is in reality a type of processing element sometimes needed in real designs, for instance in FPGA solutions where you may need to capture data from possibly many different sources, possibly at the same time, and forward the data on in a suitably structured manner to a host processor or pc
- Remember, the focus here is on understanding the core concepts and design process, not on intricate low-level details. Have fun designing your peripheral controller processor!
