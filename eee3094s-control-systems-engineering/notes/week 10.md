---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 8.6 Lead compensator design - frequency domain
### Frequency Domain Perspective on Lead Compensation
**Comparing Domains**
- Root locus design gave specific compensator: z at -6.9, p at -76.6, K = 27.3
- Frequency domain design on same system produces: z at -2.8, p at -28.3, K = 27 with alpha = 10 (different from root locus result)
- Both designs meet all three requirements but approach the problem differently
- Frequency domain emphasizes phase margin improvement and gain shaping

**Understanding Phase Improvement**
- Uncompensated system at K=27: phase margin only 40 degrees, explaining oscillatory response
- Damping ratio proportional to phase margin: zeta = A*phi_m/100
- Low phase margin produces underdamped, oscillatory response
- Lead compensator adds approximately 30 degrees of phase at gain crossover frequency
- This improves both gain margin and damping ratio
### Lead Compensator Frequency Domain Formulation
**Alternative Representation**
- Standard form: K(s + z)/(s + p)
- Frequency domain form: K(alpha*tau*s - 1)/(tau*s - 1)
- Time constant: tau related to pole position
- Ratio: alpha = p/z (distance between pole and zero on real axis)
- Practical constraint: keep alpha <= 10 to avoid excessively large pole-zero separation
- If need more than 60 degrees phase lead: cascade multiple stages

**Phase Lead Calculation**
- At midpoint frequency (geometric mean): omega_m = sqrt(z*p) = 1/(tau*sqrt(alpha))
- Phase response: zero breaks at lower frequency, pole at higher frequency
- Maximum phase lead occurs at omega_m where phase contributions are balanced
- Peak phase lead formula: sin(phi_p) = (alpha - 1)/(alpha + 1)
- At omega_m on log scale: peak phase located at geometric mean of frequencies
- Compensator gain at peak: 10*log10(alpha) above DC gain

**Gain Compensation Effect**
- DC gain: 0 dB (at s=0, numerator and denominator both -1)
- High frequency gain: 20*log10(alpha) dB (at s=infinity, gain approaches alpha)
- At midpoint frequency omega_m: gain is 10*log10(alpha) dB
### Design Challenges and Solutions
**Phase Margin Paradox**
- Cannot place peak phase lead exactly at plant's gain crossover frequency
- If peak is at original gain crossover: adds 10*log10(alpha) dB extra gain
- This shifts new gain crossover to higher frequency where phase is more negative
- Result: does not achieve full 40 degrees of phase margin improvement as intended
- Must account for this gain interaction in design process

**Frequency Selection Strategy**
- Place peak at frequency where plant gain is -10*log10(alpha) dB
- When compensator and plant combine, new gain crossover has both at peak phase location
- This maximizes phase margin improvement at actual gain crossover point
- Tradeoff: may not achieve full intended phase lead due to -10*log10(alpha) offset

**Scaling Constraints**
- Cannot reduce compensator gain to preserve original gain crossover
- Scaling down would satisfy accuracy requirement but then insufficient low-frequency gain
- Scaling back up recreates original problem of insufficient phase margin
- Must accept that design involves frequency shift and iterate on alpha value
### Design Procedure
**Specification Translation to Frequency Domain**
- Accuracy spec (e < 10%): requires DC gain >= 9
- Speed spec (halve settling time): requires natural frequency omega_n >= 5.55 rad/s
- Damping spec (zeta > 0.7): requires phase margin >= 80 degrees (from zeta = A*phi_m/100 with A=0.9, phi_m=80)
- At target damping zeta=0.72: closed-loop magnitude at omega_n is -4.1 dB
- Proportional control at K=27 achieves ~40 degrees phase margin but omega_n is only ~4 rad/s

**Step-by-step Process**
1. Find gain satisfying steady-state error specification
2. Calculate phase margin at this gain
3. Determine extra phase lead needed (e.g., 40 degrees more)
4. Calculate required alpha from: sin(phi_p) = (alpha - 1)/(alpha + 1)
5. Locate frequency where plant gain = -10*log10(alpha) dB
6. Calculate time constant tau from: omega_m = 1/(tau*sqrt(alpha))
7. If designed alpha insufficient for phase margin requirement, try larger alpha (integer values 4-10)
8. Check resulting system speed using Nichols chart (find M circle for required natural frequency)

**Compensator Pole-Zero Calculation**
- From alpha and tau: z = -1/(alpha*tau), p = -1/tau
- Final compensator: K[alpha*tau*s + 1]/[tau*s + 1]
- Example with alpha=10, tau=0.06: z = -2.8, p = -28.3
- Verify design meets all three specs before implementation
### Speed Verification via Bandwidth
**Natural Frequency vs Bandwidth**
- Bandwidth (omega_BW) and natural frequency (omega_n) related by damping ratio
- Full formula: omega_BW = omega_n * sqrt(1 - 2*zeta^2 + sqrt(4*zeta^4 - 4*zeta^2 + 2))
- Linear approximation (0.3 < zeta < 0.8): omega_BW/omega_n ≈ -1.19*zeta + 1.85
- For zeta=0.72, omega_n=5.55: omega_BW ≈ 5.45 rad/s

**Using Nichols Chart for Speed Check**
- Find -3 dB point on Nichols chart using M circles
- Frequency where magnitude drops 3 dB below DC gain is bandwidth
- Bandwidth higher than required indicates design exceeds speed specification
- Compare actual bandwidth to calculated requirement

**Speed Comparison Across Designs**
- Different alpha values produce different phase margins and damping ratios
- Each design requires different natural frequency target based on its damping
- M circles differ for different natural frequencies
- Higher alpha produces higher natural frequency (faster response)
- All designs with alpha >= minimum for phase margin requirement exceed speed spec
- Alpha selection influences margin by which speed requirement is exceeded
### Practical Design Notes
**Why Bandwidth Over Natural Frequency**
- Bandwidth indicates where roll-off begins (higher bandwidth = more noise passed)
- Easier to compare multiple systems with same DC gain using bandwidth
- -3 dB point always relative to DC gain, so consistent reference
- More commonly used in industry than natural frequency approach

**Real Design Considerations**
- Final frequency domain design may differ significantly from root locus version
- Both approaches valid; represent different design philosophies
- Frequency domain emphasizes steady-state gain and stability margins
- Root locus emphasizes pole placement and transient response
- Choice depends on available information and design specifications

**Example Final Design**
- Compensator: 10(s + 2.8)/(s + 28.3) * 27
- Results: error < 10%, settling time < 50% of baseline, minimal overshoot
- Outperforms root locus design in speed with same accuracy
- Meets all three design requirements
