---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 2.3 Transient response
### Modal Decomposition Review
**Understanding system behavior through modes**
- High-order systems decomposed into elementary modes
- Mode: first-order system $\frac{r}{s - p}$, repeated pole $\frac{r}{(s - p)^m}$, or complex pair $\frac{r}{(s - \sigma + j\omega)(s - \sigma - j\omega)}$
- Dominant mode: mode with most influence on overall response
- Modal decomposition represents complex system as combination of simple subsystems

**Determining dominance**
- NOT simply the smallest time constant
- NOT simply the largest gain
- Dominant mode: largest time constant (contributes longest before decay)
- Reasoning: modes with longer time constants remain significant in response longer before decaying to insignificance
### First-Order Systems
**First-order transfer function**
- Standard form: $\frac{A}{\tau s + 1}$
- Gain $A$: found by setting $s = 0$, $\lim_{s \to 0} = A$
- Time constant $\tau$: determines rate of decay

**First-order impulse response**
- Residual: $r = A/\tau$, pole: $-1/\tau$
- Laplace: $\frac{r}{s - (-1/\tau)}$
- Time domain: $re^{-t/\tau}u(t) = \frac{A}{\tau}e^{-t/\tau}u(t)$
- At $t = \tau$: response reaches approximately 63% of final value

**First-order step response**
- $A(1 - e^{-t/\tau})u(t)$
- Settling time (to within 5% of final value): $t_{5\%} \approx 3\tau$
- Settling time (to within 2% of final value): $t_{2\%} \approx 4\tau$

**Pole location determines speed**
- Distance from pole to origin determines time constant
- Poles far left (more negative): faster decay
- Poles near origin: slower response
### Second-Order Systems
**Standard form and parameters**
- General form: $\frac{A\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$
- Natural frequency $\omega_n = \sqrt{k/m}$: frequency system would oscillate without damping
- Damping ratio $\zeta = \frac{b}{2m\omega_n}$: ratio of actual to critical damping
- Critical damping: $b = 2\sqrt{mk}$, equivalently $b = 2m\omega_n$

**Poles of second-order system**
- Quadratic formula: $s = \frac{-b \pm \sqrt{b^2 - 4mk}}{2m}$
- Discriminant ($b^2 - 4mk$) determines pole type and response form
- Stability requires $m, k, b > 0$ (energy dissipation)
### Response Modes: Overdamped, Critically Damped, Underdamped
**Overdamped response ($\zeta > 1$, $b^2 - 4mk > 0$)**
- Two distinct real poles: $p_1 = -b/(2m) + \sqrt{b^2 - 4mk}/(2m)$, $p_2 = -b/(2m) - \sqrt{b^2 - 4mk}/(2m)$
- Response: sum of two first-order exponential modes
- Slower pole dominates settling time
- Increasing damping: one pole approaches origin (slower), other approaches negative infinity
- No overshoot; slow response

**Critically damped response ($\zeta = 1$, $b^2 - 4mk = 0$)**
- Repeated real pole: $p_1 = p_2 = -\omega_n = -b/(2m)$
- Response: $-te^{-\omega_n t}u(t)$ (exponential times $t$)
- Fastest response with no overshoot
- Optimal balance between speed and stability
- Time constant: $\tau = 1/\omega_n$

**Underdamped response ($\zeta < 1$, $b^2 - 4mk < 0$)**
- Complex conjugate poles: $p_{1,2} = -\zeta\omega_n \pm j\omega_n\sqrt{1 - \zeta^2}$
- Response: $e^{-\zeta\omega_n t}\cos(\omega_n\sqrt{1 - \zeta^2} \cdot t)u(t)$
- Oscillatory with exponential decay envelope
- Damped frequency: $\omega_d = \omega_n\sqrt{1 - \zeta^2}$
- Real part gives time constant: $\tau = 1/(\zeta\omega_n)$
- Frequency of oscillation given by imaginary part

**Summary of damping effects**
- $\zeta > 1$: overdamped (slow, no overshoot)
- $\zeta = 1$: critically damped (fastest without overshoot)
- $\zeta < 1$: underdamped (fast but oscillatory overshoot)
- Damping ratio indicates distance from critical damping condition
## 2.4 Pole dominance
### Dominant Modes and System Approximation
**Identifying the dominant mode**
- Dominant mode has most influence on overall response
- NOT the mode with smallest time constant
- NOT the mode with largest individual gain
- IS the mode with longest time constant (persists longest in response)

**Modal residuals**
- Residual: the coefficient of each mode in partial fraction expansion
- Combines both pole gain and time constant effects
- Larger residual means that mode contributes more to overall response
### Residual Calculation
**Two-pole system example**
- System: $\frac{1}{(s+4)(s+6)}$
- Partial fraction: $\frac{r_1}{s+4} + \frac{r_2}{s+6} = \frac{1}{(s+4)(s+6)}$
- Residue at $-4$: $r_1 = \lim_{s \to -4} (s+4)\frac{1}{(s+4)(s+6)} = \frac{1}{2}$
- Residue at $-6$: $r_2 = \lim_{s \to -6} (s+6)\frac{1}{(s+4)(s+6)} = -\frac{1}{2}$
- Residuals have same magnitude, opposite signs

**General residual formula**
- For simple pole: $r_i = \lim_{s \to p_i} (s - p_i)H(s)$
- For repeated pole $m$ times: $r_{i,k} = \frac{1}{(m-k)!} \lim_{s \to p_i} \frac{d^{m-k}}{ds^{m-k}}[(s - p_i)^m H(s)]$

**Residual as function of pole proximity**
- Residual is inversely proportional to product of distances from all other poles
- $r = \frac{1}{\text{[product of distance from every other pole]}}$
- Poles close to each other have larger residuals
- Close to origin means large influence on response

**Complex poles and residuals**
- Complex poles come in conjugate pairs: residuals also conjugate
- Distance calculation uses magnitude: $|(p - \sigma) \pm j\omega|$
- Combined residuals produce real-valued sinusoid in time domain
- Residual: $r = re^{j\phi}$, $r^* = re^{-j\phi}$ produces $2r\cos(\omega t + \phi)$

**Repeating poles**
- Repeating pole at same location: closer together than distinct poles
- Residuals become more complex (involve higher powers of pole locations)
- For triple pole and other simple poles: residuals still depend on distances
- Each mode of repetition has its own residual
### Zeros in Transfer Functions
**Zeros and their effect**
- Zero: root of numerator of transfer function
- Do not change basic form or duration of transient response
- Do affect initial value of response

**Transfer function classifications**
- Proper (biproper): same number of poles and zeros ($m = n$)
- Strictly proper: more poles than zeros ($m < n$) - typical for real systems
- Improper: more zeros than poles ($m > n$) - not physically realizable

**Why improper systems cannot occur**
- Improper system would require differentiator (zero at origin)
- Derivative requires future values of input for causality
- Physical systems cannot look into future
- Energy requirements would be infinite for step inputs

**Zero effect on residuals**
- Zero in numerator changes how residuals are calculated
- Example: $\frac{s+5}{(s+4)(s+6)}$ vs $\frac{1}{(s+4)(s+6)}$
- Residual at pole $-4$: $r_1 = \lim_{s \to -4} (s+5)/(s+6) = 1/2$
- Residual at pole $-6$: $r_2 = \lim_{s \to -6} (s+5)/(s+4) = 1/2$ (same sign now)
- Zero near pole reduces that pole's residual; zero at infinity reduces influence uniformly

**Zero at origin effect**
- As zero approaches origin, residuals become dominant at $t = 0$
- Response suddenly becomes very large near $t = 0$
- Zero-pole cancellation: if zero location matches pole, that mode disappears

**First-order system with zero**
- Form: $\frac{A(s - z)}{\tau s + 1} = \frac{A}{\tau s + 1} - \frac{As}{z(\tau s + 1)}$
- First term: standard first-order response
- Second term: derivative of first term scaled by $-A/(z\tau^2)$
- Derivative produces delta function at $t = 0$: $-\delta(t) \cdot \frac{A}{z\tau}$
- Initial value theorem: $x(0) = -A/(z\tau)$
### Free Response Structure
**Free response with initial conditions**
- Contains zeros from initial condition terms
- Example: $sx(0) + (3x(0) + \dot{x}(0))$ in numerator
- Behaves like system with zero at pole location
- Zeros represent initial condition effects
### Practical Residual Analysis Example
**System: $\frac{1}{(s+1)^3(s+5)(s+7)}$**
- Poles: triple pole at $-1$, simple poles at $-5$, $-7$
- For simple poles: standard residual formula gives distances
- Residual at $-5$: $r_2 = \frac{1}{(-5+1)^3(-5+7)} = \frac{1}{-64 \cdot 2} = -1/128$
- Residual at $-7$: $r_3 = \frac{1}{(-7+1)^3(-7+5)} = \frac{1}{-216 \cdot (-2)} = 1/432$
- For repeated poles: derivative method needed
- Residual at triple pole: $r_{1,3} = \frac{1}{(-1+5)(-1+7)} = 1/24$
- Higher powers of repetition: smaller magnitude, greater complexity
- All residuals ultimately functions of pole separations
