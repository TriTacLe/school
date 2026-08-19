---
type: note
status: active
project: ntnu
course: TTK4215
tags: [ntnu, kybernetikk, adaptiv-regulering, solutions]
---

## Solutions: TTK4215 exam, 3 December 2024

The PDF in `materials/Tidligere eksamensoppgaver/TTK4215-Exam2024.pdf` already
has the correct alternatives ticked. It gives no reasoning, so that is what this
note supplies, plus full answers to the parts with no key at all: the fill-in
blanks in MRAC b) and the handwritten parts MRAC c) and d).

Notation follows Ioannou and Sun, which is the course book.

### 1. Barbalat's lemma (5 points)

**Claim: $g \in \mathcal{L}_2 \cap \mathcal{L}_\infty \Rightarrow g(t) \to 0$. False.**

$\mathcal{L}_2 \cap \mathcal{L}_\infty$ does not force convergence, because a
signal can keep returning to a fixed height as long as it does so on ever
narrower intervals. Take triangular spikes of height 1 centred at $t = n$ with
width $2^{-n}$. Then $\|g\|_\infty = 1$, $\|g\|_2^2 \le \sum 2^{-n} < \infty$,
and $g(n) = 1$ for every $n$, so $g \not\to 0$. What is missing is uniform
continuity. Barbalat needs $\dot g \in \mathcal{L}_\infty$ on top of
$g \in \mathcal{L}_2$.

**$g(t) = \dfrac{\sin(t^{1/4})}{1+t}$ on $[0,\infty)$.**

- $g \in \mathcal{L}_\infty$: **true**. $|g(t)| \le \dfrac{1}{1+t} \le 1$.
- $g \in \mathcal{L}_2$: **true**. $\int_0^\infty \frac{\sin^2(t^{1/4})}{(1+t)^2}dt
  \le \int_0^\infty \frac{dt}{(1+t)^2} = 1 < \infty$.
- $\dot g \in \mathcal{L}_\infty$: **false**. Differentiating,
  $$\dot g(t) = \frac{\tfrac14 t^{-3/4}\cos(t^{1/4})}{1+t} - \frac{\sin(t^{1/4})}{(1+t)^2}.$$
  The first term blows up as $t \to 0^+$ because of $t^{-3/4}$, and $t = 0$ is in
  the domain. So $\dot g$ is unbounded, at the left endpoint rather than at
  infinity. Read the domain, not just the tail.
- $\lim_{t\to\infty} g(t) = 0$: **true**, directly from $|g| \le 1/(1+t)$.

Take the pair together. This $g$ tends to zero even though $\dot g \notin
\mathcal{L}_\infty$, so Barbalat's conditions are sufficient, never necessary.
Failing them proves nothing.

### 2. Gradient method (10 points)

Linear parametric model $z = \theta^{*T}\phi$, normalised gradient law with
$m^2 = 1 + n_s^2$, $n_s^2 = \phi^T\phi$, and
$V(\tilde\theta) = \tfrac12 \tilde\theta^T\Gamma^{-1}\tilde\theta$.

The one computation everything hangs on. Since $\theta^*$ is constant,
$\dot{\tilde\theta} = \dot\theta = \Gamma\epsilon\phi$, and
$\epsilon = \dfrac{z - \theta^T\phi}{m^2} = -\dfrac{\tilde\theta^T\phi}{m^2}$, so

$$\dot V = \tilde\theta^T\Gamma^{-1}\Gamma\epsilon\phi = \epsilon\,\tilde\theta^T\phi = -\epsilon^2 m^2 \le 0.$$

From $\dot V \le 0$ alone:

| property | provable | why |
|---|---|---|
| $V \in \mathcal{L}_\infty$ | yes | $V$ non-increasing, $V \ge 0$ |
| $\lim V = V_\infty \in [0, V(0)]$ | yes | monotone and bounded below |
| $\theta \in \mathcal{L}_\infty$ | yes | $V$ bounded and $\Gamma^{-1} > 0$ give $\tilde\theta$ bounded |
| $\epsilon m \in \mathcal{L}_2$ | yes | integrate $\dot V$: $\int_0^\infty \epsilon^2m^2 = V(0) - V_\infty$ |
| $\epsilon n_s \in \mathcal{L}_2$ | yes | $|\epsilon n_s| \le |\epsilon m|$ since $m^2 = 1 + n_s^2$ |
| $\epsilon \in \mathcal{L}_2$ | yes | $|\epsilon| \le |\epsilon m|$, same reason |
| $\epsilon \in \mathcal{L}_\infty$ | yes | $|\epsilon| \le \dfrac{|\tilde\theta||\phi|}{1+|\phi|^2} \le \tfrac12|\tilde\theta|$ |
| $\dot\theta \in \mathcal{L}_\infty$ | yes | $|\dot\theta| \le \|\Gamma\| |\tilde\theta| \dfrac{|\phi|^2}{m^2} \le \|\Gamma\||\tilde\theta|$ |
| $\dot\theta \in \mathcal{L}_2$ | yes | $|\dot\theta| \le \|\Gamma\||\epsilon||\phi| \le \|\Gamma\||\epsilon m|$ |

The seven that are **not** provable, and the reason each fails:

- $V \in \mathcal{L}_2$ and $\lim V = 0$: $V$ converges to $V_\infty$ which may be
  strictly positive. Nothing here drives it to zero.
- $\tilde\theta \in \mathcal{L}_2$ and $\lim\theta = \theta^*$: parameter
  convergence needs $\phi$ persistently exciting. Without PE the estimate can
  settle anywhere on the level set.
- $\theta \in \mathcal{L}_2$: $\theta \to$ a nonzero constant in general.
- $z \in \mathcal{L}_2$, $z \in \mathcal{L}_\infty$, $\hat z \in
  \mathcal{L}_\infty$: $z$ and $\phi$ are given data. The estimator says nothing
  about them, and unbounded $\phi$ is entirely allowed. Normalisation exists
  precisely so the estimator survives that.

The pattern worth memorising: the Lyapunov argument buys you boundedness of the
estimates and square integrability of the normalised error. It never buys
parameter convergence, and it never says anything about the regressor.

### 3. APPC a) (15 points)

Plant $y_p = \dfrac{Z_p}{R_p}u_p$ with $Z_p = 1$, $R_p = s - 1$, so an unstable
first order plant. Target $A^* = (s+1)^3$, with $P(s) = 4s^2 - s + 5$.

**Where the internal model is hiding.** The controller is not simply
$L u_p = -P y_p$. In the pole placement design with an internal model, the
controller denominator is $Q(s)L(s)$, where $Q$ is the internal model chosen by
the designer and $L$ is what is left over after solving the Diophantine equation

$$Q(s)L(s)R_p(s) + P(s)Z_p(s) = A^*(s).$$

The paper gives $L = 1$ and $P = 4s^2 - s + 5$ but leaves $Q$ implicit. Recover it:

$$Q(s)(s-1) = (s+1)^3 - (4s^2 - s + 5) = s^3 - s^2 + 4s - 4 = (s-1)(s^2+4),$$

so $Q(s) = s^2 + 4$. Degrees check out, $\deg(QL R_p) = 3 = \deg A^*$ and
$\deg P = 2$. Work this out first. Without $Q$ the question cannot be answered,
and $Q$ is the entire answer.

**Why $Q$ decides the answer.** Internal model principle: the loop tracks $y_m$
asymptotically exactly when the annihilating polynomial $Q_m$ of $y_m$, defined
by $Q_m(s)\,y_m = 0$, divides the internal model $Q$ sitting in the controller
denominator. Here $Q = s^2 + 4$ holds the internal model of a sinusoid at
$\omega = 2$ rad/s and nothing else.

| $y_m$ | $Q_m$ | tracked | reason |
|---|---|---|---|
| $0$ | $1$ | yes | trivially, $1$ divides $Q$ |
| $2\cos 2t - 3\sin 2t$ | $s^2+4$ | yes | exactly the internal model in $Q$ |
| $\sin(2t+4)$ | $s^2+4$ | yes | phase shift does not change the annihilator |
| $e^{-t}$ | $s+1$ | yes | decays, and the closed loop is stable, so the error decays |
| $\dfrac{1}{1+t}$ | none rational | yes | $\to 0$ and $\in \mathcal{L}_2$, error dies with it |
| $3\cos 2t - \sin t$ | $(s^2+4)(s^2+1)$ | no | the $\omega = 1$ part has no internal model |
| $2\sin t - 4\cos t$ | $s^2+1$ | no | same, wrong frequency |
| $t$ | $s^2$ | no | needs a double integrator in $Q$ |
| $t^2$ | $s^3$ | no | same, worse |
| $e^{t}$ | $s-1$ | no | unbounded, and $s-1$ does not divide $Q$ |

The two decaying signals are the ones people get wrong. They are tracked, but not
because of an internal model. They are tracked because they vanish, so tracking
them is the same as regulating to zero.

### 4. APPC b) (10 points)

Plant $y_p = \dfrac{b}{s+a}u_p$ with $a$, $b$ unknown. Four estimators offered,
the fourth is correct.

**Deriving the parametric model** shows why the signs in the first two options
are wrong. From $(s+a)y_p = b u_p$, filter both sides with $\frac{1}{s+5}$:

$$y_p = \frac{s}{s+5}y_p + \frac{5}{s+5}y_p \quad\Longrightarrow\quad
y_p - \underbrace{\frac{5}{s+5}y_p}_{x} = \frac{-a\,y_p + b\,u_p}{s+5}.$$

So with $\dot x = -5x + 5y_p$, the correct regressand is

$$z = y_p - x, \qquad z = a\phi_1 + b\phi_2, \qquad
\phi_1 = -\frac{1}{s+5}y_p, \quad \phi_2 = \frac{1}{s+5}u_p,$$

that is $\dot\phi_1 = -5\phi_1 - y_p$ and $\dot\phi_2 = -5\phi_2 + u_p$.

Options 1 and 2 use $z = y_p + x$ with $\dot\phi_1 = -5\phi_1 + y_p$ and
$\dot\phi_2 = -5\phi_2 - u_p$. Those signs do not come out of the filtering, so
they estimate the wrong quantities. Rule them out before reading any further.

**Between options 3 and 4**, the only difference is the update for $\hat b$:

$$\dot{\hat b} = \begin{cases} 10\epsilon\phi_2 & \hat b > 0.1 \ \text{ or } \ \epsilon\phi_2 > 0\\ 0 & \text{otherwise}\end{cases}$$

This is projection. The APPC control law solves a Diophantine equation built from
the current estimates and then divides by $\hat b$. If $\hat b$ drifts to zero
the estimated plant loses stabilisability and the controller blows up, and
nothing in the unprojected gradient law prevents that. The switching keeps
$\hat b \ge 0.1$ while only ever refusing updates that would push it further
down, so it preserves the $\dot V \le 0$ inequality. Option 4.

This is the standard answer to "why does adaptive pole placement need
projection". The estimator is fine without it. The controller is not.

### 5. APPC c) (10 points)

Now both asymptotic tracking **and** parameter convergence
$\hat a \to a$, $\hat b \to b$.

Tracking is question a) again, so only the five signals from that list survive.
Convergence adds persistence of excitation of $\phi = [\phi_1, \phi_2]^T$. Two
parameters need two independent spectral lines, and a single sinusoid at
$\omega \neq 0$ supplies exactly that, at $\pm\omega$.

- $2\cos 2t - 3\sin 2t$: tracked, and a genuine sinusoid at 2 rad/s, so PE. **Yes.**
- $\sin(2t+4)$: same signal up to phase. **Yes.**
- $y_m = 0$: tracked, but $\phi \to 0$, no excitation at all. No convergence.
- $e^{-t}$ and $\frac{1}{1+t}$: tracked, but both die, so the regressor carries no
  persistent information. No convergence.
- The rest fail tracking already.

The lesson: regulation to zero and parameter identification pull in opposite
directions. The better the controller does its job, the less the estimator learns.

### 6. MRAC a) (4 points)

$$y_p = \frac{s+b_0}{(s+a_0)(s+a_1)}u_p, \qquad y_m = \frac{1}{s+1}r.$$

Answer: $b_0 > 0$ and $a_0 \neq b_0$ and $a_1 \neq b_0$.

- $b_0 > 0$ makes $Z_p = s + b_0$ Hurwitz. MRAC cancels the plant zeros, so a
  right half plane zero would put an unstable hidden mode in the loop. Minimum
  phase is not negotiable.
- $a_0 \neq b_0$ and $a_1 \neq b_0$ keep $Z_p$ and $R_p$ coprime. A shared root
  is a pole-zero cancellation, the realisation stops being minimal, and the
  parametrisation the design rests on breaks.
- $a_0, a_1$ are otherwise unconstrained. In particular they may be negative, so
  the plant may be open loop unstable. That is the point of the method.

Why the other options fail: $b_0 \neq 0$ is too weak, it allows $b_0 < 0$ and a
non-minimum-phase plant. $a_0 \neq 0$ and $a_1 \neq 0$ forbid a pole at the
origin, which is not required, while saying nothing about coprimeness.
$a_0 \neq a_1$ alone forbids repeated plant poles, again not required.

Relative degree here is $n^* = 1$, matching the reference model, which is what
the design needs.

### 7. MRAC b) (21 points), the fill-in parts

**Filter realisation.** Both blanks are $-f$:

$$\dot\omega_1 = -f\,\omega_1 + u_p, \qquad \dot\omega_2 = -f\,\omega_2 + y_p,$$

since $\frac{1}{s+f}$ realised in state space is exactly $\dot\omega = -f\omega +
(\text{input})$.

**Closed loop matrices.** With $X_p = [x_p, \omega_1, \omega_2]^T$:

$$A_c = \begin{bmatrix} A + \theta_3^* BC & \theta_1^* B & \theta_2^* B\\
\theta_3^* C & -f + \theta_1^* & \theta_2^*\\
C & 0 & -f \end{bmatrix},\qquad
B_c = \begin{bmatrix} B\\ 1\\ 0\end{bmatrix},\qquad
C_c = \begin{bmatrix} C & 0 & 0\end{bmatrix}.$$

Substituting $u_p = \theta_1^*\omega_1 + \theta_2^*\omega_2 + \theta_3^* y_p + r$
into $\dot x_p = Ax_p + Bu_p$ with $y_p = Cx_p$ gives the first row. The second
row is $\dot\omega_1 = -f\omega_1 + u_p$ with $u_p$ expanded. The third is
$\dot\omega_2 = -f\omega_2 + Cx_p$, which is why it has no $\theta^*$ in it.

**Transfer function.**

$$y_p = C_c(sI - A_c)^{-1}B_c\,r = \frac{1}{s+1}\,r,$$

that is, numerator blank $1$ and denominator blank $s+1$. This is the matching
condition: with $\theta^* $ chosen correctly the closed loop is
indistinguishable from the reference model, which is what makes $e_1 \to 0$ even
achievable.

**Derivative of $V = \tfrac12 e^TPe + \tfrac12\tilde\theta^T\Gamma^{-1}\tilde\theta$.**

$$\dot V = \tfrac12 e^T\!\left(A_c^TP + PA_c\right)e + \tilde\theta^T\Gamma^{-1}
\left(\dot\theta + \Gamma\omega\left(PB_c\right)^Te\right).$$

First blank $A_c^TP + PA_c$, second blank $B_c$. Both blanks have equivalent
alternatives listed, $PA_c + A_c^TP$ is the same matrix, pick either.

### 8. MRAC c) and d) (10 points, handwritten)

**c) Choosing the adaptive law.**

$A_c$ is Hurwitz and, because the matching condition makes
$C_c(sI-A_c)^{-1}B_c = \frac{1}{s+1}$ strictly positive real, the
Meyer-Kalman-Yakubovich lemma gives a $P = P^T > 0$ and $q$, $\nu > 0$, $L =
L^T > 0$ with

$$A_c^TP + PA_c = -qq^T - \nu L, \qquad PB_c = C_c^T.$$

The second identity is the one that matters for implementation. Take

$$\boxed{\dot\theta = -\Gamma\,\omega\,e_1}, \qquad e_1 = y_p - y_m.$$

Substituting into the expression for $\dot V$, the bracket becomes
$\dot\theta + \Gamma\omega(PB_c)^Te = -\Gamma\omega e_1 + \Gamma\omega C_ce =
-\Gamma\omega e_1 + \Gamma\omega e_1 = 0$, leaving

$$\dot V = -\tfrac12 e^Tqq^Te - \tfrac{\nu}{2}e^TLe \le 0.$$

Implementable, and this is the whole reason for the argument: the natural
choice $-\Gamma\omega(PB_c)^Te$ needs the full error state $e$, which is not
measured, while $PB_c = C_c^T$ converts it into $C_c e = e_1$, a single
measurable scalar. $\omega = [\omega_1, \omega_2, y_p]^T$ is built from the
designer's own filters, so it is known too. No unknown plant parameter appears
anywhere in the law.

**d) Proof that $e_1 \to 0$.**

1. $\dot V \le 0$ and $V \ge 0$ give $V \in \mathcal{L}_\infty$, hence
   $e \in \mathcal{L}_\infty$ and $\tilde\theta \in \mathcal{L}_\infty$, so also
   $\theta \in \mathcal{L}_\infty$.
2. Integrating $\dot V \le -\tfrac{\nu}{2}e^TLe \le -\tfrac{\nu\lambda_{\min}(L)}{2}|e|^2$
   from 0 to $\infty$:
   $$\frac{\nu\lambda_{\min}(L)}{2}\int_0^\infty |e|^2dt \le V(0) - V_\infty < \infty,$$
   so $e \in \mathcal{L}_2$, and therefore $e_1 = C_ce \in \mathcal{L}_2 \cap
   \mathcal{L}_\infty$.
3. Boundedness of the signals. $r$ is bounded by assumption and the reference
   model is stable, so $X_m \in \mathcal{L}_\infty$ and $y_m \in
   \mathcal{L}_\infty$. Since $X_c = e + X_m$ and $e$ is bounded, $X_c \in
   \mathcal{L}_\infty$, which gives $x_p$, $\omega_1$, $\omega_2$ and
   $y_p = Cx_p$ all bounded. Hence $\omega \in \mathcal{L}_\infty$, and
   $u_p = \theta^T\omega + r$ is bounded as well. The closed loop has no finite
   escape and every signal is bounded.
4. Uniform continuity. From $\dot e = A_ce + B_c\tilde\theta^T\omega$ with every
   factor bounded, $\dot e \in \mathcal{L}_\infty$, so
   $\dot e_1 = C_c\dot e \in \mathcal{L}_\infty$ and $e_1$ is uniformly
   continuous.
5. Barbalat. $e_1 \in \mathcal{L}_2$ and $\dot e_1 \in \mathcal{L}_\infty$ give
   $$\lim_{t\to\infty} e_1(t) = 0. \qquad \blacksquare$$

Note what is not claimed. $\theta \to \theta^*$ does not follow, and cannot
without persistence of excitation in $\omega$. Tracking is achieved with a
possibly wrong model, which is the recurring theme of this course.

### 9. Adaptive backstepping (15 points)

$$\dot x_1 = x_2 + \theta^*x_1^3, \qquad \dot x_2 = x_2 + u,$$

virtual control $\alpha_1 = -cx_1 - \theta x_1^3$. Here is the derivation, which
also shows which sign errors the three wrong alternatives contain.

**Step 1.** Let $z_1 = x_1$ and $z_2 = x_2 - \alpha_1 = x_2 + cx_1 + \theta x_1^3$.
With $\tilde\theta = \theta - \theta^*$,

$$\dot z_1 = x_2 + \theta^*x_1^3 = z_2 - cz_1 - \tilde\theta x_1^3.$$

For $V_1 = \tfrac12 z_1^2 + \tfrac{1}{2\gamma}\tilde\theta^2$,

$$\dot V_1 = -cz_1^2 + z_1z_2 + \tilde\theta\left(\tfrac{1}{\gamma}\dot\theta - x_1^4\right),$$

which identifies the first tuning function $\tau_1 = \gamma x_1^4$.

**Step 2.** Differentiate $z_2$, using $\theta^* = \theta - \tilde\theta$:

$$\dot z_2 = (x_2 + u) + c(x_2 + \theta^*x_1^3) + \dot\theta x_1^3 + 3\theta x_1^2(x_2 + \theta^*x_1^3)$$
$$= (1+c)x_2 + u + c\theta x_1^3 + \dot\theta x_1^3 + 3\theta x_1^2(x_2+\theta x_1^3) - \tilde\theta\left(cx_1^3 + 3\theta x_1^5\right).$$

Collecting every $\tilde\theta$ term in $\dot V_2 = \dot V_1 + z_2\dot z_2$:

$$\tilde\theta\left[\tfrac{1}{\gamma}\dot\theta - x_1^4 - z_2\left(cx_1^3 + 3\theta x_1^5\right)\right],$$

so the update that cancels the unknown is

$$\dot\theta = \gamma\left(x_1^4 + \left(3\theta x_1^5 + cx_1^3\right)\left(x_2 + \theta x_1^3 + cx_1\right)\right).$$

**The control law.** Requiring $z_2\dot z_2 = -z_1z_2 - cz_2^2$ so that
$\dot V_2 = -cz_1^2 - cz_2^2 \le 0$:

$$u = -x_1 - cz_2 - (1+c)x_2 - c\theta x_1^3 - \dot\theta x_1^3 - 3\theta x_1^2(x_2+\theta x_1^3),$$

and expanding $z_2 = x_2 + cx_1 + \theta x_1^3$:

$$u = -(1+c^2)x_1 - (1+2c)x_2 - \left(2c\theta + \dot\theta\right)x_1^3 - 3\theta x_1^2\left(x_2 + \theta x_1^3\right).$$

That is alternative 1, the ticked one.

Three checks that separate it from the distractors, useful under time pressure:

- The bracket in $\dot\theta$ must be $+(3\theta x_1^5 + cx_1^3)$. It comes from
  $\partial\alpha_1/\partial\theta$ and $\partial\alpha_1/\partial x_1$ entering
  with the same sign. Alternatives 2 and 4 flip it to a minus.
- The $x_2$ coefficient must be $-(1+2c)$. One $c$ comes from $c\dot x_1$ and one
  from $cz_2$. Alternatives 3 and 4 have $+(1+2c)$, the wrong sign, which would
  make the $x_2$ feedback positive.
- $\dot\theta$ appears inside $u$ through $\dot\theta x_1^3$. That is legal, it is
  a known quantity at run time, but it is what makes this the tuning function
  design rather than a certainty equivalence one.

Stability: $\dot V_2 = -c(z_1^2 + z_2^2) \le 0$ gives $z, \tilde\theta \in
\mathcal{L}_\infty$ and $z \in \mathcal{L}_2$, then boundedness of $\dot z$ and
Barbalat give $z \to 0$, hence $x_1 \to 0$ and $x_2 \to 0$. Parameter convergence
again is not claimed.

### Links

- [[README]]
- The room's own solutions for the 12 exercise sets are in
  `materials/Løsninger/`, and exams 2014 to 2021 are listed under
  `materials/Tidligere eksamensoppgaver/` as links to the department pages.
