---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[week-01-simple-linear-regression|SLR foundation]].
## Multiple Linear Regression
### Simple versus Multiple Linear Regression
**Population models**
- **SLR**: $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$
  - $\beta_0$ = intercept parameter
  - $\beta_1$ = slope parameter
  - $\varepsilon_i$ = error
  - One dependent variable, one independent variable
- **MLR**: $y_i = \beta_0 + \beta_1 x_{1i} + \beta_2 x_{2i} + \ldots + \beta_p x_{pi} + \varepsilon_i$
  - $p$ = number of independent variables
  - $\beta_j$ = slope parameter for $j$-th independent variable ($j = 1, \ldots, p$)
  - $\varepsilon_i$ = error
  - One dependent variable but two or more independent variables

**Sample models (p5)**
- **SLR**: $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_i$
  - $\hat{y}_i$ = predicted value of dependent variable
  - $\hat{\beta}_0$ = intercept estimate
  - $\hat{\beta}_1$ = slope estimate
- **MLR**: $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_{1i} + \hat{\beta}_2 x_{2i} + \ldots + \hat{\beta}_p x_{pi}$
  - $\hat{y}_i$ = predicted value of dependent variable
  - $\hat{\beta}_0$ = intercept estimate
  - $\hat{\beta}_j$ = slope estimate for $j$-th independent variable ($j = 1, \ldots, p$)
  - All estimates remain unbiased; interpretation unchanged

**Visualisation of simple versus multiple regression (p6)**
![[Pasted image 20260814181507.png|600]]

**Estimating the beta parameters**
- Like in simple linear regression, Ordinary Least Squares (OLS) algorithm is used to estimate the $\beta$ parameters by minimising $\sum_i \varepsilon_i^2$ (sum of squared errors)
- Closed-form solutions exist but are more complex; software solves numerically

**Aim of multiple regression**
- Model a response (dependent) variable using many explanatory (independent) variables
- Predict the value of a response variable ($y$) from the values of multiple explanatory variables
- Understand how a response variable ($y$) changes with many different explanatory variables
### Example Problem: Fresh Detergent
**Fresh example**
Company A produces Fresh, a brand of liquid laundry detergent. Gathered data on demand for Fresh over 30 sales periods.

Variables:
- $y$ (demand) = demand for Fresh (100,000s of bottles)
- $x_1$ (fresh_price) = price of Fresh (R10 per unit)
- $x_2$ (ads_expenditure) = advertising expenditure to promote Fresh (R1000s)
- $x_3$ (size) = company size (Big or Small)
- $x_4$ (ads_campaign) = advertising campaign (A: TV; B: TV & radio; C: TV, radio, magazine & newspaper)
- $x_5$ (competitor_price) = competitor's average price (R10 per unit)

Continous variables (numeric), categorical variables (labels, not numbers)

**Correlation analysis**
- Calculate correlation between $y$ and each $x_j$ (generates $p$ correlation coefficients)
- Also calculate correlations among $x$ variables to detect redundancy (multicollinearity)
- Rough guide for strength: $|r| < 0.3$ weak, $0.3$ to $0.7$ moderate, $> 0.7$ strong

**Correlation analysis in R**
Because we want the correlation between all of our variables, a convenient way to do this is by calculating a correlation matrix. In R:
```R
fresh_numeric <- fresh[,c(1,2,3,6)]
cor(fresh_numeric)
```
Correlation matrix from Fresh data:

|                  | demand  | fresh_price | ads_expenditure | competitor_price |
| ---------------- | ------- | ----------- | --------------- | ---------------- |
| demand           | 1.0000  | -0.4692     | 0.8760          | 0.7409           |
| fresh_price      | -0.4692 | 1.0000      | -0.4688         | 0.0784           |
| ads_expenditure  | 0.8760  | -0.4688     | 1.0000          | 0.6045           |
| competitor_price | 0.7409  | 0.0784      | 0.6045          | 1.0000           |
- Diagonals represent correlation between each variable and itself (always 1)
- Below and above diagonal are mirrored because each variable occurs twice, once in rows and once in columns

**Correlation matrix plot and pairwise plot**
```R
cor_matrix <- cor(fresh_numeric)
ggcorrplot(cor_matrix, lab = TRUE, type = "lower", colors = c("red", "white", "blue"))
ggpairs(fresh_numeric)
```
![[Pasted image 20260814183902.png | 1000]]
- Correlation matrix heatmap shows strength and direction of linear relationships
- Pairwise plot shows scatter plots for all variable combinations

**Correlations with dependent variable**
- **demand and fresh_price**: $r = -0.469$ (negative moderate correlation)
- **demand and ads_expenditure**: $r = 0.876$ (positive strong correlation)
- **demand and competitor_price**: $r = 0.741$ (positive quite strong correlation)

**Multicollinearity**
*Multicollinearity* refers to high correlations between independent variables. Correlated variables provide redundant information as they attempt to explain the same variability in the dependent variable. Assessed by examining correlations among independent variables in correlation analysis.

**Assessment of multicollinearity in Fresh example**
- **competitor_price and fresh_price**: $r = 0.078$ (very weak, no concern)
- **ads_expenditure and fresh_price**: $r = -0.469$ (moderate, some concern)
- **competitor_price and ads_expenditure**: $r = 0.605$ (relatively strong, concern)

**Consequences of multicollinearity**
When two independent variables are correlated, both attempt to explain the same variability in the dependent variable. Results:
- Inflated SE of coefficient estimates (how precisely the model has estimated each coefficient: high means uncertain estimate)
- Inflated p-values as a consequence of inflated SE (less likely to detect true relationships)
- Large changes to parameter estimates when adding/removing correlated variables
- Increased RSE when adding a correlated independent variable
### Multiple Linear Regression with Continuous Explanatory Variables  
**Performing multiple linear regression in R**
```R
fit <- lm(demand ~ fresh_price + ads_expenditure + competitor_price, data = fresh)
summary(fit)
```
<pre style="line-height:1.4">
##                     <span style="color:#4da6ff">beta-hat</span>  <span style="color:#ffc94d">se(beta)</span>   <span style="color:#7bd88f">tstat</span>   <span style="color:#ff9e9e">p-value</span>
## Coefficients:
##                  <span style="color:#4da6ff">Estimate</span> <span style="color:#ffc94d">Std. Error</span> <span style="color:#7bd88f">t value</span> <span style="color:#ff9e9e">Pr(>|t|)</span>
## (Intercept)        <span style="color:#4da6ff">7.5891</span>     <span style="color:#ffc94d">2.4450</span>   <span style="color:#7bd88f">3.104</span> <span style="color:#ff9e9e">0.004567</span> **   beta0
## fresh_price       <span style="color:#4da6ff">-2.3577</span>     <span style="color:#ffc94d">0.6379</span>  <span style="color:#7bd88f">-3.696</span> <span style="color:#ff9e9e">0.001028</span> **   beta1 (x1)
## ads_expenditure    <span style="color:#4da6ff">0.5012</span>     <span style="color:#ffc94d">0.1259</span>   <span style="color:#7bd88f">3.981</span> <span style="color:#ff9e9e">0.000491</span> ***  beta2 (x2)
## competitor_price   <span style="color:#4da6ff">1.6122</span>     <span style="color:#ffc94d">0.2954</span>   <span style="color:#7bd88f">5.459</span> <span style="color:#ff9e9e">1.01e-05</span> ***  beta3 (x3)
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: <span style="color:#ffc94d">0.2347</span> on <span style="color:#7bd88f">26</span> degrees of freedom   RSE, df = n-p-1 = 30-3-1
## Multiple R-squared:  <span style="color:#4da6ff">0.8936</span>, Adjusted R-squared:  <span style="color:#4da6ff">0.8813</span>   R2 = 89.36% explained
## F-statistic:  <span style="color:#7bd88f">72.8</span> on <span style="color:#7bd88f">3 and 26</span> DF,  p-value: <span style="color:#ff9e9e">8.883e-13</span>     F on p and n-p-1 df
</pre>

Regression equation for the example:
$$\hat{y} = \hat{\beta}_0 + \hat{\beta}_1(\text{fresh\_price}) + \hat{\beta}_2(\text{ads\_expenditure}) + \hat{\beta}_3(\text{competitor\_price})$$

$$\hat{y} = 7.5891 - 2.3577(\text{fresh\_price}) + 0.5012(\text{ads\_expenditure}) + 1.6122(\text{competitor\_price})$$

Coefficients:
- $\hat{\beta}_0 = 7.5891$ (intercept)
- $\hat{\beta}_1 = -2.3577$ (fresh_price, SE = 0.6379)
- $\hat{\beta}_2 = 0.5012$ (ads_expenditure, SE = 0.1259)
- $\hat{\beta}_3 = 1.6122$ (competitor_price, SE = 0.2954)

Multiple $R^2 = 0.8936$, Adjusted $R^2 = 0.8813$, $F = 72.8$ (3 df, 26 df), p-value $< 0.001$

**Interpretation of beta coefficients**
For the Fresh example:
- **$\hat{\beta}_0$ (intercept)**: On average, demand for Fresh is $7.5891 \times 100000 = 758910$ bottles when all independent variables = 0 (rarely practically meaningful)
- **$\hat{\beta}_1$ (fresh_price)**: On average, demand for Fresh decreases by $2.3577 \times 100000 = 235770$ bottles for each additional R10 increase in price, holding all else constant
- **$\hat{\beta}_2$ (ads_expenditure)**: On average, demand for Fresh increases by $0.5012 \times 100000 = 50120$ bottles for each additional R1000 increase in advertising, holding all else constant
- **$\hat{\beta}_3$ (competitor_price)**: On average, demand for Fresh increases by $1.6122 \times 100000 = 161220$ bottles for each additional R10 increase in competitor price, holding all else constant

General interpretation:
- **$\beta_0$ (intercept)**: average estimated value of $y$ when all $x_j = 0$
- **$\beta_j$ (slope)**: average estimated change in $y$ for one-unit increase in $x_j$, holding all other independent variables constant

**Testing the significance of beta_j estimates**
Determining whether the slope estimates are significant so that we can make statistical inference.  Can do hypothesis test on these estimates (for each $\beta_j$ where $j = 1, \ldots, p$):
1. $H_0: \beta_j = 0$
2. $H_a: \beta_j \neq 0$
3. $\alpha = 0.05$
4. Test statistic: $$t_{\text{stat}} = \frac{\hat{\beta}_j}{SE(\hat{\beta}_j)} \sim t_{n-p-1}$$
Example for $\beta_2$ (ads_expenditure): $$t_{\text{stat}} = \frac{0.5012}{0.1259} = 3.981 \sim t_{26}$$
5. Find p-value from t-distribution
6. Conclude: reject $H_0$ if p-value $< \alpha$

For Fresh: ads_expenditure has p-value = 0.000491, so reject $H_0$. Significant linear relationship between advertising expenditure and demand.

**Confidence intervals for $\beta_j$ estimates**
Get range of values that we are relatively sure that the true $\beta_j$ parameters fall into for each $\beta_j$. 
Can calculate using:
$$CI = \hat{\beta}_j \pm t_{\alpha/2, n-p-1} \times SE(\hat{\beta}_j)$$

Example: 95% CI for $\hat{\beta}_2$:
$$CI = 0.5012 \pm 2.056 \times 0.1259 = [0.242, 0.760]$$

In R: `confint(fit)` gives all confidence intervals

**Checking overall model significance** 
Can check overall model significance by assessing if our model is significantly different to a null model (model with just an intercept)
ANOVA table partitions variation: $SS_{\text{tot}} = SS_{\text{reg}} + SS_{\text{resid}}$

| Source | df | SS | Mean Square | F |
|---|---|---|---|---|
| Regression | $p$ | $SS_{\text{reg}}$ | $MS_{\text{reg}} = \frac{SS_{\text{reg}}}{p}$ | $F = \frac{MS_{\text{reg}}}{MS_{\text{resid}}}$ |
| Residual | $n-p-1$ | $SS_{\text{resid}}$ | $MS_{\text{resid}} = \frac{SS_{\text{resid}}}{n-p-1}$ |  |
| Total | $n-1$ | $SS_{\text{tot}}$ |  |  |

Six-step F-test:
1. $H_0: \beta_1 = \beta_2 = \ldots = \beta_p = 0$ (null model)
2. $H_a$: at least one $\beta_j \neq 0$
3. $\alpha = 0.05$
4. Test statistic: $$F_{\text{stat}} = \frac{MS_{\text{reg}}}{MS_{\text{resid}}} \sim F_{p, n-p-1}$$
5. Find p-value from F-distribution
6. Conclude: reject $H_0$ if p-value $< \alpha$

For Fresh: $F = 72.8$ with p-value $< 0.001$, reject $H_0$. At least one independent variable significantly affects demand.

**Coefficient of determination ($R^2$)**
$$R^2 = \frac{SS_{\text{reg}}}{SS_{\text{tot}}} = 1 - \frac{SS_{\text{resid}}}{SS_{\text{tot}}}$$
- Share of variation in $y$ explained by the model
- $R^2 \in [0, 1]$; higher is better
- Limitations
	- Never decreases when adding independent variables, even useless ones (becomes problem for comparing models)
	- 
- In R: `summary(fit)$r.squared`

**Adjusted coefficient of determination**
$$R^2_{\text{adj}} = 1 - \frac{SS_{\text{resid}}/(n-p-1)}{SS_{\text{tot}}/(n-1)}$$
- Penalizes model complexity (accounts for sample size and number of predictors)
- Ensures scaling between 0 and 1
- Use for comparing models with different numbers of variables
- Adjusted $R^2$ can decrease when adding a weak predictor

Adjusted $R^2$ in R
 `summary(fit)` output alongside Multiple $R^2$ 

**Model checking**
Check assumptions with residual diagnostics:
- **Residuals vs fitted plot**: random scatter around 0 (linearity, equal variance)
- **QQ-plot**: points on the line (normality)
- **Histogram of residuals**: approximately normal
- **Residuals vs each predictor**: no patterns (independence, linearity)

In R: `plot(fit)` for diagnostic plots; or produce individual plots for each independent variable.

**Prediction**
Prediction works exactly the same as in SLR but supply values for all independent variables to get a prediction for the dependent variable:

For the fitted line: $\hat{y} = 7.5891 - 2.3577(\text{fresh\_price}) + 0.5012(\text{ads\_exp}) + 1.6122(\text{comp\_price})$

Example: predicted demand when fresh_price = R50 (5), competitor_price = R55 (5.5), ads_expenditure = R8000 (8):
$$\hat{y} = 7.5891 - 2.3577(5) + 0.5012(8) + 1.6122(5.5) = 8.6773$$

Predicted demand = 867,730 bottles.

**Confidence and prediction intervals )**
- **CI for average y** (narrower): where the average $y$ lies at $x_0$
- **PI for individual y** (wider): where a single new observation lies
- Formulas involve matrix algebra; use R to compute

In R: `predict(fit, newdata, interval = "confidence")` or `"prediction"`

**Prediction in R**
```R
newdat <- data.frame(fresh_price = 5, ads_expenditure = 8, competitor_price = 5.5)
predict(fit, newdata = newdat, interval = "confidence")   # CI for mean
predict(fit, newdata = newdat, interval = "prediction")   # PI for individual
```
### Multiple Linear Regression with Categorical Explanatory Variables  
**Categorical explanatory variables**
Datasets often contain categorical variables alongside continuous ones. Examples in Fresh data: company size and advertising campaign type may explain important variation in demand. Cannot use category names directly in regression; must encode as numeric dummy variables.

**Slide: How to include binary variables in a regression analysis**
For categorical variables with 2 levels (e.g., size: Small or Big):
- Assign Small = 0, Big = 1
- Treats Small as reference category; intercept captures Small effect
- When Big: add $\hat{\beta}_j$ to intercept

Regression equation: $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \ldots + \hat{\beta}_3 x_3 + \hat{\beta}_4 x_4$

where $\hat{\beta}_4$ represents change in demand when company is Big vs Small.

**How to include binary variables in a regression analysis in R**
Default reference category (alphabetically first):
```R
fresh$size <- as.factor(fresh$size)
contrasts(fresh$size)
# Big = 0, Small = 1
```

Manual reference category (if Big should be reference):
```R
size_Big <- ifelse(fresh$size == "Small", 0, 1)
size_Big <- factor(size_Big, labels = c("Small", "Big"))
contrasts(size_Big)
# Small = 0, Big = 1
fresh$size_Big <- size_Big
```

**How to include categorical variables in a regression analysis**
For multi-level categorical (3+ levels): use $k-1$ dummy variables.

Example with ads_campaign (A, B, C):
- A is reference (not included as dummy)
- B gets one dummy variable
- C gets one dummy variable
- Adds two additional $\hat{\beta}$ estimates ($\hat{\beta}_5$ and $\hat{\beta}_6$)

Equation: $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \hat{\beta}_2 x_2 + \hat{\beta}_3 x_3 + \hat{\beta}_4 x_4 + \hat{\beta}_5 x_5 + \hat{\beta}_6 x_6$

where $\hat{\beta}_5$ = change in demand for campaign B vs A, $\hat{\beta}_6$ = change for campaign C vs A.

**How to include categorical variables in a regression analysis in R**
Default reference category:
```R
fresh$ads_campaign <- as.factor(fresh$ads_campaign)
contrasts(fresh$ads_campaign)
# A = 0 0, B = 1 0, C = 0 1
```

Manual reference category (if B should be reference):
```R
campaignA <- ifelse(fresh$ads_campaign == "A", 1, 0)
campaignC <- ifelse(fresh$ads_campaign == "C", 1, 0)
campaignA <- factor(campaignA, labels = c("notA", "A"))
campaignC <- factor(campaignC, labels = c("notC", "C"))
fresh$campaignA <- campaignA
fresh$campaignC <- campaignC
```

**Regression analysis using our example in R**
```R
fit_full <- lm(demand ~ fresh_price + ads_expenditure + competitor_price + size + ads_campaign, data = fresh)
summary(fit_full)
```

Regression equation:
$$\hat{y} = \hat{\beta}_0 + \hat{\beta}_1(\text{fresh\_price}) + \hat{\beta}_2(\text{ads\_expenditure}) + \hat{\beta}_3(\text{competitor\_price}) + \hat{\beta}_4(\text{sizeSmall}) + \hat{\beta}_5(\text{ads\_campaignB}) + \hat{\beta}_6(\text{ads\_campaignC})$$

Example from Fresh data:
$$\hat{y} = 8.297 - 2.310(\text{fresh\_price}) + 0.433(\text{ads\_expenditure}) + 1.469(\text{competitor\_price}) - 0.194(\text{sizeSmall}) + 0.223(\text{ads\_campaignB}) + 0.415(\text{ads\_campaignC})$$

**Interpretation of beta coefficients for categorical variables )**
For the Fresh example:
- **$\hat{\beta}_0$ (intercept)**: On average, demand is $8.297 \times 100000 = 829737$ bottles when all continuous predictors = 0 and categorical predictors are at reference (Big, campaign A)
- **$\hat{\beta}_4$ (sizeSmall)**: On average, demand is $0.194 \times 100000 = 19425$ bottles lower when company is Small compared to Big, holding all else constant
- **$\hat{\beta}_5$ (ads_campaignB)**: On average, demand is $0.223 \times 100000 = 22263$ bottles higher when campaign is B compared to A, holding all else constant
- **$\hat{\beta}_6$ (ads_campaignC)**: On average, demand is $0.415 \times 100000 = 41478$ bottles higher when campaign is C compared to A, holding all else constant

General interpretation:
- **Intercept**: average estimated $y$ when all continuous predictors = 0 and categorical predictors at reference level
- **Categorical $\hat{\beta}_j$**: average estimated change in $y$ when $x_{categorical}$ takes on dummy category $i$ compared to when $x_{categorical}$ takes on the reference category holding all else constant


**Testing significance of categorical $\beta_j$ estimates**
Same process as continuous variables (six-step hypothesis test). Conclusion differs:
- If $H_0$ rejected: p-value $< \alpha$, significant difference between that category and reference category
- If $H_0$ not rejected: p-value $> \alpha$, no significant difference detected between that category and reference category
### Interactions 
**Additive models and interactions**
Additive models (until now): effect of $x_1$ is independent of $x_2$:
$$\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \hat{\beta}_2 x_2$$

Sometimes: effect of $x_1$ on $y$ depends on value of $x_2$. Use interaction term:
$$\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \hat{\beta}_2 x_2 + \hat{\beta}_3 x_1 x_2$$

Effect of $x_1$ on $y$ is now $(\hat{\beta}_1 + \hat{\beta}_3 x_2)$, not just $\hat{\beta}_1$.

**Adding interaction terms to regression models in R**
Use `*` for interaction (includes main effects automatically):
```R
fit <- lm(demand ~ fresh_price * ads_campaign, data = fresh)
summary(fit)
```

Regression equation:
$$\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1(\text{fresh\_price}) + \hat{\beta}_2(\text{ads\_campaignB}) + \hat{\beta}_3(\text{ads\_campaignC}) + \hat{\beta}_4(\text{fresh\_price} \times \text{ads\_campaignB}) + \hat{\beta}_5(\text{fresh\_price} \times \text{ads\_campaignC})$$

**Interpreting interaction terms**
For multiplicative model with interaction between fresh_price and ads_campaign:
- **$\hat{\beta}_1$ (fresh_price)**: effect of fresh_price when ads_campaign is A (reference)
- **$\hat{\beta}_2$ (ads_campaignB)**: intercept adjustment when campaign is B vs A
- **$\hat{\beta}_3$ (ads_campaignC)**: intercept adjustment when campaign is C vs A
- **$\hat{\beta}_4$ (fresh_price $\times$ ads_campaignB)**: adjustment to the slope for fresh_price when campaign is B compared to A
- **$\hat{\beta}_5$ (fresh_price $\times$ ads_campaignC)**: adjustment to the slope for fresh_price when campaign is C compared to A

Example coefficients:
$$\hat{y}_i = 12.226 - 1.079(\text{fresh\_price}) + 35.186(\text{ads\_campaignB}) + 13.538(\text{ads\_campaignC}) - 9.307(\text{fresh\_price} \times \text{ads\_campaignB}) - 3.549(\text{fresh\_price} \times \text{ads\_campaignC})$$

When campaign A: $\hat{y}_i = 12.226 - 1.079(\text{fresh\_price})$

When campaign B: $\hat{y}_i = 47.412 - 10.286(\text{fresh\_price})$

When campaign C: $\hat{y}_i = 25.764 - 4.628(\text{fresh\_price})$

**Additive vs multiplicative model comparison**
- **Additive model**: parallel lines (same slope across categories)
- **Multiplicative model**: non-parallel lines (different slopes across categories)
- Visualize with ggplot: `geom_line()` colored by category
## MLR in R
Page refs: (pNN) = PDF page in [[materials/lectures/week-02/MLR_in_R.pdf|R walkthrough]] (6 slides).
### R Walkthrough: Correlation and Model Fitting
**Slide: Loading data and correlation analysis**
```R
# Load libraries
library(ggcorrplot)
library(ggplot2)
library(GGally)

# Read data
fresh <- read.csv("fresh.csv")

# Correlation analysis: select numeric columns only
fresh_numeric <- fresh[, c(1, 2, 3, 6)]
cor(fresh_numeric)

# Visualize correlations
cor_matrix <- cor(fresh_numeric)
ggcorrplot(cor_matrix, lab = TRUE, type = "lower", colors = c("red", "white", "blue"))
ggpairs(fresh_numeric)  # pairwise scatter plots
```

**Slide: Fitting multiple regression and testing coefficients**
```R
# Fit the model
fit <- lm(demand ~ fresh_price + ads_expenditure + competitor_price, data = fresh)
summary(fit)

# Manually calculate test statistic for beta2
b2 <- 0.5012
se_b2 <- 0.1259
tstat_b2 <- b2 / se_b2  # = 3.981

# Calculate p-value
n <- 30
p <- 3
pval_b2 <- 2 * pt(q = tstat_b2, df = n - (p + 1), lower.tail = FALSE)
```

**Slide: Confidence intervals and model significance**
```R
# Confidence intervals for coefficients
confint(fit)  # 95% CI by default

# Manual calculation of F-test for overall model
ybar <- mean(fresh$demand)
SSreg <- sum((fit$fitted.values - ybar)^2)
SSresid <- sum((fresh$demand - fit$fitted.values)^2)
SStot <- sum((fresh$demand - ybar)^2)

MSreg <- SSreg / p
MSresid <- SSresid / (n - (p + 1))
Fteststat <- MSreg / MSresid

# p-value for F-test
pval_Fteststat <- pf(q = Fteststat, df1 = p, df2 = n - (p + 1), lower.tail = FALSE)
```

**Slide: $R^2$ calculations and residual diagnostics**
```R
# R-squared values
r2 <- SSreg / SStot
r2_adj <- 1 - ((n - 1) / (n - (p + 1))) * (1 - r2)

# Residual diagnostics
hist(fit$residuals)           # histogram for normality
qqnorm(fit$residuals)         # QQ-plot
qqline(fit$residuals, col = "red")
plot(fit$fitted.values, fit$residuals)  # constant variance

# Plot residuals vs each predictor
plot(fresh$fresh_price, fit$residuals)
plot(fresh$ads_expenditure, fit$residuals)
plot(fresh$competitor_price, fit$residuals)
```

**Slide: Prediction and categorical variables**
```R
# Prediction with confidence and prediction intervals
newdat <- data.frame(fresh_price = 5, ads_expenditure = 8, competitor_price = 5.5)
predict(fit, newdata = newdat, interval = "confidence")   # CI for mean
predict(fit, newdata = newdat, interval = "prediction")   # PI for individual

# Categorical variables: binary with default reference
fresh$size <- as.factor(fresh$size)
contrasts(fresh$size)  # shows coding (Big = 0, Small = 1)

# Categorical variables: multi-level with default reference
fresh$ads_campaign <- as.factor(fresh$ads_campaign)
contrasts(fresh$ads_campaign)  # shows coding (A = 0 0, B = 1 0, C = 0 1)
```

**Slide: Full model with categorical variables and interactions**
```R
# Fit full model with continuous and categorical variables
fit_full <- lm(demand ~ fresh_price + ads_expenditure + competitor_price + size + ads_campaign, 
               data = fresh)
summary(fit_full)

# Fit model with interaction term
fit_mult <- lm(demand ~ fresh_price * ads_campaign, data = fresh)
summary(fit_mult)

# Visualize additive model
fit_ad <- lm(demand ~ fresh_price + ads_campaign, data = fresh)
fresh$fitad <- predict(fit_ad)
ggplot(fresh, aes(x = fresh_price, y = fitad, color = ads_campaign)) +
  geom_line(size = 1) +
  labs(y = "Demand", x = "Fresh price") +
  xlim(3.55, 3.9) + ylim(7, 11) +
  theme_minimal()

# Visualize multiplicative model
fresh$fitmult <- predict(fit_mult)
ggplot(fresh, aes(x = fresh_price, y = fitmult, color = ads_campaign)) +
  geom_line(size = 1) +
  labs(y = "Demand", x = "Fresh price") +
  xlim(3.55, 3.9) + ylim(7, 11) +
  theme_minimal()
```
## Example Practice Questions
Page refs: (pNN) = PDF page in [[materials/lectures/week-02/STA2020___MLR_example_questions.pdf|example questions]] (26 slides).
### Animal Sleep Example Problem (p2-26)
**Slide: Animal sleep example (p2)**
A researcher studies whether body weight, lifespan, and feeding habits affect sleep amount.

Variables:
- $y$ (TotalSleep) = average total hours of sleep per day
- $x_1$ (logBodyWt) = log of body weight in kgs
- $x_2$ (Lifespan) = animal's average lifespan
- $x_3$ (Feeding) = feeding habits (Carnivore, Omnivore, Herbivore)

**Slide: Interpretation of correlation matrix (p3-4)**
The correlation matrix for continuous variables:

Interpretations:
- **TotalSleep and logBodyWt**: moderate negative correlation
- **TotalSleep and Lifespan**: moderate negative correlation
- **Lifespan and logBodyWt**: relatively strong positive correlation

**Slide: Regression model and equation (p5-6)**
Using model output provided:

**Question 1**: Give the estimated regression equation from the model output.

$$\hat{y}_i = 13.799 - 0.378(\text{logBodyWt}) - 0.060(\text{Lifespan}) - 4.497(\text{Herbivore}) - 0.359(\text{Omnivore})$$

**Slide: Interpreting feeding habit coefficients (p7-8)**
**Question 2**: Interpret the Feeding_herbivore and Feeding_omnivore estimates.

- **Feeding_herbivore**: On average, total hours of sleep are 4.497 hours lower for animals who are herbivores compared to carnivores (reference), holding all else constant
- **Feeding_omnivore**: On average, total hours of sleep are 0.359 hours lower for animals who are omnivores compared to carnivores (not statistically significant)

**Slide: Regression equations by feeding category (p9-14)**
**Question 3**: Estimated regression equation when Feeding = Carnivore.
$$\hat{y}_i = 13.799 - 0.378(\text{logBodyWt}) - 0.060(\text{Lifespan})$$

**Question 4**: Estimated regression equation when Feeding = Omnivore.
$$\hat{y}_i = 13.440 - 0.378(\text{logBodyWt}) - 0.060(\text{Lifespan})$$

**Question 5**: Estimated regression equation when Feeding = Herbivore.
$$\hat{y}_i = 9.302 - 0.378(\text{logBodyWt}) - 0.060(\text{Lifespan})$$

**Slide: Interaction model equation (p15-16)**
A new model includes interaction between logBodyWt and Feeding.

**Question 6**: Give the estimated regression equation from the model output.
$$\hat{y}_i = 13.855 - 0.341(\text{logBodyWt}) - 0.063(\text{Lifespan}) - 4.304(\text{Herbivore}) - 0.512(\text{Omnivore}) - 0.110(\text{logBodyWt} \times \text{Herbivore}) + 0.127(\text{logBodyWt} \times \text{Omnivore})$$

**Slide: Interaction model equations by feeding category (p17-22)**
**Question 7**: Estimated regression equation when Feeding = Carnivore.
$$\hat{y}_i = 13.855 - 0.341(\text{logBodyWt}) - 0.063(\text{Lifespan})$$

**Question 8**: Estimated regression equation when Feeding = Herbivore.
$$\hat{y}_i = 9.551 - 0.451(\text{logBodyWt}) - 0.063(\text{Lifespan})$$

**Question 9**: Estimated regression equation when Feeding = Omnivore.
$$\hat{y}_i = 13.343 - 0.214(\text{logBodyWt}) - 0.063(\text{Lifespan})$$

**Slide: Interpreting interaction coefficients (p23-26)**
**Question 10**: Interpret the logBodyWt:Feeding_herbivore interaction estimate.

It is the change in the slope estimate for logBodyWt when an animal is a herbivore compared to a carnivore. The slope for logBodyWt decreases by 0.110 when an animal is a herbivore compared to carnivore.

**Question 11**: Interpret the logBodyWt:Feeding_omnivore interaction estimate.

It is the change in the slope estimate for logBodyWt when an animal is an omnivore compared to a carnivore. The slope for logBodyWt increases by 0.127 when an animal is an omnivore compared to carnivore.
