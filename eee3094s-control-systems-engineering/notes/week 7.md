---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 5.3 Nyquist plots
### Stability from Frequency Response
**Can frequency response tell us about stability**
- Bode plot shows frequency response magnitude and phase
- For stable open-loop system, Bode plot is valid
- But we often want to assess closed-loop stability

**Unstable poles in frequency response**
- Unstable system has poles in right-half plane
- When we substitute $j\omega$ (on imaginary axis), we're evaluating transfer function outside region of convergence
- Results don't have physical meaning for unstable system
- Fourier transform integral doesn't converge for unstable systems

**Stability criterion from transfer function**
- Closed-loop: $G_{CL} = \frac{L(s)}{1 + L(s)}$ where $L(s) = K(s)Q(s)H(s)$ is loop transfer function
- Closed-loop poles = zeros of $1 + L(s)$
- System unstable if $L(s) = -1$ at any frequency
- This means: magnitude = 1 (0 dB) AND phase = -180 degrees (or odd multiple)

**Gain and phase margins: open-loop perspective**
- Gain crossover frequency: frequency where gain = 0 dB
- Phase crossover frequency: frequency where phase = -180 degrees (or odd multiple)
- Gain margin: how much magnitude can increase before hitting -1 point
- Phase margin: how much phase can shift before hitting -1 point
- Margins wider = more stable

**Limitation of margins alone**
- Gain and phase margins assume one parameter varies independently
- Can't capture systems where both vary together
- Example: system with high gain margin but low phase margin, or vice versa, might be sensitive to combined variation
- Margins don't fully characterize robustness
### Cauchy's Argument Principle
**Contour in complex plane**
- Contour = closed looping path in s-plane
- Can map contour through transfer function to get new contour in output

**Output contour interpretation**
- Position of output contour reveals location of input contour relative to poles and zeros
- Output for point $\lambda$: product of vectors from all zeros to $\lambda$, divided by product of vectors from all poles
- $G(\lambda) = K\frac{(\lambda-z_1)(\lambda-z_2)...(\lambda-z_m)}{(\lambda-p_1)(\lambda-p_2)...(\lambda-p_n)}$

**Argument calculation**
- Angle of output = sum of zero vector angles minus sum of pole vector angles
- $\angle G(\lambda) = \angle(\lambda-z_1) + \angle(\lambda-z_2) + ... - \angle(\lambda-p_1) - ... $

**Encirclement condition**
- For point far from contour: angle range less than 360 degrees
- Only if pole or zero is inside contour: angle sweeps full 360 degrees (one encirclement)
- Multiple poles/zeros inside: multiple encirclements

**Encirclement formula**
- $N = Z - P$ where $N$ is encirclements, $Z$ is zeros inside contour, $P$ is poles inside
- From $N$, we can deduce how many zeros (or poles) enclosed
### Nyquist Stability Criterion
**Problem setup**
- Want to find how many zeros of $1 + L(s)$ are in right-half plane
- These zeros are the unstable closed-loop poles
- Know number of unstable poles in $1 + L(s)$ from open-loop $L(s)$ (same denominator)

**Nyquist contour**
- Contour around entire right-half plane: vertical line along imaginary axis from $-j\infty$ to $+j\infty$, then semicircle at infinity
- Pass this contour through $1 + L(s)$; count encirclements of origin

**Shift to L(s)**
- Instead of plotting $1 + L(s)$ and counting encircles of origin
- Plot just $L(s)$ and count encircles of -1
- Reason: adding real constant shifts plot horizontally; $-1$ is shift of origin by 1 unit left

**Stability condition**
- If $L(s)$ (open-loop) is stable: zero encircles of -1 means closed-loop stable
- If $L(s)$ is unstable with $P$ unstable poles: $N$ counterclockwise encircles of -1 needed for stability
- Formula: $Z = N + P$ where $Z$ must equal zero for closed-loop stability

**Clockwise vs. counterclockwise**
- Positive encirclement = clockwise
- Negative encirclement = counterclockwise (opposite of input)
- Sign matters for determining stability
### Sketching Nyquist Plots
**Procedure for sketching**

Step 1: Substitute $s = j\omega$ and find starting point ($\omega \to 0$)
- Evaluate $L(j0)$ to find where plot begins
- This gives starting magnitude and phase

Step 2: Find ending point ($\omega \to \infty$)
- Evaluate behavior as $\omega \to \infty$
- For proper transfer function, ends at origin

Step 3: Find real and imaginary axis crossings
- Separate into real and imaginary parts: $L(j\omega) = R(\omega) + jI(\omega)$
- Solve $R(\omega) = 0$ to find imaginary axis crossings; evaluate imaginary part there
- Solve $I(\omega) = 0$ to find real axis crossings; evaluate real part there

Step 4: Complete the curve
- Connect points smoothly based on continuity and known asymptotes

Step 5: Reflect for negative frequencies
- Nyquist criterion uses full range $-\infty$ to $+\infty$
- For real systems, reflect plotted positive frequency curve across real axis
- This creates closed contour

Step 6: Indicate direction of increasing frequency

**Example: second-order system**
- $L(s) = \frac{480}{s^2 + 10s + 24}$
- At $\omega = 0$: $L(j0) = 20$ (starting point on real axis)
- At $\omega = \infty$: $L(j\infty) = 0$ (ends at origin)
- At $\omega = \sqrt{24}$: real part = 0; imaginary part = -9.8
- At $\omega = 0$: imaginary part = 0; real part = 20
- Curve passes through these points, reflecting symmetry
### Analyzing Closed-Loop Response
**Gain margin from Nyquist plot**
- If plot doesn't intersect negative real axis: infinite gain margin
- If plot does intersect: find intersection point; gain margin is reciprocal of distance from origin
- Tells how much system gain can increase before encircling -1

**Phase margin from Nyquist plot**
- Find point on plot with magnitude exactly 1 (distance from origin = 1)
- Find angle from that point to -1 along the unit circle
- That angle is phase margin
- System can tolerate that much phase shift without becoming unstable

**Gain and phase shift effects**
- Scaling by gain $K$: scales magnitude of all points; doesn't change angle
- Scaling by $e^{-j\theta}$ (phase shift): rotates all points; each point rotates by same angle
- Phase shift most realistic physically via frequency-dependent delay $e^{-j\omega t_0}$ (causes spiral)

**Sensitivity via minimum distance to -1**
- Vector from -1 to any point on plot: $L(j\omega) + 1$
- Distance to -1: $|L(j\omega) + 1|$
- Minimum distance indicates how close system is to instability
- Smaller minimum distance = higher sensitivity to perturbations

**Sensitivity function definition**
- $S(j\omega) = \frac{1}{1 + L(j\omega)}$
- Magnitude $|S(j\omega)|$ tells how much open-loop changes get magnified to closed-loop
- $|S| > 1$: changes amplified (bad); $|S| < 1$: changes attenuated (good)
## 5.4 Constant M and N circles
### Closed-Loop Inference from Open-Loop
**Why we care**
- Root locus shows closed-loop poles vs. gain
- Nyquist shows closed-loop stability
- Can we also get closed-loop magnitude and phase response directly from open-loop plot

**From s-plane to frequency domain**
- Root locus: lines of constant time-domain characteristics (settling time, damping)
- Frequency domain: circles of constant closed-loop magnitude and phase
- These circles overlay on top of open-loop frequency response plot
### M Circles and N Circles
**M circles: constant closed-loop magnitude**
- Each circle represents one closed-loop gain value
- Open-loop point on circle means closed-loop magnitude at that frequency is the circle's value
- Circles of value 1 (0 dB) are line through -1/2
- Circles > 1 extend left; circles < 1 extend right

**N circles: constant closed-loop phase**
- Each circle represents one closed-loop phase angle
- Open-loop point on circle means closed-loop phase at that frequency is the circle's value
- N = tan(phase angle)
- Positive angles (upper half-plane); negative angles (lower half-plane)
### Derivation of M Circle
**Starting with closed-loop transfer function**
- Unity feedback: $G_{CL}(j\omega) = \frac{G(j\omega)}{1 + G(j\omega)}$
- Let open-loop response be $a(j\omega) + jb(j\omega)$ where $a, b$ are real and imaginary parts

**Magnitude ratio**
- $M = \frac{|a + jb|}{|(1+a) + jb|} = \frac{\sqrt{a^2 + b^2}}{\sqrt{(1+a)^2 + b^2}}$

**Derivation steps**
- Square both sides: $M^2 = \frac{a^2 + b^2}{(1+a)^2 + b^2}$
- Multiply by denominator: $M^2[(1+a)^2 + b^2] = a^2 + b^2$
- Expand: $M^2(1 + 2a + a^2 + b^2) = a^2 + b^2$
- Rearrange: $M^2 + 2aM^2 + a^2(M^2-1) + b^2(M^2-1) = -M^2$
- Complete square: $\left(a + \frac{M^2}{M^2-1}\right)^2 + b^2 = \left(\frac{M}{M^2-1}\right)^2$

**M circle equation**
- $\left(a + \frac{M^2}{M^2-1}\right)^2 + b^2 = \left(\frac{M}{M^2-1}\right)^2$
- Center: $\left(-\frac{M^2}{M^2-1}, 0\right)$
- Radius: $\frac{M}{M^2-1}$ (absolute value)
- Special case $M = 1$: straight line through -1/2 (infinite radius)
### Derivation of N Circle
**Starting with closed-loop phase**
- Phase difference: $\theta = \angle(a+jb) - \angle(1+a+jb)$
- Using tangent difference formula with $N = \tan(\theta)$
- $N = \tan\left(\arctan\frac{b}{a} - \arctan\frac{b}{1+a}\right)$

**Derivation steps**
- Apply identity: $\tan(\alpha - \beta) = \frac{\tan\alpha - \tan\beta}{1 + \tan\alpha\tan\beta}$
- Simplify: $N = \frac{\frac{b}{a} - \frac{b}{1+a}}{1 + \frac{b^2}{a(1+a)}} = \frac{b(1+a) - ba}{a(1+a) + b^2} = \frac{b}{a(1+a) + b^2}$
- Multiply by denominator: $N[a(1+a) + b^2] = b$
- Rearrange: $Na + Na^2 + Nb^2 = b$
- Complete squares: $\left(a + \frac{1}{2}\right)^2 + \left(b - \frac{1}{2N}\right)^2 = \left(\frac{1}{2}\right)^2 + \left(\frac{1}{2N}\right)^2$

**N circle equation**
- $\left(a + \frac{1}{2}\right)^2 + \left(b - \frac{1}{2N}\right)^2 = \frac{1}{4}\left(1 + \frac{1}{N^2}\right)$
- Center: $\left(-\frac{1}{2}, \frac{1}{2N}\right)$
- Radius: $\frac{1}{2}\sqrt{1 + \frac{1}{N^2}}$
- Special case $N = 0$ (phase = 0): straight line along real axis
### Using M and N Circles
**Example: apply circles to Nyquist plot**
- Plot open-loop frequency response (Nyquist plot)
- Overlay M and N circles
- Where open-loop curve intersects a circle, read off closed-loop magnitude or phase

**For varying gain**
- Multiply open-loop by gain $K$: scales all points outward from origin
- Low frequencies extend toward unit circle (0 dB)
- Around break frequency: passes through circles of larger magnitude as resonance emerges
- Easier to visualize gain effect this way

**Magnitude behavior**
- Low frequencies: stick to circle close to origin
- Higher frequencies: loop toward origin through circles of decreasing magnitude

**Phase behavior**
- Starts at 0 degrees (real axis)
- Ends at higher negative angles
- Passes through all intermediate phase circles
## 5.5 Nichols chart
### Frequency Response Visualization Roundup
**Three ways to plot the same system**

Bode plot:
- Magnitude in dB vs. log(frequency), phase in degrees vs. log(frequency)
- Two separate axes
- Pros: easy to read frequency response across spectrum; easy to see gain/phase at specific frequencies

Nyquist plot:
- Real and imaginary parts on single complex plane
- Frequency annotated as you move along curve
- Pros: shows both gain and phase together; direct for stability analysis

Nichols chart:
- Magnitude in dB (vertical) vs. phase in degrees (horizontal)
- Single Cartesian plot
- Pros: combines best of Bode and Nyquist; easier to read closed-loop response with M/N circles
### Nichols Chart Definition
**Basic layout**
- Vertical axis: magnitude in dB (negative values pointing down)
- Horizontal axis: phase in degrees (negative values to left)
- Frequency marked along curve as parameter
- Low frequencies typically on left/right; high frequencies toward center

**Adding the M and N circles**
- Overlay M circles (magnitude contours) directly on this grid
- Overlay N circles (phase contours) directly on this grid
- Where open-loop curve intersects circle, read off closed-loop magnitude/phase

**Compared to Bode**
- Bode: magnitude and phase on separate plots; easier to follow one at a time
- Nichols: both on one plot; easier to identify resonance and see closed-loop response

**Compared to Nyquist**
- Nyquist: polar form; hard to read actual magnitude/phase values from plot
- Nichols: Cartesian form; much easier to quantify; circles help visualize closed-loop behavior
### Stability Margins on Nichols Chart
**Reading gain and phase margins**
- Gain crossover frequency: where curve passes through 0 dB line
- Phase crossover frequency: where curve passes through -180 degree line
- At these crossovers, read off the other quantity

**Example**
- At gain crossover: magnitude = 0 dB, phase = -200 degrees; phase margin = -200 - (-180) = -20 degrees
- At phase crossover: phase = -180 degrees, magnitude = +50 dB; gain margin = 50 dB

**Distance to instability**
- Shortest distance to (-180 degrees, 0 dB) point gives better picture of robustness
- Accounts for combined gain and phase variation
- Margin alone doesn't capture this; distance does

**Why Nichols is better for margins**
- Bode plot shows gain and phase separately; hard to see combined effect
- Nyquist plot circles the point, but distance not obvious
- Nichols chart: shortest distance to (-180, 0) clearly visible
### Design Specifications
**Typical margin targets**
- Gain margin: 6 to 8 dB
- Phase margin: 45 to 60 degrees
- These balance stability robustness with performance

**Frequency-domain specs**
- Closed-loop gain must stay within boundaries over certain frequency range
- Example: ensure at least -5 dB gain at omega = 1 rad/s
- On Nichols chart: mark the frequency point; ensure it stays above the -5 dB M circle

**High-frequency attenuation**
- Want high frequencies attenuated to prevent noise amplification
- If closed-loop magnitude is high at high frequencies and system passes through resonance circles (M > 1), high-frequency noise gets amplified
- Design goal: keep closed-loop response below certain M circle at high frequencies
### Why Nichols Over Nyquist
**Ease of reading closed-loop response**
- Nichols chart directly shows closed-loop magnitude and phase via M/N circles
- Nyquist requires calculating or estimating closed-loop response separately
- Nichols visual representation makes resonance region obvious

**Handling gain variations**
- On Nichols: multiplying by gain shifts entire curve up (increases magnitude at all frequencies)
- Easier to see effect on closed-loop response and margins
- Low-frequency portion stays visible (doesn't get compressed toward origin)

**Authorship opinion**
- Nichols chart more user-friendly for practical design
- Surprising that textbooks emphasize Nyquist criterion (important mathematically) but give Nichols less time
- Likely due to textbook focus on mathematics rather than practical design workflow
### Robust Design Using Nichols Chart
**Uncertainty representation**
- Real plant may vary from nominal model
- Can represent gain uncertainty as vertical band on Nichols chart
- If nominal gain = 1 and varies by factor 0.5 to 2: draw line from 6 dB above to 6 dB below nominal curve

**Templates for parametric uncertainty**
- System parameters vary (e.g., damping ratio, natural frequency)
- At each frequency: find region (template) containing all possible responses
- Can construct by evaluating system at combinations of min/max parameter values
- Template shape changes with frequency

**Example with multiple uncertainties**
- Pole damping $b$: 7.5 to 12.5
- Static gain: 18 to 30
- Find corners of parameter space
- Template becomes more complex but more accurate

**Design frequencies**
- Don't need to track templates at all frequencies
- Select key design frequencies (e.g., 0.1, 1, 10, 50 rad/s)
- Ensure closed-loop response meets specs at all design frequencies
### Sensitivity Function and Inverse Nichols Chart
**Sensitivity definition**
- Open-loop transfer function: $G(j\omega)$
- Sensitivity function: $S(j\omega) = \frac{1}{1 + G(j\omega)}$
- $|S| > 1$ means changes get amplified; $|S| < 1$ means attenuated

**Plotting inverse for sensitivity specs**
- Instead of $G(j\omega)$, plot $\lambda(j\omega) = \frac{1}{G(j\omega)}$
- Same M and N circles apply
- Where $\lambda$ intersects M circle of value $M$: $|S| = M$

**Flipping the chart**
- Or equivalently: plot $G(j\omega)$ normally but flip the M and N circles upside-down
- This gives inverse Nichols chart
- Read sensitivity directly without computing inverse

**Inverse Nichols layout**
- Phase axis same as Nichols (horizontal, negative left)
- Magnitude axis inverted (high dB toward bottom)
- M circles inverted; N circles inverted

**Sensitivity design constraints**
- Ensure sensitivity below required level over frequency ranges
- Example: sensitivity must stay below -3 dB at omega = 1 rad/s; marker must stay above -3 dB M circle on inverse chart
- General rule: keep response out of 3 dB circle to avoid amplifying disturbances
### The Waterbed Effect
**Fundamental trade-off**
- Can't reduce sensitivity everywhere simultaneously
- Reducing sensitivity in one frequency range causes it to increase elsewhere
- Like squishing waterbed: push down in one place, it rises somewhere else

**Physical constraint**
- If you try to decrease low-frequency sensitivity below -20 dB, high-frequency sensitivity increases
- Conversely, decreasing high-frequency sensitivity increases low-frequency sensitivity
- Mathematical constraint based on system stability and minimum-phase properties

**Impact on design**
- Must balance low-frequency performance (tracking, disturbance rejection) vs. high-frequency robustness (noise immunity)
- High-frequency sensitivity particularly concerning; can't be made arbitrarily low
- Often limits how aggressive low-frequency controller can be

**Uncertainty effects**
- System model uncertainty also affects sensitivity
- Template approach on inverse Nichols chart tracks how uncertainty affects sensitivity across frequency spectrum
- Ensures robust design stays within bounds for all parameter combinations
