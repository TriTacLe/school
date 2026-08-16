---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L16a Information theory and sampling
Sampling theory, Shannon's Theorem, Nyquist criterion. Hardware-in-the-loop simulation for embedded systems testing.
### Hardware-In-The-Loop (HITL) Simulation
**HITL Concept**
- Replaces physical system or sensors with simulation software
- Embedded system under test connects to simulated environment
- Real hardware interacts with virtual plant model
- Allows testing without expensive hardware or dangerous conditions
- Bridges gap between pure simulation and real-world testing

**HITL Application Example: Race Car ECU**
- Engine Control Unit (ECU) controls fuel injection, spark timing
- HITL replaces actual engine with software model
- Model calculates engine response to ECU commands
- Simulated sensors feed back engine state to ECU
- ECU sees realistic engine behavior without physical engine

**HITL Benefits**
- Test in compressed time (simulate hours in seconds)
- Repeatable test conditions (same input always produces same response)
- Safe testing of edge cases and failure modes
- No hardware wear or consumables
- Early validation before hardware availability
- Cost effective for development phase

**HITL Drawbacks**
- Simulation model must be accurate
- Mismatches between simulation and reality may hide bugs
- Environmental factors not captured in model
- Model development and validation adds time
- Doesn't catch hardware-specific integration issues
- Real-world timing constraints may differ
### Sensor Types and Signals
**Common Embedded Sensors**
- Temperature: thermistor or IC sensor
- Pressure: piezoelectric or capacitive
- Acceleration: MEMS accelerometer
- Position: potentiometer or encoder
- Velocity: tachometer or gyroscope
- Light: photodiode or phototransistor

**Signal Characteristics**
- Continuous: naturally varying over time (temperature, pressure)
- Discrete: only specific states (digital switch, button)
- Analog: voltage or current proportional to measured quantity
- Digital: already in binary format
- Noise: unwanted variations on true signal
### Sampling and Digitization
**Why Sample Signals**
- Embedded systems work with digital data (binary)
- Analog sensors produce continuous signals
- Must convert continuous signal to discrete samples
- Sampling captures signal at specific time points
- Quantization maps continuous voltage to discrete digital code

**Sampling Process**
- Sample-and-hold circuit captures voltage at precise moment
- Capacitor holds voltage stable during ADC conversion
- ADC converts held voltage to digital code
- Process repeats at regular sampling intervals
- Frequency of sampling = sampling rate (samples per second)

**Nyquist Sampling Rate**
- Sampling frequency must be at least twice signal bandwidth
- If highest signal frequency is f_max, need f_s >= 2 * f_max
- Violating this causes aliasing (information loss)
- Rule of thumb: sample 5-10 times faster than fastest signal change
- Practical designs often oversample to simplify filtering
### Sample-and-Hold Circuits
**Sample-and-Hold Block Diagram**
- Input signal (continuous)
- Analog switch (controlled by timing pulse)
- Capacitor (holds voltage)
- Output amplifier (buffer, high input impedance)

**Sample Phase**
- Switch closes, capacitor charges to input voltage
- Capacitor voltage tracks input signal
- Acquisition time determines sampling accuracy
- Settling required before switching to hold

**Hold Phase**
- Switch opens, capacitor maintains constant voltage
- Leakage current slowly discharges capacitor
- Hold time limits how long voltage remains stable
- Output amplifier provides stable buffered output to ADC

**Practical Considerations**
- Acquisition time: time to accurately sample new input
- Aperture time: time switch is open (defines sampling instant precision)
- Hold time: time capacitor can maintain voltage within spec
- Droop rate: voltage loss per unit time during hold (leakage)
- Charge injection: capacitor voltage shifts when switch opens
### Shannon's Theorem
**Shannon's Theorem Statement**
- No cable or signal is perfectly clean
- Interference from other sources causes noise on line
- Shannon's theorem predicts maximum data speed through noisy channel
- Relates achievable throughput to signal power and noise power
- Fundamental limit of information theory

**Shannon Capacity Formula**
- C = B * log2(1 + S/N)
- Where C is channel capacity (bits per second)
- B is bandwidth (frequency range available)
- S is signal power
- N is noise power
- S/N is signal-to-noise ratio

**Shannon's Implications**
- More signal power increases throughput
- More noise reduces throughput
- Wider bandwidth increases capacity (more room for data)
- Doubling SNR adds more capacity
- Shows fundamental tradeoff between speed, power, and noise

**Relevance to Communications**
- Network cables have noise and interference
- Must balance data rate, power, and noise tolerance
- Adding error correction helps when SNR is low
- Useful for understanding channel limitations
### Nyquist's Theorem (Sampling)
**Nyquist's Theorem Statement**
- Any signal can be represented by discrete samples if sampling frequency is at least twice signal bandwidth
- f_sampling > 2 * f_signal (sampling frequency must exceed twice signal frequency)
- A bandlimited analog signal sampled at f_s can be perfectly reconstructed from infinite sequence of samples if f_s > 2 * f_max
- f_max is highest frequency in original signal

**Nyquist Criterion**
- Sampling rate must exceed twice the bandwidth of the signal you want to sample
- Critical for embedded engineers since sampling needs to be twice as fast as speed of signal changes
- General rule of thumb: sampling rate must be at least 2x frequency of signal you are sampling

**Aliasing**
- Occurs when signal contains frequency components larger than (1/2) * f_s
- Analog signal appears to have different frequency than original
- Different signals become indistinguishable when sampled below Nyquist rate
- When digital signal is reconstructed, appears to have wrong frequency
- Can introduce false signals not present in original analog

**Nyquist Band**
- Nyquist frequency = f_s / 2 (half the sampling rate)
- All signal energy must be below Nyquist frequency to avoid aliasing
- Frequencies above Nyquist fold back into lower frequencies
- Example: 2200 Hz signal sampled at 2000 Hz appears as 200 Hz (aliasing)
### Sampling and Aliasing Examples
**Example: 200 Hz Signal Sampled at 2000 Hz**
- Signal frequency well below Nyquist (1000 Hz)
- Sampling rate is 10x signal frequency
- Reconstruction shows correct 200 Hz waveform (not aliased)
- Sufficient samples to capture signal shape accurately

**Example: 2200 Hz Signal Sampled at 2000 Hz**
- Signal frequency above Nyquist frequency (1000 Hz)
- Violates Nyquist criterion (f_s < 2 * f_signal)
- Aliasing occurs, sampled signal appears as 200 Hz (200 Hz alias)
- Cannot distinguish original 2200 Hz from 200 Hz after reconstruction

**Example: 1000 Hz Signal Sampled at 2000 Hz**
- Signal at exactly Nyquist frequency (f_s / 2)
- Borderline case, at edge of aliasing
- Cannot reliably reconstruct correct waveform
- Need margin above Nyquist for practical implementation

**Aliasing Prevention**
- Use analog low-pass filter before sampling (anti-aliasing filter)
- Filter removes frequency components above f_s / 2
- Must transition smoothly from pass-band to stop-band
- Steepness determines how far above Nyquist protection extends
### Difference Between Shannon and Nyquist's Theorems
**Nyquist's Theorem: Sampling Rates**
- Deals with concept of sampling rates
- Extremely important for embedded engineers
- Sampling needs to be twice as fast as speed of signal changes you want to detect
- General rule: your sampling rate must be at least 2x frequency of signal you are sampling

**Shannon's Theorem: Throughput**
- Has to do with throughput
- No cable or signal is perfectly clean
- There is lot of interference from other sources that cause noise on line
- What Shannon's theorem does is predicts speed of data that you can push through cable before noise becomes too much of factor
- Looking at this aspect may be useful in ECE design project

**Relationship Summary**
- Nyquist is all about sampling, Shannon is all about noise
- They are related as speed of data impacts both theorems
- Nyquist: tells you what frequencies you can expect to get out for certain ADC (assuming ADC is linear and pretty perfect)
- Shannon: tells you most you can get out of your channel (excluding super Shannon)
### Shannon and Nyquist Relevant to ADCs
**ADC Planning Using Formulas**
- These formulae are useful tools for planning what ADCs you need
- Determine what system will be capable of in terms of sampling and utilizing channels
- Shannon tells you most you can get out of your channel
- Nyquist tells you what frequencies you can expect to get out for certain ADC

**Shannon Application to ADCs**
- Most you can get out of channel, excluding super Shannon
- No perfectly clean cable or signal, there is interference from other sources
- Noise on line limits data speed before noise becomes too much of factor
- Predicts speed of data that you can push through cable before noise dominates

**Nyquist Application to ADCs**
- Tells you what frequencies you can expect to get out for certain ADC
- Assuming ADC is linear and pretty perfect, we will see later how ADCs may be imperfect
- You might not even be able to reliably sample F_s / 2 frequencies
- Tells what sampling rates needed for detecting certain signal frequencies
## L17 ADC design 2 of 2
ADC performance metrics, quantization, resolution, accuracy, and linearity specifications. Static and dynamic ADC characteristics.
### ADC Resolution
**Resolution Definition**
- Resolution (in bits): number of bits produced by ADC
- Resolution Q (in volts): difference between two input voltages causing output to increment by 1
- Quantization factor calculation: Q = V_FSR / n (where n = 2^N for N-bit ADC)
- Example: 8V full-scale range, 3-bit ADC gives Q = 8 / 8 = 1V per step, 8-bit gives 8 / 256 = 31.25mV per step

**Resolution and Signal Fidelity**
- Higher resolution enables more accurate representation of analog signal
- Each additional bit halves the voltage step size
- More levels available to represent signal variations
- Limited by noise and ADC linearity at higher resolutions

**Unique Output Codes**
- Number of unique codes = 2^N (N = number of bits)
- N-bit ADC produces codes from 0 to 2^N - 1
- Each code represents voltage range of one quantization step
- Answers question: how many voltage levels can your ADC or DAC quantize?

**Trends in ADC Resolution Over Time**
- 1986-1990: ADCs typically 6-8 bits resolution
- 1991-2000: Advancement to 8-12 bits, improved performance
- 2001-2008: Resolution increased to 12-16 bits, better accuracy
- 2008 onwards: 16-24+ bits available in commercial products
- Historical trend shows consistent improvement in both resolution and sampling rates
- Sampling rates scaled from MHz to GHz range across decades
- Trade-off: higher resolution usually means lower maximum speed
- ENOB (Effective Number of Bits) limits practical resolution due to noise
### ADC/DAC Quantization
**Quantization Definition**
- Mapping of analogue voltages to digital codes
- Continuous analog signal approximated by discrete digital values
- Analog sine wave becomes staircase digital representation
- Quality of representation depends on resolution and quantization levels

**Quantization Error**
- Quantization causes inherent loss of information
- Signal rounded to nearest digital level
- Maximum error = ± 0.5 LSB (one-half of least significant bit)
- Creates quantization noise (jagged appearance vs smooth curve)

**3-Bit ADC Example**
- Full-scale range 7/8 to 8/8 volts produces output 111
- 6/8 to 7/8 volts produces 110
- 5/8 to 6/8 volts produces 101
- And so on through all 8 possible codes
- Coarser quantization results in visible stepping in reconstructed signal

**Quantization Levels**
- More bits provide more quantization levels and finer granularity
- 1-bit resolution: only 2 levels (crude, high noise)
- 2-bit resolution: 4 levels (better)
- 4-bit resolution: 16 levels (recognizable)
- 8-bit resolution: 256 levels (reasonably smooth)
- 16-bit resolution: 65,536 levels (very smooth)
### Static Metrics of an ADC
**Static Metric Definition**
- DC (direct current, or zero-frequency constant input) performance
- Does it read 0 when input is 0V?
- Measured with stationary, unchanging analog input signal
- Represents steady-state accuracy of ADC

**Static Metric Measurement**
- Apply constant analog input voltage
- Measure digital output code
- Compare to expected value from ideal transfer function
- Repeat over full input range
- Deviations from ideal indicate static errors
### Offset Error
**Offset Error Definition**
- Deviation of ADC output code transition points from ideal
- Present across all output codes
- Systematic error in all measurements
- Similar to offset error in amplifiers

**Offset Error Impact**
- If input is 0V, ADC does not read exactly 0
- All readings shifted by constant amount
- Example: input should read 101 but reads 100 (offset error of 1 LSB)
- Occurs at every digital code level

**Offset Error Visualization**
- Ideal transfer function passes through origin (0V input = 0 code)
- Actual ADC transfer function shifted vertically
- Shift amount = offset error in LSBs or volts
- Occurs uniformly across entire input range

**Offset Error Correction**
- Can easily be corrected using microcontroller
- Reduces dynamic range of ADC by one code in software
- Measure offset at 0V input, subtract from all future readings
- Improves accuracy significantly with minimal effort
### Static Metric: Gain Error
**Gain Error Definition**
- Similar to gain error of amplifier
- Determines amount of "rotational" deviation away from ADC ideal transfer function slope
- Assuming ADC offset error is removed first
- Affects full-scale span of ADC

**Gain Error Characteristics**
- Gain error determines "rotational" deviation from ideal slope
- May occur at different Vrefs (reference voltages)
- Wider ADC output range or bigger jump produces larger gain error
- Slope of transfer function not ideal (dashed diagonal line of figure)

**Gain Error Correction**
- Once gain error has been characterized, it may be possible to compensate
- Requires knowledge of gain error characteristics
- More complex than offset correction (involves scaling)
- Improves end-to-end accuracy
### Dynamic Metrics of an ADC
**Dynamic Metric Definition**
- ADC performance with changing input signals
- Measured with time-varying analog inputs
- Reflects real-world signal processing scenarios
- Captures effects of noise and nonlinearity under dynamic conditions
### ADC and DAC Metric: LSB Accuracy
**LSB Accuracy Concept**
- Compares how LSB change in digital code relates to step change in measured voltage
- Relates directly to quantization granularity
- Important for precision measurements
- Varies with different Vref values (reference voltages)

**LSB Calculation**
- LSB = Vref / 2^n (for n-bit ADC)
- Example: 8V full-scale, 3-bit ADC: LSB = 8 / 8 = 1V
- Example: 5V full-scale, 8-bit ADC: LSB = 5 / 256 = 19.53mV
- Consistency across all codes important for linearity

**LSB Accuracy Impact**
- Wider ADC with different Vref will have different jump sizes
- LSB accuracy affects resolution and useful signal discrimination
- System must oversample noise floor to extract full ADC resolution
- Consistency between Vref and 2^n directly determines LSB size
### ADC and DAC Metric: Linearity (DNL)
**Differential Non-Linearity (DNL) Definition**
- Deviation between actual steps and ideal steps
- Measures how closely actual step sizes match ideal step sizes
- Must be < 0.5 LSB to ensure no missing codes
- Signed parameter (can be positive or negative)

**DNL Requirement**
- To avoid missing codes (no output code missing from sequence)
- DNL must be less than 0.5 LSB
- If DNL exceeds 0.5 LSB, some digital output codes unreachable
- Creates gaps in conversion, unrecoverable information loss

**DNL Visualization**
- Ideal transfer function shows uniform steps
- Actual ADC has steps of varying heights
- Positive DNL: actual step larger than ideal (output jumps farther)
- Negative DNL: actual step smaller than ideal (output doesn't advance enough)
- Deviations from diagonal line show DNL error
### ADC and DAC Metrics: Linearity (INL)
**Integral Non-Linearity (INL) Definition**
- Integration of DNL error (accumulation of all DNL errors)
- Represents cumulative deviation from ideal straight-line transfer function
- Measured from 0V input to full-scale input
- Sum of all DNL errors against ideal line

**INL Calculation**
- Accumulation of all individual DNL deviations
- Some DNLs may be positive, some negative
- Errors can partially cancel (net INL may be lower than sum of absolute DNLs)
- If you want very pedantic (type-A analysis), work out absolute INL: sum of |DNL_i| for i = 0 to (2^N - 1)

**INL Visualization**
- Ideal straight-line diagonal from (0,0) to full-scale
- Actual transfer function deviates from diagonal
- Deviations accumulate, creating bow or wiggle in curve
- Total deviation across full range = INL
### Offset Error Recap and Full Scale Error
**Offset Error Summary**
- Deviation of output code transition point across all codes
- Can easily be corrected using microcontroller
- Reduces range of ADC by 1 code in software
- Not to be confused with full-scale error

**Full-Scale Error Definition**
- Offset error at last transition point
- ADC reaches highest code before reaching highest voltage
- Caused by both offset error and non-ideal slope of transfer function
- Combines effect of offset deviation with gain slope mismatch

**Full-Scale Error Characteristics**
- Offset error = 1 LSB (at 0.25V input)
- Dynamic range reduced by 1 code in software
- Not-ideal slope that doesn't quite start from (x=0, y=0)
- Last transition occurs too early (before full-scale voltage reached)
### Dynamic Measures: Effective Number of Bits (ENOB)
**ENOB Concept**
- Resolution of ADC is specified by number of bits used to represent analogue value
- In principle, N bits gives 2^N signal levels
- ENOB indicates how many bits effectively contribute to representing sampled input
- Tells how many bits actually contribute toward representing sampled input, not corrupted by noise

**ENOB Significance**
- Bad ENOBs are like bad apples for embedded engineer
- They can spoil rest of processing package
- Real-world ADC performance limited by noise and imperfections
- Practical useful resolution often much lower than nominal bit width

**ENOB vs Noise Trade-offs**
- Thermal noise floor: 0.5-1/2 bit/octave
- Aperture uncertainty: 1 bit/octave
- This shows real ADCs lose effective bits at higher frequencies
- Must account for noise when selecting ADC specifications

**ENOB Trends Over Time**
- 1986-1990: 14-16 effective bits typical at moderate sampling rates
- 1991-1995: 12-15 effective bits achieved
- 1996-2000: 8-12 effective bits at higher speeds
- 2001-2005: 4-8 effective bits at very high sampling rates
- Trade-off between speed (sampling rate) and effective resolution
### Quantization Noise (Not Examined in 2025)
**Quantization Noise Concept**
- Difference between original analog signal h(t) and quantized digital signal w(t)
- Quantization noise = w(t) - h(t) (the error introduced by quantization)
- Assuming "rounding" (truncating) towards 0
- Signal reconstruction always shows jagged appearance due to quantization steps

**Quantization Noise Characteristics**
- Appears as noise-like variations in reconstructed signal
- Amplitude bounded by ± 0.5 LSB (half a quantization step)
- Increases with signal frequency (more aliasing at higher frequencies)
- Quantum Q = avg(|w(t)|) - avg(|h(t)|) (average deviation measure)

**Quantization Noise Impact**
- Limits dynamic range of ADC
- Fundamental limit even with perfect hardware
- Cannot be eliminated, only managed
- Must be considered in noise budget calculations
### Quantization Noise Impacts SNR
**Signal-to-Noise Ratio (SNR) Definition**
- SNR = signal / noise (power ratio)
- SNR in dB = 10 * log10(signal / noise)
- SNR in dB = 20 * log10(V_signal / V_noise) for voltage signals
- SNR_Q in dB = 20 * log10(n / a*Q) where alpha characterizes tracking quality

**SNR Breakdown**
- Quantization noise adds to other noise sources
- Total noise = quantization noise + thermal noise + other interference
- Shannon's theorem applies: predicts data speed through noisy channel
- Alpha parameter (0 to 1) shows how well w(t) tracks h(t)
- Alpha = 0: perfect tracking (h(t) = w(t)), infinite SNR
- Alpha = 1: w(t) off from h(t), strong signal but signal corrupted by noise

**SNR and Channel Capacity**
- Shannon and Nyquist theorems work together
- Nyquist sets sampling rate requirement
- Shannon predicts maximum data throughput given noise
- Speed of data impacts both theorems
- Channel capacity limited by noise, bandwidth, and power
### Spurious-Free Dynamic Range (SFDR)
**SFDR Definition**
- Frequency-domain measurement determining minimum signal level distinguishable from spurious components
- Includes all spurious components over full Nyquist band regardless of origin
- Minimum signal level must be above highest "spur" (unwanted frequency)
- Typically decreases as sampling rate increases

**SFDR Measurement**
- Sample known sinusoidal reference (or carrier signal) with minimum interference
- Sample for period and perform Fourier transfer (FFT)
- Find difference between max of spurious signals and full-scale range (P_FS)
- Note: must put spectrum in dBs (10 * log10(P_s / P_REF))
- Example: 65dB SFDR means largest spur is 65dB below full-scale power

**SFDR Characteristics**
- Typically decreases as sampling rate increases (faster = noisier)
- Generally indicates as power or S/N ratio value
- Noise spurs at bottom of plot
- Highest single "spur" determines minimum detectable signal

**SFDR Practical Applications**
- Determines weakest signal that can be reliably detected
- Must raise signal level above strongest spurious component
- Affects minimum signal dynamic range for communications
- Important for radar, sonar, and communications receivers
