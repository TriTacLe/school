---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course, test-prep]
summary: Notation key, formula sheet audit, and worked marking for the 2026 F practice paper.
---
Companion to [[ct1-2026-f-questions]]. Read in Obsidian so the maths renders.

# Notation, so nothing else is confusing

| Symbol | Means | Value in Section 1 Q1 |
| --- | --- | --- |
| $n$ | number of observations (rows of data) | 50 |
| $p$ | number of **independent variables** in the model | 1 |
| $y_i$ | observed value of the response for observation $i$ | |
| $\hat{y}_i$ | value the model predicts for observation $i$ | |
| $e_i$ | residual, $e_i = y_i - \hat{y}_i$ | |
| $\bar{y}$ | mean of all the observed $y$ values | |

## Why $p = 1$ in simple linear regression

$p$ counts the $x$ variables on the right-hand side. Nothing else.

$$\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_{i,1} + \hat{\beta}_2 x_{i,2} + \cdots + \hat{\beta}_p x_{i,p}$$

- **Simple** linear regression has exactly one $x$, so $p = 1$.
- The Fresh model `demand ~ fresh_price + ads_expenditure + competitor_price` has three, so $p = 3$.
- The intercept $\hat{\beta}_0$ is **never** counted in $p$.
- **Dummy variables count individually.** A categorical variable with 3 levels adds 2 dummies, so it adds 2 to $p$.

This matters because residual degrees of freedom are always

$$df = n - p - 1$$

For SLR, $p = 1$, so $df = n - 1 - 1 = n - 2$. That is where the familiar $n-2$ comes from. It is not a separate rule.

For Q1: $df = 50 - 1 - 1 = 48$.

## The three sums of squares

Yes, $SSE$ is the sum of squared errors. It is the same object as $\sum e_i^2$.

$$SSE = \sum_{i=1}^{n}(y_i - \hat{y}_i)^2 = \sum_{i=1}^{n} e_i^2 \qquad \text{variation the model did NOT explain}$$

$$SSR = \sum_{i=1}^{n}(\hat{y}_i - \bar{y})^2 \qquad \text{variation the model DID explain}$$

$$SST = \sum_{i=1}^{n}(y_i - \bar{y})^2 \qquad \text{total variation in } y$$

They add up:

$$SST = SSR + SSE$$

Naming trap. All of these are the same number:

$$SSE \;=\; SS_{resid} \;=\; SS_{residual} \;=\; \sum e_i^2$$

So when Q1 handed you $\sum_{i=1}^{n} e_i^2 = 602$, it handed you $SSE = 602$. That is the whole trick of part (c).

# Formula sheet audit

## Already printed on the sheet

$$SSR = \sum (\hat{y}_i - \bar{y})^2 \qquad SSE = \sum (y_i - \hat{y}_i)^2 \qquad SST = \sum (y_i - \bar{y})^2$$

$$r_{xy} = \frac{SS_{xy}}{\sqrt{SS_x SS_y}}$$

$$s_{\beta_1} = \frac{s_\varepsilon}{\sqrt{SS_x}}$$

$$\text{CI for } \beta_j: \quad \hat{\beta}_j \pm t_{\frac{\alpha}{2},\, n-p-1} \; s_{\beta_j}$$

$$s_\varepsilon = \sqrt{MSE} = \sqrt{\frac{SSE}{n-p-1}}$$

$$R^2 = \frac{SSR}{SST} = 1 - \frac{SSE}{SST} \qquad R^2_{adj} = 1 - \frac{n-1}{n-p-1}\cdot\frac{SSE}{SST}$$

$$R^2_{partial} = \frac{SSE_{reduced} - SSE_{full}}{SSE_{reduced}} \qquad F_{partial} = \frac{(SSE_{reduced} - SSE_{full})/r}{SSE_{full}/(n-p-1)}$$

$$\text{logit}(p) = \log\left(\frac{p}{1-p}\right) \qquad p = \frac{1}{1 + e^{-(\beta_0 + \beta_1 x + \cdots)}}$$

Plus the full CI and PI formulas for $Y | x_g$.

Note the sheet says **"standard error of estimate"** and puts it under MULTIPLE REGRESSION. That is the residual standard error. Same thing. This is why you could not find it.

$$\text{RSE} \;=\; s_\varepsilon \;=\; \sqrt{MSE} \;=\; \text{standard error of estimate}$$

## NOT on the sheet, memorise these

$$t = \frac{\hat{\beta}_j}{se(\hat{\beta}_j)} \sim t_{n-p-1} \qquad \text{coefficient significance test}$$

$$F = \frac{MSR}{MSE} \sim F_{p,\; n-p-1} \qquad \text{overall model test, and } F = t^2 \text{ in SLR}$$

$$R^2 = r^2 \qquad \textbf{simple linear regression only}$$

$$\hat{\beta}_1 = \frac{SS_{xy}}{SS_x} = r\cdot\frac{s_y}{s_x} \qquad \hat{\beta}_0 = \bar{y} - \hat{\beta}_1 \bar{x}$$

$$t = \frac{r\sqrt{n-2}}{\sqrt{1-r^2}} \sim t_{n-2} \qquad \text{correlation significance test}$$

$$\text{odds} = e^{LO} \qquad \text{odds ratio} = e^{\beta} \qquad df = n - p - 1$$

Logistic coefficient tests use $z$, not $t$.

# Confidence level to alpha

The single most common cheap mistake.

| Stated level | $1-\alpha$ | $\alpha$ | $\alpha/2$ | Table column to read |
| --- | --- | --- | --- | --- |
| 90% | 0.90 | 0.10 | 0.05 | **0.05** |
| 95% | 0.95 | 0.05 | 0.025 | **0.025** |
| 99% | 0.99 | 0.01 | 0.005 | **0.005** |

Lower bound uses $-$, upper bound uses $+$. A lower bound is always the smaller number.

# Section 1, Question 1 worked

Given $n = 50$, $\hat{y}_i = 5.7 - 0.4x_i$, $r = -0.7$, $\sum e_i^2 = 602$, $se(\hat{\beta}_1) = 0.13$.

## a) Coefficient of determination

$$R^2 = r^2 = (-0.7)^2 = 0.49$$

## b) Predicted $y$ at $x = 5$

$$\hat{y} = 5.7 - 0.4(5) = 5.7 - 2 = 3.7$$

## c) Residual standard error

$\sum e_i^2 = SSE = 602$, and $df = n - p - 1 = 50 - 1 - 1 = 48$.

$$RSE = \sqrt{\frac{SSE}{n-2}} = \sqrt{\frac{602}{48}} = \sqrt{12.5417} = 3.54$$

## d) Lower bound of the 90% CI for the slope

90% means $\alpha = 0.10$, so $\alpha/2 = 0.05$. Look up $t_{0.05,\,48} = 1.677$.

$$\hat{\beta}_1 - t_{\frac{\alpha}{2},\,n-2}\; se(\hat{\beta}_1) = -0.4 - 1.677 \times 0.13 = -0.62$$

## e) Test statistic for the slope

$$t = \frac{\hat{\beta}_1}{se(\hat{\beta}_1)} = \frac{-0.4}{0.13} = -3.08$$

With $df = 48$. Not on the formula sheet.
