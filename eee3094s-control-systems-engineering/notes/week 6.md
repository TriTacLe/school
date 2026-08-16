---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 4.2 Root locus part 2 sketching
### Root Locus Geometry and Angle Criterion
**Characteristic Equation in Closed Loop**
- Closed-loop transfer function: $G_{CL} = \frac{KQ(s)}{1+KQ(s)H(s)}$
- Characteristic equation: $1 + KQ(s)H(s) = 0$, or equivalently $KL(s) = -1$ where $L(s) = Q(s)H(s)$ is the loop transfer function
- At a closed-loop pole $\lambda$ when gain equals $K$: $KL(\lambda) = -1$

**Magnitude and Angle Conditions**
- From $KL(\lambda) = -1$:
  $$K\frac{(\lambda-z_1)(\lambda-z_2)...(\lambda-z_m)}{(\lambda-p_1)(\lambda-p_2)...(\lambda-p_n)} = -1$$
- Magnitude condition: $K\frac{\text{product of magnitudes from all zeros to } \lambda}{\text{product of magnitudes from all poles to } \lambda} = 1$ (can adjust gain to satisfy)
- Angle condition: sum of angles from zeros to $\lambda$ minus sum of angles from poles to $\lambda$ equals odd multiple of $\pi$:
  $$[\text{sum of angles from zeros}] - [\text{sum of angles from poles}] = (2k+1)\pi, \quad k \in \mathbb{Z}$$

**Angle Criterion**
- If sum of angles from zeros minus sum of angles from poles equals an odd multiple of $\pi$, then that point must be on the root locus for some gain value
- This is the fundamental geometric principle behind root locus sketching
### Real Axis Segments
**Rule for Real Axis Inclusion**
- For a point on the real axis, complex pole and zero pairs always contribute zero to the angle sum (angles cancel)
- Any section of the real axis with an odd number of real-valued poles and zeros on its right will be part of the root locus
- As we move from right to left along the real axis, we add or subtract $\pi$ every time we pass a critical frequency (pole or zero)
- Segments alternate between being on and off the root locus

**Example Analysis**
- Sections with 0, 2, 4, ... critical frequencies on right: angle sum is 0 (not on locus)
- Sections with 1, 3, 5, ... critical frequencies on right: angle sum is $\pi$ or $3\pi$, etc. (on locus)
### Asymptotes
**Number of Asymptotes**
- Only poles without corresponding zeros travel to infinity
- System with $m$ zeros and $n$ poles has $n - m$ asymptotes
- Each asymptote shows the direction a pole takes as it approaches infinity

**Asymptote Angles**
- As point approaches infinity along asymptote, distances between poles appear negligibly small
- All vectors from poles tend to same asymptote angle $\theta_a$
- Angle criterion at infinity: sum of $n$ pole angles equals $(2k+1)\pi$ where pole angles all equal $\theta_a$:
  $$n\theta_a = (2k+1)\pi \quad \text{for } k = 0, 1, 2, ...$$
  $$\theta_a = \frac{(2k-1)\pi}{n-m} \quad k = 1, 2, ..., (n-m)$$
- When zeros are present, they subtract from angle sum:
  $$n\theta_a - m\theta_a = (2k+1)\pi$$
  $$\theta_a = \frac{(2k-1)\pi}{n-m}$$

**Asymptote Centroid (Real Axis Intercept)**
- Consider second-order system: two poles, one asymptote (pointing to $-\infty$)
- For point to satisfy angle criterion on asymptote, angles from both poles must be equal
- This happens only when point is on perpendicular bisector of line connecting poles
- Asymptotes intersect the real axis at centroid: $\sigma_a = \frac{\sum \text{pole locations} - \sum \text{zero locations}}{n-m}$
- General rule: $\sigma_a = \frac{\sigma \text{ poles} - \sigma \text{ zeros}}{n-m}$ (sum of real parts of poles minus sum of real parts of zeros, divided by number of asymptotes)
### Breakaway and Break-in Points
**Physical Meaning**
- Breakaway points: where root locus leaves real axis (transition from overdamped to underdamped)
- Break-in points: where root locus returns to real axis (transition from underdamped to overdamped)
- These correspond to gains where system is critically damped
- Response transitions from over- to underdamped and back

**Finding Breakaway/Break-in Points**
- From characteristic equation $1 + KL(s) = 0$: $K(s) = -\frac{1}{L(s)}$
- Breakaway and break-in occur where $\frac{dK}{ds} = 0$ or equivalently $\frac{d}{ds}\frac{1}{L(s)} = 0$

**Alternative Formula (Less Computational)**
- Instead of computing derivative of $\frac{1}{L(s)}$, use logarithmic derivative:
  $$\frac{d}{ds}\ln\frac{1}{L(s)} = 0$$
- Properties of logarithms convert products to sums:
  $$\frac{d}{ds}[\ln(s-p_1) + ... + \ln(s-p_n) - \ln(s-z_1) - ... - \ln(s-z_m)] = 0$$
- Taking derivatives:
  $$\frac{1}{s-p_1} + ... + \frac{1}{s-p_n} = \frac{1}{s-z_1} + ... + \frac{1}{s-z_m}$$
- Solve for values of $\lambda$ satisfying this equation

**Example with L(s) = (s+5)/[(s+2)(s+4)]**
- $K(s) = -(s+2)(s+4)/(s+5)$
- $\frac{dK}{ds} = -\frac{s^2+10s+22}{(s+5)^2} = 0$
- $s^2 + 10s + 22 = 0$ gives $s = -5 \pm \sqrt{3}$, approximately $-3.3$ and $-6.7$
### Imaginary Axis Intercepts
**Maximum Gain and Stability**
- Imaginary intercepts show where root locus crosses $j\omega$ axis
- These points indicate the system's maximum gain before becoming unstable
- Transition from stable to unstable

**Method 1: Routh-Hurwitz Criterion**
- Use Routh-Hurwitz array to find maximum gain $K_{\max}$
- Substitute this into characteristic equation and solve for imaginary roots

**Method 2: Substitution of $j\omega$**
- Substitute $s = j\omega$ into characteristic equation
- Separate into real and imaginary parts
- Solve for values of $K$ and $\omega$ making both real and imaginary parts zero

**Example with System from Second-Order Case**
- Characteristic equation: $K(s^2-4s+5) + s^2+8s+15 = 0$
- Open-loop zeros at $2 \pm j$ (right-half plane zeros exist)
- Using Routh array: $K \leq 2$
- At $K = 2$: $3s^2 + 0s + 25 = 0$ gives $s = \pm j\sqrt{25/3} = \pm 5j/\sqrt{3}$
- Alternative: substitute $j\omega$: Real part $-(1+K)\omega^2 + 15 + 5K = 0$, Imaginary part $(8-4K)\omega = 0$ gives $K = 2$ and $\omega = 5/\sqrt{3}$
### Angles of Arrival and Departure
**Definitions**
- Angle of arrival: angle at which root locus approaches a complex zero
- Angle of departure: angle from which root locus leaves a complex pole
- These angles reveal information about damping and frequency characteristics

**Physical Insight**
- Steeper angle (further from real axis) indicates higher frequencies and lower damping ratios
- Angles help refine sketch of root locus shape

**Calculation Method**
- Consider point on root locus very close to the complex zero or pole
- Angles from all other poles and zeros to this point are (approximately) their angles to the zero/pole in question
- Point must satisfy angle criterion: the unknown arrival/departure angle is the only variable
- Solve for the angle

**Angle of Arrival at Complex Zero**
- Formula: $(2k-1)\pi - \sum(\text{angles from poles to zero}) + \sum(\text{angles from other zeros to zero}) = \theta_{\text{arrival}}$

**Angle of Departure from Complex Pole**
- Formula: $(2k-1)\pi - \sum(\text{angles from other poles to pole}) + \sum(\text{angles from zeros to pole}) = \theta_{\text{departure}}$
- Common choice: keep angle in range $[-\pi, \pi]$ (add or subtract $2\pi$ as needed)
### Sketching Rules Summary
**Real Axis Segments Rule**
- Any section of the real axis with an odd number of real-valued critical frequencies (poles or zeros) on its right is on the root locus

**Asymptotes (2 parts)**
- Number: $n - m$ asymptotes (where $n$ = poles, $m$ = zeros)
- Angles: $\theta_a = \frac{(2k-1)\pi}{n-m}$ for $k = 1, 2, ..., n-m$

**Centroid Rule**
- Asymptotes intersect real axis at: $\sigma_a = \frac{\sum \text{pole locations} - \sum \text{zero locations}}{n-m}$

**Breakaway/Break-in Points**
- Where $\frac{d}{ds}K(s) = \frac{d}{ds}\frac{1}{L(s)} = 0$ or where $\sum \frac{1}{s-p_i} = \sum \frac{1}{s-z_j}$

**Imaginary Axis Crossings**
- Find maximum gain using Routh array, then substitute into characteristic equation
- Or substitute $j\omega$ and solve for $K$ and $\omega$ making real and imaginary parts zero

**Angles of Arrival/Departure**
- Arrival at complex zero: $(2k-1)\pi - \sum(\text{angles from poles}) + \sum(\text{angles from other zeros})$
- Departure from complex pole: $(2k-1)\pi - \sum(\text{angles from other poles}) + \sum(\text{angles from zeros})$
## 4.3 Root locus examples
### Example 1: Fifth-Order System
**System Overview**
- Fifth-order system with 2 zeros and 5 poles (generated from random transfer function)
- Poles: $-7 \pm 4j$, $-6 \pm 2j$, $-5$
- Zeros: $4 \pm 3j$

**Real Axis Segments**
- Only section of real axis to the left of pole at $-5$ (to the left of all poles and zeros) has odd number of critical frequencies (all 5+2=7 on its right)
- This is the only part of the real axis that is part of the root locus

**Asymptotes Analysis**
- Number of poles minus zeros: $5 - 2 = 3$ asymptotes
- Sum of poles: $-7 + 4j - 7 - 4j - 6 + 2j - 6 - 2j - 5 = -31$
- Sum of zeros: $4 + 3j + 4 - 3j = 8$
- Centroid: $\sigma_a = \frac{-31 - 8}{3} = \frac{-39}{3} = -13$
- Asymptote angles: $\theta_a = \frac{(2k-1)\pi}{3}$
  - $k=1$: $\theta_a = \pi/3$ (60 degrees)
  - $k=2$: $\theta_a = \pi$ (180 degrees, real axis)
  - $k=3$: $\theta_a = -\pi/3$ (-60 degrees)

**Breakaway and Break-in Points**
- No breakaway or break-in points found (would be complex values)
- This tells us the outer complex poles travel directly along asymptotes to infinity

**Imaginary Axis Crossings**
- Using Routh-Hurwitz criterion: maximum gain $K \leq 683$
- At $K = 683$: characteristic equation gives crossings at $s = \pm 3.12j$
- These represent the transition points where system becomes unstable

**Angles of Arrival and Departure**
- At complex pole near $-4 + 3j$:
  - Angles from other poles: calculated using trigonometry
  - Example calculation: vector from pole at $-7 + 4j$ has angle $\approx 2.03$ rad
  - Using angle criterion: solve for departure angle
  - Result: $\theta_{d1} = 1.40$ rad (after adjusting to $[-\pi, \pi]$ range)
- Symmetry ensures departure angle from $-4 - 3j$ is $-1.40$ rad

**Rough Sketch and Refinement**
- Outermost complex poles travel outward along asymptotes
- Outer poles at $\pm 4 \pm 3j$ (zeros) serve as attractors for some poles
- Inner poles and real pole must move to their destinations without overlapping
- Departure angles help identify whether poles become complex
- Imaginary crossings confirm maximum stable gain
- True solution shows poles' complex paths through s-plane

**Interpretation**
- Response is decomposed into three first- or second-order modes
- Real pole's response gets faster (less dominant) as gain increases
- Inner complex pole pair stays close to open-loop frequency but decays more slowly as poles approach origin
- Outer complex poles' response slows down, but oscillation frequency increases as poles move from real axis
- Overall: response becomes more oscillatory at higher frequency as gain increases
- Proportional control makes system worse; compensation needed to reduce oscillation
### Example 2: Damping Coefficient Variation
**Problem Setup**
- System: $\frac{1}{s^2 + bs + 1}$ with characteristic equation $s^2 + bs + 1 = 0$
- Goal: track pole behavior as damping coefficient $b$ is varied (not gain)
- Can reformulate as root locus by writing: $(s^2 + 1) + bs = 0$, then $1 + b\frac{s}{s^2+1} = 0$

**Auxiliary Transfer Function**
- Auxiliary: $L(s) = \frac{s}{s^2+1}$
- Loop transfer function has poles at $\pm j$ (undamped system poles on imaginary axis)
- Zero at origin
- Pole positions (undamped): $j$ and $-j$ on imaginary axis

**Root Locus Sketch**
- Real axis segments: zero at origin, so no odd count on right for any real section
- Asymptote: $n - m = 2 - 1 = 1$ asymptote
  - Angle: $\theta_a = \frac{(2k-1)\pi}{1} = \pm \pi$ (along negative real axis)
  - Centroid: $\sigma_a = \frac{0 - 0}{1} = 0$ (starts at origin, goes to $-\infty$)
- Poles start at $\pm j$ and move toward $0$ and $-\infty$
- One pole moves along imaginary axis toward origin, the other breaks into complex plane

**Pole Movements and Damping**
- When $b = 0$ (no damping): poles at $\pm j$ (undamped oscillation, $\zeta = 0$)
- As $b$ increases: damping ratio increases
- At breakaway/break-in point: system reaches critical damping ($\zeta = 1$)
  - Poles: real and equal
- Beyond breakaway: system becomes overdamped, poles move along real axis
  - One pole approaches origin (slower)
  - Other pole approaches $-\infty$ (faster)

**True Solution**
- Poles start on imaginary axis at $\pm j$
- Break away from imaginary axis at break-in point
- Move toward real axis along symmetric paths
- Rejoin real axis at critical point
- One pole moves slowly toward origin, other approaches $-\infty$

**Interpretation**
- Small damping coefficient: underdamped response (complex poles, oscillation)
- Intermediate damping: system passes through critical damping
- Large damping coefficient: overdamped response (real poles, slow response)
- Can use root locus to predict exact damping coefficient needed for desired damping ratio
### Root Sensitivity
**Definition**
- Root sensitivity: sensitivity of pole position to changes in some parameter
- Formula: $S_\lambda^p = \frac{\partial p / p}{\partial \lambda / \lambda}$ (fractional change in pole position per fractional change in parameter)
- Often interested in sensitivity with respect to gain: $S_K^p = \frac{\partial p / p}{\partial K / K}$
- Can compute for any parameter (e.g., damping coefficient $b$)

**Visualization**
- Annotate root locus with parameter values that produce each pole location
- Poles are not spaced uniformly even for uniformly-spaced parameter values
- Tightly spaced parameter markers indicate low sensitivity (poles don't move much)
- Widely spaced markers indicate high sensitivity (poles move a lot)

**Practical Example: Damper with Tolerance**
- Nominal damping coefficient: $b = 2$ (critically damped)
- Tolerance: 10% (range from 1.8 to 2.2)
- At $b = 1.8$: poles at $-0.9 \pm 4.3j$ (underdamped)
- At $b = 2$: poles at $-1$ (critically damped)
- At $b = 2.2$: poles at $-1.5$ and $-0.6$ (overdamped)
- Sensitivity: $S_b^p = \frac{\text{largest pole change}}{0.1} \approx 5$ (poles move significantly for small parameter changes)

**Improving Robustness**
- Same tolerance (10%) applied to higher nominal value: $b = 4$ (overdamped region)
- Range from 3.6 to 4.4: poles don't vary as much
- Sensitivity: $S_b^p \approx 1.1$ (much lower)
- Design recommendation: choose operating point in less sensitive region of root locus
### Summary: Root Locus Applications
**What It Shows**
- Positions of closed-loop poles for all values of gain (or other parameter)

**What We Can Do With It**
- Evaluate stability margins for different parameters
- See how parameter variation affects system's performance
- Evaluate sensitivity of system to specific parameter over different ranges
- Design compensators to place poles in desired region
