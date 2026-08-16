---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 8.7 Lag compensator design - root locus
### When to Use Lag Compensation
**Ideal Application**
- System has acceptable transient response characteristics (speed, damping)
- Steady-state accuracy insufficient
- Goal: keep pole locations same to maintain good transient properties, but add more DC gain
- Proportional control won't work: increases gain indiscriminately, changes pole locations
- Lead compensator not ideal: designed to change root locus shape, not preserve it

**Example System**
- Plant: 12/[(s+2)(s+6)]
- Requirements:
  - Position error < 10%
  - Overshoot < 1% (requires zeta >= 0.83)
  - Settling time to 2% < 1 second (requires real part <= -4, tau <= 1/4)
- Target poles at -4 + j2.7 already on root locus
- Proportional gain needed: K = 0.94 satisfies transient specs
- Closed-loop gain at this setting: 0.94/(1 + 0.94) = 0.48
- This low closed-loop gain causes poor tracking (error far from 10%)
### Lag Compensator Placement Strategy
**DC Gain Requirement**
- For tracking error < 10%: system DC gain must be > 9
- Lag compensator contributes z/p to DC gain
- Must satisfy: 0.94 * (z/p) > 9, so z/p > 10.6 (use z/p > 10)

**Angle Criterion Preservation**
- Target point already satisfies angle criterion: -53.5 - 126.5 = -180 degrees
- Cannot disrupt this angle sum or will move poles off desired location
- Placing pole and zero far left creates large angle difference, violates criterion
- Example: pole at -70, zero at -7 contributes +145.7 - 15.9 = +129.8 degrees (too much)

**Moving Pole-Zero Close to Origin**
- Place pole and zero very close to origin where angles are nearly parallel
- Even with 10x separation required for gain, angles nearly cancel
- Compensator contributes theta_z - theta_p ≈ 0 + 0.1 degrees (negligible)
- Pole much closer to origin (>> 5x) than system poles becomes non-dominant
- Doesn't affect existing dominant pole behavior

**Practical Constraint**
- Cannot place pole at origin (would require zero at infinity, making transfer function improper)
- Integrator (pole at 0) requires active components (amplifiers, power sources)
- Lag compensator is passive (no poles at origin), uses only passive components
- Practical limit: z/p ratio <= 10

**Placement Rules of Thumb**
- Zero should be 10 to 50 times closer to origin than system poles
- Keep angle contribution < 2 degrees
- Can cascade multiple lag stages if > 10:1 ratio needed
- Example: poles at -6 and -2; place zero at -0.2, pole at -0.02 (10x ratio, ~1 degree contribution)
### Design Outcome and Tradeoff
**Time Domain Response**
- Compensated system's impulse response closely matches uncompensated
- Transient response preserved (damping, settling time of high-frequency components same)
- But step response takes much longer to settle
- Small pole at origin causes extra slow accumulation during integration

**Why Step Response Differs**
- Lag compensator pole contribution small but prolonged
- When integrating impulse response to get step response, small constant adds up slowly
- Sliver of extra area accumulates over time before reaching final value
- Effect is especially pronounced at low frequencies

**Tradeoff Analysis**
- Maintains excellent transient response (overshoot, damping)
- Improves steady-state accuracy significantly
- Cost: settling time increases dramatically
- Not suitable for time-critical applications
- Good for applications where accuracy and robustness matter more than speed
## 8.8 Lag compensator design - frequency domain
### Lag Compensator Frequency Response Characteristics
**Gain Shaping Properties**
- Adds gain at low frequencies, removes gain at high frequencies
- DC gain (s=0): z/p in linear form, 20*log10(z/p) in dB
- High frequency gain (s→infinity): 1 in linear form, 0 dB
- Transition region spans roughly 10:1 to 50:1 frequency range
- More practical than lead for low-frequency gain boost without stability issues

**Phase Response**
- Creates phase lag (negative phase shift) by design name
- But phase lag is not the main value of the compensator
- Main value is gain shaping: selective amplification at low frequencies
- Phase lag relatively unimportant compared to gain effect

**Combined System Response**
- When combined with plant response, boosts low frequencies without changing higher frequencies
- Effective strategy for increasing DC gain while preserving phase margin
- Different from lead: lead boosts phase margin directly, lag boosts low-frequency gain
### Frequency Domain Design Method 1: Adding Phase Margin
**Problem Setup**
- System has good accuracy but insufficient phase margin
- Proportional controller increases gain to 20 dB, reducing phase margin to only 30 degrees
- Want phase margin of 60 degrees for robustness against delays/sampling
- Lag compensator must contribute 30 degrees additional phase margin

**Strategy**
1. Find frequency where phase is 60 degrees away from -180 (i.e., at -120 degrees)
2. Decrease gain there until it becomes new gain crossover frequency
3. At new gain crossover with better phase: achieve desired phase margin

**Frequency Selection**
- At 4 rad/s: phase = -120 degrees, gain = 15 dB
- Need to decrease gain by 15 dB at this frequency
- Create lag compensator with DC gain of 15 dB = 10^(15/20) = 5.6
- Requires z/p = 5.6

**Pole-Zero Placement**
- Plant's -3 dB bandwidth around 2 rad/s (system pole break frequency)
- Place zero 10x lower than plant bandwidth: z at -0.2
- Calculate pole: p = z/5.6 = -0.036
- Compensator: (s + 0.2)/(5.6(s + 0.036)) scaled down by 1/5.6
- Decreasing section lands on target frequency (4 rad/s) without introducing unnecessary lower frequencies

**Result**
- Combined system has gain crossover at intended frequency
- Phase margin improves to desired level
- Low-frequency response unaffected
- High-frequency noise rejection maintained
### Frequency Domain Design Method 2: Sensitivity Reduction
**Sensitivity Function Background**
- Closed-loop sensitivity: S(jw) = 1/[1 + L(jw)] where L is loop transfer function
- Magnitude of sensitivity gives distance from frequency response point to -1
- Larger |L(jw) + 1| = smaller sensitivity = more robust system
- Sensitivity also equals transfer function from output disturbance to output

**Disturbance Rejection Implications**
- If sensitivity = 6 dB (factor of 2), output disturbances doubled in output
- Want to keep sensitivity < 3 dB (factor of 1.4) for robustness
- Inverse Nichols chart shows M circles for sensitivity levels
- Can plot specifications and iterate to find satisfactory design

**Two Specification Types**
- Local specifications: keep sensitivity below limit at particular frequencies or ranges
- Global specifications: keep sensitivity below limit at all frequencies
- Default rule: keep sensitivity < 3 dB globally if no specification given

**Compensator Design for Sensitivity**
- Increase gain enough to meet low-frequency sensitivity requirements (e.g., -15 dB @ 0.02 rad/s)
- Find lowest frequency violating high-frequency sensitivity boundary
- Place lag compensator zero 10-50x lower than plant bandwidth to create gain decrease at critical frequency
- Calibrate zero/pole ratio to decrease gain by required amount at that frequency

**Uncertainty Handling**
- Account for modeling uncertainty (e.g., +/- 5 dB gain uncertainty)
- Represent uncertainty as template around nominal response
- Shift sensitivity circles by uncertainty amount to accommodate full uncertainty range
- Entire uncertainty band must stay outside specified circles

**Iterative Design**
- Initial design may violate constraints at multiple frequencies
- Adjust pole/zero positions incrementally
- May need to move compensator frequency higher if too much affect at low frequencies
- May need to adjust gain ratio (z/p) if sensitivity requirements tighter than expected
### Lag Compensation Design Procedure
**Step-by-step Summary**
1. Increase gain to meet accuracy specifications or low-frequency sensitivity requirements
2. Calculate phase margin needed or identify frequency to decrease gain at
3. Calculate required zero/pole ratio z/p from:
   - Phase margin: using phase relationship (60 degrees desired, etc.)
   - Sensitivity: gain decrease required in dB = 20*log10(z/p)
4. Place zero 10-50x lower than system -3 dB bandwidth (or -3 dB point on Bode plot)
5. Calculate pole from z/p ratio
6. Check that low-frequency response not over-affected by compensator action
7. Verify both phase margin and sensitivity specifications met across all frequencies

**Design Considerations**
- Lag compensator reduces bandwidth (system becomes slower), visible in time domain
- Cannot increase phase directly like lead compensator, must reduce gain strategically
- Passive implementation limited to z/p ratios <= 10; cascade stages if needed
- Compensator placement critical: too high frequency affects low-frequency accuracy, too low affects mid-range response
- Iteration necessary: cannot always satisfy all constraints with single lag stage

**Trade-offs**
- Improves accuracy and robustness simultaneously
- Cost: reduced system bandwidth and slower transient settling
- Good for systems where disturbance rejection and plant uncertainty robustness matter
- Not suitable when fast response required with high accuracy
