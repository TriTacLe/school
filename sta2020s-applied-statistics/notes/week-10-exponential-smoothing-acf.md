---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/lectures/week-10/Time Series 2025 (UPDATED).pdf|master deck]], [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[week-09-time-series-decomposition]].
## Exponential Smoothing
Page refs: (pNN) = PDF page in [[materials/lectures/week-10/Time Series 2025 (UPDATED).pdf|master deck]] (25 slides).
### Exponential Smoothing Foundations (p159-160)
**Slide: Exponential Smoothing (p159)**
- Derives name from series of exponentially weighted averages
- Forecasts are weighted averages of past observations with exponentially decaying weights
- Older observations receive less weight; recent observations emphasized
- Each smoothing calculation dependent on all previous values to varying degrees
- General form: $\hat{Y}_{T+1|T} = \sum_{j=1}^{T-1} \alpha (1-\alpha)^j y_{T-j} + (1-\alpha) l_0$
- $\alpha$ is smoothing constant (0 <= α <= 1); $l_0$ is estimated level in period 0
- Generates reliable forecasts quickly for wide range of time series

**Slide: Smoothing constant interpretation (p160)**
- Small $\alpha$ (close to 0): great deal of smoothing; more weight to distant past
- Large $\alpha$ (close to 1): very little smoothing; more weight to recent observations
- Extreme case α=1: $\hat{Y}_{T+1|T} = Y_T$ (naive forecasts)
- Choice somewhat subjective based on desired smoothing amount
### Simple Exponential Smoothing (p161-173)
**Slide: Two forms of exponential smoothing equations (p161)**
Weighted average form:
- Forecasts: $\hat{y}_{t+1|t} = \alpha y_t + (1 - \alpha) \hat{y}_{t|t-1}$
- Fitted values: $\hat{y}_{t+1|t} = \alpha y_t + (1 - \alpha) \hat{y}_{t|t-1}$
- Process starts with $l_0$ (estimated level in period 0) or $l_1 = y_1$
- Recursive: each fitted value depends on all previous values via exponential weights

**Slide: Component form of simple exponential smoothing (p162)**
- Forecast equation: $\hat{y}_{t+h|t} = l_t$
- Smoothing equation: $l_t = \alpha y_t + (1 - \alpha) l_{t-1}$
- $l_t$ is level (smoothed value) at time t
- Current level = weighted average of current information and previous level information
- Setting h=1 gives fitted values; setting t=T gives forecasts beyond training data
- If we replace $l_t$ with $\hat{y}_{t+1|t}$ in smoothing equation and evaluate recursively, we get general form

**Slide: Simple exponential smoothing example (p163)**
Car rental agency revenues over 11 years (1992-2002):
4.0, 5.0, 7.0, 6.0, 8.0, 9.0, 5.0, 2.0, 3.5, 5.5, 6.5 million Rands
- Fit simple exponential smoothing model with α = 0.25

**Slide: SES example calculation (p164-167)**
Year data and smoothed values:

| Year | t | Data | EXP(0.25) |
|------|---|------|-----------|
| 1992 | 1 | 4.0 | 4.00 |
| 1993 | 2 | 5.0 | 4.25 |
| 1994 | 3 | 7.0 | 4.94 |
| 1995 | 4 | 6.0 | 5.20 |
| 1996 | 5 | 8.0 | 5.90 |
| 1997 | 6 | 9.0 | 6.68 |
| 1998 | 7 | 5.0 | 6.26 |
| 1999 | 8 | 2.0 | 5.19 |
| 2000 | 9 | 3.5 | 4.77 |
| 2001 | 10 | 5.5 | 4.95 |
| 2002 | 11 | 6.5 | 5.34 |

Each level is weighted average: α times current observation plus (1-α) times previous level

**Slide: When to use simple exponential smoothing (p168)**
- Only useful for series with no clear trend or seasonality
- All future forecasted values set to last level component value
- Resembles naive forecasting method
- Since constant forecasts, not appropriate when trend or seasonality present

**Slide: Optimization of initial values and smoothing parameters (p168-169)**
- Initial values and smoothing parameters must be chosen or estimated
- Subjective choice based on forecaster's knowledge/experience
- More reliable approach: estimate from data by minimizing sum of squared errors (SSE)
- $SSE = \sum_{t=1}^{T} (y_t - \hat{y}_{t|t-1})^2 = \sum_{t=1}^{T} e_t^2$
- Estimated via non-linear optimization, beyond course scope
### Exponential Smoothing Forecasting Examples (p170-173)
**Slide: Oil production forecasting example (p170-173)**
- Oil production series shows increasing non-linear trend
- Simple exponential smoothing NOT appropriate because cannot model trend
- Demonstrates need for exponential smoothing method that captures trend
- Example shows fitting in R: α = 0.8339 (large value indicates rapid response to changes)
- Large α produces large changes in estimated level each period
- Smaller α would produce smoother fitted values with less period-to-period change
### Holt's Linear Trend Method (p174-177)
**Slide: Holt's linear trend method (p174)**
Extends simple exponential smoothing to allow forecasting series with linear trend.
- Forecast equation: $\hat{y}_{t+h|t} = l_t + h b_t$
- Level equation: $l_t = \alpha y_t + (1 - \alpha)(l_{t-1} + b_{t-1})$
- Trend equation: $b_t = \beta^* (l_t - l_{t-1}) + (1 - \beta^*) b_{t-1}$
- $l_t$ = level (smoothed value) at time t
- $b_t$ = estimate of trend (slope) at time t
- $\alpha$ = smoothing parameter for level (0 <= α <= 1)
- $\beta^*$ = smoothing parameter for trend (0 <= β* <= 1); note: NOT same as regression coefficients
- Forecast function is no longer flat but trending (linear function of h)
- h-step-ahead forecast equals last level plus h times last trend value
- Initial states (level and slope in period 0) used to calculate values in period 1

**Slide: Component interpretation for Holt's method (p177)**
- Level component: weighted average of current level information and previous level information
- Slope component: weighted average of current slope information and previous slope information
- Small β* means slope hardly changes over time (almost all weight on previous slope)
- Example parameter estimates: α = 0.8302, β* = 0.0001 (very small beta indicates stable trend)

**Slide: Holt's linear trend example (p175-177)**
Oil production forecast example demonstrating the level, slope, and forecast calculations at each time period using the estimated component and smoothing parameter values.
### Holt-Winters Seasonal Method (p178-182)
**Slide: Holt-Winters seasonal method overview (p178)**
Extension of Holt's linear trend for series displaying seasonality in addition to trend.
- Choose between additive and multiplicative based on nature of seasonality
- Additive: magnitude of seasonality stays constant throughout series
- Multiplicative: amplitude of seasonality changes with time (preferred for this course)
- Only multiplicative formulation covered in STA2020
- Comprises forecast equation and three smoothing equations

**Slide: Holt-Winters multiplicative seasonal equations (p178-179)**
- Forecast equation: $\hat{y}_{t+h|t} = (l_t + h b_t) s_{t+h-m(k+1)}$
- Level equation: $l_t = \alpha \frac{y_t}{s_{t-m}} + (1 - \alpha)(l_{t-1} + b_{t-1})$
- Trend equation: $b_t = \beta^* (l_t - l_{t-1}) + (1 - \beta^*) b_{t-1}$
- Seasonal equation: $s_t = \gamma \frac{y_t}{l_{t-1} + b_{t-1}} + (1 - \gamma) s_{t-m}$

**Slide: Holt-Winters components and parameters (p179)**
- m = frequency of seasonality (seasons per year); e.g., m=4 for quarterly, m=12 for monthly
- k = integer part of (h-1)/m, ensures seasonal estimates from final sample year
- α = smoothing parameter for level
- β* = smoothing parameter for trend
- γ = smoothing parameter for seasonal component
- Level equation: weighted average between seasonally adjusted observation and non-seasonal forecast
- Trend equation: identical to Holt's linear method
- Seasonal equation: weighted average between current seasonal index and same season last year

**Slide: Holt-Winters seasonal example (p180-182)**
Quarterly data example (2004-2017) showing level, slope, seasonal, and forecast calculations:
- Initial states for level and slope in period 0 used to calculate period 1 values
- Previous seasonal component values required for initialization
- Each time period: each component is weighted average between recent information and previous information
- Example calculation: $l_1 = 0.4406 \frac{42.2057}{0.9618} + 0.5594 (32.4875 + 0.6974) = 37.8980$
- Demonstrates how method adapts to both level changes and seasonal patterns
## Autocorrelation, ACF, and PACF
Page refs: (pNN) = PDF page in [[materials/lectures/week-10/Time Series 2025 (UPDATED).pdf|master deck]] (7 slides).
### Autocorrelation Concepts (p184-189)
**Slide: Definition of autocorrelation (p184)**
- Autocorrelation: correlation of variable with lagged (past) values of itself; also called serial correlation
- Lag g: number of time periods between observations where autocorrelation measured
- Autocorrelation at lag g=1: strength of relationship between consecutive observations ($y_t, y_{t-1}$)
- Autocorrelation at lag g=2: strength between observations two periods apart ($y_t, y_{t-2}$)
- Autocorrelation at lag g=p: strength between observations p periods apart ($y_t, y_{t-p}$)

**Slide: ACF formula and properties (p185)**
$$\rho(h) = \frac{\sum_{t=h+1}^{T} (y_t - \bar{y})(y_{t-h} - \bar{y})}{\sum_{t=1}^{T} (y_t - \bar{y})^2}$$
- h = lag, T = length of time series, $\bar{y}$ = mean of series
- $\rho(h)$ takes values in [-1, 1]
- ρ = -1: perfect negative autocorrelation
- ρ = 1: perfect positive autocorrelation
- ρ = 0: no autocorrelation
- Interpreted similarly to correlation coefficient
- ACF is even function: $\rho(h) = \rho(-h)$; considered for h >= 0
- ACF Calculation: at lag h, uses n-h pairs of observations

**Slide: Autocorrelation and regression (p185)**
- Problem: regression assumes independence; fails when autocorrelation present
- Residuals may be incorrect or imprecise
- Opportunity: autocorrelation represents information for forecasting in time series models

**Slide: Positive autocorrelation (p186-187)**
- Observations positively autocorrelated if large degree of similarity between observations close together in time
- Successive values similar over short time intervals
- Highs follow highs, lows follow lows (persistence)
- Strong positive: ρ = 0.95 indicates very strong persistence
- Alignment from lower left to upper right in lagged scatterplot indicates positive autocorrelation

**Slide: White noise and independence (p188)**
- Series jumps around mean in random fashion
- Values of autocorrelation close to 0 imply white noise
- No autocorrelation present; no dependence between observations
- Knowledge of previous values valueless for prediction
- Ideal for residuals of fitted model: if residuals resemble white noise, model captured most information/patterns

**Slide: Negative autocorrelation (p189)**
- Negative values imply successive observations oscillate above and below mean in sawtooth pattern
- Do not confuse sawtooth pattern with seasonal effects
- Strong negative: ρ = -0.90 indicates strong oscillatory behavior
- Alignment from upper left to lower right in lagged scatterplot indicates negative autocorrelation
### Autocorrelation Function (ACF) and Plots
**Slide: ACF calculation at different lags**
- At lag h=1: calculated using n-1 pairs $(y_1, y_2), (y_2, y_3), \ldots, (y_{n-1}, y_n)$
- At lag h=2: calculated using n-2 pairs $(y_1, y_3), (y_2, y_4), \ldots, (y_{n-2}, y_n)$
- At lag h=3: calculated using n-3 pairs $(y_1, y_4), (y_2, y_5), \ldots, (y_{n-3}, y_n)$

**Slide: The correlogram (ACF plot)**
- Graph of autocorrelation at lag h against h
- Vertical spikes display estimated autocorrelations (standard visualization)
- Most useful tool in time series analysis after time series plot itself

**Slide: Uses of correlogram**
- Descriptive tool: simple description of dependency within series
- Model identification tool: part of procedure for identifying appropriate model

**Slide: Interpreting ACF for stationarity (p176 context)**
- For stationary process: correlogram provides estimate of theoretical ACF
- For non-stationary process: correlogram meaningless; values don't come down to zero except at high lags
- Indicates non-stationarity if ACF decays very slowly

**Slide: ACF with confidence bands**
- Blue dashed lines: 95% confidence bands for hypothesis ρ(h) = 0 for all h
- For white noise series: $\hat{\rho}(h)$ approximately follow N(0, 1/T) distribution
- Confidence bands: ±1.96/√T
- Autocorrelation coefficients within bands: different from 0 only by chance
- Autocorrelation coefficients outside bands: truly significantly different from 0
- Note: expect ~5% (1 in 20) ACF coefficients to exceed bounds by chance

**Slide: Detecting patterns in ACF**
- Stationary series: ACF decays to zero rapidly
- Series with trend: ACF exhibits slow decay as lag increases
- Reason: if trend present, consecutive observations usually on same side of global mean; positive terms dominate numerator for small/moderate lags
- Result: sample autocorrelation close to 1
- Series with seasonality: ACF displays same wave-like structure as series; large autocorrelations at seasonal period lags
### Partial Autocorrelation (PACF)
**Slide: Concept of partial autocorrelation**
- If A highly correlated to B, and B highly correlated to C, then A usually highly correlated to C
- Useful to understand direct relation between A and C (excess to B's correlation)
- Partial autocorrelation: correlation between two variables assuming values of other variables known
- Measures excess correlation at lag h not accounted for by first h-1 lags
- Association between $X_t$ and $X_{t+h}$ with linear dependence of $X_{t+1}$ through $X_{t+h-1}$ removed

**Slide: PACF properties**
- 1st order partial autocorrelation equals 1st order autocorrelation
- Addresses autocorrelation "propagation" to higher lags
- Example: strong autocorrelation at lag 4 may cause apparent correlation at lags 8, 12, 16; PACF clarifies
## Diagnostic Checks of Residuals
Page refs: (pNN) = PDF page in [[materials/lectures/week-10/Time Series 2025 (UPDATED).pdf|master deck]] (7 slides).
### Purpose and Properties (p139-140)
**Slide: Diagnostic checks of residuals - purpose (p139-140)**
Properties of good residuals:
- No autocorrelation: if present, information left in residuals representing potential patterns; model hasn't captured all patterns
- Zero mean: if not, forecasts will be biased
- Constant variance
- Normally distributed
- Properties (i) and (ii) more important than (iii) and (iv)

**Slide: Residual sequence definition (p139-140)**
- Residual sequence: $\hat{\epsilon}_t$ (t=1, 2, ..., T)
- Obtained by subtracting fitted values from observed values
- Represent true error (noise) sequence; true random variation component $R_t$

**Slide: General strategy for residual diagnostic checks (p140)**
- Check all properties and proceed with caution if any suggests serious deviation from iid hypothesis
- If model satisfies these checks, does NOT mean it cannot be improved
- Possible to have several different forecasting methods for same dataset, all satisfying these properties
- Checking these properties important to see whether method using all available information
- NOT a good way to select forecasting method alone
### Ljung-Box Test (p139-145)
**Slide: Ljung-Box test statistic (p139)**
$$Q_{LB}(m) = T(T+2) \sum_{h=1}^{m} \frac{\hat{\rho}(h)^2}{T-h}$$
- T = length of time series
- $\hat{\rho}(h)$ = sample autocorrelation coefficients at lag h
- m = lag up to which test performed (typical: m = 1, 3, 5, 10, or 20)
- Tests joint hypothesis that all ACF coefficients up to lag m are simultaneously equal to zero
- Evaluates whether there is any significant autocorrelation in series

**Slide: Ljung-Box test hypotheses (p139)**
- $H_0$: There is no autocorrelation present in any of first m lags
- $H_1$: There is autocorrelation present in at least one of first m lags

**Slide: Ljung-Box distribution and degrees of freedom (p140)**
- On residuals of fitted model: Q has $\chi^2$ distribution with (m-K) df, where K = number of parameters
- On time series data (not residuals): set K=0; Q has m df

**Slide: Ljung-Box decision rule (p140)**
- Reject $H_0$ if Q > $\chi^2_{1-\alpha}(m-K)$ OR if p-value < α
- Test sensitive to large values of test statistic only
- Small values evidence $H_0$ is TRUE; only large values evidence $H_0$ is FALSE
- Interpretation: small p-value (p < 0.05) evidence of autocorrelation; reject independence hypothesis

**Slide: Ljung-Box test example (p141-145)**
100 daily closing stock prices on JSE. Sample autocorrelation coefficients up to lag 15 computed.
Test question: Is there any autocorrelation between daily closing price and any of previous 5 days' closing prices?
- Hypotheses: $H_0$: no autocorrelation at lags 1-5; $H_1$: significant autocorrelation at least one lag
- Test at 5% significance level

**Slide: Ljung-Box example calculation (p142-143)**
| Lag | Correlation |
|-----|-------------|
| 0 | 1 |
| 1 | 0.593 |
| 2 | 0.267 |
| 3 | 0.099 |
| 4 | -0.109 |
| 5 | -0.116 |

Test statistic: $Q_{LB}(5) = 100(102) \times \sum_{h=1}^{5} \frac{\hat{\rho}(h)^2}{100-h} = 47.39$
Critical value: $\chi^2_{0.05;5} = 11.070$
p-value < 0.005

**Slide: Ljung-Box test conclusion (p144-145)**
- Decision: Since 47.39 > 11.070 (OR p-value < 0.005) we Reject $H_0$
- Conclusion: There is autocorrelation between daily closing price and at least one of previous 5 days' closing prices
- Under null hypothesis of no autocorrelation, should not see more than 1 autocorrelation coefficient outside dotted lines
- Here, 3 coefficients lie outside; result of Ljung-Box test makes sense
- At lag 1, there is moderate positive autocorrelation (ρ = 0.593)
## In R
**Basic functions**
- `ses()` fits simple exponential smoothing model; returns forecast object
- `holt()` fits Holt's linear trend method; returns forecast object
- `HoltWinters()` or `hw()` fits Holt-Winters seasonal method
  - `seasonal = "additive"` or `"multiplicative"` specifies seasonality type
  - Default multiplicative fits method as taught
- `acf()` computes and plots autocorrelation function
- `pacf()` computes and plots partial autocorrelation function
- `Box.test(data, lag=m, type="Ljung-Box")` conducts Ljung-Box test
  - `type="Ljung-Box"` for Ljung-Box; `type="Box-Pierce"` for Box-Pierce alternative
- `checkresiduals()` produces residual plots and Ljung-Box test output

**Workflow**
- Fit exponential smoothing model: `model <- ses(data, h=forecast_horizon)`
- Extract forecasts: `model$mean`
- Extract fitted values: `model$fitted`
- Plot with forecasts: `autoplot(data) + autolayer(model, PI=FALSE, series="Method")`
- Assess accuracy on test set: `accuracy(model, test_data)`
- Check residuals: `checkresiduals(model)`
