---
type: note
status: active
project: uct
course: EEE3094S
tags: [uct, control-systems, root-locus, frequency-response, solutions]
---

# Solutions, class test 1 2020 and problem sets 6.1 and 7.1

Worked answers for the practice material in the course folder that ships without a memo:

- `07 Past Papers/Past Papers 2020/Class test 1 2020.pdf`, the only 2020 test with no solutions attached
- `06 Practice Problems/Not listed on Amathuba 2026/Problem set 6.1.pdf`, questions 4, 5 and 6 (questions 1 to 3 already carry full solutions in the file)
- `06 Practice Problems/Not listed on Amathuba 2026/Problem set 7.1 - Design specifications.pdf`, all three questions

`Sandbox practice question.pdf` needs nothing. It carries a full mark-by-mark memo from page 5 onwards, including the block diagram, the system identification, both controller designs and the sensitivity check.

Everything below is derived from the papers, not copied. Where a figure has to be read off a plot rather than computed, that is said explicitly, so treat those to about one significant figure.

Conventions used throughout: `Ts(5%) = 3/|Re(pole)|`, `Ts(2%) = 4/|Re(pole)|`, `%OS = exp(-pi*zeta/sqrt(1-zeta^2))`, and the course rule of thumb `zeta ~ PM/100` for phase margin in degrees.

---

## Class test 1 2020 ("The Testening Part 1", 50 marks, open book)

### Question 1, block diagram equivalence and steady-state error

**A) Are diagram A and diagram B equivalent? (6 marks)**

Yes. Work the inner loop of diagram A first.

The inner forward block is `G1 = 1/(3s+10)`. Two feedback paths tap the same node at G1's output: `H1 = 1/(s+3)` and `H2 = 3`. They add:

```
H1 + H2 = 1/(s+3) + 3 = (1 + 3s + 9)/(s+3) = (3s+10)/(s+3)
```

That is the whole trick. The loop gain is

```
G1 * (H1 + H2) = [1/(3s+10)] * [(3s+10)/(s+3)] = 1/(s+3)
```

so the `3s+10` cancels and the inner closed loop becomes

```
G1 / (1 + G1(H1+H2)) = [1/(3s+10)] / [1 + 1/(s+3)]
                     = [1/(3s+10)] * (s+3)/(s+4)
                     = (s+3) / [(3s+10)(s+4)]
```

Cascade `G2 = 1/(s+1)`:

```
(s+3) / [(3s+10)(s+4)(s+1)]
```

which is exactly the forward block drawn in diagram B.

Now the outer feedback. In diagram A the path `H3 = 1/(s^2+s) = 1/(s(s+1))` is tapped from the node **before** `G2`, not from the output. The signal at that node is `y * (s+1)`, because `y` is that node divided by `(s+1)`. So the returned signal is

```
y(s+1) * 1/(s(s+1)) = y/s
```

which is exactly diagram B's `1/s` feedback taken from `y`. Both loops return the same signal, so the two diagrams are equivalent.

**B) System type, and the steady-state errors (4 marks)**

Open-loop transfer function of the equivalent single loop:

```
L(s) = (s+3) / [ s (3s+10)(s+4)(s+1) ]
```

One pole at the origin, so the system is **type 1**.

- Position error constant `Kp = lim(s->0) L(s) = infinity`, so `ess` to a **unit step is 0**.
- Velocity error constant `Kv = lim(s->0) s*L(s) = 3/(10*4*1) = 3/40 = 0.075`, so the error to a **unit ramp** is `1/Kv = 40/3 = 13.33`.

(An acceleration input would give infinite error, since `Ka = 0`.)

### Question 2, root locus of a second-order system

The closed-loop characteristic equation is

```
1 + P/(s+1)^2 = 0   ->   s^2 + 2s + (1 + P) = 0
```

so the closed-loop poles are

```
s = -1 +/- j*sqrt(P)
```

**Read the supplied plot carefully.** The gain markers on the printed locus run over `(P+1)`, not over `P`. Check it three ways against the figure: the two open-loop `x` markers sit at `0` and `-2`, the branches meet at `-1` where the marker reads `1.0`, and the marked points at `2.0`, `5.0` and `9.0` sit at imaginary parts `1.0`, `2.0` and `2.83`, which is `sqrt(K-1)` every time. So when the plot says `K`, the gain in the question is `P = K - 1`. This changes no answer, but you cannot use the plot without it.

**A) Description of the locus**

Two open-loop poles, both at `s = -1` (a double pole), no finite zeros. `n - m = 2`, so two asymptotes at `+/-90 degrees` with centroid at `-1`. The real-axis segment between the two coincident poles has zero length, so there is no real-axis travel at all: for `P > 0` the branches break away vertically from `-1` immediately and run straight up and down the line `Re(s) = -1`. Breakaway point `-1`, breakaway angles `+/-90 degrees`.

**B) Which components meet the specifications**

Two specs, and they behave very differently.

*Settling time.* The real part is pinned at `-1` for every `P > 0`, so

```
Ts(5%) = 3/1 = 3 seconds, for all four components
```

Every component meets a 3 s settling requirement, and meets it **marginally and identically**. The settling-time spec cannot discriminate between the components at all. Worth saying out loud in the answer.

*Damping.* From `s = -1 +/- j*sqrt(P)`:

```
omega_n = sqrt(1 + P),  zeta = 1/sqrt(1 + P)
```

For `zeta > 0.45`:

```
1/sqrt(1+P) > 0.45  ->  1 + P < 4.938  ->  P < 3.938
```

Equivalently, the imaginary part must stay below `sqrt(3.938) = 1.985`.

| Component | P range | zeta range | max Im | Passes? |
|---|---|---|---|---|
| A | 0.9 to 1.1 | 0.690 to 0.725 | 1.049 | yes |
| B | 1.0 to 1.4 | 0.645 to 0.707 | 1.183 | yes |
| C | 2.502 to 3.498 | 0.471 to 0.534 | 1.870 | yes, narrowly |
| D | 4.75 to 5.25 | 0.400 to 0.417 | 2.291 | **no** |

Component D fails: at its best case `P = 4.75` the damping ratio is only 0.400, below the 0.45 floor, and it gets worse across the tolerance band.

**C) Which component is most consistent**

**Component A.** Consistency means the smallest spread in the closed-loop pole position across the tolerance band:

| Component | spread in zeta | spread in omega_n | spread in Im |
|---|---|---|---|
| A | 0.0355 | 0.071 | 0.100 |
| B | 0.062 | 0.140 | 0.183 |
| C | 0.063 | 0.240 | 0.339 |
| D | 0.017 | 0.102 | 0.147 |

A wins on damping-ratio spread and on natural-frequency spread, and it has the tightest pole cluster. D has a slightly tighter `zeta` spread but is disqualified anyway.

### Question 3, identifying a transfer function from a step response and a Bode plot

The Bode phase shows a **positive** peak of exactly 30 degrees and the magnitude **rises** with frequency, so this is a lead network. Of the two candidate forms, that is **form (b)**, and it requires

```
tau1 > tau2
```

Now pull the four numbers out.

*DC gain.* The low-frequency magnitude is 20 dB, that is a linear gain of 10. For the given form the DC gain is `A/2`, so

```
A = 20
```

*Step height.* The step response settles at 40. The DC gain is 10, so

```
U = 40/10 = 4
```

*Ratio tau1/tau2.* Three independent routes, all agreeing:

1. Initial value theorem. The response jumps to 120 at `t = 0+`, and the initial value is `(A * tau1/tau2) * U / 2`, giving `120 = 10 * (tau1/tau2) * ... ` which reduces to `tau1/tau2 = 1.5` once the settled value of 40 is divided out. Cleanest form: `initial/final = tau1/tau2 = 120/... ` scaled, giving 1.5.
2. Phase peak. For this form the peak phase satisfies `sin(phi_max) = (r-1)/(r+1)` with `r = 2*tau1/tau2`. With `phi_max = 30 degrees`, `sin 30 = 0.5`, so `r = 3` and `tau1/tau2 = 1.5`.
3. High-frequency magnitude. The plot flattens out at 29.54 dB, that is 29.99 linear, which is `10 * 3` to the accuracy you can read off the page. Same ratio.

*Absolute values.* The step response decays with time constant `tau2/2`. It passes 63.2% of the way from its initial 120 to its final 40, that is `y = 69.4`, at `t = 0.105 s`. So

```
tau2/2 = 0.1  ->  tau2 = 0.2  ->  tau1 = 0.3
```

**Answer: form (b), `A = 20`, `U = 4`, `tau1 = 0.3`, `tau2 = 0.2`.** As a lead network that is a zero at `1/tau1 = 3.33 rad/s`, a pole at `1/tau2 = 10 rad/s`, and maximum phase lead at `omega_m = sqrt(3.33*10) = 5.77 rad/s`, which is where the 30 degree peak sits on the plot. Good cross-check.

### Question 4, root locus with five open-loop poles

Open-loop poles at `-11`, `-10`, `+3` and `-12 +/- j3`. One open-loop zero at `-8`.

Before anything else, sanity-check the real-axis segments against the printed plot. A real point is on the locus if an odd number of real poles and zeros lie **strictly to its right**. Counting from the right: to the right of `+3` there is nothing (0, even, off); between `-8` and `+3` there is one (the pole at `+3`, odd, on); between `-10` and `-8` there are two (odd count broken by the zero, even, off); between `-11` and `-10` there are three (the zero at `-8` and the poles at `+3` and `-10`, odd, on); left of `-11` there are four (even, off). That matches the figure. It is easy to miscount the `-11` to `-10` segment by forgetting that the pole at `-10` is itself to the right of a test point at `-10.5`.

**A) Asymptotes**

`n = 5` poles, `m = 1` zero, so `n - m = 4` asymptotes.

```
angles = (2k+1)*180/4 = 45, 135, 225, 315 degrees, that is +/-45 and +/-135
centroid = (sum of poles - sum of zeros)/(n - m)
         = [(-11 - 10 + 3 - 12 - 12) - (-8)] / 4
         = (-42 + 8)/4
         = -34/4
         = -8.5
```

**B) Range of K for stability**

There are two separate crossings of the imaginary axis, so the stable range is a band, not a half-line.

- The branch that starts at the open-loop pole `+3` is in the right half plane at `K = 0` and travels left. It reaches the origin at `K = 1.0`. Below that gain the system is unstable simply because that pole has not been dragged into the left half plane yet.
- The pair of branches heading out along the `+/-45 degree` asymptotes crosses back into the right half plane just below `K = 2.0`.

So the system is stable for roughly

```
1 < K < 2
```

Read off the plot, so treat the endpoints as approximate.

**C) Can a second-order approximation be used?**

**Yes**, over essentially the whole stable range. Two things have to hold and both do.

1. The dominant pair sits 6 to 8 times closer to the imaginary axis than any other closed-loop pole, comfortably past the usual factor-of-5 rule.
2. The remaining closed-loop pole that would otherwise matter runs into the open-loop zero at `-8` and is very nearly cancelled by it, so its residue in the step response is small.

**D) Can a 5% settling time under 1.5 s be achieved with proportional gain alone?**

**No.** The dominant branches break away from the real axis at about `-1.2`, and that is the most negative real part the dominant poles ever reach for any positive `K`. The fastest achievable settling time is therefore

```
Ts(5%) = 3/1.2 = 2.5 seconds
```

which is well over the 1.5 s target. Proportional gain cannot get there because you cannot move the breakaway point by changing gain; you have to change the shape of the locus. That means adding a compensator zero to pull the locus left, that is lead compensation.

### Question 5, reading a Bode plot back to a transfer function

The plot: magnitude flat at 0 dB out to a break at about 4 rad/s, then a roll-off of about `-40 dB/decade` down to about `-100 dB` at `10^3 rad/s`; phase runs from 0 degrees to `-180 degrees` with no bump in the magnitude anywhere.

Four facts come straight off the page and every refutation below uses them:

- DC gain is `0 dB`, that is unity.
- The final slope is `-40 dB/decade` and the final phase is `-180 degrees`, so there are exactly **two poles and no zeros**.
- The break is at `omega = 4 rad/s`.
- There is **no resonant peak**, so `zeta >= 0.7`. The magnitude at the break reads about `-6 dB`, that is `1/(2*zeta) = 0.5`, so `zeta = 1`: critically damped.

Taken together the plot is `16/(s+4)^2`, or something very close to it.

**A) Why each candidate is not the system**

| Candidate | Why not |
|---|---|
| `1/(0.5s+1)` | First order. Its slope can only reach `-20 dB/decade` and its phase can only reach `-90 degrees`. The plot has `-40 dB/decade` and `-180 degrees`, both of which need two poles. Its break is also at 2 rad/s, not 4. |
| `1/(s^2+4s+8)` | The order and the final slope are right, but the DC gain is `1/8 = -18 dB`, and the plot starts at `0 dB`. Its natural frequency is `sqrt(8) = 2.83 rad/s`, not 4. |
| `8(s+10)/(s^2+4s+8)` | The zero at `-10` is fatal twice over: past 10 rad/s the slope flattens back to `-20 dB/decade` and the phase turns back up to `-90 degrees`, whereas the plot keeps falling at `-40` and settles at `-180`. Its DC gain is `80/8 = 10 = +20 dB` as well. |
| `8/(s^2+s+8)` | DC gain is right at `0 dB`, but `zeta = 1/(2*sqrt(8)) = 0.177`. That would put a resonant peak of `1/(2*zeta*sqrt(1-zeta^2)) = 2.87`, about `+9 dB`, at 2.8 rad/s. The plot has no peak at all. |
| `512/(s+8)^3` | DC gain is right, but three poles give a final slope of `-60 dB/decade` and a final phase of `-270 degrees`. The plot has `-40` and `-180`. Its break is at 8 rad/s, not 4. |

**B) i. 2% settling time**

The break frequency is the natural frequency, `omega_n = 4 rad/s`, and the absence of a peak fixes `zeta = 1`, so the pole real part is `-zeta*omega_n = -4` and

```
Ts(2%) = 4/(zeta*omega_n) = 4/4 = 1 second
```

(Strictly, a critically damped second-order step response carries a `t*exp(-4t)` term, so the exact 2% settling time is closer to `5.8/omega_n = 1.45 s`. The `4/(zeta*omega_n)` figure is what the course formula gives, and is the expected answer.)

**B) ii. What a faster settling time does to the magnitude plot**

Faster settling means the poles move further left, so `zeta*omega_n` increases. With everything else the same, the break frequency moves to a **higher frequency**: the whole magnitude curve shifts to the right. The 0 dB low-frequency level and the `-40 dB/decade` slope are unchanged, so the effect is a wider flat region and a later corner, that is a larger closed-loop bandwidth. Faster time response and wider bandwidth are the same statement.

**C) Sketch with the gain increased by a factor of 10**

Multiplying by 10 adds `20*log10(10) = 20 dB` at every frequency. The magnitude curve **shifts up by 20 dB** with its shape untouched: the flat section moves from 0 dB to `+20 dB`, the break stays at 4 rad/s, the slope stays at `-40 dB/decade`, and the `-100 dB` point at `10^3` becomes `-80 dB`. The **phase plot does not move at all**, because a positive real constant contributes 0 degrees at every frequency.

---

## Problem set 6.1

Questions 1, 2 and 3 already have full solutions printed in the file. What follows is 4, 5 and 6.

### Question 4, comparing two lead compensator designs

Plant `G(s) = 1/[(s+3)(s+1)]`.

```
C1(s) = K(0.09523s + 1)/(0.00396s + 1)   ->  zero at -10.50, pole at -252.5
C2(s) = K(0.1s + 1)/(0.01091s + 1)       ->  zero at -10.00, pole at -91.66
```

**Start with the hint: find the pole location that just satisfies the specs.**

*Fastest proportional control.* The uncompensated locus has real-axis poles at `-1` and `-3`, so it breaks away at `-2` and then runs vertically. The real part is pinned at `-2` for any gain past breakaway, so the fastest proportional settling time corresponds to a real part of `-2`. Settling in under 60% of that requires

```
|Re| > 2/0.6 = 3.333
```

Note this is independent of whether you use the 2% or the 5% definition, since the same factor divides out of both sides.

*Overshoot.* `%OS < 10%` gives

```
pi*zeta/sqrt(1-zeta^2) = ln(10) = 2.3026  ->  zeta > 0.591
```

which is a wedge of half-angle `acos(0.591) = 53.75 degrees` about the negative real axis.

The point that sits on **both** boundaries at once is

```
s_d = -3.333 + j4.543     (|Im| = 3.333*tan(53.75 deg) = 4.543)
omega_n = 5.635,  zeta = 0.5915
```

**A) Minimum gain K for each design, and the resulting position error constant**

Check the angle criterion at `s_d` for both. Angles from `s_d` to each singularity:

| | C1 | C2 |
|---|---|---|
| compensator zero | `+32.36 deg` (from -10.50) | `+34.27 deg` (from -10.00) |
| compensator pole | `-1.04 deg` (from -252.5) | `-2.95 deg` (from -91.66) |
| plant pole at -3 | `-94.19 deg` | `-94.19 deg` |
| plant pole at -1 | `-117.17 deg` | `-117.17 deg` |
| **sum** | **-180.04 deg** | **-180.04 deg** |

Both land on `-180` to within reading error, so both compensators were designed for exactly this target point. Good confirmation that `s_d` is right.

Now the magnitude criterion, `|C(s_d)G(s_d)| = 1`:

```
|G(s_d)| = 1/(|s_d+3| * |s_d+1|) = 1/(4.555 * 5.107) = 0.04299

C1:  |C1(s_d)/K| = 0.8081/0.98697 = 0.8188
     K * 0.8188 * 0.04299 = 1   ->  K = 28.4

C2:  |C2(s_d)/K| = 0.8068/0.96491 = 0.8361
     K * 0.8361 * 0.04299 = 1   ->  K = 27.8
```

Position error constants. In the given form `C(0) = K`, so

```
Kp = C(0)*G(0) = K/3

C1:  Kp = 28.4/3 = 9.47,  steady-state step error = 1/(1+9.47) = 9.6%
C2:  Kp = 27.8/3 = 9.27,  steady-state step error = 1/(1+9.27) = 9.7%
```

Practically identical.

**B) Maximum phase lead and where it occurs**

For `C(s) = K(s/z + 1)/(s/p + 1)` with `alpha = z/p`:

```
phi_max = asin[(1 - alpha)/(1 + alpha)]     at   omega_m = sqrt(z*p)

C1:  alpha = 0.00396/0.09523 = 0.04158
     phi_max = asin(0.9202) = 66.9 degrees   at  omega_m = sqrt(10.50*252.5) = 51.5 rad/s

C2:  alpha = 0.01091/0.1 = 0.1091
     phi_max = asin(0.8033) = 53.4 degrees   at  omega_m = sqrt(10.0*91.66) = 30.3 rad/s
```

**C) Which design to recommend**

**C2.** The two designs put the dominant poles in exactly the same place and give position error constants within 2% of each other, so performance is a wash. Everything that separates them is cost, not performance.

- **Noise.** C1's pole is at `-252.5`, 24 times further out than its zero, so its high-frequency gain is 24 times its DC gain, `+27.6 dB`. C2's ratio is 9.2, `+19.2 dB`. That extra 8 dB lands directly on top of whatever sensor noise the loop is carrying, and lead compensators amplify noise by construction. C2 is much gentler.
- **Actuator demand.** The same ratio sets how big the control signal spikes on a step. C1 demands roughly 2.6 times the peak effort of C2 for the same result.
- **Practicality.** 67 degrees from a single lead section is close to the point where a single stage stops being sensible; the pole/zero ratio needed grows very fast past about 65 degrees, and the design gets sensitive to component tolerance. C2 does the same job with 53 degrees.

Both designs put their third closed-loop pole far to the left (`-249.9` for C1, `-89.0` for C2), so the second-order approximation is safe for both. C2 wins on every practical axis for a 2% loss in steady-state accuracy.

### Question 5, lead compensator for an unstable plant

Plant `G(s) = 1/[(s+2)(s-0.5)]`, so open-loop poles at `-2` and `+0.5`. The pole in the right half plane means the open loop is unstable and the loop has to be closed to fix it.

Specs: `Ts(5%) < 3 s` gives `|Re| > 1`; `zeta > 0.7` gives a wedge of half-angle `acos(0.7) = 45.57 degrees`.

**A) Root locus and the specification region**

No finite zeros, two real poles. Real-axis test: right of `+0.5` nothing lies to the right (off); between `-2` and `+0.5` exactly one pole lies to the right (on); left of `-2` two poles lie to the right (off). So the locus is the segment from `-2` to `+0.5`, it breaks away at the midpoint

```
sigma_b = (-2 + 0.5)/2 = -0.75
```

and the two branches run vertically from there, `n - m = 2` asymptotes at `+/-90 degrees` with centroid also at `-0.75`.

The important consequence: **proportional control tops out at a real part of `-0.75`**, that is `Ts(5%) = 3/0.75 = 4 s`, which fails the 3 s spec. Hence lead compensation.

The specification region is the intersection of two half-plane-and-wedge constraints: everything to the left of `Re(s) = -1` **and** inside the wedge `|Im| < 1.020*|Re|` about the negative real axis (`tan 45.57 deg = 1.020`).

**B) Angles at the target and the compensator contribution**

Target `s_d = -3.2 + j3`. Both specs pass: `Re = -3.2 < -1`, and `zeta = 3.2/sqrt(3.2^2 + 3^2) = 3.2/4.386 = 0.730 > 0.7`.

```
angle from the pole at -2:    vector -1.2 + j3   ->  180 - atan(3/1.2)  = 111.80 deg
angle from the pole at +0.5:  vector -3.7 + j3   ->  180 - atan(3/3.7)  = 140.95 deg
                                                            sum = 252.75 deg
```

The angle criterion needs the total to come to `-180 degrees`, so the compensator must supply

```
252.75 - 180 = +72.75 degrees
```

**C) i. Zero at -2.1**

The zero at `-2.1` contributes

```
vector -1.1 + j3  ->  180 - atan(3/1.1) = 110.14 degrees
```

so the compensator pole must contribute `110.14 - 72.75 = 37.39 degrees`:

```
tan(37.39 deg) = 3/(p - 3.2)  ->  p - 3.2 = 3.924  ->  p = 7.12
```

**Compensator pole at about `-7.12`.** It satisfies the angle criterion, and the gain follows from the magnitude criterion as `K = 23.8` in pole-zero form. But it is a bad design, for two reasons.

*It is a near cancellation of the plant pole at `-2`.* The zero sits 0.1 away from a pole you only know to a tolerance. If the real plant pole is anywhere other than exactly `-2`, the cancellation is incomplete and you are left with an uncontrollable slow mode. You never rely on cancelling a plant pole you did not put there yourself.

*It destroys the dominance you designed for.* Because the numerator degree is two less than the denominator degree, the sum of the closed-loop poles equals the sum of the open-loop poles, which gives the third closed-loop pole directly:

```
r = p - 4.9 = 7.12 - 4.9 = 2.22
```

So the third closed-loop pole lands at `-2.22`, which is **closer to the imaginary axis than the pair at `-3.2`**. The "dominant" pair is not dominant at all, and every number computed from `zeta = 0.73` and `Ts = 3/3.2` is meaningless. The actual response is set by the slow pole at `-2.22` and by the zero at `-2.1` sitting next to it.

There is a third objection worth stating, because it is the general rule and it drives part ii: the compensator zero at `-2.1` lies to the **right** of the target poles' real part `-3.2`. A closed-loop zero closer to the imaginary axis than the dominant poles adds substantial overshoot on top of whatever the pole pair predicts.

**C) ii. How far left the zero may go**

The general rule, and the way the sandbox memo in this same folder phrases it: **the compensator zero must sit between the target real part and the point where the zero alone supplies the entire required angle.**

*Right-hand limit.* The zero must be at or to the left of `-3.2`, the target's real part, so it does not become the closest singularity to the imaginary axis and inflate the overshoot. That is the rule part i violates.

*Left-hand limit.* As the zero moves left its angle contribution shrinks, so the pole has to move left too. The limit is reached when the zero on its own contributes the whole 72.75 degrees and the pole would have to be at infinity:

```
atan[3/(z - 3.2)] = 72.75 deg  ->  z - 3.2 = 3/tan(72.75 deg) = 0.937  ->  z = 4.14
```

**So the usable range for the zero is `-4.14 <= zero <= -3.2`.**

Note on the paper: the question states the left-hand limit as `-12.47`, and part D then asks for a design with the zero at `-10`. Neither is consistent with the angle criterion at `s_d = -3.2 + j3`. A zero at `-10` contributes only `atan(3/6.8) = 23.8 degrees`, and that is its **maximum** possible net contribution, reached when the compensator pole is pushed to infinity. 23.8 degrees is nowhere near the 72.75 degrees part B asks for, so no real compensator pole exists that satisfies the angle criterion with a zero at `-10`. The number `-12.47` is almost certainly the compensator **pole** that pairs with a zero placed at the target real part: putting the zero at `-3.2` gives a zero angle of exactly 90 degrees, so the pole must supply `90 - 72.75 = 17.25 degrees`, which puts it at `-3.2 - 3/tan(17.25 deg) = -12.87`. Same ballpark, wrong element. Work the question with `-4.14` and it is consistent all the way through.

**D) A working design (zero placed inside the feasible range)**

Take the zero at `-3.5`, comfortably inside `[-4.14, -3.2]`.

**i. Compensator pole.**

```
zero angle:  atan[3/(3.5 - 3.2)] = atan(10) = 84.29 deg
pole angle:  84.29 - 72.75 = 11.54 deg
p - 3.2 = 3/tan(11.54 deg) = 14.69  ->  p = 17.89
```

**Compensator pole at about `-17.9`.** The pole/zero ratio is `17.89/3.5 = 5.1`, under the factor-of-10 rule of thumb, so the compensator is physically realizable.

**ii. Compensator with its gain.** Magnitude criterion at `s_d`:

```
|s_d + 2|    = |-1.2 + j3|  = 3.231
|s_d - 0.5|  = |-3.7 + j3|  = 4.763
|s_d + 3.5|  = | 0.3 + j3|  = 3.015
|s_d + 17.9| = |14.69 + j3| = 14.99

K = (z/p) * |s_d+2| * |s_d-0.5| * |s_d+p| / |s_d+z|
  = (3.5/17.89) * 3.231 * 4.763 * 14.99 / 3.015
  = 15.0
```

```
C(s) = 15.0 * (s/3.5 + 1) / (s/17.9 + 1)
```

**iii. Tracking accuracy.** This is where the hint about the uncompensated plant gain matters. The plant DC gain is

```
G(0) = 1/[(2)(-0.5)] = -1
```

negative, because of the right-half-plane pole. So

```
L(0) = C(0)*G(0) = 15.0 * (-1) = -15.0
steady-state step error = 1/(1 + L(0)) = 1/(1 - 15.0) = -0.0714
```

The error magnitude is **7.1%**, so the system tracks a position input to 92.9% accuracy. That is better than the 90% required, so **yes, this is an acceptable design.**

For completeness, the third closed-loop pole is at `r = p - 4.9 = 13.0`, which is four times further left than the dominant pair, so the second-order approximation holds. The compensator zero at `-3.5` does sit close to the dominant pair, so expect a bit more overshoot than the nominal `zeta = 0.73` predicts.

If you want the maximum accuracy available inside the feasible band, push the zero to the left edge: a zero at `-4.0` gives a pole at `-77` and a pole/zero ratio of 19, which fails the realizability rule. `-3.5` is about the sweet spot.

### Question 6, lead compensator for a spring-mass-damper

```
m*xdd = -b*xd - k*x + F,   m = 2, b = 5, k = 10
```

Laplace transform at rest and rearrange:

```
G(s) = X(s)/F(s) = 1/(2s^2 + 5s + 10)
```

Open-loop poles at `s = (-5 +/- j*sqrt(55))/4 = -1.25 +/- j1.854`, so `omega_n = sqrt(5) = 2.236` and `zeta = 0.559`. DC gain `G(0) = 0.1`.

**Specification analysis**

| Written spec | What it means for the poles or the loop |
|---|---|
| position error < 5% | `1/(1+Kp) < 0.05`, so `Kp > 19`, so the open-loop DC gain must exceed 19 |
| `zeta > 0.4` | poles within `acos(0.4) = 66.4 deg` of the negative real axis |
| `Ts(5%) < 1 s` | `3/abs(Re) < 1`, so `Re < -3` |
| phase margin `>= 60 deg` | by `zeta ~ PM/100`, effectively `zeta >= 0.6`; this is the binding damping constraint, not the 0.4 |

**Why proportional control cannot work.** The closed-loop characteristic equation is `2s^2 + 5s + (10 + K) = 0`, so the real part of the poles is `-5/4 = -1.25` for every `K` past breakaway. Proportional gain moves the poles straight up and down and never left. Fastest possible settling time is `3/1.25 = 2.4 s`, more than double the spec. A lead stage is mandatory.

**Why a lead alone is not enough either.** Pick a target and check the two remaining specs against each other. With a lead sized to put the dominant poles at `-6 +/- j6` (`zeta = 0.707`, `Ts(5%) = 0.5 s`), the gain that the magnitude criterion forces is `K = 100`, giving `Kp = 100*0.1 = 10` and a steady-state error of 9.1%. Too big. Push the target further out to get more gain and the crossover frequency climbs with it and the phase margin falls below 60 degrees. The two specs pull in opposite directions, which is exactly the situation lag compensation exists for.

**Design: lead plus lag**

Target `s_d = -6 + j6`: `zeta = 0.707`, `omega_n = 8.49`, `Ts(5%) = 3/6 = 0.5 s`.

*Angles required.*

```
from -1.25 + j1.854:  vector -4.75 + j4.146  ->  138.89 deg
from -1.25 - j1.854:  vector -4.75 + j7.854  ->  121.15 deg
                                       sum  =   260.04 deg
compensator must supply 260.04 - 180 = 80.04 degrees
```

*Lag stage.* Put a zero at `-0.6` and a pole at `-0.3`, both close enough to the origin that they barely tilt the locus but far enough apart to double the DC gain:

```
angle contribution at s_d:  131.99 - 133.56 = -1.57 degrees
DC gain contribution:       z/p = 0.6/0.3 = 2
```

*Lead stage.* It now has to supply `80.04 + 1.57 = 81.61 degrees`. Put the zero directly below the target at `-6`, so its angle is exactly 90 degrees, leaving the pole to supply `90 - 81.61 = 8.39 degrees`:

```
p - 6 = 6/tan(8.39 deg) = 40.8  ->  p = 46.8
```

Pole/zero ratio `46.8/6 = 7.8`, under 10, so it is realizable.

*Gain.* Magnitude criterion at `s_d`:

```
|s_d + 6|    = |j6|          = 6.000
|s_d + 0.6|  = |-5.4 + j6|   = 8.072
|s_d + 46.8| = |40.8 + j6|   = 41.24
|s_d + 0.3|  = |-5.7 + j6|   = 8.276
|2*s_d^2 + 5*s_d + 10| = |-20 - j114| = 115.7

K = (41.24 * 8.276 * 115.7) / (6.000 * 8.072) = 815
```

**Final compensator:**

```
C(s) = 815 * (s + 6)(s + 0.6) / [ (s + 46.8)(s + 0.3) ]
```

**Verification against every spec**

*Angle criterion.* `90 + 131.99 - 8.37 - 133.56 - 260.04 = -180.0 degrees`. The dominant poles land where they were placed.

*Steady-state error.*

```
Kp = L(0) = 815 * 6 * 0.6 / (46.8 * 0.3 * 10) = 2934/140.4 = 20.9
error = 1/(1 + 20.9) = 4.6%   ->  passes (< 5%)
```

*Damping and settling.* Dominant pair at `-6 +/- j6`, `zeta = 0.707 > 0.4`, `Ts(5%) = 0.5 s < 1 s`.

*Phase margin.* Evaluating the open loop at `omega = 10 rad/s`:

```
|L(j10)| = 815 * 11.662 * 10.018 / (47.856 * 10.004 * 196.47) = 1.01
angle L(j10) = 59.04 + 86.57 - 12.05 - 88.28 - 165.28 = -120.0 degrees
```

so the gain crossover is at `omega_gc = 10.1 rad/s` and the **phase margin is 60.0 degrees**, exactly meeting the spec. The phase never reaches `-180 degrees` at any frequency, so the gain margin is infinite.

*The remaining closed-loop poles.* Expanding the characteristic polynomial and dividing out `s^2 + 12s + 72` leaves `s^2 + 37.58s + 21.37`, whose roots are `-0.58` and `-37.0`.

**The honest caveat.** The pole at `-0.58` sits next to the lag zero at `-0.6`, forming a dipole. Its residue in the step response works out to about 3.8% of the final value, decaying with a 1.7 s time constant. That does not break the 5% settling band on its own, but it eats most of it, so the real settling time will be somewhat longer than the 0.5 s the dominant pair predicts. That slow tail is the standard price of lag compensation and it is worth stating in the answer rather than hiding.

If the tail is unacceptable, replace the lag with integral action: a PI stage in place of the lag drives the steady-state position error to zero exactly, which removes the reason the extra DC gain was needed in the first place. The cost is one more pole at the origin to keep stable, so the lead stage has to work harder.

---

## Problem set 7.1, design specifications

### Question 1, first-order time specs rewritten in the frequency domain

**A) Tracks a position setpoint with less than 5% error**

Time-domain: `ess = 1/(1 + Kp) < 0.05`, so `Kp > 19`.

Frequency-domain: `Kp` is just the open-loop gain as `omega -> 0`, so the requirement is on the low-frequency asymptote of the open-loop magnitude:

```
|G(j0)| > 19,  that is  20*log10(19) = 25.6 dB
```

On a Nichols chart, the `omega -> 0` end of the trajectory must sit above `25.6 dB`. Equivalently, in closed-loop terms, the closed-loop magnitude at low frequency must be within `20*log10(0.95) = -0.45 dB` of unity.

**B) Settles to within 5% of final value in under 3 seconds**

For a first-order system the 5% settling time is exactly `3*tau` (since `exp(-3) = 0.0498`), so

```
3*tau < 3  ->  tau < 1 second  ->  closed-loop pole at -1 or further left
```

Frequency-domain: the closed-loop bandwidth of a first-order system is `1/tau`, so

```
omega_BW > 1 rad/s
```

That is the whole content of the spec: a faster time response is a wider bandwidth, nothing more.

### Question 2, is the -4 +/- j3 target acceptable?

**Translate the target pole pair into frequency-domain terms first.**

```
s = -4 +/- j3   ->  omega_n = 5 rad/s,  zeta = 4/5 = 0.8
```

Since `zeta = 0.8 > 0.707`, the closed loop has **no resonant peak at all**. On a Nichols chart that means the trajectory must not penetrate any M-circle above 0 dB.

The phase margin corresponding to `zeta = 0.8`:

```
PM = atan[ 2*zeta / sqrt(sqrt(1 + 4*zeta^4) - 2*zeta^2) ] = atan(1.6/0.5868) = 69.9 degrees
```

(the crude `zeta ~ PM/100` rule would say 80 degrees, which is why it is worth using the exact expression when the damping is high).

The gain requirement `>= 15` becomes `20*log10(15) = 23.5 dB` at the low-frequency end of the chart.

**Now read the chart. The system is acceptable.**

- The low-frequency end of the trajectory sits at about `26 dB`, above the `23.5 dB` floor.
- The trajectory crosses `0 dB` at a phase of about `-107 degrees`, giving a **phase margin of about 73 degrees**, which brackets the 70 degrees the target pair needs.
- It never reaches the `-180 degree` line, so the gain margin is infinite.
- It stays clear of the positive M-circles, consistent with no resonant peak.

Cross-checking against the hint, `G(s) = 23.81/(s^2 + 8s + 1.19)`:

```
DC gain = 23.81/1.19 = 20.0, that is 26.0 dB    -> above 23.5 dB, so the gain spec passes
closed loop: s^2 + 8s + 1.19 + 23.81 = s^2 + 8s + 25 = 0
             roots -4 +/- j3
```

The closed-loop poles land exactly on the target. Computing the crossover directly gives `omega_gc = 2.85 rad/s` at a phase of `-106.9 degrees`, so `PM = 73.1 degrees`, matching the chart read-off.

### Question 3, three specs and a chart

**A) The region on the s-plane**

Convert each spec into a boundary:

```
Ts(2%) < 1 s        ->  4/(zeta*omega_n) < 1   ->  zeta*omega_n > 4   ->  Re(s) < -4
%OS < 10%           ->  pi*zeta/sqrt(1-zeta^2) > ln(10) = 2.3026  ->  zeta > 0.591
                        that is, within acos(0.591) = 53.75 degrees of the negative real axis
position error < 10% ->  1/(1 + Kp) < 0.1  ->  Kp > 9, that is 19.1 dB of open-loop DC gain
```

The first two are s-plane constraints and the third is a gain constraint, so the drawing has two boundaries:

- a **vertical line at `Re(s) = -4`**, everything to its left is allowed;
- a **wedge of half-angle 53.75 degrees** about the negative real axis, that is `|Im| < 1.363*|Re|`, everything inside is allowed.

The acceptable region is the intersection: the wedge, truncated on the right by the vertical line. It is unbounded outwards.

**B) Does the charted system satisfy the requirements?**

**No. It passes on settling time and steady-state accuracy, and fails on overshoot.**

Read the chart:

- Low-frequency end sits at about `19.8 dB`, just above the `19.1 dB` needed for the position-error spec. **Passes**, narrowly.
- Gain crossover at about `9 rad/s` at a phase of about `-128 degrees`, giving a **phase margin of about 52 degrees**. The overshoot spec needs `zeta > 0.591`, which by the course rule of thumb needs a phase margin above about 59 degrees. **Fails.**
- The trajectory reaches into the **2 dB M-circle**. The `%OS < 10%` spec caps the resonant peak at `1/(2*zeta*sqrt(1-zeta^2))` with `zeta = 0.591`, that is `1.049`, or `0.4 dB`. Penetrating a 2 dB M-circle is the same failure seen a second way, and it is the more reliable read of the two because it does not rely on a rule of thumb.

Cross-checking against the hint, `G(s) = 113.6/(s^2 + 10s + 11.6)`:

```
Kp = 113.6/11.6 = 9.79   ->  position error = 1/10.79 = 9.3%   -> passes (< 10%)
closed loop: s^2 + 10s + 125.2 = 0  ->  poles at -5 +/- j10.0
             omega_n = 11.19,  zeta = 5/11.19 = 0.447
Ts(2%) = 4/5 = 0.8 s                                            -> passes (< 1 s)
%OS = exp(-pi*0.447/sqrt(1 - 0.447^2)) = 20.8%                  -> FAILS (> 10%)
```

The poles at `-5 +/- j10` sit to the left of the `-4` line, so the settling-time boundary is met, but they lie at `atan(10/5) = 63.5 degrees` off the negative real axis, outside the 53.75 degree wedge. The damping is the one thing short, and it is short by a wide margin, not marginally.

*Fix:* the only spec failing is damping, so reduce the loop gain to pull the poles back into the wedge. But dropping the gain also drops `Kp`, which is already only 9.79 against a floor of 9. The two specs are almost mutually exclusive at this plant, which is the point the question is making: this system needs a compensator, not a gain adjustment.
