---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 8.1 Compensation basics
### Time Domain Specifications
**Time Domain Pole Positioning**
- Poles must be in left-half plane for stability
- Want poles far left for speed (faster settling time)
- At shallow angle for damping (high damping ratio)
- Close to real axis for bandwidth constraints
- Can define specification region that all poles must fall within

**Proportional Control Approach**
- Simplest control: adjust gain K to move closed-loop poles along root locus
- Works when root locus already passes through desired specification region
- Problem: if root locus misses the region entirely, no gain adjustment helps
- Need to modify root locus using compensator zeros and poles

**Root Locus Manipulation**
- Closed-loop poles travel toward open-loop zeros
- Add zeros to left-half plane to attract poles in that direction
- Add non-dominant poles for each zero to maintain proper transfer function
- This is gain and phase compensation (vs gain compensation alone)
### Frequency Domain Specifications
**Good System Characteristics**
- Response stays far from point representing -1 on Nyquist plot (represents 0 dB gain at -180 degrees)
- High gain at low frequencies improves setpoint tracking and disturbance rejection
- Low gain at high frequencies attenuates noise
- Inverse Nichols chart shows that good response shape avoids large sensitivity peaks, making system robust to open-loop model variations

**Unstable System Considerations**
- If system has unstable open-loop poles, Nyquist stability criterion: Z = N + P (unstable closed-loop poles = clockwise encirclements + unstable open-loop poles)
- Changing only gain cannot stabilize system that crosses -1 incorrectly - need compensator to add phase/change response shape
- Compensator response must be combined with plant response to achieve -1 crossing in proper direction
### Compensator Types
**Lead and Lag Equivalence**
- Mathematically, lead and lag compensators have same transfer function form
- Differ in how they conceptualize system behavior
- Lead adds positive phase shift, lag adds negative phase shift
- Lead-lag approach: think in terms of gain and phase contribution
- PID approach: think of output as weighted combination of error, integral, and derivative

**Compensator Combinations**
- P (Proportional) control alone: works if root locus already good
- PD control: equivalent to lead compensation, improves transient response
- PI control: special case of lag compensation, improves tracking accuracy
- PID combines all three elements

**Compensation Recipes**
- Lead-lag and PID controllers are two main "recipes"
- Lead-lag compensation works in frequency domain (gain and phase)
- PID compensation works in time domain (proportional, integral, derivative components)
## 8.2 Lead-lag compensation
### Lead-Lag Compensator Fundamentals
**Basic Form**
- General compensator: K(s + z)/(s + p)
- Adds one pole, one zero, and scales overall gain
- Lead compensator: zero closer to origin (|p| > |z|)
- Lag compensator: pole closer to origin (|p| < |z|)

**Frequency Response Characteristics**
- Pole creates frequency response that peaks near its break frequency
- Zero creates frequency response that dips near its break frequency
- Maximum phase shift occurs at geometric mean of pole and zero frequencies on log scale
- Maximum shift is: theta_m = arctan(p/z) - arctan(z/p)
- Distance between pole and zero limits maximum shift: theoretical max is 90 degrees, practical limit around 60 degrees due to component size

**Phase Contribution Geometry**
- Phase angle given by: angle K(j*omega) = angle(j*omega - z) - angle(j*omega - p) = theta_z - theta_p
- At low frequencies: both angles approach 0, so phase is 0
- At high frequencies: both angles approach 90, so phase is 0
- Peak phase occurs at maximum of (theta_z - theta_p), found by setting derivative to zero
- Result: omega_m = sqrt(z*p), and on log scale: log(omega_m) = [log(z) + log(p)]/2 (geometric mean)
### Lead Compensator
**Effect on Root Locus**
- Number of asymptotes unchanged (both add one pole and one zero)
- Centroid shifts based on pole and zero locations
- For lead: pole more negative than zero, so centroid shifts left
- Shifted asymptotes pull root locus branches left, toward left-half plane

**Stabilization and Speed Benefits**
- Moving poles left increases speed (faster settling)
- Decreasing angle between pole and real axis improves damping ratio (zeta = cos(theta))
- Can stabilize otherwise unstable system
- Can improve phase margin of stable system from <30 degrees to >45 degrees

**Design Tradeoffs**
- Lead compensator has lower gain at low frequencies, higher at high frequencies
- Gain scaling must be chosen carefully to balance:
  - Setpoint tracking (needs large low-frequency gain)
  - Noise rejection (needs small high-frequency gain)
  - Increasing speed must watch for higher gain amplifying high-frequency noise
- At gains that produce faster poles, system closer to instability than at best-case speed for uncompensated design

**Practical Implementation**
- Can cascade multiple stages for more than 60 degrees of phase lead
- Nichols chart analysis tip: for unstable open-loop systems, add negative frequency response to plot (same magnitude, opposite phase) to create closed contour for easier Nyquist-like interpretation
### Lag Compensator
**Effect on Root Locus**
- Pole closer to origin than zero (opposite of lead)
- Centroid shifts right, pulling root locus branches toward right-half plane

**Gain and Accuracy Benefits**
- Main value is not phase shift but gain shape: higher gain at low frequencies, lower at high frequencies
- Allows large low-frequency gain (for tracking accuracy) without proportional controller instability
- As DC gain increases indiscriminately with proportional control, response becomes resonant and unstable
- Lag compensator shapes response to increase low-frequency gain while maintaining stability
- Integrator is extreme lag case: pole at origin (infinite DC gain), zero at infinity (no effect)

**Stability Paradox**
- Appears to move poles right (toward right-half plane), which seems destabilizing
- But actually improves gain margin, providing net stabilizing effect
- Key insight: pole stability relative to right-half plane is not the full picture
- Same pole position (e.g., -1 vs -10) creates same gain-phase shape in frequency domain
- Faster poles (further left) have frequencies more compressed on Bode plot
- Destabilizing effects (delays, sampling) have greater impact at high frequencies
- Slower poles concentrated at low frequencies are less vulnerable to high-frequency disturbances

**Placement Strategy**
- If placed poorly (at gain crossover frequency), reduces phase margin
- If compressed close to origin, attenuating region aligns with phase crossover frequency
- Remove gain at phase crossover instead of adding phase at gain crossover
- Design tradeoff: accuracy and robustness more important than speed for some systems
## 8.3 Lead compensator design - root locus
### Design Problem Setup
**System and Specifications**
- Plant: 1/[(s+1)(s+3)]
- Requirements:
  - Position error < 10%
  - Halve settling time at specified accuracy
  - Damping ratio > 0.7

**Uncompensated Baseline**
- Open-loop transfer function: K/[(s+1)(s+3)]
- With proportional control only
- Error specification: e(infinity) = 1/[1 + lim G(s)] <= 0.1, requires minimum gain = 9
- After accounting for plant DC gain of 1/3: controller gain K > 27
- At K=27: closed-loop poles at approximately -2 +/- j5.1
- Damping ratio at this gain: zeta = cos(theta) = 0.37, only half the required 0.7
- Response oscillatory and underdamped
### Target Pole Selection
**Specification Region**
- Need poles twice as far from origin to halve settling time (factor of 2 in speed)
- Combined with damping requirement zeta > 0.7: poles must lie in region with |angle| < arccos(0.7) from real axis
- Choose target pole at -4 + j4 as representative point in feasible region

**Angle and Magnitude Criteria**
- For s to be closed-loop pole: 1 + KG(s) = 0, or KG(s) = -1
- Angle criterion: angle[KG(s)] = -180 degrees
- Magnitude criterion: |KG(s)| = 1
- At s = -4 + j4: angle from existing poles is approximately -231 degrees (-(104 + 127))
- Compensator must add 51 degrees to satisfy angle criterion: theta_z - theta_p = 51 degrees
### Compensator Pole-Zero Selection
**Finding Valid Compensation**
- Infinite possible combinations of pole and zero that satisfy 51-degree angle requirement
- Examples: z at -5, p at -12.5 (K=18.8); z at -4, p at -8.9 (K=14.7); z at -7, p at -107 (K=23.1)
- Compensators differ in gain and pole-zero separation, affecting gain scaling and second-order approximation validity

**Zero Positioning Constraints**
- Cannot place zero to right of target pole (-4), or rightmost system pole approaches it (becomes dominant)
- Cannot place zero to left beyond a minimum, or zero angle contribution exceeds required angle shift
- Practical range: -7.25 <= z <= -4
- At z = -4: pole at approximately -8.9, K = 14.7 (insufficient for accuracy spec)
- At z = -6.9: pole at approximately -76.6, K >= 27 (meets gain requirement)
- Pole much further than 5x the leftmost system pole is allowable; second-order approximation valid

**Design Tradeoffs**
- Closer pole-zero spacing: easier to build (within one order of magnitude), less vulnerable to noise/phase disturbances
- More distant spacing: slightly higher gain (less steady-state error)
- Diminishing returns as zero moves left; a gain increase from 27.3 to 28.8 (1%) not worth 25x pole distance
- Choose z = -6.9, p = -76.6, K = 27.3 (or similar nearby values) as practical compromise
### Design Process Summary
**Step-by-step procedure**
1. Establish uncompensated performance baseline with proportional control
2. Find gain satisfying steady-state error specification
3. Find specification region and select target pole in desired performance region
4. Try a zero position within feasible range
5. Calculate pole position satisfying angle criterion using trigonometry
6. Calculate gain producing target pole at desired location
7. If gain doesn't meet error specification, iterate with different zero position

**Testing Results**
- Before: proportional control with K=27, error >10%, settling time = baseline, damping ratio = 0.37
- After: lead compensator with final design, error <10%, settling time = 50% of baseline, overshoot reduced, damping ratio > 0.7
- All three design requirements successfully met
- Design is iterative; may need several cycles before achieving all specs
