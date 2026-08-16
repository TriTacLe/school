---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]], [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[week-10-exponential-smoothing-acf]], [[materials/lectures/week-11/Slide 183 HW.pdf|week-11 homework]], [[materials/lectures/week-12/Lecture16_TIMESERIES_IN_R_Example.pdf|R examples]], [[materials/lectures/week-12/Time Series Summary.pdf|summary]], [[materials/lectures/week-12/Time Series Exam Workshop Practice Questions.pdf|workshop questions]].
## TS Lecture 9: Stationarity and transformations
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]] (pages 10-12, 136-182).
### Stationarity (p12, p191)
**Slide: Stationarity definition and properties (p12)**
- Time series is stationary if its statistical properties constant over time (independent of time)
- Implies: constant mean AND constant variability over time
- Stationary series: no predictable patterns long-term; time plots roughly horizontal with constant variance
- Non-stationary series: with trends or seasonality; trend and seasonality affect values at different times

**Slide: Stationarity as process property (p191)**
- Property of process generating data, not data itself
- Hypothesis to test on data
- May reject hypothesis with certainty if data strongly speak against it
- Can never prove stationarity with certainty; at best plausible series originated from stationary process

**Slide: Making series stationary (p191)**
- Real-life data often non-stationary (trend, seasonal effect)
- Must transform non-stationary series to achieve stationarity
- Transformations remove trend/seasonality components via differencing, Box-Cox variance stabilization
### Transformations (p110-135)
**Slide: Box-Cox transformation (p116)**
Purpose: Stabilise variance when variance changes with level of series

Formula: $w_t = \begin{cases} \log(y_t) & \lambda = 0 \\ (y_t^\lambda - 1)/\lambda & \text{otherwise} \end{cases}$
- $\lambda$ determined by transformation; typically $\lambda = 0$ (log) or $\lambda = 0.5$ (square root)

Implementation:
- R function `BoxCox()` from forecast package automatically determines $\lambda$ by likelihood maximization
- Applies transformation using estimated $\lambda$
- Often used before differencing to handle variance instability

**Slide: First-order differencing (p?)**
- $w_t = y_t - y_{t-1}$ (t = 2, 3, ..., T)
- Removes linear trend from data
- Loses first observation; results in T-1 differenced values
- Example: Google stock prices with strong upward trend removed by first differencing

**Slide: Seasonal differencing (p?)**
- $w_t = y_t - y_{t-g}$ (t = g+1, g+2, ..., T) where g is length of seasonal period
- Example: g=12 for monthly data with 12-month seasonality
- Removes both seasonality and strictly linear trend
- Loses first g values; results in T-g differenced values
- Change compared to previous season (e.g., January 2024 vs. January 2023)

**Slide: Example: Gas production (p?)**
- Monthly data 1963-1976 shows upward trend with clear 12-month seasonality
- Low points in November, high points in August
- Seasonal differencing at lag g=12 removes pattern but variance still increases
- Apply log transformation first to stabilize variance: $\log(y_t)$
- Then seasonal difference logged data: $w_t = \log(y_t) - \log(y_{t-12})$
- Result: stationary series in mean, variance, and covariance

**Slide: Over-differencing (p?)**
- Common error: over-differencing; stop when standard deviation lowest
- If first lag autocorrelation more negative than -0.5: may indicate over-differencing
- If differencing increases standard deviation rather than reducing, reduce order

**Slide: Determining differencing order (p?)**
Visual inspection method:
- Before differencing: examine time plot; linear increase/decrease suggests first difference appropriate
- No obvious order: examine correlogram
- "Nice" correlogram decays fairly rapidly to zero
- High positive autocorrelations at 10+ lags: needs differencing
- Lag 1 autocorrelation zero or negative: doesn't need further differencing

Unit root testing (KPSS test):
- KPSS test: null hypothesis series is stationary; reject for small p-values
- R functions: `ndiffs()` determines appropriate first differences; `nsdiffs()` for seasonal differences
- Tests stationarity formally via sequence of KPSS tests

**Slide: Note on stationarity testing (p?)**
- Multiple tests available, sometimes conflicting
- All tests focus on specific non-stationarity aspects, not broad stationarity
- Low power for general non-stationarity detection
- Theory complex; beyond course scope
- Recommend visual inspection: primary tool is time plot; correlogram helpful second check
## TS Lecture 10: AR and MA models
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]] (pages 183-232).
### ACF/PACF Introduction (p183-211)
**Slide: ACF and PACF plots (p183)**
(content is a figure: autocorrelation and partial autocorrelation function plots for time series diagnosis)
### Autoregressive models (p217-228)
**Slide: AR(p) model definition (p217)**
- Observed value at time t depends linearly on last p observed values
- Like regression model (hence "autoregression")
- Future value assumed linear combination of p past observations, random error, and constant
- Autoregressive process: $X_t = c + \phi_1 X_{t-1} + \phi_2 X_{t-2} + \cdots + \phi_p X_{t-p} + \epsilon_t$
- $\epsilon_t$: white noise with mean 0 and variance $\sigma^2$
- c: constant related to process mean; often c=0 (zero mean)

**Slide: AR model applications (p?)**
- Mortality rates, GDP dynamics, climatology (El Nino, solar radiation)
- Volcanic tremors, brain electrical activity mapping
- Widely used by financial investors

**Slide: AR stationarity condition (p?)**
- Restrict AR models to stationary data
- AR(1) stationary only when $|\phi_1| < 1$
- As $\phi_1 \to 1$ or $\phi_1 \to -1$: stronger non-stationary behavior
- For $\phi_1 = 1$: "random walk" process (non-stationary trend)
- For $\phi_1 = -1$: "random jump" process (non-stationary variance)
- For $|\phi_1| > 1$: mean increases exponentially (non-stationary)

**Slide: AR(1) process properties (p?)**
- Mean: $\mu = \frac{c}{1 - \phi_1}$ (for stationary process)
- Variance: $V[X_t] = \frac{\sigma^2}{1 - \phi_1^2}$
- ACF: $\rho(h) = \phi_1^h$ (h = 1, 2, ..., T)
- ACF decays exponentially to 0 as lag $h \to \infty$
- 1st order autocorrelation equals $\phi_1$; subsequent decay exponentially

**Slide: AR(p) process properties (p?)**
- Mean: $E[X_t] = \mu = \frac{c}{1 - \phi_1 - \phi_2 - \cdots - \phi_p}$
- ACF decays to zero (stationarity requirement)
- PACF shows significant spike at lag p, but none beyond lag p
### Moving Average models (p229-231)
**Slide: MA(q) model definition (p229)**
- Uses past forecast errors in regression-like model (not past values)
- Current value weighted average of past "white noise" terms
- Moving average process: $X_t = c + \epsilon_t + \theta_1 \epsilon_{t-1} + \theta_2 \epsilon_{t-2} + \cdots + \theta_q \epsilon_{t-q}$
- $\epsilon_t$: white noise with mean 0 and variance $\sigma^2$

**Slide: MA vs. moving average smoothing (p?)**
- MA(q) model: seeks to model dependency structure in series
- MA(k) smoothing (used earlier): applied to smooth random variation or seasonal component
- Completely different concepts; same terminology can be confusing

**Slide: MA model applications (p?)**
- Evaluate effect of random events (natural disasters) on economic processes
- Any q-correlated process representable as MA process
- Widely used with AR processes to model vast range of series

**Slide: AR vs. MA differences (p?)**
- AR(p): includes lagged terms of series itself as explanatory variables; MA(q): includes lagged terms on forecast errors
- AR: uses actual values to form next realization; MA: uses only random component/forecast errors
- AR: depends on entire set of observations before time t; MA: depends on forecast errors only

**Slide: MA(q) process properties (p?)**
- Mean: $E[X_t] = c$
- Variance: $V[X_t] = \sigma^2 (1 + \theta_1^2 + \theta_2^2 + \cdots + \theta_q^2)$
- Stationarity: MA(q) always stationary (finite linear combination of white noise)
- Finite-memory model: linearly related only to first q lagged values
- ACF vanishes at lags greater than q (distinctive feature)

**Slide: MA(1) process (p?)**
- Simplest MA process: $X_t = c + \epsilon_t + \theta_1 \epsilon_{t-1}$
- Mean: $E[X_t] = c$
- Variance: $V[X_t] = \sigma^2 (1 + \theta_1^2)$
- Autocorrelation at lag 1: $\rho(1) = \frac{\theta_1}{1 + \theta_1^2}$
- Zero autocorrelation at lags >1 (memory of only 1 period)
- ACF shows single non-zero spike at lag 1; zero at all higher lags
## TS Lectures 11-15: ARIMA models and forecasting
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]] (pages 212-275).
### ARIMA models definition (p212-214)
**Slide: ARIMA models: AutoRegressive Integrated Moving Average (p212)**
- Mixture of AR(p) and MA(q) models
- Exponential smoothing: based on trend/seasonality description
- ARIMA: aims to describe autocorrelation in data
- Two most widely-used forecasting approaches (complementary)
- Use ARIMA for series where autocorrelation key; use exponential smoothing when trend/seasonality pattern-based

**Slide: ARIMA(p,d,q) model form (p?)**
- ARIMA(p,d,q) for non-stationary series modeled by both AR(p) and MA(q)
- Full form: $X_t = c + \phi_1 X_{t-1} + \phi_2 X_{t-2} + \cdots + \phi_p X_{t-p} + \epsilon_t + \theta_1 \epsilon_{t-1} + \theta_2 \epsilon_{t-2} + \cdots + \theta_q \epsilon_{t-q}$

**Slide: ARIMA parameters (p?)**
- p: number of autoregressive terms
- d: order of differencing (integration order)
- q: number of moving average terms
- Example: ARIMA(1,1,0) = AR(1) with first differencing
- Example: ARIMA(2,1,1) = AR(2) + MA(1) with first differencing

**Slide: The "I" in ARIMA: integration (p?)**
- "Integrated" means transforming data by taking differences
- ARIMA has been "Integrated" at order d if dth-order difference applied to non-stationary series makes it stationary
- Integration is reverse of differencing: back-transform forecasts to original scale
### General ARIMA modeling approach (p215-216)
**Slide: Step 1: Plot and examine data (p?)**
- Plot series; identify unusual observations, changing variance, trend, seasonality, sharp changes, outliers

**Slide: Steps 2-3: Transform and difference (p?)**
- Stabilize variance (Box-Cox if necessary)
- Remove trend/seasonality via differencing at appropriate lag to get stationary series

**Slide: Step 4: Choose ARIMA(p,d,q) (p?)**
- Based on autocorrelation nature using ACF/PACF plots
- Likely cannot specify single best model from ACF/PACF alone
- Practice: estimate various ARIMA(p,d,q) for ranges 0 ≤ p ≤ P and 0 ≤ q ≤ Q
- Compare models using information criteria (AIC)

**Slide: Steps 5-6: Parameter estimation and diagnostics (p?)**
Step 5: Estimate parameters
- Computer software estimates using MLE or method of moments
- Course: let R do this; not manually estimated

Step 6: Diagnostic checks of residuals
- Independence of error terms
- Mean of 0
- Normality of error terms
- Constant error variance (homoscedasticity)
- Should resemble white noise

**Slide: Step 7: Forecast (p?)**
- Using appropriate fitted model
- Likely range of similar models may work for same series
- Fit few different models; compare using AIC and forecast accuracy (MSE/RMSE, MAE)
### Model identification using ACF/PACF (p233-256)
**Slide: AR(p) model identification (p?)**
- ACF: exponentially decaying or sinusoidal pattern
- PACF: significant spike at lag p only; none beyond lag p
- Example patterns: AR(1) has PACF spike at lag 1 only; ACF geometric/sinusoidal decay
- If significant PACF up to lag 3 with slow ACF decay: AR(3) appropriate
- PACF coefficients ARE autoregressive model coefficients

**Slide: MA(q) model identification (p?)**
- ACF: significant spike at lag q only; none beyond lag q
- PACF: exponentially decaying or sinusoidal pattern
- Number of significant ACF coefficients outside dashed lines indicates q
- Example: MA(1) has ACF spike at lag 1 only; PACF geometric/sinusoidal decay
- If significant ACF up to lag 3: MA(3) appropriate

**Slide: Mixed ARIMA(p,d,q) model identification (p?)**
- Both ACF and PACF decay slowly to 0 OR both have sharp cut-off at low lags
- ACF sinusoidal, PACF geometric (or vice versa)
- Fit few low-order ARIMA(p,d,q) models and compare with AIC
- Example: ARIMA(3,1,3) shows slow decay in both
- Start with ARIMA(1,1,1), ARIMA(2,1,1), ARIMA(1,1,2), ARIMA(2,1,2); compare AIC

**Slide: Decision guide flowchart (p?)**
1. Is time-plot stationary? If NO: difference data; if YES: continue
2. Does correlogram decay to zero? If NO: difference more; if YES: continue
3. Is there sharp cut-off in correlogram? If YES: MA model; if NO: continue
4. Is there sharp cut-off in partial correlogram? If YES: AR model; if NO: ARMA model

**Slide: Important notes on model identification (p?)**
- Determining model order from ACF/PACF NOT exact science; serves as guide
- Seldom fit only one model; always fit suggested model plus similar models
- Compare all on AIC values for final selection
- Model order selection: visual patterns from ACF/PACF + AIC comparison = best practice
### Model selection criteria (p258-259)
**Slide: Information criteria: AIC (p?)**
- AIC (Akaike Information Criterion): $AIC = -2\ln(L) + 2k$
  - L: maximum likelihood value
  - k: number of parameters (p+d+q)
  - Lower AIC = better model
- Used to compare candidate ARIMA models
- Balances goodness-of-fit with model complexity

**Slide: Forecast accuracy measures (p?)**
- MAE: Mean Absolute Error = $\frac{1}{n}\sum |Y_t - \hat{Y}_t|$
- MSE: Mean Squared Error = $\frac{1}{n}\sum (Y_t - \hat{Y}_t)^2$
- RMSE: Root Mean Squared Error = $\sqrt{MSE}$
- Compare models on test set (data not used for fitting)
- Training set accuracy uninformative; can overfit
## In R
**ARIMA fitting and diagnostics**
- `arima()` fits ARIMA(p,d,q) model to data; specify order=c(p,d,q)
  - Returns fitted model object with coefficients and AIC
  - Example: `arima(data, order=c(1,1,0))`
- `auto.arima()` automatically selects ARIMA(p,d,q) using AIC
  - Convenient but check plots; not always best for interpretation
  - Example: `auto.arima(data)`
- `forecast()` generates forecasts from fitted model
  - Specify horizon h for h-step-ahead forecasts
  - Example: `forecast(model, h=12)`
- `checkresiduals()` produces diagnostics
  - Residual plot, ACF, Ljung-Box test output
  - Checks for white noise residuals
  - Example: `checkresiduals(model)`
**Transformation and differencing**
- `BoxCox()` applies Box-Cox transformation
  - `lambda` parameter estimated automatically
  - Example: `transformed_data <- BoxCox(data, lambda=NULL)` (NULL auto-estimates)
- `diff()` computes differences
  - `lag` parameter for lag g
  - Example: `diff(data, lag=1)` for first differences; `diff(data, lag=12)` for seasonal
- `ndiffs()` determines first differencing order (KPSS-based)
- `nsdiffs()` determines seasonal differencing order
**ACF and PACF plots**
- `acf()` plots autocorrelation function
- `pacf()` plots partial autocorrelation function
- `ggAcf()` and `ggPacf()` from ggplot2-style alternatives (modern)
- Interpretation: significant spikes outside dashed blue lines indicate autocorrelation
**Workflow example**
```r
# Plot original data
plot(data)
# Check stationarity
ndiffs(data)  # suggests d=1 or d=2
nsdiffs(data) # suggests seasonal differences
# Transform and difference
transformed <- BoxCox(data, lambda=NULL)
differenced <- diff(transformed, lag=12)
differenced <- diff(differenced, lag=1)
# Check ACF/PACF to identify p,q
acf(differenced)
pacf(differenced)
# Fit candidate models
model1 <- arima(data, order=c(1,1,0))
model2 <- arima(data, order=c(0,1,1))
model3 <- arima(data, order=c(1,1,1))
# Compare AIC
AIC(model1, model2, model3)
# Check best model diagnostics
checkresiduals(model1)
# Forecast
forecast_values <- forecast(model1, h=12)
plot(forecast_values)
```
## In R: Time Series Examples
Lecture16_TIMESERIES_IN_R_Example.pdf provides practical R code examples for implementing time series models, ARIMA fitting, diagnostics, and forecasting workflows with real data.
## Exam workshop
Practice questions covering all time series topics:
**Question 1: Classical decomposition and exponential smoothing**
- Time series components: discuss observed/unobserved components in time plot
- Moving average smoothing: explain concept, centered MA, window choice
- Classical decomposition: calculate seasonal indices, detrended data, deseasonalized series, fit trend regression
- Simple forecasting methods: compare average, naive, seasonal naive, drift methods
- Exponential smoothing: compare SES, Holt linear trend, Holt-Winters models; interpret parameters; calculate MAE/MSE
- Prediction intervals: calculate upper/lower bounds at 80% and 95% confidence levels
**Question 2: ARIMA and model selection**
- Time series components: identify trend, seasonality, cyclical variation in time plot
- Stationarity assessment: visual inspection, ACF analysis, determine need for differencing
- Box-Cox transformation: interpret lambda value; compare log vs. square-root transformations
- Differencing: apply seasonal and first differencing; assess stationarity of transformed series
- ACF/PACF interpretation: determine ARIMA(p,d,q) order from plot behavior
- AR model identification: recognize patterns; estimate parameters; write model equation
- MA model identification: recognize patterns; estimate parameters; write model equation
- Residual analysis: interpret residual plots, ACF, Ljung-Box test; assess model adequacy
- Model comparison: select best among multiple ARIMA models using AIC and forecast accuracy
- Forecasting: generate predictions using fitted ARIMA model
