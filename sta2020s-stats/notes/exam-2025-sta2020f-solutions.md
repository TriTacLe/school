---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, time-series, regression, anova, non-parametric, solutions]
---

# Solutions: STA2020F exam, 9 June 2025

Covers `past-papers/STA2020F Exam 2025.pdf` (17 pages, 100 marks, 180 minutes).
`exam-2025-sta2020f.pdf` in the same folder is a byte-identical copy of it. Every
class test in `past-papers/` ships with a memo; this exam is the only paper that
does not, which is why it is worked here.

Marks: Section A 20, Section B 23, Section C 20, Section D 37.

Three places where the printed paper contradicts itself are flagged in the text
rather than smoothed over. They are in Section B Q1a, Section D ANOVA Q3, and
Section D non-parametric Q5.

---

## Section A: MCQ (20)

### 1. Pearson correlation (2)

`r = 6528 / sqrt(8541 * 7124) = 6528 / 7800.39 = 0.8369`

**Answer: A (0.84).**

### 2. Regression model for a difference in relationship (2)

The researchers want to know whether the *relationship* between height and age
differs by disease status. A difference in relationship is a difference in slope,
which is an interaction between age and disease. Height is the response.

**Answer: E.** Option A allows only a shift in intercept, not a change in slope.
B and C put age on the wrong side. D models disease, not height.

### 3. Which AIC statement is FALSE (2)

Model 4 is fitted to `y^2`, a different response variable, so its likelihood is
computed on a different scale and its AIC is not comparable to the rest.

**Answer: D.** Statement E is the one that is true, which is exactly why D is
false. A (450 to 411), B (426 against 450) and C (450 to 411) all read correctly
off the comparable models.

### 4. Replication (2)

**Answer: B.** Replication means applying the same treatment to several
independent experimental units so that the within-treatment variability can be
estimated. Option D is pseudo-replication, not replication.

### 5. Which ANOVA assumption, and does it hold (2)

`tapply(df$value, df$treatment, sd)` returns standard deviations, so the check is
on homogeneity of variance. T3 has `sd = 5.58` against 1.91 and 2.08, roughly
three times as large, and the T3 box is visibly much wider.

**Answer: B.** A rule of thumb is that the largest sd should be under twice the
smallest; 5.58 against 1.91 fails that comfortably.

### 6. Two-way ANOVA without replication (2)

With one observation per cell there are no degrees of freedom left to separate
interaction from error, so the interaction sum of squares and the residual sum of
squares are the same thing.

**Answer: C.**

### 7. Parametric against non-parametric (2)

**Answer: C.** When normality and equal variance hold, the parametric test uses
the actual values rather than the ranks and so has more power. A overstates the
fragility of parametric tests, B and D are backwards, and E ignores that the
central limit theorem says nothing about the non-parametric test's power.

### 8. Correlogram of monthly magazine subscriptions (2)

The ACF starts near 0.95 and decays slowly while staying well above the
significance bounds for the whole range, which is the signature of a trend. On
top of that decay there are humps peaking around lags 12 and 24, which is
seasonality with a period of 12 months.

- (i) false, there is a trend.
- (ii) **true**, trend and seasonality both.
- (iii) **true**, twelve seasons in a year for monthly data, and `y2` to `y8` is
  lag 6, where the ACF reads about 0.62.
- (iv) false, four seasons would be quarterly data.
- (v) false, seasonality is clearly present.
- (vi) false, a correlogram says nothing about whether a trend is linear.

**Answer: A.**

### 9. Time plot of quarterly letter mail volumes (2)

- (i) **true**, the series falls steadily from about 100 to about 55.
- (ii) false, the data is quarterly, so the season is one year (four quarters),
  not three months.
- (iii) **true**, the mid-1990s show a multi-year wander away from the trend line
  that is too long to be seasonal.
- (iv) false, it denies the cyclicality in (iii). The CMA(4) part of the statement
  is correct, but the statement as a whole is not.
- (v) false, the decline is close to a straight line.

**Answer: D.** Note that (iii) and (iv) contradict each other, which rules out
option E immediately.

### 10. Adjusted seasonal index (2)

Adjusted multiplicative seasonal indices must sum to the number of seasons:

`A = 4 - (1.066568 + 1.000392 + 1.000890) = 4 - 3.067850 = 0.93215`

`1 - 0.93215 = 0.06785`, so the third quarter sits 6.79% below the annual average.

**Answer: D.** E misreads the index itself as the percentage.

---

## Section B: Time series (23)

### Question 1: monthly newspaper subscriptions (16)

#### a) Values B to F (5)

The data is monthly, so `k = 12`. With an even `k` the moving average falls
between two months and has to be centred, which the table does as
`CMA_t = (MA_{t-1} + MA_t) / 2`. This is the only reading under which both B and
C can be recovered from the printed numbers.

**B, the MA(12) at t = 14.** Use `CMA_15 = (MA_14 + MA_15) / 2`:

`97.97 = (B + 97.50) / 2`, so `B = 2(97.97) - 97.50 = 98.44`

**C, the CMA(12) at t = 13.**

`C = (MA_12 + MA_13) / 2 = (97.42 + 97.33) / 2 = 97.375`, so `C = 97.38`

**D, the de-trended value at t = 18.** De-trending divides the observation by the
centred moving average:

`D = Y_18 / CMA_18 = 78 / 95.38 = 0.8178`, so `D = 0.82`

**E, the adjusted seasonal index at t = 20.** Seasonal indices repeat every
period. `t = 20` is month 2 of 1986, and month 2 of 1985 (`t = 8`) carries 0.89.

`E = 0.89`

**F, the seasonally adjusted value at t = 15.** Deseasonalising divides the
observation by its seasonal index:

`F = Y_15 / S_15 = 111 / 1.13 = 98.23`

A warning about F. Every other row where both columns are printed shows the
seasonally adjusted column reproducing the CMA column exactly (t = 12, 16, 17,
18, 19 and 20 match to the decimal, t = 11 differs by 0.01), and none of them
equals `Y_t / S_t`. At `t = 18` for instance the table gives 95.38 while
`78 / 1.00 = 78`. So the printed column was not produced by the definition, and a
marking key built from that column would want `F = CMA_15 = 97.97`. The value
above is the one the method actually gives; both are worth writing down.

#### b) Reading the time plot

**i) Why the series is not stationary (2)**

Stationarity requires the mean, the variance and the autocovariance structure to
be free of `t`. This series fails on all three counts:

- the level falls from roughly 100 in 1985 to roughly 60 by 2005, so the mean
  depends on `t`;
- there is a strong repeating annual pattern, so the covariance between two
  points depends on where in the year they sit, not only on the gap between them;
- the amplitude of the seasonal swings shrinks as the level falls, so the
  variance depends on `t` as well.

**ii) Lag 6 or lag 12 (1)**

**Lag 12 is stronger.** The data is monthly with an annual season, so a point is
most like the same month one year earlier. Lag 6 compares a seasonal peak with a
seasonal trough half a year away, which weakens rather than strengthens the
correlation.

**iii) Best long-term simple forecasting method (1)**

**The drift method.** Of the four simple methods (mean, naive, seasonal naive,
drift) it is the only one that extrapolates the downward slope. Mean and naive
give a flat forecast, and seasonal naive repeats the last year unchanged, so all
three ignore a trend that has run for two decades and will be badly biased five
years out.

#### c) Comparing MOD1 and MOD2

**i) What MOD2 is (1)**

**Holt-Winters** exponential smoothing, with both a trend and a seasonal
component. Its three point forecasts move up and down (52.44, 49.90, 51.45),
which simple exponential smoothing and Holt's linear method cannot do since
neither carries a seasonal term. Given that the seasonal amplitude shrinks with
the level, the multiplicative version is the natural one.

MOD1 is the drift method from part b iii): its forecasts fall by a constant
0.22284 each month.

**ii) 80% prediction interval for the first test-set forecast (1)**

`57.37503 ± 1.28 * 0.7052 = 57.37503 ± 0.9027`

**(56.47, 58.28).**

**iii) Preferred model (1)**

**MOD2.** Every test-set accuracy measure favours it: RMSE 3.78 against 4.46, MAE
3.18 against 3.67, MAPE 5.83 against 6.53 and MASE 0.41 against 0.48. The test
set is the right place to look, since it is the part of the data neither model
was fitted to.

#### d) Residual diagnostics for MOD2 (4)

Four things to check, and this set passes all four:

1. **Zero mean.** The residual plot scatters around 0 with no drift, and the
   training-set ME is -0.38, close to zero. Forecasts are therefore roughly
   unbiased.
2. **Constant variance.** The spread is fairly even across the whole plot, with a
   little more movement in the mid-1980s. Nothing serious.
3. **No autocorrelation.** Every spike in the residual ACF stays inside the
   significance bounds. The Ljung-Box test confirms it: `Q* = 20.794` on 24
   degrees of freedom gives `p = 0.6508`, far above 0.05, so there is no evidence
   against the null of no autocorrelation up to lag 24.
4. **Normality.** The histogram is roughly symmetric and bell-shaped against the
   fitted normal curve, with a slight right tail.

Conclusion: the residuals behave like white noise, so MOD2 has extracted the
usable structure and its prediction intervals can be trusted.

(The residual plot is on a scale of about ±0.2 while the reported training RMSE is
6.57, so those two outputs are not on the same scale. It does not change any of
the four readings above.)

### Question 2: ARIMA on quarterly global surface temperatures (7)

#### a) The AR(p) part (1)

AR(p) is the autoregressive part: the current value is modelled as a linear
combination of its own `p` previous values plus white noise,

`y_t = c + phi_1 y_{t-1} + ... + phi_p y_{t-p} + e_t`

so the series is regressed on lagged versions of itself. In an ARIMA(p,d,q) the
regression is on the `d`-times differenced series, not the raw one.

#### b) The transformation (1)

**First-order differencing, `d = 1`.** The Box-Cox `lambda = 1.0006` is
effectively 1, which means no power transformation was needed. The y-axis of the
transformed plot reads "Change in degrees Celsius" and the series now varies
around a constant zero level with no trend, which is exactly what taking
`y_t - y_{t-1}` does to a trending series.

#### c) Model suggested by the ACF and PACF (3)

On the differenced series the ACF has a large positive spike at lag 1 (about
0.48), significant negative values at lags 2 and 3, and then falls inside the
bounds, so it cuts off after about lag 3. The PACF has a large spike at lag 1, a
large negative one at lag 3, a smaller one at lag 4 and then tails away with
alternating signs.

An ACF that cuts off with a PACF that tails off points to a **pure moving average
model on the differenced series, ARIMA(0,1,3) or ARIMA(0,1,4)** depending on
whether lag 4 is counted as significant. The paper's Model Y is ARIMA(0,1,4), so
the examiners read it the same way.

Both special cases are worth stating explicitly: ARIMA(p,d,0) is AR, recognised
by a PACF that cuts off and an ACF that tails off, and ARIMA(0,d,q) is MA, which
is the mirror image and the case here.

#### d) Best fitted model (2)

| Model | Fitted | AIC |
|-------|--------|-----|
| X | ARIMA(2,1,2) | 623.14 |
| Y | ARIMA(0,1,4) | 627.06 |
| Z | ARIMA(4,1,4) | 631.79 |

Read the orders off the coefficient names: X has `ar1, ar2, ma1, ma2`, Y has
`ma1` to `ma4` only, and Z has `ar1` to `ar4` plus `ma1` to `ma4`. All three
carry `d = 1`.

**Model X, an ARIMA(2,1,2), is the best.** It has the lowest AIC (623.14) and the
lowest AICc (623.45) and BIC (639.61) where those are reported. Since all three
were fitted to the same differenced series with the same `d`, AIC is comparable
across them. Model Z illustrates the penalty at work: it has the highest
likelihood (-305.89) but eight coefficients, most with standard errors larger
than the estimates themselves, so it is over-fitted.

---

## Section C: Regression (20)

### Question 1 (6)

**a) What is `e_i` and why is it there (2)**

`e_i` is the random error term, the vertical distance between the observed `y_i`
and the population regression line `beta_0 + beta_1 x_i`. It is there because the
relationship between `x` and `y` is statistical, not deterministic: the response
is also affected by variables not in the model and by measurement error, so no
straight line passes through every point. It is the error term that lets us treat
`y` as a random variable and carry out inference on the slope.

**b) Coefficient of determination (1)**

`R^2` is the proportion of the total variation in the response that the fitted
linear relationship with `x` explains, `R^2 = SSR/SST = 1 - SSE/SST`.

**c) Assumptions about the residuals (3)**

1. **Normality**: the errors are normally distributed.
2. **Constant variance**: the spread of the errors does not depend on the fitted
   value or on `x` (homoscedasticity).
3. **Independence**: the errors are independent of one another, with mean zero.

In practice these are checked with a normal Q-Q plot, a residuals-against-fitted
plot and, for ordered data, a residual sequence plot.

### Question 2: predicting units produced (8)

**a) Which variable looks like a good predictor (2)**

**`workers`.** Its correlation with `units` is 0.667, a fairly strong positive
linear association, while `temperature` manages only 0.131, which is close to no
linear relationship at all. `workers` and `temperature` correlate at 0.056, so
there is no collinearity problem between them either.

`time` does not appear in the matrix because it is categorical (morning or
afternoon), and a Pearson correlation is not defined for it.

**b) Are the model-building results consistent (2)**

**Yes, and they add something the matrix could not give.**

- `workers` is retained at every step, and dropping it would push the AIC from
  137.79 to 152.25. That matches the strong correlation of 0.667.
- `temperature` is the first variable removed, and removing it *improves* the AIC
  from 139.30 to 137.79. That matches its correlation of 0.131.
- `time` is retained (dropping it would raise the AIC from 137.79 to 139.23) even
  though it never appeared in the correlation matrix. There is no contradiction:
  the matrix simply could not assess a categorical variable, so backward
  selection is the first evidence we have about it.

**c) AIC of the best model (1)**

**137.79**, the AIC of `units ~ workers + time`. The second step confirms it is
the best because `<none>` sits at the top of that table, so no further removal
improves the AIC.

**d) Hypothesis test for `beta_temperature` (3)**

`H0: beta_temperature = 0` against `H1: beta_temperature != 0`, at 5%.

From the full-model output the test statistic is `t = 0.2612 / 0.4001 = 0.653` on
`n - k - 1 = 30 - 3 - 1 = 26` degrees of freedom, with `p = 0.5195`.

Since `p = 0.5195 > 0.05`, do not reject `H0`. There is no evidence that ambient
temperature is linearly related to the number of units produced once the number
of workers and the time of day are already in the model. That is consistent with
backward selection dropping it first.

### Question 3: logistic regression on notification clicks (6)

**a) Interpreting the `Last_interaction` coefficient in terms of odds (2)**

`exp(-0.02610) = 0.9742`.

For each additional hour since the user's last app interaction, the odds of
clicking the notification are multiplied by 0.974, a decrease of about 2.6%,
holding the time of day fixed. Note that with `p = 0.2531` this effect is not
statistically significant at 5%, so the sample gives no firm evidence that the
effect is real.

**b) 95% confidence interval for the Time coefficient on the log-odds scale (2)**

`1.39202 ± 1.96 * 0.65778 = 1.39202 ± 1.28925`

**(0.1028, 2.6813).**

The interval excludes zero, which agrees with the significant `p = 0.0343`.
Exponentiating gives an odds ratio interval of (1.11, 14.61): notifications sent
after work hours are associated with higher odds of a click than those sent
during work hours.

**c) Appropriate variable types (2)**

The **dependent variable must be binary**, taking two categories coded 0 and 1
(here click or no click). The **independent variables may be of any type**:
continuous (`Last_interaction`), or categorical, with categorical predictors
entered as dummy variables (`Time`, entered as `TimeAfterWork` against the
`TimeDuringWork` baseline).

---

## Section D: ANOVA and non-parametric tests (37)

### ANOVA Question 1: fat retained in fried potato (5)

**a) Interaction plot (3)**

Oil type on the x-axis in the order sunflower, olive, coconut; mean fat retained
on the y-axis, running from about 5 to about 14 g per 100 g; one line per cooking
method, both labelled.

| Oil type | Air fryer | Deep fryer |
|----------|-----------|------------|
| Sunflower | 7.05 | 11.60 |
| Olive | 6.40 | 5.55 |
| Coconut | 7.40 | 13.35 |

The air fryer line is almost flat, drifting from 7.05 down to 6.40 and back up to
7.40. The deep fryer line drops steeply from 11.60 to 5.55 and then climbs to
13.35, crossing below the air fryer line at olive oil.

**b) Is there an interaction (1)**

**Yes.** The two lines are nowhere near parallel and they cross, which is as
strong a visual signal of interaction as this kind of plot gives.

**c) What an interaction means here (1)**

The effect of the cooking method on fat retention depends on which oil is used.
Deep frying adds a lot of fat with sunflower (+4.55 g) and coconut (+5.95 g) but
slightly *reduces* it with olive oil (-0.85 g), so there is no single statement
of the form "deep frying adds so many grams" that holds across all three oils.

### ANOVA Question 2: discount type and first-order spend (5)

**a) Hypotheses (1)**

`H0: mu_flat = mu_percentage = mu_freedelivery` (the mean amount spent is the same
for all three discount types)

`H1: at least one mean differs from the others.`

**b) p-value from an F table (2)**

The test statistic is `F = 66.54` with **2 numerator degrees of freedom** (3
treatments minus 1) and **12 denominator degrees of freedom** (15 observations
minus 3 treatments), read straight off the Df column of the output.

From the F tables, the critical values at `F(2, 12)` are 3.89 at 5%, 6.93 at 1%
and 12.97 at 0.1%. Since 66.54 is far beyond even the 0.1% value,

**p < 0.001.**

**c) Decision and conclusion (2)**

`p < 0.001 < 0.05`, so reject `H0`.

At the 5% level there is very strong evidence that the mean first-order spend
differs between at least two of the three discount types. A post-hoc test such as
Tukey's HSD would be needed to say which pairs differ.

### ANOVA Question 3: Instagram content formats (10)

**a) Identifying the parts (2)**

- **Treatment factor:** content type (one factor). Day is a *blocking* factor, not
  a treatment factor.
- **Treatments:** the three formats, Feed Post, Story and Reel.
- **Response:** number of link clicks (taps on the install link) within 24 hours.
- **Number of replicates:** 4, one per format per day, giving `3 x 4 = 12`
  observations.

**b) Treatment structure and randomisation (1)**

The treatment structure is a **single factor with three levels**. Randomisation
is **restricted**: the three formats are randomly assigned within each day, so
every day carries a complete set of all three treatments and randomisation
happens inside blocks rather than across all twelve units.

**c) Type of design (1)**

A **randomised complete block design (RCBD)**, with day as the block.

**d) Population model (1)**

`y_ij = mu + tau_i + beta_j + e_ij`

- `y_ij` is the number of clicks for content type `i` on day `j`
- `mu` is the overall mean number of clicks
- `tau_i` is the effect of the `i`-th content type, `i = 1, 2, 3`
- `beta_j` is the effect of the `j`-th day (block), `j = 1, ..., 4`
- `e_ij` is the random error, assumed independent and `N(0, sigma^2)`

**e) Standard error of a treatment mean (1)**

`SE = sqrt(MS_E / r)` where `r = 4` is the number of blocks.

The paper calls 0.25 the "residual sum of squares", but the two F values it gives
only work if 0.25 is the residual **mean square**. Check it against the data:
`SS_day = 49.00` on 3 df gives `MS_day = 16.333`, and `16.333 / 0.25 = 65.33`,
exactly the stated F for Day. Likewise `SS_content = 1275.17` on 2 df gives
`MS_content = 637.58`, and `637.58 / 0.25 = 2550.3`, the stated F for Content
Type. (The true residual sum of squares is 1.50 on 6 df, which is a mean square of
0.2495. So 0.25 is the mean square, rounded.)

Taking `MS_E = 0.25`:

`SE = sqrt(0.25 / 4) = sqrt(0.0625) = 0.25`

If the number is instead read literally as a sum of squares, `MS_E = 0.25/6 =
0.0417` and `SE = 0.10`. The first reading is the one consistent with the rest of
the question.

**f) Experimental unit (2)**

The **audience segment that receives one format on one day**. It is the smallest
unit to which a treatment is independently applied, and there are twelve of them.
The individual user is not the experimental unit, because users were not
randomised one at a time; they arrived already grouped into a segment, and the
response was recorded per segment.

**g) Was running over multiple days necessary (2)**

**Yes.** Two reasons:

1. The team expected engagement to vary by weekday, and the data bears that out:
   `F = 65.33` for Day on (3, 6) degrees of freedom is far past the 5% critical
   value of 4.76, so day-to-day variation is real and large.
2. Because that variation is pulled out into the block term, it leaves the
   residual mean square instead of inflating it. Running everything on a single
   day would have given no replication at all, and running all twelve segments on
   one day without blocking would have confounded day effects with format
   effects.

### Non-parametric Question 4: wait times at three branches (8)

**a) i) Why a parametric test is not appropriate (1)**

Two assumptions fail at once. The histograms are strongly right-skewed rather
than symmetric, so normality does not hold, and Branch C carries extreme values
out to 50 minutes. The standard deviations are 2.1, 3.9 and 11.5, so the largest
is more than five times the smallest and the equal-variance assumption fails too.

**a) ii) The parametric test that would otherwise be used (1)**

**One-way ANOVA** (a one-factor F test comparing three independent group means).

**b) Appropriate non-parametric test (2)**

The **Kruskal-Wallis test**. Beyond the failed assumptions, it fits the design:
three independent samples, one grouping factor, and a response that can be
ranked. It works on ranks, so the extreme Branch C values pull much less weight
than they would on the original scale, and it needs only that the three
distributions have a similar shape.

**c) Hypotheses (1)**

`H0: the median wait time is the same at all three branches` (the three
distributions are identical)

`H1: at least one branch has a different median wait time.`

**d) Distribution of the test statistic (1)**

Approximately **chi-square with `k - 1 = 2` degrees of freedom**, valid because
each sample is reasonably large.

**e) Interpretation at 5% (2)**

`p = 0.0405 < 0.05`, so reject `H0`.

At the 5% level there is evidence that median customer wait times differ across
at least two of the three branches. Looking at the summaries, Branch B (mean 14.3)
is the slowest and Branch A (mean 10.4) the fastest, so that is the likely pair,
though a post-hoc pairwise comparison (Dunn's test) would be needed to confirm it.

(The stem says 20 customers per branch while the table says 30. It does not change
the test, the degrees of freedom or the conclusion.)

### Non-parametric Question 5: noise-cancelling headphones (9)

**a) Type of data and relationship between samples (1)**

The response is a test score out of 30, so the data is numerical but discrete and
bounded. The two samples are **paired (dependent)**: the same ten workers are
measured under both conditions, so each observation in one sample has a natural
partner in the other.

**b) Appropriate non-parametric test (1)**

The **Wilcoxon signed-rank test**, the paired-sample test that works on the ranks
of the within-pair differences.

**c) Why non-parametric (1)**

Only ten pairs, which is far too few to check the normality of the differences
with any confidence and too few to lean on the central limit theorem. Scores out
of 30 are also bounded and discrete, so a normal model for the differences is
questionable from the start.

**d) The test (6)**

**Hypotheses (1).** Let `M_d` be the population median of the differences
(with headphones minus without):

`H0: M_d = 0` (headphones make no difference to focus)

`H1: M_d != 0` (headphones change the score)

A one-sided `H1: M_d > 0` is defensible if the company only cares about
improvement; state whichever you use, because it changes the p-value by a factor
of two.

**Steps for the statistic (3).**

1. Form the differences `d_i` = with minus without:
   `3, 2, 0, 2, 1, 3, -1, 3, 2, 2`
2. Discard any zero difference. The third pair (24 and 24) drops out, leaving
   `n = 9`.
3. Rank the absolute differences from smallest to largest, using average ranks
   for ties. The two 1s share ranks 1 and 2, so both get 1.5; the four 2s share
   ranks 3 to 6, so each gets 4.5; the three 3s share ranks 7 to 9, so each gets
   8.
4. Sum the ranks carrying a positive sign and those carrying a negative sign:
   `W+ = 1.5 + 4(4.5) + 3(8) = 43.5` and `W- = 1.5`. As a check,
   `W+ + W- = 45 = n(n+1)/2`.
5. Standardise, since `n` is on the edge of the normal approximation:
   `E[W+] = n(n+1)/4 = 22.5` and
   `sd = sqrt(n(n+1)(2n+1)/24) = sqrt(71.25) = 8.44`, giving
   `z = (43.5 - 22.5) / 8.44 = 2.49`.
6. Convert to a p-value: `p = 2(1 - 0.9936) = 0.013` two-sided.

Using the standardised value the paper supplies, `z = 2.58`, the same step gives
`p = 2(1 - 0.99506) = 0.0099`.

The paper's stated test statistic of 58 cannot be reproduced from this data. The
maximum possible value of `W+` with `n = 9` is 45, and keeping the zero pair
(`n = 10`) caps it at 55. Its standardised value of 2.58 is close to the 2.49 that
the ranks actually give, and both land in the same place, so the conclusion below
holds either way.

**Decision and conclusion (2).**

`p = 0.0099 (or 0.013) < 0.05`, so reject `H0`.

At the 5% level there is evidence that noise-cancelling headphones change logic
test scores, and since eight of the nine non-zero differences are positive, the
change is an improvement. The practical size is modest: the median difference is
2 points out of 30.
