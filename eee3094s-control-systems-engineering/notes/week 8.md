---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 8.4 Time response design in the frequency domain
### Design Specifications
**Design Specifications**
- Time-domain performance requirements fall into three categories: accuracy (steady-state error), speed (settling time, rise time, time to peak), and damping (damping ratio, percent overshoot)
- Can map specifications to pole locations in the s-plane
- Relate time-domain parameters to frequency response characteristics: accuracy depends on DC gain, speed depends on bandwidth, damping depends on phase margin

**Feedback System Example**
- For system with transfer function 1/(s+1)(s+3), accuracy specifications set a minimum DC gain
- e(infinity) = 1/(1 + lim G(s)) <= 0.1 specifies a minimum gain for tracking accuracy
### Bandwidth and Speed
**Bandwidth Definition**
- Control systems bandwidth is the frequency where magnitude drops 3 dB below peak value (not to zero as in signals)
- For first-order systems with pole at -omega_0: the -3 dB point occurs at the break frequency
- Break frequency is related to the real part of the pole

**Relating to Bandwidth**
- Speed (time constant) depends on bandwidth
- For open-loop system, read -3 dB bandwidth directly from Bode plot
- For closed-loop system, must explicitly calculate closed-loop frequency response before plotting
- Use M circles on Nyquist or Nichols chart to find closed-loop bandwidth from open-loop response
- Find circle 3 dB below the DC gain and locate frequency where response intersects it
### Damping vs Phase Margin
**Rule of Thumb**
- Damping ratio relates to phase margin: zeta = (A * phi_m) / 100 where A is closed-loop gain and phi_m is phase margin in degrees
- Useful but not perfect relationship

**Mathematical Derivation**
- For second-order closed-loop system: G_CL(s) = A*omega_n^2 / (s^2 + 2*zeta*omega_n*s + omega_n^2)
- Assuming A=1 for unity gain, open-loop becomes: G(s) = omega_n^2 / (s(s + 2*zeta*omega_n))
- System must be type 1 for A=1

**Gain Crossover Frequency**
- From magnitude criterion: |G(j*omega_c)| = 1, solve for omega_c using quadratic formula
- Result: omega_c = omega_n * sqrt(-2*zeta^2 + sqrt(4*zeta^4 + 1))
- Define lambda(zeta) = sqrt(-2*zeta^2 + sqrt(4*zeta^4 + 1)) so omega_c = omega_n * lambda(zeta)

**Phase Margin Expression**
- At gain crossover: angle G(j*omega_c) = arctan(2*zeta*lambda) / (-lambda^2) = arctan(2*zeta / lambda)
- Phase margin: phi_m = arctan(2*zeta / sqrt(-2*zeta^2 + sqrt(4*zeta^4 + 1))) + 180 degrees
- Linear approximation for smaller phase margins: phi_m ≈ 100*zeta (only valid for linear region)

**Effect of Closed-Loop Gain**
- If closed-loop gain A < 1, the frequency response point shifts right, increasing angle to real axis
- Larger closed-loop gain results in smaller phase margin for same damping ratio
- Approximation phi_m/100 ≈ zeta holds best for gain close to 1
## 8.4.2 Time constant in the frequency domain
### First-Order System Example
**Example 1: First-Order System**
- Open-loop: G(s) = 3/(s+3)
- Closed-loop with unity feedback: 3/(s+6)
- From Nichols chart: DC gain is -6 dB
- Find -3 dB bandwidth by locating intersection with -9 dB circle (gain 3 dB down from -6 dB)
- Closed-loop break frequency is 6 rad/s, so pole is at -6
- Time constant tau = 1/6 seconds
### Second-Order System Example
**Example 2: Second-Order System**
- Open-loop: G(s) = 10/(s+2)(s+5)
- Closed-loop: 200/(s^2 + 7s + 210)
- Closed-loop poles at -3.5 +/- j14
- DC gain from Nichols chart: -0.4 dB
- Must find intersection with -6.4 dB circle (each pole contributes -3 dB at its break frequency)
- Suggested closed-loop break frequency: 25 rad/s - but this is WRONG for complex pole pair

**Correct Approach for Second-Order**
- Natural frequency omega_n corresponds to distance from origin to pole
- At natural frequency, magnitude is A / (2*zeta) in linear form, or 20*log10(A) - 6 - 20*log10(zeta) in dB
- For damped second-order system, must account for both damping ratio and DC gain effects
- From damping ratio approximation: zeta = A*phi_m/100
- Magnitude at omega_n drops below DC gain by approximately 6 + 20*log10(zeta) dB

**Example 2 Continued**
- Phase margin ≈ 30 degrees, closed-loop gain = 0.95
- Damping ratio: zeta ≈ 0.95 * 30 / 100 = 0.285
- Subtract 20*log10(0.285) = -10.9 dB from -0.4 dB to get 10.5 dB for M circle
- Natural frequency around 12 rad/s (from Nichols chart intersection)
- Actual poles at approximately -3.42 +/- j11.5 (compared to true -3.5 +/- j14)

**Overdamped Systems**
- Method works for complex pole pair or critically-damped system
- For overdamped (zeta > 1), unlikely to encounter in closed-loop design
## 8.5 Frequency domain design methods
### Comparison of Frequency Response Plots
**Root Locus as Benchmark**
- Root locus can get closed-loop information from open-loop poles and zeros alone
- Easy to interpret: pole positions clearly relate to performance metrics (tau, omega_d, theta)
- Works for unstable systems
- Predicts design decision effects
- Drawbacks: depends on accurate transfer function, needs Pade approximation for delays

**Bode Plot (B-tier)**
- Provides incomplete closed-loop picture without calculating closed-loop expression
- Can evaluate closed-loop stability via gain and phase margins (only if open-loop stable)
- Can get closed-loop accuracy and damping from DC gain and phase margin
- Cannot tell closed-loop speed without calculating closed-loop response (must plot multiple designs)
- Good for combining compensator and plant responses (they add in dB and degrees)
- Predicts gain and phase changes (sliding on log scale), but not speed changes completely

**Nyquist Plot (D-tier)**
- Gives more complete closed-loop stability picture than Bode
- Can see gain margin, phase margin, and sensitivity to gain/phase changes
- Nyquist stability criterion works for unstable open-loop systems
- Distance from -1 gives sensitivity information
- Drawbacks: M and N circles hard to read, scaling is awful (especially with type > 1), difficult to predict compensator-plant interaction

**Nichols Chart (A-tier)**
- Combines best aspects of Bode and Nyquist
- Information accessible about closed-loop performance from open-loop response
- Easy to interpret once annotated with frequencies
- Stability margins visible, including overall proximity to -1
- Works for unstable systems
- M and N circles easier to read than Nyquist format
- Layout and sliding motion make predictions about closed-loop behavior easier
- M circles spaced further apart at higher regions, improving readability
- Gain and phase add, showing how compensator shapes different frequency regions of plant

**Inverse Nichols Chart**
- Cannot compare directly to other plots as it does different job
- Shows sensitivity: how consistent closed-loop behavior will be if open-loop plant is inaccurate or fluctuating
### Design Method Recommendations
- Root locus is S-tier for time response design if confident in transfer function
- Bode plot is B-tier: useful but has limitations, will use in most designs anyway
- Nichols chart rates A-tier for frequency domain method
- Use combination of methods: no single tool covers everything
- MATLAB allows plotting as many representations as helpful
