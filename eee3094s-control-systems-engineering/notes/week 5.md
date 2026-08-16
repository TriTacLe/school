---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 3.1 Design guide to the s-plane
Overview of where closed-loop poles must be placed in the s-plane to satisfy design specifications.
### Design Guide Overview
**Design Guide to the S-plane**
- We draw up a map of the s-plane showing where poles must be located to satisfy different design specifications
- The right-half plane is forbidden (where unstable poles lie)
- Poles must fall in the left-half plane
### Settling Time Specifications
**Settling Time Constraints**
- Requirement: the system must settle (reach 2% of steady state) within a specified time $\tau_2$ seconds
- Relationship with natural frequencies: $\frac{4}{\text{Re}(p)} \leq \tau_2$ for a pole at location $p$
- This means $\text{Re}(p) \leq -\frac{4}{\tau_2}$
- A maximum settling time means poles must be at least a minimum distance from the origin
- Settling time specification restricts poles to a vertical region left of the line $\text{Re}(s) = -\frac{4}{\tau_2}$
### Damping Specifications
**Damping Ratio and Oscillation Control**
- Requirement: the system must have damping ratio $\zeta \leq$ specified value to control oscillation
- Only complex pole pairs produce oscillation
- For a second-order system $\frac{A\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$:
  - Real part: $-\zeta\omega_n$
  - Imaginary part: $\pm\omega_n\sqrt{1-\zeta^2}$
- Relationship: $\cos(\theta) = \zeta$ where $\theta$ is the angle from the real axis to the pole
- Poles along the same diagonal line have the same damping ratio
- Response gets faster or slower moving along the line, but shape stays the same
- Steeper angle of pole means more oscillatory response
- When poles are close to the real axis, response looks more critically damped
- Rule of thumb: use damping ratio around 0.7 as lower limit (pole angle of 45 degrees means real and imaginary parts are equal)
- Damping specification is represented by a wedge-shaped region bounded by two diagonal lines through the origin
### Frequency Specifications
**Damped Frequency Constraints**
- Requirement: system must keep damped frequency $\omega_d$ below specified value
- Relationship: $\omega_d = \omega_n\sqrt{1-\zeta^2}$ (imaginary part of pole)
- A frequency specification restricts poles to a horizontal region below the line $\text{Im}(s) = \omega_d$
### The Complete Design Map
**S-Plane Regions**
- Right-half plane: unstable (forbidden)
- Left region bounded by: time (vertical line), frequency (horizontal line), and damping (diagonal wedge)
- Robust system's behavior won't drastically change due to parameter variations
- Sensitivity is the opposite of robustness
### Moving Poles with Controller Gain
**Proportional Control**
- Characteristic equation: $1 + K \frac{1}{(s+4)(s+6)} = 0$ becomes $s^2 + 10s + 24 + K = 0$
- Controller gain $K$ is added directly to the denominator of the closed-loop transfer function
- Gain directly affects pole locations
- When $K = 5$: $G_{CL} = \frac{1}{s^2 + 10s + 25} = \frac{1}{(s+5)^2}$ (repeated poles at -5)
- When $K = 150$: closed-loop poles are more complex with larger imaginary parts (more oscillation)
- Choosing gains will be the bread and butter of controller design
### Parameter Variations and Robustness
**Tolerance and Uncertainty**
- Nominal model: model of the plant where all parameters are assigned typical values
- Real-life components come with tolerances (e.g. spring constant varies by 5%, mass by 1%, damping by 2%)
- Parameter box: the true plant model could be anywhere within a box in parameter space
- Robust design requirement: closed-loop poles of every system in the parameter box must lie in the specified region
### Sensitivity Analysis
**Definition and Formula**
- Sensitivity of quantity $a$ with respect to parameter $b$: $S_b^a = \frac{\partial a / a}{\partial b / b}$ (proportional change in $a$ per proportional change in $b$)
- If a system is sensitive to a parameter, small changes in that parameter result in large changes to the system's response
- Example: Each class test is 5% of class mark and 40% of final mark; sensitivity is $S_{\text{test}}^{\text{final}} = 0.0005 / 2.5 = 2 \times 10^{-4}$ (very insensitive, not worth the effort)

**Sensitivity of Closed-Loop Transfer Function**
- Sensitivity of closed-loop transfer function $G_{CL}$ with respect to open-loop transfer function $Q$:
  $$S = \frac{\partial G_{CL} / G_{CL}}{\partial Q / Q}$$
- For unity feedback: $G_{CL} = \frac{Q(s)}{1+Q(s)}$
- Derivation:
  $$\frac{\partial G_{CL}}{\partial Q} = \frac{1}{(1+Q(s))^2}$$
  $$S = \frac{1}{1+Q(s)}$$
- Sensitivity function: if $S = \frac{1}{1+Q(s)} > 1$, the system is sensitive (changes to open loop are magnified in closed loop)
- For robust system, must avoid $S > 1$ for all values of $s$ (easier said than done, especially at high frequencies)
### Analysis Techniques Preview
**What's coming next**
- The Routh-Hurwitz criterion: tells us whether closed-loop system is stable without explicitly calculating pole locations
- The root locus: tracks how closed-loop poles move around s-plane as gain changes
- Bode plots: give overall picture of frequency response
- Nyquist plots: indicate how much system parameters can change before system becomes unstable
- Nichols charts: help evaluate how robust the system is
## 4.1 Root locus part 1
### Root Locus Definition and Purpose
**Root Locus Basics**
- Root locus is the path a closed-loop pole follows as the gain is increased from 0 to infinity
- "Root" because poles are roots of the characteristic polynomial
- "Locus" means path traced out by a point as it moves
- Answers three key questions:
  1. Which gain values put the poles in the specified region?
  2. How much can the gain fluctuate without system behavior failing to meet specifications?
  3. Are there any gains that would destabilize the system?

**Gain and Transfer Functions**
- Gain can refer to any scalar, such as the gain of a transfer function $\lim_{s \to 0} Q(s)$
- In feedback systems, the relevant gain is the gain of the forward path (controller)
- For unity feedback: $G_{CL} = \frac{Q(s)}{1+Q(s)}$
### Closed-Loop Transfer Function and Characteristic Equation
**General Form**
- For feedback system: $G_{CL} = \frac{KN_Q D_H}{KN_Q N_H + D_Q D_H}$
- With unity feedback: $G_{CL} = \frac{KN_Q}{KN_Q + D_Q}$
- Characteristic equation: $KN_Q + D_Q = 0$
### First-Order Systems
**Simple Case: Single Pole**
- System: $\frac{1}{s-p}$ with characteristic equation $K + (s - p) = 0$
- When gain = 0: characteristic equation becomes $s - p = 0$ (same as open-loop poles)
- Pole starts at open-loop pole position $p$
- For this system: pole = $p - K$
- Pole can only become positive if gain is negative (system stays stable for all gains we consider)
- As gain increases, pole approaches $-\infty$
- Root locus: straight line along real axis from $p$ to $-\infty$

**With a Zero**
- System: $\frac{s+z}{s-p}$ with characteristic equation $K(s+z) + (s - p) = 0$
- When $K = 0$: pole starts at open-loop pole position
- When $K \to \infty$: numerator term dominates, so $K(s+z) = 0$ means pole approaches $-z$ (the zero)
- Root locus: straight line from pole to zero
- If zero is in right-half plane, system could become unstable at high gains

**Observations from First-Order Cases**
- Closed-loop poles move from open-loop poles to open-loop zeros, or to $-\infty$ if no zero available
- If zero is in right-half plane, system could become unstable at high gains
### Second-Order Systems
**Real Poles Becoming Complex**
- System: $\frac{1}{(s+p_1)(s+p_2)}$ with characteristic equation $s^2 + 10s + (24 + K) = 0$
- Poles: $-5 \pm \frac{1}{2}\sqrt{100 - 4(24+K)} = -5 \pm \frac{1}{2}\sqrt{4-4K}$
- Discriminant decreases as $K$ increases
- As $K$ increases: real parts stay at $-5$, imaginary parts grow
- Poles go from real ($K = 0$: poles at $-4, -6$) to repeating ($K = 1$: double pole at $-5$) to complex

**Pole Movements**
- Square root term: $\frac{1}{2}\sqrt{(p_1-p_2)^2 - 4K}$ can only be larger than 1 if gain is negative
- Poles will never move outside the range from $p_1$ to $p_2$
- When discriminant reaches zero (breakaway point), real parts equal $-\frac{p_1+p_2}{2} = -5$
- Imaginary parts tend to infinity as gain increases
- For complex open-loop poles, discriminant never becomes larger than it is for open-loop poles, so closed-loop poles will always be complex

**Second-Order with Two Zeros**
- Closed-loop poles tend toward the zero positions as gain increases

**Second-Order with One Zero**
- One pole tends to zero, the other tends to $-\infty$
- If poles are to break away from real axis and become complex, they must do so to avoid overlapping
- Poles' paths are symmetrical about real axis
### Real and Complex Pole Pairs
**Key Observations**
- Closed-loop poles move from open-loop poles to open-loop zeros, or to $-\infty$ if no zero available
- Poles' paths may not overlap
- Root loci must be symmetrical about the real axis
- Poles move along paths determined by geometry of open-loop poles and zeros

**Behavior Patterns**
- One pole between two poles and one zero: pole on right goes to zero, left pole goes to $-\infty$
- Zero to right of poles: pole on right unstable for high gain
- Zero to left of poles: poles must break away and become complex to avoid overlapping
- Complex zero pairs: poles must break away at same point to preserve symmetry
### Summary of Root Locus Basics
**Stability and Oscillation Predictions**
- Always stable, might oscillate: zero between poles, or poles with no zeros
- Always stable: all poles left of all zeros
- Unstable for high gain: zero in right-half plane
- The paths reveal whether the system can be stable, whether it will oscillate, and where poles cross into right-half plane
