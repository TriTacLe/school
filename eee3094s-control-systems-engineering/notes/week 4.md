---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 5.1 Frequency response introduction
### Recap: LTI Systems and Time Domain Analysis
**Understanding LTI systems**
- Goal: understand and manipulate how systems respond to inputs
- Linear time-invariant systems can be modeled two ways: time-domain response or frequency response

**Time-domain modeling via impulse response**
- Signals decompose as weighted sums of scaled, shifted impulses
- Response is a weighted sum of scaled, shifted impulse responses
- This leads to convolution: $y(t) = \int_{-\infty}^{\infty} x(\lambda)h(t-\lambda)d\lambda$

**Pole-zero analysis**
- System transfer function: $H(s) = \frac{(s-z_1)(s-z_2)...(s-z_m)}{(s-p_1)(s-p_2)...(s-p_n)}$
- Poles are roots of the denominator; zeros are roots of the numerator
- Modal decomposition: response breaks into individual responses to each pole/pole-pair

**Transient response characteristics**
- Poles in left-half plane (negative real part): stable; decay over time
- Poles in right-half plane (positive real part): unstable; grow over time
- Distance from pole to origin determines time constant; closer pole = faster response
- Complex conjugate pairs create oscillatory components

**Dominant mode and order reduction**
- Dominant mode: pole with most influence on overall response (usually closest to imaginary axis)
- Non-dominant poles decay quickly and can be removed to simplify model
- Replace non-dominant poles with constant gain terms

**Root locus recap**
- Shows where closed-loop poles move as gain varies
- Tells us what specs the system can satisfy at different gains
### Signals as Frequency Components
**Alternative representation: Fourier series**
- Any signal can be written as weighted sum of frequency components (sinusoids or complex exponentials)
- Each frequency component oscillates at different rate

**Sinusoids as eigenfunctions of LTI systems**
- LTI systems have special property: sinusoidal inputs produce sinusoidal outputs
- Input sine passes through without changing shape or frequency
- Output amplitude and phase may change

**Frequency response concept**
- For sinusoid input $\cos(\omega t)$, output is $A\cos(\omega t + \theta)$
- $A$ (amplitude scaling) and $\theta$ (phase shift) depend on frequency $\omega$
- If we know how system affects magnitude and phase at all frequencies, we completely define its response
- This is the frequency response
### Finding Frequency Response
**Frequency response from transfer function**
- Substitute $s = j\omega$ into transfer function
- $H(j\omega)$ is complex number: $H(j\omega) = Ae^{j\theta}$ where $A$ is magnitude and $\theta$ is phase

**Laplace synthesis equation**
- Impulse response built from weighted sum of exponential components: $h(t) = \frac{1}{2\pi j}\int_{c-j\infty}^{c+j\infty} H(s)e^{st}ds$
- Each point on complex s-plane contributes: $H(s) = \sigma + j\omega$, giving term $|H(\sigma + j\omega)|e^{\sigma t}\cos(\omega t + \angle H(\sigma+j\omega))$
- Exponential part from real component $\sigma$; sinusoidal part from imaginary component $\omega$

**Why frequency response uses imaginary axis**
- For stable system, $e^{\sigma t}$ decays to zero, leaving only $\sigma = 0$ terms
- Only s-values along imaginary axis ($j\omega$) contribute to steady-state response
- Transient response from other s-values with nonzero real parts

**Frequency response = steady-state response to sinusoid**
- Not dependent on initial conditions
- Only function of input and its frequency
### Graphical Representation of Frequency Response
**Two visualization approaches**
1. Separate magnitude and phase plots vs. frequency (Bode plot)
2. Single plot with magnitude and phase on same axes, tracing locus as frequency varies (Nyquist plot)

**Bode plot advantages**
- Separate plots easier to interpret
- Magnitude in decibels; frequency on logarithmic scale

**Nyquist plot advantages**
- Shows relationship between magnitude and phase directly
- Useful for stability analysis when evaluated along imaginary axis for all frequencies
## 5.2 Bode plots
### Introduction and Definition
**What is a Bode plot**
- Separate magnitude and phase plots of frequency response vs. frequency
- Magnitude plotted in decibels; phase in degrees
- Frequency axis logarithmic; allows view across wide spectrum

**Why logarithmic frequency scale**
- Efficient for displaying large range of frequencies
- Single decade (factor of 10) spacing used throughout

**Positive frequencies only**
- For real signals, plots symmetric about zero frequency
- Magnitude has even symmetry; phase has odd symmetry
- Log scale can only display positive frequencies, so we only plot those
### Decibel Conversion
**Decibel formula for power**
- Power gain in dB: $K[dB] = 10\log_{10}(K)$
- Decibel is logarithmic unit of power gain

**For amplitude (voltage/current)**
- Power of sinusoid proportional to amplitude squared
- Amplitude gain in dB: $K[dB] = 20\log_{10}(K)$

**Useful reference values**
- 40 dB = 100; 20 dB = 10; 60 dB = 1000
- 6 dB = 2; 0 dB = 1; -20 dB = 0.1

**Conversion shortcut**
- Divide dB by 20, raise 10 to that power: $K = 10^{K[dB]/20}$
### First-Order System Analysis
**First-order system form**
- Standard form: $G(s) = \frac{A}{\tau s + 1}$ where $\tau$ is time constant
- Frequency response: $G(j\omega) = \frac{A}{1 + j\omega/\omega_0}$
- Break (corner) frequency: $\omega_0 = 1/\tau$

**Finding frequency response shape via three regions**

Low frequencies ($\omega \to 0$):
- $G(j0) = A$, so magnitude = $20\log_{10}(A)$ dB, phase = 0 degrees

High frequencies ($\omega \to \infty$):
- Frequency dominates denominator: $G(j\omega) \approx \frac{A}{j\omega/\omega_0} = \frac{A\omega_0}{j\omega}$
- Magnitude: $20\log_{10}(A\omega_0/\omega)$ dB
- Line through this expression: $20\log_{10}(A\omega_0) - 20\log_{10}(\omega)$
- Slope = -20 dB/decade; line crosses 0 dB at $\omega = \omega_0$
- Phase tends to -90 degrees as $\omega \to \infty$

At break frequency ($\omega = \omega_0$):
- Magnitude: $|1/(1+j)| = 1/\sqrt{2} \approx -3$ dB
- Phase: $\angle(1/(1+j)) = -45$ degrees

**Asymptotic (straight-line) approximation**
- Low frequency: flat line at $20\log_{10}(A)$ dB
- High frequency: line with -20 dB/decade slope
- Connect via transition from 0.1$\omega_0$ to 10$\omega_0$
- Good for quick calculations; actual plot smoothly rounded through -3 dB point

**Gain effect**
- Constant gain $A$ shifts magnitude plot up/down by $20\log_{10}(A)$ dB
- Does not affect phase (phase of real constant is 0 degrees)

**With a zero**
- Zero at frequency $\omega_z$: inverse of pole response
- Magnitude response inverted (negative in dB)
- Phase response inverted
- If zero left of pole (higher break frequency): gain decreases at high frequencies
- If zero right of pole (lower break frequency): gain increases at high frequencies
- If zero and pole at same location: cancel out

**Filter interpretation**
- Low-pass filter: low frequencies amplified, high frequencies attenuated
- Faster poles (higher $\omega_0$) amplify higher frequencies; can amplify noise
### Second-Order Systems with Real Poles
**Cascaded first-order poles**
- Each additional pole adds -20 dB/decade roll-off at high frequencies
- Two poles cascade: -40 dB/decade roll-off
### Second-Order Systems with Complex Poles
**Complex conjugate pole pair analysis**
- General form: $G(s) = \frac{A\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$
- $\omega_n$ = natural frequency
- $\zeta$ = damping ratio

**Low frequency behavior**
- Magnitude = constant (flat)
- Phase = 0 degrees (both poles' phases cancel due to symmetry)

**High frequency behavior**
- Magnitude: $20\log_{10}(\omega_n^2/\omega^2)$ dB
- Roll-off: -40 dB/decade (two poles)
- Phase: -180 degrees (each pole contributes -90 degrees)

**At natural frequency ($\omega = \omega_n$)**
- Magnitude: $-20\log_{10}(2\zeta)$ dB
- Phase: -90 degrees
- Key insight: damping ratio determines resonance peak

**Resonance and damping**
- If $\zeta > 0.5$: magnitude negative at $\omega_n$ (attenuated)
- If $\zeta < 0.5$: magnitude positive at $\omega_n$ (resonance peak)
- Resonance = tendency of oscillatory system to amplify signals near its natural frequency
- Smaller damping = sharper, taller resonance peak

**Complex zero pair**
- Invert response of equivalent pole pair (negate magnitude and phase)
