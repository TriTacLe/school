---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L15 Analogue signal generation and DAC
Timers and PWM for digital-to-analog conversion. DAC architectures: GPIO PWM DAC, R2R Ladder, Binary Weighted DAC.
### Timer Recap
**Timer Modes of Operation**
- Normal Mode: counts up, no clear, counter wraps when it overflows
- Clear Timer on Compare (CTC) match mode: resets counter when it matches a compare value
- Fast Pulse Width Modulation (PWM) Mode: generates PWM signal with configurable duty cycle
- Phase Correct PWM mode: PWM that maintains consistent frequency with phase alignment
**Periodic Interrupt Timer (PIT)**
- Counts at a frequency (usually processor clock divided by some factor)
- When count reaches zero, fires interrupt and reloads count value
- Useful for generating periodic events at regular time intervals
- Can be used to generate timing signals for PWM and DAC applications
- 32-bit counter loads with start value and counts down with each clock pulse
- Calculation: `period = round(T * X_count)` where T = 1/f_CLK and f_CLK is clock frequency
### Pulse Width Modulation (PWM)
**PWM Basics**
- Varies the duty cycle (ratio of on-time to total period) to encode information
- Allows digital signals to modulate analog signals
- Period remains constant, only width of pulse changes
- Duty cycle can be expressed as percentage of total period
- Example: 25% duty cycle means signal is on for 1/4 of the period

**PWM Applications**
- Power control (LED brightness, motor speed)
- Signal generation (analog output approximation)
- Can be hardware-generated (timer peripherals) or software-controlled
**PWM for Communications and Modulation**
- Can transmit information over a carrier wave by modulating the pulse width
- Used in Software Defined Radio (SDR) designs to shape carrier signals
- 50% duty cycle = no data (F_m = 0, no modulation)
- Varying duty cycle produces pulses at clock frequency with varying magnitude
- Carrier frequency F_c Hz modulated by message signal
- Output fed through capacitors and mixer creates modulated analog signal
- Modulation frequency F_m relates to carrier as F_m = 1/(K*T) where T is period
### DAC Conceptual Design
**Digital-to-Analog Conversion**
- Takes digital value and produces analog voltage output
- Must convert discrete steps to continuous voltage range
- Resolution depends on number of bits and reference voltage
- Reference voltage (Vref) sets the full-scale output range

**Basic DAC Block Diagram**
- Digital input provides bit pattern
- Decoding logic selects appropriate analog value
- Output stage produces analog voltage or current
### GPIO-Based PWM DAC
**GPIO PWM DAC Implementation**
- Use GPIO pin toggled by timer to generate PWM signal
- PWM frequency set by timer reload value
- Duty cycle controlled by timer compare value
- GPIO toggles between digital 0V and VDD at PWM frequency
- Filtering removes PWM carrier, leaving smooth analog signal

**Advantages**
- Simple, minimal hardware required
- Can be implemented on any microcontroller with GPIO and timer
- Software-controllable through timer registers

**Limitations**
- Limited resolution (only PWM frequency and compare value matter)
- Switching noise at PWM carrier frequency
- Filtering adds complexity
### PWM DAC with Filtering
**Low-Pass Filter for PWM DAC**
- RC filter (resistor and capacitor) removes high-frequency PWM carrier
- Cutoff frequency must be well below PWM frequency but above signal frequency
- Smoother analog output than unfiltered PWM
- Filter choice depends on output impedance requirements

**Passive RC Filter**
- Simple resistor-capacitor network
- Time constant tau = R * C determines cutoff frequency
- Attenuation increases with frequency
- Phase shift introduced by filter

**Active Filter Options**
- Op-amp based filters provide better performance
- Can compensate for loading effects
- May require additional supply voltage
### R2R Ladder DAC
**R2R Ladder Architecture**
- Uses network of resistors in pattern of R and 2R values
- Each bit controls a switch connecting node to either Vref or ground
- Produces output through summing amplifier (op-amp)
- Output voltage determined by binary weighted sum of switched resistors

**R2R Ladder Operation**
- MSB has largest weight, LSB has smallest weight
- Each bit position contributes (Vref / 2^n) to output
- Resolution determined by number of resistors (bits)
- Monotonic if resistor tolerances are good

**Advantages of R2R**
- Only two resistor values needed (R and 2R)
- Scales easily to higher resolution
- Settling time independent of number of bits
- Output impedance relatively low

**Limitations**
- Resistor tolerances directly impact linearity
- Requires precision resistors for good resolution
- Current output requires additional circuitry for voltage output
### Binary Weighted DAC
**Binary Weighted Architecture**
- Each bit controls switch selecting between ground and Vref
- Resistor value for each bit inversely proportional to bit weight
- MSB uses smallest resistor (largest current contribution)
- LSB uses largest resistor (smallest current contribution)

**Binary Weighted Operation**
- Output current is sum of weighted currents from each switch
- First bit contributes I, second contributes I/2, third contributes I/4, etc.
- Summing amplifier converts current to voltage output
- Resolution determined by number of weighted resistors

**Limitations of Binary Weighted DAC**
- Resistor values span large range (for N-bit DAC, ratio can be 2^N)
- Large range of resistor values makes tolerances challenging
- Resistor matching more critical than R2R
- Leakage currents from switch off-resistance can degrade accuracy
### DAC Performance Metrics
**Key DAC Specifications**
- Resolution (bits): number of distinguishable output levels
- Accuracy: how close output is to ideal value
- Linearity: whether output steps are uniform
- Settling time: time required to reach final value after input change
- Monotonicity: output always increases or decreases with input (no missing codes)
- Output impedance: electrical loading characteristics

**Quantization**
- DAC resolution creates discrete voltage steps
- Smallest step size = Vref / 2^N (in volts per step)
- Actual output quantized to nearest step value
- Limits precision of analog signal generation
## L16 ADC design 1 of 2
Analog-to-digital conversion architectures. Flash ADC, Successive Approximation, Multi-stage, Pipelined topologies.
### ADC Conceptual Model
**Analog-to-Digital Converter Basics**
- Takes analog input voltage and produces digital output code
- Converts continuous signal into discrete digital representation
- Resolution determines number of possible output codes
- Sampling captures voltage at specific points in time

**ADC Signal Path**
- Analog input signal
- Sampling and hold circuitry
- Comparison logic against known reference levels
- Encoding to binary output
- Digital output bits
**Conceptual ADC Example**
- DAC output voltages from changing binary counter values show transfer function
- Least Significant Bit (LSB) = step size in volts (e.g., 0.25V for a 4-bit ADC with 1V reference)
- Each digital output code corresponds to input voltage range equal to one LSB step
- Example: 4-bit ADC with 1V reference: codes 0000-1111 map to 0V-1V range, step size = 1V/16 = 0.0625V
- Physical properties of system affect actual step size due to environmental fluctuations (temperature, humidity)
### Flash ADC (Parallel Comparator ADC)
**Flash ADC Architecture**
- Uses parallel array of comparators (one per possible output code)
- Each comparator compares input to different reference threshold
- All comparisons happen simultaneously (parallel)
- Thermometer code output from comparators encoded to binary
- Fastest ADC topology available

**Flash ADC Operation**
- Analog input applied to all comparator non-inverting inputs
- Each comparator has different reference voltage (ladder from Vref)
- Comparators produce thermometer code (all 1s below threshold, all 0s above)
- Encoder converts thermometer code to binary representation
- Conversion time limited by comparator delay and encoder logic

**Advantages of Flash ADC**
- Fastest conversion (no iterations needed)
- Simple architecture, easy to implement
- Good for high-speed applications
- Conversion time independent of resolution

**Limitations of Flash ADC**
- Requires 2^N comparators for N-bit resolution
- Power consumption grows exponentially with bits
- Large silicon area requirements
- Difficult to achieve high resolution (8-bit needs 256 comparators)
- Comparator offset and mismatch limit accuracy
### Successive Approximation ADC (SA-ADC)
**Successive Approximation Operation**
- Uses binary search algorithm to find output code
- Compares input against trial value starting from MSB
- Each iteration determines one output bit
- Requires N iterations for N-bit resolution
- Uses single comparator (much simpler than Flash)

**SA-ADC Block Diagram**
- Analog input
- Sample-and-hold circuit freezes input during conversion
- Single high-speed comparator
- DAC generates trial voltages
- SAR (Successive Approximation Register) controls search
- Output becomes stable when all bits determined

**SA-ADC Algorithm**
- Start with MSB = 1, lower bits = 0
- Compare input to DAC output
- If input greater, keep bit as 1; else change to 0
- Move to next bit and repeat
- After N iterations, all bits determined

**Advantages of SA-ADC**
- Uses only one comparator (efficient)
- Moderate speed, good for most applications
- Reasonably low power consumption
- Scales well to higher resolution
- Good resolution-to-speed tradeoff

**Limitations of SA-ADC**
- Conversion takes N clock cycles minimum
- DAC settling time critical for accuracy
- Requires accurate DAC inside ADC
- Not suitable for very high-speed applications
### Multi-Stage Flash ADC
**Multi-Stage Topology**
- Uses cascade of simpler flash stages
- Each stage converts portion of bits with fewer comparators
- Reduces total comparator count versus single-stage flash
- Adds delay due to multiple stages but maintains reasonable speed

**Multi-Stage Operation**
- First stage converts upper bits (coarse)
- Remaining error amplified
- Second stage converts lower bits (fine)
- Residue from first stage becomes input to second
- Stages operate on different time scales

**Comparator Reduction**
- Two 4-bit stages need 16 + 16 = 32 comparators
- Single 8-bit flash would need 256 comparators
- Significant hardware reduction with cascading

**Advantages**
- Much lower power than full-parallel flash
- Smaller silicon area than single-stage flash
- Faster than SA-ADC for same resolution
- Good for medium to high-speed applications

**Limitations**
- Slower than single-stage flash ADC
- Requires accurate amplifiers and interleaving logic
- More complex than SA-ADC
- First-stage errors propagate to final result
### Pipelined Flash ADC
**Pipelined Architecture**
- Multiple stages operating on different samples simultaneously
- Each stage processes output of previous stage while next stage starts
- High throughput despite moderately long latency
- Each stage is simpler than single-stage implementation

**Pipelined Operation**
- Sample 1 enters stage 1
- When sample 1 moves to stage 2, sample 2 enters stage 1
- When sample 1 moves to stage 3, sample 2 in stage 2, sample 3 enters stage 1
- After pipeline full, output ready every clock cycle
- Latency = number of stages, but throughput is high

**Pipeline Advantages**
- High throughput for streaming applications
- Power efficiency better than single-stage flash
- Lower area than full-parallel flash
- Suitable for real-time signal processing

**Pipeline Limitations**
- Higher latency due to cascading stages
- Requires precise timing synchronization
- Residue mismatch can cause errors
- More complex control logic
### Resolution and Speed Tradeoffs
**ADC Architecture Selection**
- Flash: highest speed, highest power and area, lower resolution typical
- SA-ADC: moderate speed, low power, good resolution, widely used
- Multi-stage: high speed with lower power than full flash
- Pipelined: high throughput, good power efficiency

**Speed-Power-Area Tradeoffs**
- Higher resolution requires more comparators or longer conversion time
- Faster conversion typically requires more power
- Area grows with number of comparators or complexity
- Technology node affects all metrics

**Practical Selection Criteria**
- Required resolution (8, 10, 12, 16 bits common)
- Maximum sampling rate needed
- Power budget constraints
- Silicon area available
- Noise and accuracy requirements
