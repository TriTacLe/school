---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 1.1 Signals revision: impulse
### Signals
**Signal:** quantity that varies with time, represented as function $x(t)$. Can be discrete or continuous (voltage over time, payload height over time, temperature over time).

**Slide: Signals**
- A signal is a quantity that varies with time
### Systems
**System:** object or process that transforms signals, taking input signal and producing output signal. Defines input-output relationship.
- Anything can be a system if you can think of suitable inputs and outputs to describe it
- Examples: car, chemical plant, resistor, motor, robot, quadcopter, circuit, avocado, chihuahua, guy covered in bees

**In control engineering, "the system" could refer to:**
- The thing we are trying to control
- Part of the thing
- The combination of the thing and the controller

**System types:**
- SISO (Single-Input, Single-Output): $x(t) \to y(t)$
- MIMO (Multiple-Input, Multiple-Output): $[x_1(t), x_2(t), x_3(t)] \to [y_1(t), y_2(t), y_3(t)]$
- SIMO, MISO: variants

**Slide: We can think of a signal as a mathematical function**
- We can think of signal as a mathematical function
- But we won't always know what the function is
### System Identification
**System identification:** finding a model that can calculate the response to any input. Determining the system model $F(x)$ such that $y = F(x)$.

**White box modelling:** we know something about the system (e.g., spring constant $k=5$), can use knowledge of dynamics to work out the system model
- Example: $y = -5x$ for spring with known constant
- Determining system model based on known components

**Black box modelling:** we don't know anything about contents of system, identify model through experiments by applying known inputs
- Determining system model through experiments

**Grey box:** combination of both approaches. Even when we can work out general form, there will probably be unknown parameters (e.g. spring constant) that we have to find through experiments.
### LTI Systems
**Linear and Time-Invariant (LTI) systems:** only need to know response to one signal (the impulse) to fully define the system and calculate response to any input.

**Linearity properties:**
- **Homogeneity:** response to scaled input equals response scaled by same factor. $ax(t) \to ay(t)$
- **Additivity:** response to sum equals sum of responses. $x_1(t) + x_2(t) \to y_1(t) + y_2(t)$
- **Superposition:** linear systems preserve weighted sums. $ax_1(t) + bx_2(t) \to ay_1(t) + by_2(t)$

**Time invariance:**
- Time-shifting the input causes the same shift in the response
- $x(t - \lambda) \to y(t - \lambda)$

**Pulse basis approximation:**
- We can approximate any input using sum of shifted, scaled pulses: $$x(t) = \sum_{\lambda=-\infty}^{\infty} x[\lambda]p(t-\lambda)$$
- If we know response to pulse, can approximate response based on LTI properties: $$y(t) = \sum_{\lambda=-\infty}^{\infty} x[\lambda]g(t-\lambda)$$
- Narrower pulses spaced more closely together give more accurate approximation
- Perfect replica achieved with infinitesimally narrow pulse
### Impulse
**Dirac delta (impulse) function $\delta(t)$:** infinitesimally narrow pulse with:
- Height: $\infty$
- Area: 1
- Width: $\frac{1}{\infty}$ (near zero)

Representation: $$x(t) = \int_{-\infty}^{\infty} x(\lambda)\delta(t-\lambda)d\lambda$$

**Impulse response $h(t)$:** output you get when input is single impulse. Completely defines system model for LTI system.

If we know impulse response, can calculate any output: $$y(t) = \int_{-\infty}^{\infty} x(\lambda)h(t-\lambda)d\lambda$$

**Convolution:** operation to calculate output from input and impulse response
$$y(t) = x(t) * h(t) = \int_{-\infty}^{\infty} x(\lambda)h(t-\lambda)d\lambda$$
- Running weighted sum of input's history with $h$ weighting each past value by how long ago it happened
- Computationally intensive, so we prefer to avoid it using frequency domain methods
## 1.2 Signals revision: frequency domain
### Overview
**Time and frequency domains:** like different "coordinate systems" for representing signal information. Same signal, two views: value at each instant (time) vs. which frequencies it is built from (frequency).

**Domain-specific objectives:** we might need to satisfy both time- and frequency-domain objectives, such as:
- Decreasing settling time (time domain)
- Attenuating high-$\omega$ noise (frequency domain)
### Basis and Coordinate Systems
**Basis:** set of signals that can be linearly combined to create all signals in a domain.

**Time domain basis:** set of shifted impulses $\delta(t-\lambda)$ for all $\lambda \in \mathbb{R}$
- Any signal can be constructed as weighted sum of shifted impulses
- Basis functions: $\delta(t-\lambda) \, \forall \lambda \in \mathbb{R}$

**Frequency domain basis:** set of sinusoids with frequencies that are integer multiples of the signal's fundamental frequency
- Basis functions: $\cos(k\omega t) \, \forall k \in \mathbb{Z}$
- Allows representation of periodic signals

**Changing domains = basis change:** transforming between domains is mathematically a change of basis, like transforming between rectangular and polar coordinates.
### Harmonics
**Harmonics:** frequencies that are integer multiples of the signal's fundamental frequency
- Basis: $\cos(k\omega t)$ where $k \in \mathbb{Z}$ and $\omega = \frac{2\pi}{T}$
- First through fourth harmonics shown as constituent frequencies

**DC component:** 0th harmonic
- Changing DC component shifts entire signal up or down without changing shape

**Periodicity requirement:** frequencies must be integer multiples for combination to be periodic

**Parameters of each harmonic:**
- Magnitude: $A$
- Phase: $\theta$
- General form: $A\cos(k\omega t + \theta)$
### Complex Exponentials and Conjugate Pairs
**Question:** impulses only have magnitude, so how can one coefficient represent both magnitude and phase?

**Answer:** coefficients are 2-dimensional numbers (complex numbers)

**Basis expansion:** frequency domain basis is set of complex exponentials with positive and negative integer multiples of signal frequency
- Basis: $e^{jk\omega t}$ for $k \in \mathbb{Z}$ (positive and negative frequencies)

**Real-valued signals:** positive and negative frequency components must form conjugate pairs to produce real-valued output
- Conjugate pair: $Ae^{j\theta}e^{jk\omega t} + Ae^{-j\theta}e^{-jk\omega t}$
- Same magnitude, opposite phase

**Euler's formula:** $$\frac{1}{2}e^{jk\omega t} + \frac{1}{2}e^{-jk\omega t} = \cos(k\omega t)$$
### Fourier Series
**Fourier series:** representation of periodic signal as weighted sum of harmonic components (sinusoids with integer multiple frequencies)

**Example:** $$6\cos\left(\pi t + \frac{\pi}{4}\right) = 3e^{j\pi/4}e^{j\pi t} + 3e^{-j\pi/4}e^{-j\pi t}$$

**General form:** $$x(t) = \sum_{k=-\infty}^{\infty} a_k e^{jk\omega_0 t}$$

**Frequency domain plot properties:**
- Magnitude: even function
- Phase: odd function
- For real-valued signals

**Pulse spacing and frequency components:**
- Moving pulses closer (increasing $\omega_0$): moves frequency components further apart
- Moving pulses further apart (decreasing $\omega_0$): brings frequency components closer together
- Pulses infinitely far apart (non-periodic): frequency components become continuous
### Fourier Transform
**Fourier transform:** frequency domain representation of non-periodic signal.

**Fourier synthesis equation (reconstruction):** reconstructs signal as integral of frequency components
$$x(t) = \frac{1}{2\pi}\int_{-\infty}^{\infty} X(\omega)e^{j\omega t}d\omega$$

**Fourier analysis equation:** calculates transform of signal
$$X(\omega) = \int_{-\infty}^{\infty} x(t)e^{-j\omega t}dt$$

**Practical use:** seldom use analysis equation directly. Instead evaluate Fourier transform using:
- Transform properties (scaling, time shift, differentiation, etc.)
- Table of common transform pairs

**Example 1:** $x(t) = 5e^{-2(t-1)}u(t-1)$
- Form: $e^{-bt}u(t) \to \frac{1}{j\omega+b}$ with $b=2$
- Scaling: $ax(t) \to aX(\omega)$ with $a=5$
- Time shift: $x(t-c) \to X(\omega)e^{-j\omega c}$ with $c=1$
- Result: $$X(\omega) = \frac{5e^{-j\omega}}{j\omega+2}$$

**Example 2:** $x(t) = \frac{1}{2}e^{2t}u(t)$ - non-convergent case
- Direct integration diverges (integral does not converge)
- Solution: multiply by "helper" exponential $e^{-\sigma t}$
### Laplace Transform and s-Domain
**Problem with Fourier transform:** convergence issues with non-decaying signals

**Solution:** introduce "helper" exponential $e^{-\sigma t}$

**Example 2 continued:** $x(t) = \frac{1}{2}e^{-\sigma t}e^{2t}u(t)$ with $\sigma > 2$
- Product becomes decreasing exponential
- Analysis equation converges when $\sigma = 5$:
$$X(\omega) = \int_0^{\infty} \frac{1}{2}e^{-(3+j\omega)t}dt = \frac{1}{2(3+j\omega)}$$

**Basis change to s-plane:** integrating product with complex exponential $e^{-st}$ where $s = \sigma + j\omega$
$$X(s) = \int_0^{\infty} x(t)e^{-st}dt$$

**s-plane representation:** complex plane with $\sigma$ on real axis, $\omega$ on imaginary axis ($s = \sigma + j\omega$)

**Laplace transform:** $X(s)$, the s-domain version of signal
- Bilateral Laplace transform: spans all time from $-\infty$ to $\infty$
- Unilateral Laplace transform: runs from 0 to $\infty$ (used in control for right-sided signals)

**Region of convergence (ROC):** region in s-plane where integral converges
- For right-sided signal (0 for $t < 0$): unilateral Laplace sufficient

**Laplace basis functions:** complex exponentials with exponential envelope
- Form: $e^{\sigma}e^{j\omega t}$ or combined: $e^{\sigma}2\cos(\omega t)$
- Sinusoids multiplied by exponential envelopes

**Eigenfunctions of linear systems:** sinusoids and exponentials are only types of signals that pass through linear systems without changing shape
- Pass through derivative unchanged (only scaled and phase-shifted)
- Example: triangle wave becomes square wave (changes shape)
- Property: only transformation is scaling, hence "eigenfunctions"
### Convolution Property
**Key insight:** convolution in time domain becomes multiplication in frequency/s-domain

**Time domain:** $$y(t) = x(t) * h(t) = \int_{-\infty}^{\infty} x(\lambda)h(t-\lambda)d\lambda$$

**Frequency domain:** $$Y(\omega) = X(\omega)H(\omega)$$

**s-domain:** $$Y(s) = X(s)H(s)$$

**System computation:**
- Instead of convolving input and impulse response in time domain (computationally intensive)
- Multiply Laplace transforms in s-domain
- Transform back if needed

**Transfer function:** Laplace transform of impulse response
$$H(s) = \mathcal{L}\{h(t)\}$$

**Transfer function as system model:** completely defines model of LTI system, just as impulse response does

**Working with transfer functions:** gives intuitive way to visually represent and manipulate interconnected systems (block diagram algebra)
## 1.3 Block diagrams
### System Blocks
**System block:** basic unit of block diagram
- Input: $x(s)$ (in Laplace domain) or $x(t)$ (in time domain)
- Transfer function: $H(s)$
- Output: $y(s) = H(s)x(s)$ (frequency domain) or $y(t) = h(t) * x(t)$ (time domain)

**Output calculation:**
- Frequency domain: output = input multiplied by transfer function
- Time domain: output = convolution of input and impulse response (rarely used due to computational intensity)
### Cascade Connection
**Cascade connection:** one system connected after another, so output of first becomes input to next

**Signal flow:** $x(s) \to H_1(s) \to H_2(s) \to y(s)$
- Output of $H_1$: $H_1(s)x(s)$
- Final output: $y(s) = H_2(s)H_1(s)x(s)$

**Effective transfer function:** $$H(s) = H_2(s)H_1(s)$$
- Cascade blocks are multiplied
- Transfer function of single equivalent system with same effect as combination
### Take-off Points
**Take-off point:** point where signal splits into different paths
- Signal remains same anywhere along either path
- Allows signal to feed multiple subsystems
### Summing Junctions
**Summing junction:** combines signals using addition/subtraction
- Represented by circle with +/- signs
- Inputs are added (+ sign) or subtracted (- sign)
- Single output

**Multiple summands:** representing sums with > 2 signals
- Can use multiple + or - symbols around junction circle
- Alternative representations exist, lecture uses simple circle with +/- marking
### Parallel Connection
**Parallel connection:** two systems along separate paths that join at summing junction

**Effective transfer function:** $$H(s) = H_1(s) + H_2(s)$$
- Parallel blocks are added
- Outputs from each path combine at sum

**Alternative notation:** various ways to draw summing junctions and paths, all equivalent
### Feedback and Loops
**Loop:** connecting output of system to its input, creating feedback path

**Feedback:** ability of system to monitor its own output
- Putting system in feedback gives ability to regulate itself by responding to present output
- Can be negative (stabilizing) or positive (destabilizing)

**Shower example - open loop control:**
- Turn tap to position, no feedback
- No way to know if water is right temperature before getting in
- Disturbances (roommate using water) cause temperature changes we cannot correct

**Shower example - closed loop control:**
- Feel water temperature (sensor)
- Compare to desired value (setpoint)
- Adjust tap (actuator) based on error
- Negative feedback: if too hot, turn toward cold; if too cold, turn toward hot
- Oscillates between states but eventually reaches setpoint

**Negative feedback:** output is subtracted from setpoint
- Corrections opposite to direction of error
- Stabilizing, used in control engineering

**Positive feedback:** output is added to setpoint
- Reinforces deviations from ideal
- Destabilizing, rarely used in control
- Example: outbreak of mass hysteria
### Control Systems
**Plant:** the thing we are trying to control (motor, heater, shower, crane)

**Process:** part of plant that produces the output
- Example: shower (produces water temperature)

**Actuator:** drives process in response to input
- Example: person turning tap (you are the actuator)

**Actuator input:** control signal $u(s)$ sent to actuator

**Process input:** what actuator actually drives (tap position $x(s)$)

**Setpoint:** desired value for output, $r(s)$

**Error:** difference between setpoint and output, $e(s) = r(s) - y(s)$

**Sensor:** system that measures output
- Block shown explicitly if not perfect
- No sensor block means perfect sensing (output of sensor is exactly true output)

**Controller:** system that adjusts plant input in response to error
- Takes error signal and produces actuator input
- Transfer function: $K(s)$

**Control system diagram:**
```
r(s) --[+]--[e(s)]--[K(s)]--[u(s)]--[P(s)]--[y(s)]
       [- ]          plant              [H(s)]
              [sensor]
```

**Control engineering definition:** "the science and art of choosing inputs to get the outputs that we want"

**Control objectives:**
1. System reliably reaches setpoint value
2. Once at setpoint, improve how it gets there:
   - Make it get there in less time (settling time)
   - Make it get there with less oscillation (damping)
### Closed-Loop Transfer Function
**Closed-loop transfer function:** effective transfer function that maps setpoint to output

**Notation:**
- Controller: $K(s)$
- Plant: $P(s)$
- Sensor: $H(s)$

**Open-loop transfer function:** transfer function of forward path (from setpoint to output without loop)
$$G(s) = K(s)P(s)$$

**Derivation of closed-loop transfer function:**
1. Feedback signal: $v = H(s)y(s)$
2. Error: $e(s) = r(s) - H(s)y(s)$
3. Control input: $u(s) = K(s)e(s)$
4. Plant output: $y(s) = P(s)u(s)$
5. Combining: $y(s) = P(s)K(s)[r(s) - H(s)y(s)]$
6. Expanding: $y(s) = P(s)K(s)r(s) - P(s)K(s)H(s)y(s)$
7. Rearranging: $y(s)[1 + P(s)K(s)H(s)] = P(s)K(s)r(s)$
8. Solving: $$G_{CL} = \frac{y(s)}{r(s)} = \frac{K(s)P(s)}{1 + K(s)P(s)H(s)} = \frac{G(s)}{1 + G(s)H(s)}$$

**Basic feedback loop (unity feedback):**
$$G_{CL} = \frac{G}{1 + GH}$$
where the denominator $1 + GH$ is called the "loop gain"
### Feedback Loop Configurations
**Nested loops:** one feedback loop inside another
- Inner loop $A$ with feedback $B$: $\frac{A}{1+AB}$
- Outer loop $C$ around the result: overall transfer function $\frac{A}{1+AB+AC}$

**Cascaded loops:** feedback loops in series
- Each loop reduced independently: $\frac{A}{1+AB}$ and $\frac{C}{1+CD}$
- Combined as cascade: $$\frac{AC}{(1+AB)(1+CD)}$$

**Interlocking loops:** loops that share signals, require block diagram manipulation
- Use moving take-off points: multiply by $\frac{1}{G(s)}$ to extract signal before a block
- Use moving summing junctions: multiply by $\frac{1}{G(s)}$ to move sum before block
- Technique allows reduction to simpler nested or cascaded form
### Block Diagram Reduction
**Moving a take-off point:**
- Moving from output of $G(s)$ to input requires adding $\frac{1}{G(s)}$ block in the signal path
- Ensures output remains unchanged

**Moving a summing junction:**
- Moving sum from output of $G(s)$ to input requires adding $\frac{1}{G(s)}$ block for the affected signal
- Preserves output relationships

**Interlocking loop example - reduction steps:**
1. Identify take-off points to move
2. Add inverse transfer functions where needed
3. Reduce inner loops
4. Reduce parallel sections
5. Apply basic feedback formula to final loop

**Result:** reduces complex interconnected loops to standard form allowing formula application

**Example interlocking reduction:** From complex multi-branch configuration:
$$G_{CL} = \frac{ABC}{1 + BEA + BDC}$$
### Three Core Block Diagram Rules
**Series (cascade):** blocks in sequence multiply
- Equivalent single block: $H_{total}(s) = H_2(s)H_1(s)$

**Parallel:** blocks with outputs combined at summing junction add
- Equivalent single block: $H_{total}(s) = H_1(s) + H_2(s)$

**Feedback:** output fed back to input through loop
- General form: $$G_{CL} = \frac{G(s)}{1 + G(s)H(s)}$$
- Negative feedback (standard): output subtracted from reference
- Positive feedback: output added to reference
