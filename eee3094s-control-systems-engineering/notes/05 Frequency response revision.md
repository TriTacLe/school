---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
aliases: [frequency response, Bode plot, gain margin, phase margin, sinusoidal steady state]
summary: Frequency response of LTI systems, Bode plots, gain and phase margins.
---
Skeleton mirroring deck sections, page numbers = PDF pages in [[../lecture-notes/05 frequency response|05 frequency response]] decks. Fill bullets while watching.
## 5.1 Frequency response introduction
### Recap: time domain modelling (p2-26)
Goal of the course: understand and manipulate how systems respond to inputs
So far, time domain view of LTI systems:
- Signals = weighted sums of scaled, shifted impulses, so the response = weighted sum of impulse responses (convolution)
- Analysis focused on poles (roots of denominator) and zeros (roots of numerator)
- Modal decomposition: break the response into per-pole modes. Pole location in the s plane sets each mode's character: left-half stable, right-half unstable, distance from origin sets the time constant, complex pairs oscillate
- Zeros reshape residuals. Time constant and residuals together pick the dominant mode, and order reduction removes non-dominant poles (replace with their gains)
- Root locus (coming later) tells how the closed loop behaves for any gain
TLDR (p26): pole-zero methods are time-domain techniques, they focus on the impulse response
### Sinusoids as eigenfunctions of LTI systems (p27-35)
Signals can also be modelled as weighted sums of frequency components, complex exponentials, sinusoids for real signals
**Sinusoids are eigenfunctions of LTI systems:** they pass through without changing shape or frequency, only multiplied by a scalar (the eigenvalue)
The eigenvalue is complex, $Ae^{j\theta}$, so the system can change the sinusoid's magnitude and phase:
$$\cos(\omega t) \to A\cos(\omega t + \theta)$$
Since any signal is built from these components (Fourier), knowing how the system scales and shifts a sinusoid at every frequency completely defines the response
### Frequency response definition (p36-63)
**Frequency response:** substitute $s = j\omega$ into the transfer function, giving $H(j\omega)$
Where it comes from (p43-55). Inverse Laplace (synthesis equation):
$$h(t) = \frac{1}{2\pi j}\int_{c-j\infty}^{c+j\infty} H(s)e^{st}\,ds$$
- $H(s)$ at each $s$ is the coefficient of $e^{st}$ in the weighted sum that builds $h(t)$
- With $s = \sigma + j\omega$ and conjugate pairs combined, each term looks like $|H(\sigma+j\omega)|\,e^{\sigma t}\cos(\omega t + \angle H(\sigma+j\omega))$
- Stable system: the $e^{\sigma t}$ parts die away, only $\sigma = 0$ terms survive
- So s values off the imaginary axis make the transient, s values on the imaginary axis make the steady state. Frequency response = transfer function evaluated on the $j\omega$ axis
The frequency response is only a function of the input and concerns the **steady state**
At a given frequency, $H(j\omega) = Ae^{j\theta}$: magnitude $A$ = gain at that frequency, angle $\theta$ = phase shift (deck p57-58 labels these "real part" and "imaginary part", it means magnitude and angle)
Two graphical representations (p59-63):
- **Bode plot:** separate magnitude and phase plots against frequency
- **Nyquist plot:** magnitude and phase on one set of axes, trace the locus of $H(j\omega)$ as $\omega$ runs from $-\infty$ to $\infty$. Harder to read (frequency not visible without annotation) but has its own advantages, later
## 5.2 Bode plots
### Last time (p2-5)
Frequency response = how the system affects the magnitude and phase of sinusoids at different frequencies, $H(j\omega)$
Two graphical forms: Bode (separate magnitude and phase plots) and Nyquist (both on one set of axes). This deck: how to draw the Bode plot of any system. Framing question (p5): which features make a Bode plot different from any nonspecific magnitude and phase plot?
### Bode plot definition (p6-9, p15)
Three features:
- **Frequency on a log scale** (p6): only shows positive frequencies, but that is fine, for real signals the magnitude has even symmetry and the phase odd symmetry, so the negative half adds nothing (p7). Log scale displays a wide spectrum of frequencies efficiently (p8)
- **Magnitude in decibels** (p9)
- **Phase in degrees** (p15)
### Decibel (p10-14)
Decibels are a unit of power gain: $K\,[\text{dB}] = 10\log_{10}(K)$ (p10). The power of a sinusoid is proportional to its amplitude squared, so for amplitude gain we use (p11-12):
$$K\,[\text{dB}] = 20\log_{10}(K)$$
Quick conversion trick (p13): divide the dB value by 20 and raise 10 to that power, $K = 10^{K[\text{dB}]/20}$

| dB | gain |
|----|------|
| -20 | 0.1 |
| 0 | 1 |
| 6 | 2 |
| 20 | 10 |
| 40 | 100 |
| 60 | 1000 |

### First-order system (p16-70)
Start with $\frac{A}{\tau j\omega + 1}$, handle the gain $A$ separately later (p16-18)
Given $\frac{1}{j\omega + p}$ instead, scale the denominator: $\frac{1}{p}\cdot\frac{1}{\frac{1}{p}j\omega + 1}$, the $\frac{1}{p}$ factor joins the gain (p19-20)
**Break (or corner) frequency:** $\omega_0 = \frac{1}{\tau}$, equal to the pole's distance from the origin (p21, p52)
Find the shape by considering three frequency ranges (p22-24):
- **Low frequencies** $\omega \to 0$: term goes to 1 = 0 dB, phase 0 (p25)
- **High frequencies** $\omega \to \infty$: the $\frac{1}{\omega_0}j\omega$ part dominates the denominator, magnitude is $\frac{\omega_0}{\omega} = 20\log_{10}\omega_0 - 20\log_{10}\omega$ dB, so the magnitude drops 20 dB every time frequency increases by a factor of 10 (**roll-off = 20 dB/decade**, decade = x10 in frequency) and the line crosses 0 dB at $\omega = \omega_0$ (p26-30). Phase: the leftover $\frac{1}{j} = e^{-j\pi/2}$, so $-90°$ (p31-32)
- **Break frequency** $\omega = \omega_0$: term is $\frac{1}{j+1}$, magnitude $\frac{1}{\sqrt{2}} = -3$ dB, phase $-45°$ (p34-38)
**Asymptotic (straight-line) approximation** (p39-41): magnitude flat at 0 dB up to $\omega_0$, then -20 dB/decade. Phase flat at 0 up to $0.1\omega_0$, straight line down to $-90°$ at $10\omega_0$. Fine for quick calculations. The true Bode plot is smooth and passes through -3 dB and $-45°$ at $\omega_0$ (p42-43):
```functionplot
---
title: First-order magnitude, true Bode plot (p42)
xLabel: log10(w/w0)
yLabel: dB
bounds: [-2, 2, -45, 5]
grid: true
---
f(x) = -10 * log(1 + 10^(2*x)) / log(10)
```
```functionplot
---
title: First-order phase (p42)
xLabel: log10(w/w0)
yLabel: degrees
bounds: [-2, 2, -95, 5]
grid: true
---
f(x) = -57.2958 * atan(10^x)
```
**Gain** (p44-49): logs turn multiplication into addition, $20\log_{10}|H| = 20\log_{10}(A) + 20\log_{10}\left|\frac{1}{\frac{1}{\omega_0}j\omega+1}\right|$, so work out the gain's response alone and add it. A real constant has flat magnitude $20\log_{10}(A)$ and phase 0 (or $180°$ if negative). So the gain shifts the magnitude plot up or down without changing its shape and does not affect the phase
The system behaves like a **low-pass filter** (p50-51): low frequencies amplified (depending on gain), high frequencies attenuated
Faster poles have higher break frequencies, so they amplify higher frequencies: **noise warning** (p53-55)
**What if the system has a zero?** (p56-66): treat it independently, add its magnitude (in dB) and phase to the rest. Written as $\frac{1}{\omega_z}j\omega + 1$ with $\omega_z = z$ it is the inverse of the pole term, so its magnitude response is the negative of the equivalent pole's response, and so is the phase (inverting a complex number negates its angle): +20 dB/decade upward after $\omega_z$, phase $0 \to +90°$
- Pole and zero in the same place: responses cancel when combined (p67)
- Even if not in the same place, the zero's upward slope eventually cancels the pole's roll-off, so the high-frequency gain tends to a constant (p68)
- Zero left of the pole (higher break frequency): gain decreases at high frequencies. Zero right of the pole (lower break frequency): gain increases at high frequencies (p69-70)
### Second-order system (p71-121)
Two real poles: add the responses the same way (works for any higher-order system). The roll-off gets steeper by -20 dB/decade for every pole added (p71-73)
**Complex pole pair** at $-\sigma \pm j\omega_p$ (p74-95), factors $\frac{1}{\sigma + j(\omega - \omega_p)}$ and $\frac{1}{\sigma + j(\omega + \omega_p)}$:
- Low frequencies: each pole's phase tends to the angle of that pole, the two angles are opposite, so combined phase is 0. Each magnitude tends to $\frac{1}{\sqrt{\sigma^2 + \omega_p^2}}$, a constant $2 \times 20\log_{10}\frac{1}{\sqrt{\sigma^2+\omega_p^2}}$ dB, and for convenience pick gain $\sigma^2 + \omega_p^2$ to cancel it to 0 dB (p85-90)
- High frequencies: the frequency dominates each denominator, each pole adds a -20 dB/decade roll-off for a combined **-40 dB/decade**, and each phase tends to $-90°$ for a combined $-180°$ (p91-95)
So far it looks like a real pole's response, but what happens in between? (p96-97) Use the general model with gain set to 1 (p98-100):
$$\frac{\omega_n^2}{(j\omega)^2 + 2\zeta\omega_n(j\omega) + \omega_n^2} = \frac{\omega_n^2}{(\omega_n^2 - \omega^2) + j2\zeta\omega_n\omega}$$
- $\omega \to 0$: goes to 1 = 0 dB (p101-103)
- $\omega \to \infty$: goes to $-\frac{\omega_n^2}{\omega^2}$, a negative real number so phase $-180°$, magnitude $-40\log_{10}\frac{\omega}{\omega_n}$ confirming the -40 dB/decade roll-off, crossing 0 dB at $\omega = \omega_n$. So the **natural frequency is the break frequency** of a second-order system (p104-111)
- $\omega = \omega_n$: response is $\frac{1}{j2\zeta}$, phase $-90°$, magnitude $-20\log_{10}(2\zeta)$ (p112-116)
At the break frequency: $\zeta > 0.5$ gives negative dB, $\zeta < 0.5$ gives positive dB, a peak that gets larger as the damping ratio decreases (p117-119)
**Resonance:** the tendency for an oscillatory system to amplify signals at or near its natural (or resonant) frequency (p120)
```functionplot
---
title: Second-order magnitude for zeta = 0.1, 0.5, 1 (p117-119)
xLabel: log10(w/wn)
yLabel: dB
bounds: [-1.5, 1.5, -65, 20]
grid: true
---
f(x) = -10 * log((1 - 10^(2*x))^2 + (0.2 * 10^x)^2) / log(10)
g(x) = -10 * log((1 - 10^(2*x))^2 + (1 * 10^x)^2) / log(10)
h(x) = -10 * log((1 - 10^(2*x))^2 + (2 * 10^x)^2) / log(10)
```
A complex zero pair: invert the response of the equivalent complex poles (p121)
### Summary (p122-123)
- Family of real poles (p122): slower pole (closer to the origin) = lower break frequency, so its magnitude starts dropping earlier. All roll off at -20 dB/decade and phase runs 0 to $-90°$
- Family of complex pole pairs sharing $\omega_n$ (p123): magnitude peaks at $\omega_n$ and the peak grows as damping falls, matching more ringing in the step response. Phase runs 0 to $-180°$ with a sharper transition for low $\zeta$
