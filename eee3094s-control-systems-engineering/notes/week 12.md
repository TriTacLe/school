---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 8.9 Lead-lag design
### Combining Lead and Lag Stages
**Motivation**
- Lead compensators can improve transient response and add gain
- But there are limits to what they can accomplish alone
- Gain requirement may force zero placement to extreme position (root locus) or require very large alpha ratio (frequency domain)
- Lead compensator designs hit practical limits in both approaches

**Lead-Lag Architecture**
- Cascade lead stage followed by lag stage in the compensator path
- Lead stage: improves damping and phase margin, adds some gain
- Lag stage: adds additional low-frequency gain without affecting transient response
- Design strategy: get maximum gain from lead, use lag for remaining gain requirement
### Root Locus Design of Lead-Lag Compensator
**Example Problem**
- Unstable plant: 1/[(s+1)(s-2)]
- Requirements:
  - Stabilize system
  - Track step with 97.5% accuracy
  - Increase damping ratio to > 0.45
  - Decrease settling time (2%) to < 4 seconds
- Target poles: -3 +/- j4 satisfy requirements with some margin

**Lead Stage Design**
- Angle criterion at target: -(116.6 + 141.4) = -258 degrees
- Need 78 degrees from compensator: -258 + 78 = -180
- Zero position constrained: cannot exceed -3.85 (would contribute >78 degrees alone)
- Optimal zero/pole placement: z at -3.32, p at -33.3 (alpha = 10 for maximum gain)
- Proportional gain calculation: K = 218 at target pole
- DC gain from lead stage alone: 218 * (3.32/33.3) * (1/[1*(-2)]) = 10.9
- Closed-loop gain with K=218: 10.9/(1 + 10.9) = 0.92 (tracking accuracy 92%)

**Lag Stage Design**
- Accuracy requirement: need DC gain of 40 for 97.5% tracking (0.975/(1 + 0.975) = 0.975 close to 0.975)
- Lag gain requirement: 40/10.9 = 3.7, round to 4
- Cannot use standard "10-50x" rule due to existing pole at -33.3
- Use angle criterion: keep compensator angle contribution < 2 degrees
- Trial and error: z at -0.28, p at -0.07 satisfies angle and gain requirements
- Result: both transitional dynamics and accuracy requirements satisfied

**Combined System Performance**
- Stabilized system with fast, well-damped response
- Tracking accuracy improved to 97.5%
- Settling time within 4 seconds
- Design successfully meets all four requirements
### Frequency Domain Design of Lead-Lag Compensator
**Method 1: Stabilizing an Unstable System**
- Plant: 1/[(s+1)(s-2)] (same unstable system)
- Gain = 40 for 97.5% accuracy, damping requirement phi_m = 46 degrees
- Lead compensator design: alpha >= 7.5, use alpha = 10 for safety margin
- Place peak at -10 dB point on plant Bode plot (approximately 16 rad/s)
- Calculate tau from midpoint frequency: omega_m = 1/(tau*sqrt(alpha))
- Result: single lead compensator with 40(10*0.02s + 1)/(0.02s + 1) = 40(0.2s + 1)/(0.02s + 1) sufficient
- Design produces stable, accurate, fast and well-damped response without lag stage needed

**Method 2: Improving Existing Lead Design with More Accuracy**
- Plant with higher accuracy requirement: error < 1% (not 10%)
- DC gain needed: 99 for 1% error
- Proportional gain to 99 causes phase margin to drop significantly
- Damping requirement: phi_m = 70 degrees
- Lead stage with alpha = 10 can add 55 degrees at peak
- But offset from gain crossover reduces effective phase improvement to < 70 degrees
- Cannot increase lead phase further without exceeding practical limits

**Lead-Lag Solution for Higher Accuracy**
- Original lead design: 10(s + 2.8)/(s + 28.3) with K = 27
- Phase margin at higher gain: 70 degrees (extra margin available)
- Can increase lead stage proportional gain from 27 to 60 (still maintaining 70 degree margin)
- DC gain from lead stage alone: 60 * 10 * (2.8/28.3) * (1/3) = 20
- Remaining gain needed: 99/20 = 5 (rounded up for safety)
- Add lag compensator: (s + z)/(s + p) with z/p = 5

**Lag Stage Placement in Frequency Domain**
- Plant -3 dB bandwidth: approximately 1 rad/s
- Conservative approach: place zero 10x lower at 0.1 rad/s, pole at 0.02 rad/s
- More aggressive: place zero at 0.5 rad/s, pole at 0.1 rad/s (5:1 ratio)
- Verify: ensure lag stage gain decrease doesn't reach gain crossover frequency
- Check: phase margin remains >= 70 degrees after lag addition
- Result: (s + 0.5)/(s + 0.1) preserves speed while adding required low-frequency gain

**Combined System Performance**
- Proportional gain: 60, lead stage K = 10, lag gain = 5
- Total DC gain: 60 * 10 * (2.8/28.3) * (5/ratio) = 99+ for 1% accuracy
- Fast transient response maintained (< 1 second settling)
- Damping ratio > 0.7 maintained throughout
- Design successfully meets all requirements including 1% accuracy goal
### Design Strategy and Tradeoffs
**Lead Stage Design Goals**
- Achieve required transient response (damping, speed)
- Add as much DC gain as possible without exceeding practical limits
- Minimize load on lag stage (lag stage makes response slower)
- Balance pole-zero placement to get maximum gain while preserving phase margin

**Lag Stage Design Goals**
- Add remaining DC gain needed for accuracy requirement
- Place far from system dynamics to minimize transient response degradation
- Keep angle contribution negligible (< 2 degrees)
- Position zero and pole close enough to avoid excessive bandwidth reduction

**Key Insights**
- Lead stage optimizes transient response and adds some gain
- Lag stage concentrates on steady-state accuracy improvement
- Cascading stages allow achieving goals that individual compensators cannot
- Frequency domain design more flexible for complex tradeoffs
- Root locus design clearer for understanding pole placement effects

**Practical Limitations**
- Each lead stage adds up to 90 degrees phase (practical limit ~60 degrees)
- Each lag stage adds up to 10:1 gain ratio (z/p <= 10 for passive implementation)
- Multiple stages can exceed practical component constraints
- Design must balance performance against implementation complexity
