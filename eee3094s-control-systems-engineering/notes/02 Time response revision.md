---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, course]
aliases: [time response, step response, second order response, damping ratio, pole locations]
summary: Time-domain response of LTI systems, first and second order step responses, damping and pole locations.
---
Skeleton mirroring deck sections. Decks live in [[decks/2.1 Dynamic responses of LTI systems|decks/]]. Fill bullets while watching.
## System identification from a step response
Written up for tut test 1 on 19 Aug 2026, which covers tutorial 2. The whole task is: read a step response plot, produce a transfer function.

The formulas below are on the course formula sheet and are printed on the question paper. They appear on no lecture deck, so this section is the only place in these notes that carries them.
### The model
Everything reduces to one equation with three unknowns:
$$G(s) = \frac{A\,\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$$

| Symbol | Name | What it controls |
|---|---|---|
| $A$ | DC gain | Where the response settles |
| $\zeta$ | Damping ratio | The **shape**: how much it overshoots and rings |
| $\omega_n$ | Natural frequency | The **speed**: same shape, squeezed in time |

$\zeta$ sets shape, $\omega_n$ sets speed, and they do not interfere. Hold on to that.

The oscillation you actually see on the plot is not $\omega_n$ but the damped frequency
$$\omega_d = \omega_n\sqrt{1-\zeta^2}$$
$\omega_d$ is always the smaller of the two. The plot only ever shows $\omega_d$; $\omega_n$ comes out by arithmetic afterwards. Confusing the two is the standard way to lose the marks.
### Formula sheet, in full
$$t_p = \frac{\pi}{\omega_d} \qquad y_p = A\left(1 + e^{-\zeta\pi/\sqrt{1-\zeta^2}}\right) \qquad \%OS = 100\,e^{-\zeta\pi/\sqrt{1-\zeta^2}}$$
$$t_r = \frac{\pi - \theta}{\omega_d},\quad \cos\theta = \zeta \qquad\qquad t_{k\%} = \frac{\ln\left(\frac{k}{100}\sqrt{1-\zeta^2}\right)}{-\zeta\omega_n}$$

Two of these differ from the versions in most textbooks, so use these:
- $t_r$ here is the exact 0 to 100% rise time for an underdamped second-order system, not the 10 to 90% approximation $t_r \approx 1.8/\omega_n$ that Nise uses.
- $t_{k\%}$ is the general settling time to any band $k$, not the 2% rule of thumb $t_s \approx 4/(\zeta\omega_n)$.
### Part (a): deciding the order
- Rises smoothly, flattens, **never exceeds its final value** $\Rightarrow$ first order.
- **Overshoots** the final value, or oscillates $\Rightarrow$ second order or higher.

The reason, which is what the two marks are for: a first-order system $K/(\tau s + 1)$ has one energy store, so it can only crawl exponentially toward its target. Overshoot needs two energy stores trading energy back and forth, like a spring and a mass, and two stores means second order.
### Part (b): the five readings
1. **$A$** is the settled value at the right-hand end of the plot.
2. **$t_p$** is the time of the first peak. Then $\omega_d = \pi/t_p$.
3. **$y_p$** is the height of that peak. Substitute into $y_p = A(1+E)$ where $E = e^{-\zeta\pi/\sqrt{1-\zeta^2}}$, and solve for $E$. Note $E$ is just the overshoot as a fraction, so $\%OS = 100E$.
4. Take logs to get $\zeta$ out of $E$.
5. $\omega_n = \omega_d/\sqrt{1-\zeta^2}$.
### Worked example: tut test 2, 2025
The plot settles at 5, peaks at about 5.5, and the peak falls at about $t = 2$ s.

**Step 1.** $A = 5$.

**Step 2.** $t_p = 2$ s, so
$$\omega_d = \frac{\pi}{t_p} = \frac{\pi}{2} = 1.571\ \text{rad/s}$$

**Step 3.** $y_p = 5.5$, so
$$5.5 = 5(1 + E) \;\Rightarrow\; 1.1 = 1 + E \;\Rightarrow\; E = 0.1$$
It overshot by 10%.

**Step 4.** Take natural logs of $E = e^{-\zeta\pi/\sqrt{1-\zeta^2}}$:
$$\frac{-\zeta\pi}{\sqrt{1-\zeta^2}} = \ln(0.1) = -2.3026$$
$$\zeta\pi = 2.3026\sqrt{1-\zeta^2}$$
Square both sides:
$$9.870\,\zeta^2 = 5.302(1-\zeta^2) \;\Rightarrow\; \zeta^2(9.870+5.302) = 5.302$$
$$\zeta^2 = \frac{5.302}{15.172} = 0.3495 \;\Rightarrow\; \zeta = 0.591$$

**Step 5.**
$$\omega_n = \frac{\omega_d}{\sqrt{1-\zeta^2}} = \frac{1.571}{\sqrt{0.6505}} = \frac{1.571}{0.8065} = 1.95\ \text{rad/s}$$

**Answer.**
$$G(s) = \frac{5(1.95)^2}{s^2 + 2(0.591)(1.95)s + (1.95)^2} = \frac{19.0}{s^2 + 2.31s + 3.80}$$

The values actually used to generate the plot were $\zeta = 0.6$ and $\omega_n = 2$. The memo states outright that any good approximation supported by readings off the plot earns full marks. Exact numbers are not expected. Showing which points you read off the plot is.
### If it is first order instead
$$G(s) = \frac{K}{\tau s + 1}$$
Two numbers. $K$ is the settled final value. $\tau$ is the time taken to reach **63.2%** of that final value, read straight off the plot.
### Matching poles to responses
Tutorial 2 Q1 gives six impulse responses and six pole plots to pair up. Two rules cover it:
- Further **left** means it decays faster.
- Further from the real axis means it oscillates faster.

And $\cos\theta = \zeta$, where $\theta$ is the angle from the negative real axis. So a pole close to the real axis is well damped and barely overshoots, a pole close to the imaginary axis rings badly, and a pole sitting on the real axis does not oscillate at all.
### Pulling out physical parameters
Tutorial 2 Q3b gives a spring-mass-damper with unit mass:
$$\ddot{x} = -b\dot{x} - kx + F \;\Longrightarrow\; \frac{X(s)}{F(s)} = \frac{1}{s^2 + bs + k}$$
Compare against the standard form term by term:
$$k = \omega_n^2 \qquad b = 2\zeta\omega_n$$
So once the plot has given you $\zeta$ and $\omega_n$, the spring and damping coefficients drop straight out. Note the DC gain here is $1/k$, not 1.
## 2.1 Dynamic responses of LTI systems
![[2.1 Dynamic responses of LTI systems]]
## 2.2 Steady state
![[2.2 Steady state]]
## 2.3 Transient response
![[2.3 Transient response]]
## 2.4 Pole dominance
![[2.4 Pole dominance]]
