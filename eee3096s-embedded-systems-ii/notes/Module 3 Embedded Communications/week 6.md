---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L11a Memory addressed IO
### I/O Programming Principles
**Peripheral Access and I/O**
- Microcontrollers interact with peripherals through memory-mapped or port-mapped I/O
- Memory-mapped I/O: peripheral registers appear as regular memory addresses
- Port-mapped I/O: uses special CPU instructions to access a separate I/O address space
- Both approaches require the CPU to read from and write to hardware registers

**Accessing Hardware in C**
- Hardware registers can be accessed through C pointers
- Care must be taken to tell the compiler that register values can change independently
- The volatile keyword prevents compiler optimization of register accesses
### Port-Mapped I/O
**Port-Mapped I/O Characteristics**
- Separate address bus for I/O (not shared with memory)
- Special CPU instructions (IN, OUT) to read/write I/O addresses
- Address range typically 0 to 65535 (16-bit I/O address space)

**Advantages**
- Separate I/O and memory address spaces reduce potential conflicts
- Can use full address range for both memory and I/O

**Disadvantages**
- Requires special instructions, adding complexity
- Not all processors support port-mapped I/O
- Less commonly used in modern microcontrollers
### Memory-Mapped I/O
**Memory-Mapped I/O Characteristics**
- Peripheral registers occupy specific memory addresses
- Same bus used for both memory and I/O access
- CPU reads/writes peripherals using standard memory instructions (load/store)
- Addresses are reserved in the memory map and not used for RAM or ROM

**Advantages**
- Simpler to use, same instructions for memory and I/O
- More flexible, can use any memory access instruction
- Most modern microcontrollers use this approach

**Disadvantages**
- Reduces available memory space
- Bus bandwidth shared between memory and I/O
- Potential for accidental memory corruption if peripheral addresses are written incorrectly

**Example with ADC Peripheral**
- ADC control register at memory address 0x40012000
- Access via pointer: `*((volatile uint32_t *)0x40012000) = 0x01`
- This writes 0x01 to the ADC control register
### Volatile Keyword
**Why Use Volatile**
- Compiler optimizations assume variable values only change through explicit code
- Hardware registers change independently of program control
- Without volatile, compiler may cache register value in CPU register instead of re-reading
- Volatile forces compiler to access memory location each time

**Code Example**
```c
volatile uint32_t *status = (volatile uint32_t *)0x40012004;
while (*status == 0) {
    // Loop waits for status bit change
    // Without volatile, compiler might optimize away loop
}
```

**Another Example**
```c
volatile uint32_t reg = *(volatile uint32_t *)0x40012000;
reg = *(volatile uint32_t *)0x40012000;  // Must re-read each time
// Without volatile, compiler reuses first read value
```
### Linker Sections and Symbol Strength
**Linker Sections**
- .text: contains executable code and read-only constants
- .data: contains initialized global and static variables
- .bss: contains uninitialized global and static variables (Block Started by Symbol)
- Memory models define where these sections load in ROM/RAM

**Strong vs Weak Symbols**
- Strong symbol: procedure definition or initialized global variable
- Weak symbol: uninitialized global variable
- Linker resolves references by preferring strong symbols
- If only weak symbols exist, linker picks one arbitrarily
- Allows default implementations to be overridden by strong definitions
### Memory-Mapped I/O Access Approaches
**Approach 1: Using Arrays**
```c
volatile uint8_t PORT_A[256];  // 256-byte port region
PORT_A[0x00] = 0x55;           // Write to offset 0x00
```

**Approach 2: Direct Assembly Access**
```asm
MOV R0, #0x40012000     ; Load address
MOV R1, #0x01          ; Load value
STR R1, [R0]           ; Store to peripheral
```

**Approach 3: Pointers**
```c
uint32_t *reg = (uint32_t *)0x40012000;
*reg = 0x01;
```

**Approach 4: Structures (Recommended)**
```c
typedef struct {
    volatile uint32_t CR;      // Control register at offset 0
    volatile uint32_t SR;      // Status register at offset 4
    volatile uint32_t DR;      // Data register at offset 8
} ADC_TypeDef;
#define ADC ((ADC_TypeDef *)0x40012000)
ADC->CR = 0x01;  // Write to ADC control register
```
### Hardware Register Structures
**STM HAL GPIO Structure Example**
- STM provides pre-defined structures for peripheral access
- Structures map to hardware register layout
- Using structures ensures correct offsets and types
- Improves code readability and reduces errors

**Enrichment Activity: Digital Recording Device**
- Design a memory-mapped I/O system for a 32-bit microcontroller-based recording device
- Understand peripheral integration and address space allocation

**Device Peripherals and Specifications**
- 10-bit ADC: for recording voice with 1-bit Data_Request line and 10-bit Data_Out line
- USB: for downloading recorded data with Send_Data input, Receive_Data input, 8-bit DataIn/DataOut lines
- 4 LEDs: "power", "record", "full", "comms"
- 2 pushbuttons: "record/stop" and "pause/continue"

**Memory Layout**
- 32Kb internal program flash: address 0x0 to 0x7FFF
- 32Kb internal SRAM for data: address 0x8000 to 0xFFFF
- 2 Megabytes external RAM on memory bus

**Exercise Task**
- Develop a memory map showing memory device placement
- Map peripheral locations into the address space
- Design chip select logic to activate correct device when reading/writing specific addresses
## L12 State machines
### Modeling Dynamic Behaviour
**System Modeling Overview**
- Use cases capture communication and control requirements
- Real-time and QoS requirements must be identified and defined
- Fundamental operations of the system need careful definition
- Dynamic behaviour is a refinement of use cases and requirements
- Defines how classes and components operate and interact

**Refinement Process**
- Dynamic behaviour provides behavioral detail not captured in static models
- Helps define the operation and control flow within the system
- Essential for understanding sequential decision-making and state transitions
### FSM Fundamentals
**Finite State Machine Definition**
- A mathematical model of computation with finite number of states
- Transitions occur based on input events
- Output produced based on current state and/or input
- Described formally: M = (Q, Sigma, Delta, q0, F) where Q is states, Sigma is input alphabet, Delta is transition function, q0 is initial state, F is final states

**FSM Advantages**
- Visual representation clarifies system behavior
- Intuitive modeling of sequential decision-making
- Mathematically rigorous and verifiable
- Easy to implement and debug
- Supports formal verification and testing

**Abstracting FSM Models**
- High-level FSMs hide implementation details
- Focus on key states and important transitions
- Omit trivial transitions and intermediate states
- Group related transitions for clarity
### FSM Types and Comparison
**Mealy Machine**
- Output depends on current state AND input
- Outputs occur on transitions
- Fewer states often needed than Moore machines

**Moore Machine**
- Output depends only on current state
- Outputs occur in states
- More states but simpler to reason about

**Kripke Structure**
- States labeled with propositions (state properties)
- Transitions unlabeled
- Used for temporal logic properties
### Deterministic vs Non-Deterministic FSM
**Deterministic FSM (D-FSM)**
- From any state, given an input, exactly one transition defined
- Predictable behavior, single execution path
- Easier to implement

**Non-Deterministic FSM (ND-FSM)**
- From a state, an input may have multiple possible transitions
- Multiple execution paths possible
- Can model abstraction or incomplete specifications
- Arises when details are hidden or multiple options exist

**Nondeterminism Through Abstraction**
- Abstracted FSM loses detail, creating apparent nondeterminism
- Multiple low-level transitions map to single abstract transition
- Abstraction reveals essential behavior by hiding complexity
### Thermostat Example (Moore Machine)
**States**
- Off: heating system inactive
- Heating: actively heating
- Idle: reached target temperature

**Transitions**
- Off to Heating: temperature falls below threshold
- Heating to Idle: temperature reaches target
- Idle to Heating: temperature falls below threshold again

**Outputs**
- Off state: burner off
- Heating state: burner on
- Idle state: burner off
### State Machine Formal Definition
**Components**
- Set of states Q
- Set of input events (input alphabet)
- Set of output events (output alphabet)
- Transition function (state, input) -> (new state, output)
- Initial state q0

**Sequence of Operation**
1. Start in initial state
2. Receive input event
3. Execute transition: move to new state and produce output
4. Return to step 2
### FSM Limitations
**Constraints**
- FSMs model sequential logic only, not concurrent behavior
- No memory between states (state holds all information)
- Cannot easily model continuous variables or analog behavior
- Scalability limited for complex systems (state explosion)

**Workarounds**
- Use hierarchical FSMs for complexity
- Combine FSM with data variables for extended state
- Model concurrent behavior with multiple FSMs
- Use other formalisms (timed automata, Petri nets) for advanced features
### UML Approach and State Charts
**UML State Machines**
- Visual notation standardized by Object Management Group
- States drawn as rounded rectangles
- Transitions shown as arrows labeled with event/action
- Entry/exit actions and internal transitions supported

**Statecharts (Harel Automata)**
- Extends FSMs with hierarchy, concurrency, and history
- Hierarchical states contain substates
- Orthogonal regions for concurrent behavior
- History pseudo-states remember previous substate
- More expressive than flat FSMs

**Concurrency in State Machines**
- Multiple independent behaviors modeled simultaneously
- Oil pressure and water temperature monitoring example
- Each property has own state machine running in parallel
- All conditions must be satisfied for safe operation
### Environmental Test Chamber Case Study
**System Requirements**
- Control temperature and humidity in sealed chamber
- Maintain setpoints with tolerance bands
- Monitor sensor inputs continuously
- Provide alerts and safety shutdowns

**FSM Modeling Approach**
- States: Idle, Heating, Cooling, Humidifying, Dehumidifying
- Inputs: sensor readings, setpoint changes, error conditions
- Outputs: actuator commands (heater, cooler, humidifier)
- Transitions: based on sensor comparisons to thresholds

**Moore Machine Solution**
- Each state has associated outputs
- Exit one state only when condition met for next state
- Output remains constant while in state
- Suitable for actuators that need sustained commands

**State Machine Sample Solutions**
- Thermostat controller: demonstrating Moore model
- Traffic light system: showing deterministic transitions
- Environmental chamber controller: combining multiple FSMs
### FSM and Statechart References
**Design Resources**
- UML specification from Object Management Group
- Statechart theory by David Harel
- FSM textbooks and academic papers
- CAD tools with FSM support (Simulink, StateMachine tools)
