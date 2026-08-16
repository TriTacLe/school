---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/lectures/week-01/STA2020___Simple_Linear_Regression.pdf|main deck]], [[materials/lectures/week-01/STA2020_MINDMAP_Final.pdf|mind map]], [[materials/lectures/week-01/L1_Annotated.pdf|L1-L4 annotated]], [[practice/slr-practice.pdf|practice set]].
## Simple Linear Regression
Page refs: (pNN) = PDF page in [[materials/lectures/week-01/STA2020___Simple_Linear_Regression.pdf|main deck]] (51 slides).
### Recap of Foundational Concepts 
**Population versus sample (p4)**
- Population: full group of interest; sample: subset actually measured
- Parameter: numerical descriptor for a population
- Statistic: numerical descriptor for a sample
- Sample statistics approximate population parameters

**Statistical inference (p5)**
- Statistical inference: Attempt to reach conclusions about a complete set (population) using only a subset (sample). Process:
	1. Point estimates: $\bar{x}, s²$
	2. CI: range of plausible values
	3. Hypothesis testing
- Sample must be representative of the population to make accurate inference
- Conducted using hypothesis testing and sampling distributions ($\bar{x}\sim N(\mu,\frac{\sigma²}{n})$=

**Hypothesis testing**
Hypothesis testing: Allows statements about a population from a sample
1. Define null hypothesis ($H_0$), the hypothesis of no statistical significance
2. Define alternative hypothesis ($H_a$), the hypothesis of statistical significance
3. Define significance level ($\alpha$), the type one error rate (probability of falsely rejecting $H_0$. Typically $\alpha = 0.05$ or $\alpha = 0.01$
4. Calculate test statistic (depends on the test being conducted)
5. Find p-value, the probability of getting a result as or more extreme than the observed test statistic, assuming $H_0$ is true
6. Draw conclusion. If p-value $\le \alpha$, reject $H_0$ and conclude statistical significance. Otherwise, fail to reject $H_0$
### The Problem We Want to Solve 
**Describing the relationship between two variables (p8)**
- How strong is the relationship? (quantify it)
- Is this observed relationship likely real or just due to chance?
- Can we explain the impact of changing one variable on another?
- Can we predict the value of one variable from another?
### Example Problem: Lecture Attendance (p9-10)
**Slide: Lecture attendance example (p10)**
Data: 20 students with number of lectures attended and overall course marks recorded.
- Scatter plot shows positive relationship between lectures attended and marks
- Students who attended more lectures achieved higher marks
### Correlation Analysis (p11-21)
**Correlation as a method to solve our problem**
Correlation measures strength and direction of a linear relationship between two variables.
- Bounded between -1 and 1
- Has no unit
- Cannot predict one variable from another

**Correlation coefficient**
Correlation measured using correlation coefficient (typically Pearson correlation coefficient).
- Population correlation coefficient ($\rho$): measures direction and strength for full set of two variables
- Sample correlation coefficient ($r$): estimate of $\rho$ and measures the diretion and strength of the association between two variables in a sample

$$r = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum (x_i - \bar{x})^2 \sum (y_i - \bar{y})^2}} = \frac{SS_{xy}}{\sqrt{SS_x SS_y}}$$

- $r \in [-1, 1]$. Sign gives direction, magnitude gives strength
- Rough guide: $|r| < 0.3$ weak, $0.3$ to $0.7$ moderate, $> 0.7$ strong

**Correlation analysis with our example**
For lecture attendance data ($n = 20$):
- $\bar{x} = 33.8$, $\bar{y} = 58$
- $SS_{xy} = 4280$, $SS_x = 2345.2$, $SS_y = 8660$
$$r = \frac{4280}{\sqrt{2345.2 \times 8660}} = 0.95$$
Strong positive correlation between lectures attended and marks.

**Slide: Example in R (p17)**
```R
x <- lectures
y <- marks
# calculate means
xbar <- mean(x)
ybar <- mean(y)
# calculate sum of squares
SSxy <- sum((x-xbar)*(y-ybar))
SSx <- sum((x-xbar)^2)
SSy <- sum((y-ybar)^2)
# calculate correlation
(r <- SSxy/sqrt(SSx*SSy))
## [1] 0.9497185

# confirm with base R
cor(x,y)
## [1] 0.9497185
```

**Inference on correlation coefficient (is it significant?)**
Is the correlation significant in the population?
- Step 1 $H_0: \rho = 0$ (no linear correlation)
- Step 2 $H_a: \rho \neq 0$
- Step 3 $\alpha = 0.05$
- Step 4 Test statistic: $$t = \frac{r\sqrt{n-2}}{\sqrt{1-r^2}} \sim t_{n-2}$$
- Example: $$t = \frac{0.9497185 \times \sqrt{20-2}}{\sqrt{1 - 0.9497185^2}} = 12.87 \sim t_{18}$$

**Step 5: Find the p-value**
```R
# Using calculated t-stat by hand
2*pt(q=12.87, df=18, lower.tail=F)
## [1] 1.622399e-10

# Using cor.test()
cor.test(x, y)
## Pearson's product-moment correlation
## data: x and y
## t = 12.869, df = 18, p-value = 1.625e-10
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
## 0.8748863 0.9802637
## sample estimates:
## cor = 0.9497185
```

**Step 6: Make a conclusion**
- p-value ($1.625 \times 10^{-10}$) is sufficiently small to reject $H_0$ (p-value < 0.05)
- Conclude there is significant linear relationship between course marks and number of lectures attended

**Limitations of correlation analysis (p21)**
Correlation analysis answers two of the four questions:
- How strong is the relationship? Yes
- Is this observed relationship likely real or due to chance? Yes
- Can we explain the impact of changing one variable on another? No
- Can we predict the value of one variable from another? No

### Simple Linear Regression (SLR) 
**Simple linear regression as a method to solve our problem**
Different from correlation analysis in that:
- There is a *dependent variable* (one we want to explain) and *independent variable* (used to explain)
- Allows explaining the impact of changing the independent variable on the dependent variable
- Allows predicting the dependent variable from the independent variable (if model fit is good)

**Simple linear regression model**
Population model:
$$y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$$

Sample (fitted) model:
$$\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_i$$

Where:
- $i$ refers to a specific observation
- $\beta_0$ is the intercept parameter
- $\beta_1$ is the slope parameter
- $\varepsilon_i$ is the error (accounts for variability not explained by independent variable)
- $\hat{y}_i$ is the predicted value of dependent variable
- $\hat{\beta}_0$ is estimated regression intercept
- $\hat{\beta}_1$ is estimated regression slope
- Assume $E[\varepsilon_i] = 0$ and $\varepsilon_i \sim N(0, \sigma^2)$

**Estimating the $\beta$ parameters**
Algorithm used to find optimal values of $\beta_1$ and $\beta_0$: Ordinary Least Squares (OLS) minimizes sum of squared error terms:
$$\text{Minimize } \sum_{i=1}^{n} \varepsilon_i^2$$
Where: $$\varepsilon_i = y_i - \hat{y}_i$$
So:$$\sum_{i=1}^{n} \varepsilon_i^2 = \sum_{i=1}^{n} [y_i - (\hat{\beta}_0 + \hat{\beta}_1 x_i)]^2$$
Optimal $\beta$ values minimize this sum. Formulas:
$$\hat{\beta}_1 = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sum (x_i - \bar{x})^2} = r \cdot \frac{s_y}{s_x}$$
$$\hat{\beta}_0 = \bar{y} - \hat{\beta}_1 \bar{x}$$
The least squares line always passes through $(\bar{x}, \bar{y})$.

**Performing linear regression in R**
```R
fit <- lm(marks ~ lectures)
summary(fit)
## Call:
## lm(formula = marks ~ lectures)
##
## Residuals:
## Min 1Q Median 3Q Max
## -11.590 -5.215 -0.240 4.348 11.335
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) -3.6851 5.0333 -0.732 0.474
## lectures 1.8250 0.1418 12.869 1.62e-10 ***
## ---
## Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 6.868 on 18 degrees of freedom
## Multiple R-squared: 0.902, Adjusted R-squared: 0.8965
## F-statistic: 165.6 on 1 and 18 DF, p-value: 1.625e-10
```

Regression equation for example:$$\hat{y} = \hat{\beta}_0 + \hat{\beta}_1(\text{lectures})$$$$\hat{y} = -3.6851 + 1.8250(\text{lectures})$$
**Interpretation of beta coefficients (p29)**
- **Intercept $\hat{\beta}_0$**: average estimated value of $y$ when $x = 0$. Only meaningful if $x = 0$ is inside data range.
- **Slope $\hat{\beta}_1$**: average estimated change in $y$ for a unit increase in $x$. Positive sign means increase, negative means decrease.

For example:
- $\hat{\beta}_0 = -3.6851$: on average, student mark is -3.6851 when attending no lectures (not contextually practical as mark cannot be negative)
- $\hat{\beta}_1 = 1.8250$: on average, student marks increase by 1.825 for each additional lecture attended

**Assessing the accuracy of the model**
Residual Standard Error (RSE) measures *standard deviation* of model residuals, the average amount response deviates from regression line:
$$RSE = \sqrt{\frac{\sum_{i=1}^{n} \varepsilon_i^2}{n-2}}$$
- Higher RSE: larger scatter around regression line, poorer fit
- Lower RSE: tighter scatter, better fit

For example: $RSE = 6.868$. Typical distance of observations from fitted line is about 6.87 marks.

**Assessing the accuracy of the $\beta$ estimates**
*Standard error (SE)* of an estimate indicates how different the population estimate is likely from the sample estimate.
$$SE(\hat{\beta}_1) = \frac{RSE}{\sqrt{\sum (x_i - \bar{x})^2}} = \frac{RSE}{\sqrt{SS_x}}$$

- Smaller $SE(\hat{\beta}_1)$: more precise estimate
- Larger SE relative to estimate size: indication that estimate may not accurately reflect true population parameter
- More spread in $x$ and lower RSE both shrink standard error

**Testing the significance of $\beta_1$ estimate**
Usually interested in significance of slope ($\beta_1$), which tells whether there is a relationship between independent and dependent variables.
- **Step 1:** $H_0: \beta_1 = 0$ (no linear relationship)
- **Step 2:** $H_a: \beta_1 \neq 0$ (two sided)
- **Step 3:** Define the signifiance level $\alpha = 0.05$
- **Step 4:** Test statistic: $$t = \frac{\hat{\beta}_1 - \beta_1}{SE(\hat{\beta}_1)} = \frac{\hat{\beta}_1}{SE(\hat{\beta}_1)} \sim t_{n-2}$$
- Example: $$t = \frac{1.825}{0.1418} = 12.87 \sim t_{18}$$
- **Step 5:** Find the p-value 
```R
# Using t-stat calculated by hand
2*pt(q=12.87, df=18, lower.tail=F)
## [1] 1.622399e-10

# Using lm() output
fit <- lm(marks ~ lectures)
summary(fit)
## ... (output shows t = 12.869, Pr(>|t|) = 1.62e-10)
```

- **Step 6:** Make a conclusion
p-value ($1.625 \times 10^{-10}$) is sufficiently small to reject $H_0$ (p-value < 0.05). Conclude there is significant linear relationship between course marks and number of lectures attended.

**Confidence intervals for $\beta$ estimates**
Confidence interval (CI) gives range of values we are relatively sure that true $\beta$ parameters fall into (with given confidence level):
$$CI = \hat{\beta}_j \pm t_{\alpha/2, n-2} \times SE(\hat{\beta}_j)$$

For 95% CI on $\hat{\beta}_1$ (slope):
$$CI = 1.825 \pm 2.101 \times 0.1418$$
$$CI = [1.527, 2.123]$$

In R:
```R
confint(fit)
## 2.5 % 97.5 %
## (Intercept) -14.259806 6.889518
## lectures 1.527061 2.122947
```

Important: do not interpret CI as 95% probability that parameter is within interval. Really means if we resample population, 95% of estimates will be within interval.

**Checking overall model significance**
Assess whether model is significantly different from null model (intercept only). Use F-statistic and ANOVA table:

| Source     | df    | SS                                   | Mean Square       | F         |
| ---------- | ----- | ------------------------------------ | ----------------- | --------- |
| Regression | 1     | $SSR = \sum (\hat{y}_i - \bar{y})^2$ | $MSR = SSR/1$     | $MSR/MSE$ |
| Residual   | $n-2$ | $SSE = \sum (y_i - \hat{y}_i)^2$     | $MSE = SSE/(n-2)$ |           |
| Total      | $n-1$ | $SST = \sum (y_i - \bar{y})^2$       |                   |           |
Note: $MSE = RSE^2$

In R:
Test is automatically done when running `lm()`:
```R
fit <- lm(marks ~ lectures)
summary(fit)
## ...
## Residual standard error: 6.868 on 18 degrees of freedom
## Multiple R-squared: 0.902, Adjusted R-squared: 0.8965
## F-statistic: 165.6 on 1 and 18 DF, p-value: 1.625e-10
```

For simple linear regression, F-test on model is equivalent to t-test on slope ($F = t^2$).

**Coefficient of determination $R^2$**
Coefficient of determination ($R^2$) measures model fit:
$$R^2 = \frac{SS_R}{SS_T} = 1 - \frac{SS_E}{SS_T}$$
- Describes *proportion of variation in the response variable ($y$) explained by explanatory variable*
- Bounded between 0 and 1
- In simple linear regression, $R^2 = r^2$ (square of correlation coefficient)
- Low $R^2$ (closer to 0): poor model fit, small proportion of variation in $y$ explained by $x$
- High $R^2$ (closer to 1): good fit, large proportion explained

In R:
```R
fit <- lm(marks ~ lectures)
summary(fit)
## ...
## Multiple R-squared: 0.902, Adjusted R-squared: 0.8965
## ...
```

For example: $R^2 = 0.902$ means 90.2% of variation in marks is explained by lectures attended.

**Model checking**
When fitting linear regression, make assumptions about relationship:
1. Relationship between dependent and independent variable is linear
2. Errors normally distributed with mean of 0. ($\varepsilon_i \sim N(0, \sigma^2)$)
3. Errors have constant variance (no heteroscedasticity)
4. Errors are independent (no pattern in residuals)

Must check models do not violate assumptions because if they do, linear regression is not appropriate.

**Assessing linearity**
To ensure that the relationship we are modelling is linear we can just plot a scatter plot of $x$ and $y$ and look if it looks linear

**Assessing normality of residuals**
Two ways to check this assumption (do both)
1. QQ-plot: wants points to follow the red line (a bit deviation in the tails is alright)
2. Histogram (want histogram to be bell-shaped - should look normally distributed)

**Assessing constant variance of errors**
Check this assumption by plotting the residuals versus the fitted values. If there is no pattern (just random scatter) then this assumption is met

**Assessing independence of errors**
Check this assumption by plotting errors/residuals against the independent variable. If there is no pattern then the errors are independent (dont change with $x$)

**Example of model that meets assumptions**
![[Pasted image 20260814175620.png]]

**Example of model that violates assumptions**
![[Pasted image 20260814175743.png]]

**Prediction**
Linear regression predicts *dependent variable* value from *independent variable* value.
- Predicted values lie on fitted line: If supply $x$ value, predicted $y$ is corresponding point on fitted line
- Prediction should only be done after confirming model fits data well and passes all model checks
- Cannot predict outside range of data (e.g., if x ranges 0 to 10, cannot predict for x = 15)

**Predicting marks based on lecture attendance**
Fitted line equation:
$$\hat{\text{mark}} = \hat{\beta}_0 + \hat{\beta}_1 \times \text{lectures}$$
$$\hat{\text{mark}} = -3.6851 + 1.825 \times \text{lectures}$$

For student attending 35 lectures:
$$\hat{\text{mark}} = -3.6851 + 1.825 \times 35 = 60.19$$

Student attending 35 lectures can expect mark of 60.19%.

**Confidence intervals (CI) and prediction intervals (PI)**
Can predict the avg $y$ value for a given $x$ or we can predict the $y$ value for a specific individual given their $x$ value. These prediction would be the same if $x$ is the same but the intervals will differ

Two different intervals for new $x_0$, both centered at $\hat{y}_0 = \hat{\beta}_0 + \hat{\beta}_1 x_0$:
- **CI for mean response**: where average $y$ lies at $x_0$. Narrower than PI for an individual $y$ because predicting for an individual is always more uncertain than predicting the mean.
- **PI for individual response**: where single new observation lies at $x_0$. Wider, adds individual scatter on top of estimation uncertainty.

$$CI: \hat{y} \pm t_{\alpha/2, n-2} \cdot SE(\hat{y}) = \hat{y} \pm t_{\alpha/2, n-2} \cdot RSE \sqrt{\frac{1}{n} + \frac{(x_p - \bar{x})^2}{\sum (x_i - \bar{x})^2}}$$

$$PI: \hat{y} \pm t_{\alpha/2, n-2} \cdot RSE \sqrt{1 + \frac{1}{n} + \frac{(x_p - \bar{x})^2}{\sum (x_i - \bar{x})^2}}$$

CI for average $y$ always narrower than PI for individual $y$ because predicting for individual is more uncertain than predicting mean. Both narrowest at $\bar{x}$ and widen as $x_0$ moves away from it.

**Prediction in R **
```R
# Predicting for single individual
ind1_lectures <- 35
predict(fit, newdata=list(lectures=ind1_lectures), interval="prediction")
##        fit      lwr     upr
## 1 60.19001 45.40081 74.9792

# Predicting over lecture range
lectures_new <- data.frame(lectures = 10:48)
predict(fit, newdata=lectures_new)
## 1 2 3 4 5 6 ...
## 14.56490 16.38990 18.21491 20.03991 21.86492 ...
```

Use `interval = "confidence"` for CI on mean response, `interval = "prediction"` for PI on individual.

**A note on causality**
Correlation between two variables does NOT imply one variable causes change in other.
- Can identify relationship but cannot determine directionality or causality
- Third unmeasured variable may affect both, creating observed relationship without causing it
- Significant slope shows association, not causation
- Confounding variables possible
