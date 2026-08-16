---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
---
## 2.1 Dynamic responses of LTI systems
### Introduction to Dynamic Systems
**Dynamic systems and differential equations**
- Dynamic system: a system that can be modeled using differential equations in time
- Examples: motion (position, velocity, acceleration), RC circuits, spring-mass-damper systems
- LTI dynamic system: linear, constant-coefficient differential equation in time (LCCDE)
- Order of differential equation: the highest derivative present
- Counter-example of LTI: pendulum (coefficients are functions of variables)

**From time domain to s-domain**
- Laplace transform converts differential equations to algebraic equations
- For second-order example: $m\ddot{x}(t) = -b\dot{x}(t) - kx(t) + F(t)$ becomes $ms^2x(s) + bsx(s) + kx(s) = F(s) + \text{initial conditions}$
- Characteristic equation: denominator set equal to zero
- Poles: roots of characteristic equation; number of poles equals system order
### Dynamic Response Decomposition
**Forced and free response**
- Forced response (particular solution): part related to input
- Free response (homogeneous solution): part related to initial conditions
- Complete response: sum of both components

**Modal decomposition and partial fraction expansion**
- Any transfer function can be decomposed into simpler first-order components
- Partial fraction expansion: high-order system represented as sum of elementary modes
- Example: $\frac{1}{(s+1)(s+2)} = \frac{1}{s+1} - \frac{1}{s+2}$
- Working with simple modes is far easier than complex high-order systems

**Block diagram representation of modes**
- Each mode represented as its own subsystem
- Modes connected in parallel
- For step response to impulse response: multiplying by $1/s$ in s-domain equals integration in time domain
- Overall response is sum of individual mode responses

**From s-domain to time domain**
- Example: $x(t) = e^{-t}u(t) - e^{-2t}u(t) + \frac{1}{2}$
- Each mode contributes exponential decay term
- Faster poles contribute higher frequency decay
### Poles and Stability
**Pole location and time-domain response**
- Real pole at $-p$ gives response: $e^{-pt}u(t)$ (decaying if $p > 0$)
- Poles in left-half plane (negative real part): stable, exponential decay
- Poles in right-half plane (positive real part): unstable, exponential growth
- Poles on imaginary axis (real part = 0): marginally stable, bounded sinusoid

**BIBO stability**
- Bounded input, bounded output stability
- System is stable if bounded input produces bounded output
- Requires all poles in left-half plane
### Initial and Final Value Theorems
**Initial value theorem (IVT)**
- $x(0) = \lim_{s \to \infty} sx(s)$
- Finds value at $t = 0$ using only transfer function

**Final value theorem (FVT)**
- $x(\infty) = \lim_{s \to 0} sx(s)$
- Finds steady-state value as $t \to \infty$
- Note: limits in $s$ go opposite direction to desired time value
### Free Response with Initial Conditions
**Free response structure**
- Transfer function with initial conditions: $x(s) = \frac{(b + ms)x(0) + m\dot{x}(0)}{ms^2 + bs + k}$
- Partial fraction expansion still yields constant-denominator terms
- Residuals depend on initial conditions

**Complete response behavior**
- No matter initial conditions, system converges to same steady state (if stable)
- Initial conditions only affect transient response, not steady state
- Free response decays to zero regardless of initial state (for stable systems)
## 2.2 Steady state
### Reference Tracking Fundamentals
**Steady-state definition**
- Part of response that remains as time tends to infinity
- Form depends on the input type (step, ramp, parabola)

**Open-loop limitations**
- Open-loop control cannot track references reliably
- Same input produces different results under varying conditions
- Solution: feedback loop with controller
### Feedback Control Architecture
**Basic feedback loop**
- Setpoint $r(s)$ compared to measured output through sensor
- Error signal: $e(s) = r(s) - Hx(s)$
- Controller outputs force proportional to error
- Closed-loop transfer function: $G_{CL} = \frac{KQ}{1 + KQH}$

**Proportional control**
- Controller scales error by constant: $K$
- Reduces error but cannot eliminate it completely
- Too much gain causes overshoot; too little is slow

**Integral control**
- Controller integrates error: $K_i/s$
- Force increases if error persists
- Achieves zero steady-state error for step inputs
- Can be tuned with scalar to speed up or slow down response
### Error Transfer Function and Type Number
**Setpoint to error transfer function**
- General form: $G_e = \frac{1}{1 + L}$ where $L(s) = K(s)Q(s)H(s)$ is loop transfer function
- For stable system: $e(\infty) = \lim_{s \to 0} s \cdot \frac{1}{1 + L} \cdot r(s)$

**Type number concept**
- Type number: number of integrators in loop path
- System must match input order for zero steady-state error
  - Type 0: can track constants (step bounded error)
  - Type 1: can track steps perfectly, ramps with finite error
  - Type 2: can track ramps perfectly, parabolas with finite error
  - Type 3: can track parabolas perfectly

**Error constants for reference signals**
- For step input ($r(s) = 1/s$): error depends on loop gain at $s = 0$
- For ramp input ($r(s) = 1/s^2$): system needs integrator in loop to achieve zero error
- Increasing loop gain reduces error for fixed type number

**Residual numerator and denominator analysis**
- Transfer function in terms of components: $G_e = \frac{D_K D_Q D_H}{N_K N_Q N_H + D_K D_Q D_H}$
- Integrators contribute $s$ terms to numerator
- Matches input order to the $s$ in denominator

**Internal model principle**
- System must include model of reference to track it without error
- Adding integrator is equivalent to adding pole at origin
- Applies to step, ramp, and other periodic signals (e.g., sinusoid requires $\frac{b}{s^2 + b^2}$)
- Can add desired reference model into loop path
### Disturbance Rejection
**Multiple inputs (MISO systems)**
- Reference input $r(s)$
- Input disturbance $v(s)$ (affects plant input)
- Output disturbance $d(s)$ (affects plant output)
- Measurement noise $n(s)$ (corrupts sensor)

**Transfer functions for disturbances**
- Input disturbance: $G_v = \frac{Q}{1+L}$ (reduced by increasing loop gain)
- Output disturbance: $G_d = \frac{1}{1+L}$ (reduced by increasing loop gain)
- Measurement noise: $G_n = \frac{L}{1+L} \approx 1$ for high loop gain (not attenuated)

**Trade-off at high frequencies**
- Increasing loop gain helps with input/output disturbances
- High loop gain amplifies high-frequency noise
- Must balance disturbance rejection with noise robustness
