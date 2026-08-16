---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]], [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[materials/reference/course-mindmap.pdf|mindmap]], [[materials/lectures/week-09/Week 1 Homework Exercises.pdf|homework exercises]].
## L1: Introduction to Time Series Analysis
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]] (100 slides covering L1-L4).
### What is Time Series Data (p3)
**Slide: Time Series vs. Cross-Sectional Data (p3)**
- Cross-sectional data: observed or measured at one point in time (e.g., final STA2020 marks)
- Time series: any variable regularly measured over time in sequential order at fixed, equally spaced intervals (hourly, daily, weekly, monthly, quarterly, yearly)
- Definition: sequence of observations collected at regular, equally spaced intervals over a period of time
- Extremely common across all fields: business (sales figures, production numbers, customer frequencies), economics (stock prices, exchange rates, interest rates), official statistics (census data, personal expenditures, road casualties)
### Why Time Series Analysis (p8-9)
**Slide: Why Time Series Analysis (p8)**
- Economic conditions vary over time; businesses need to forecast future events and plan accordingly
- Time series analysis isolates and quantifies influences and changes to build forecasting models
- Standard inferential techniques assume independence of observations (e.g., regression) but time series observations are typically dependent
- Autocorrelation at lag g: dependence between observations g time periods apart
- Past patterns continue into the future; time series analysis aims to identify and isolate these patterns

**Slide: Basic Assumption Underlying Time Series Forecasting (p9)**
- Assumption: factors that influenced patterns in past and present will continue in more or less the same manner in future
- Overall purpose: identify and isolate influencing factors from past to better understand time series process for predictive purposes
- Can conduct time series analysis to: a) develop understanding of pattern behavior and factors, b) develop model capturing relevant information to forecast future values, c) other uses outside this course
### Two Fundamental Time Series Concepts (p10-12)
**Slide: Autocorrelation (p11)**
- Basic assumption in inference: observations are independent (random sample)
- Autocorrelation (serial correlation): observations correlated with one another because data from same variable at equally spaced intervals
- Multiple linear regression fails when sample collected over time and model doesn't capture trends well
- Most time series dependent, exhibiting significant autocorrelation at some lag g (lag = number of time periods between observations where autocorrelation measured)
- Autocorrelation represents useful information for forecasting; time series models leverage it

**Slide: Stationarity (p12)**
- Time series is stationary if its statistical properties are constant over time (independent of time)
- Stationarity implies: constant mean AND constant variability over time
- Stationary series have no predictable patterns long-term; time plots roughly horizontal with constant variance
- Non-stationary series with trends or seasonality: trend and seasonality affect values at different times
- Most real time series are non-stationary; must transform to achieve stationarity before analysis
## L2: Time Series Graphics and Components
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]].
### Time Series Plots (p13-14)
**Slide: Time series plot (p14)**
- First step in time series analysis: plot data and observe patterns over time using time series plot/line graph
- Line graph of observed data $y_t$ against time $t$
- Successive changes comparable because all relate to common time interval between observations
- Enables detection and description of patterns/factors/components
- Identified components help find suitable statistical model for forecasting based on assumption past patterns continue
### Components of Non-Stationary Time Series (p15-32)
**Slide: 4 components overview (p15)**
- Trend (T): long-term tendency, upward/downward/flat movement
- Cyclical variation (C): irregular long-term wavelike movements
- Seasonal variation (S): regular short-term repetitive wavelike movements
- Irregular/Random variation (R): random variations from unforeseen events
- Must be able to describe each component and identify in time series plot
- All time series include random variation; may include none, one, two, or all three other components

**Slide: Trend component (p16)**
- Long-term tendency of time series (upward/downward/flat movement over time)
- Result of long-term factors (population increases, consumer preferences)
- Can be linear or nonlinear
- Duration much longer than one time period
- Assume predictable into future
- When describing: be specific about direction (increasing/decreasing) and whether linear or nonlinear

**Slide: Cyclical variation (p19-20)**
- Irregular long-term wavelike movements through time series
- Due to extended periods of prosperity/booms followed by recession/depression/recovery in economy
- Duration not fixed; successive cycles usually not same length
- Cycle usually lasts at least 2 years (typical range 2-10 years)
- Cyclicality does not repeat continuously; usually only few cycles if present
- Assume predictable because appears to have repetitive pattern

**Slide: Seasonal variation (p22-24)**
- Regular short-term repetitive wavelike movements through time series
- Often when data recorded hourly, daily, weekly, monthly or quarterly; repeats throughout series
- Variations short term (a year or less), usually repeat during same calendar periods
- Duration typically fixed (same pattern repeats each year, week, etc.)
- Seasonal does NOT just refer to 4 weather seasons
- Can be predicted because pattern repeated many times (e.g., 24 hours/day, 7 days/week, 12 months/year, 4 quarters/year)

**Slide: Irregular/Random variation (p25)**
- Random variations in data due to combined effects of unforeseen events (war, strikes, natural disasters, power cuts)
- Duration short and non-repeating; emerges as variance
- No defined statistical technique for estimating random fluctuations; cannot be predicted
- Tends to hide other predictable components, especially when large relative to pattern
## L3: Time Series Model and Moving Average Smoothing
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]].
### Time Series Models (p34-36)
**Slide: Additive and Multiplicative Models (p35)**
- Additive model (components independent): $Y_t = T_t + C_t + S_t + R_t$
- Multiplicative model (components interdependent): $Y_t = T_t \times C_t \times S_t \times R_t$
- Multiplicative preferred because: can be made additive by taking logarithm, other components interpretable as indexes relative to trend, common for economic time series where variation in seasonal pattern proportional to series level
- Additive appropriate when magnitude of seasonal fluctuations doesn't vary with series level

**Slide: Multiplicative model for STA2020 (p36)**
- For this course: focus on multiplicative model with cyclical component negligible ($C_t = 1$)
- Simplified: $Y_t = T_t \times S_t \times R_t$
- When goal is not forecasting but understanding patterns in time series (trend and seasonal components)
- Often impossible or very difficult to identify components by graphing series alone due to random variation
- If no obvious pattern: moving average smoothing used to smooth series and dampen error terms
- If obvious pattern: variety of forecasting methods considered depending on data nature
### Moving Average Smoothing (p38-51)
**Slide: Moving Average concept (p38)**
- Observations close together in time likely have similar values
- Moving average method "smoothes" data (removes some random variation) by "moving" arithmetic mean over window of values through series
- Calculate mean of first window of observations (e.g., 3 observations) then move window to exclude first observation and include next three
- Compute mean of series of observations taken over k consecutive time periods over entire series
- Notation: MA(k) for moving average with window of length k consecutive time periods
- Results in T - k + 1 smoothed values

**Slide: Computing MA(k) (p39)**
- First moving average: average of first k consecutive values ($y_1, y_2, \ldots, y_k$)
- Second moving average: average of next batch excluding first value ($y_2, y_3, \ldots, y_{k+1}$)
- Third moving average: average excluding first two values ($y_3, y_4, \ldots, y_{k+2}$)
- Process continues until average of last batch of k consecutive values computed
- Total: $T - k + 1$ smoothed values

**Slide: Plotting Moving Averages (p40)**
- When plotting moving averages on chart, each computed value plotted against middle period of sequence used to compute it
- Each value associated with mid-point of time window
- For $k=3$: MA values align with $t=2, 3, 4$, etc. (middle of each 3-period window)
- Formula for midpoint: $t = 1 + \frac{k-1}{2}$

**Slide: Centered Moving Average (p48-51)**
- When k is even, MA doesn't correspond to any time period in original series
- Solution: average two adjacent MA(k) values to centre the smoothed values
- For k=4: compute CMA(4) by averaging pairs of MA(4) values
- When k is even, lose more observations but smoother curve results

**Slide: Choice of Window Width (p60)**
- $k$ should be chosen to minimize random variation to get better estimate/understanding of underlying components
- If data quarterly: $k=4$ (four quarters in year)
- If data daily: $k=7$ (seven days in week)
- Larger $k$: smoother curve but loses more observations (first $k-1$ and last $k-1$ periods unavailable)
- Smaller $k$: retains more data but less smooth
- If $k$ too large: smoothed series tends towards straight line (may defeat purpose unless only trend present or want to see trend influence)
- For seasonal data: commonly use $k$ equal to seasonal period (e.g., $k=12$ for monthly, $k=4$ for quarterly)
- Choice of $k$ also depends on what you want to achieve

**Slide: Moving Averages Advantages/Disadvantages (p64)**
- Advantage: quick and easy to apply
- Problem: lose $k-1$ observations if $k$ odd, $k$ observations if $k$ even (after averages centered)
  - For $MA(3)$: no moving average value for first and last time period
  - For $MA(4)$: after centering there is no moving average value for first and last period
- Once observation falls out of window, never considered again; has implications for forecasting future values
- Larger k: fewer moving averages computed and plotted; sometimes difficult to obtain overall impression of entire series
## L4: Classical Time Series Decomposition
Page refs: (pNN) = PDF page in [[materials/lectures/week-09/Time Series 2025 (UPDATED).pdf|master deck]].
### Classical Decomposition Method (p65-72)
**Slide: Time Series Decomposition (p65)**
- Gaining better understanding of patterns in historical time series data
- References fpp Chapter 3, Sections 3.2-3.4

**Slide: Classical decomposition overview (p66)**
- Decompose time series primarily to get better understanding of underlying components (trend and/or seasonality) and how they affect variable of interest
- Important to develop clear understanding of what seasonal variation is: does NOT just refer to 4 weather seasons
- 4 weather seasons observed may contribute to seasonal component in data, but they are not the seasonal component themselves

**Slide: Classical decomposition process (p71)**
Process involves 6 steps:
1. Estimate trend by moving average smoothing (CMA)
   - Choose appropriate $k$ (usually seasonal period)
   - Apply $CMA(k)$ to estimate trend component
2. Detrend series: divide original by trend estimate (multiplicative): $Y_t / \hat{T}_t$, leaves $S_t \times R_t$
3. Calculate seasonal indices
   - Average detrended values for each season across all years
   - Sum of seasonal indices should equal $m$ (seasonal period): $\sum S_i = m$
   - Adjust proportionally if not exactly $m$
4. Extract random component: $R_t = \frac{Y_t}{\hat{T}_t \times \hat{S}_t}$
5. Deseasonalize original series: $\frac{Y_t}{\hat{S}_t} = DS_t = T_t \times R_t$
   - Leaves trend and random; deseasonalized series smoother for trend estimation
6. Fit linear regression to deseasonalized data
   - If trend linear: $\hat{T}_t = \hat{\beta}_0 + \hat{\beta}_1 t$
   - Regress deseasonalized observations on time $t$

**Slide: Isolating components (p72)**
- Most often encounter time series with both trend and seasonality
- In such cases, isolate components (separate from each other) in original series
- Isolate seasonal variation by removing trend component (de-trending) and computing seasonal indexes
- Seasonal indices simply average of all values in each season
- Indices help gauge degree to which seasons differ from one another relative to overall seasonal average
- Recall $C_t$ negligible for this course: $Y_t = T_t \times S_t \times R_t$
### Classical Decomposition Example (p73-98)
**Slide: Quarterly earnings data (p73)**
Quarterly earnings (in R millions) of large drink manufacturer, years 1997-2000:

| Year | Q1 | Q2 | Q3 | Q4 |
|------|----|----|----|----|
| 1997 | 52 | 67 | 85 | 54 |
| 1998 | 57 | 75 | 90 | 61 |
| 1999 | 60 | 77 | 94 | 63 |
| 2000 | 66 | 82 | 98 | 67 |

Task: decompose into components, estimate components, build model for forecasting future quarterly earnings

**Slide: Step 1 - Estimate trend (p74)**
- Develop crude estimate of trend component by calculating (centered) moving averages (CMAs)
- $CMA \approx \hat{T}_t$

**Slide: Step 2 - De-trend series (p77)**
- For each time period: $\frac{Y_t}{CMA(k)_t}$
- De-trending results in measure of seasonal variation and random variation
- Multiplicative model: $\frac{Y_t}{CMA(k)_t} \approx \frac{T_t \times S_t \times R_t}{T_t} = S_t \times R_t$

**Slide: Step 3 - Calculate seasonal indices (p80)**
- Group de-trended data by corresponding seasons (e.g., by quarters or months)
- Take average of data values in each season to get seasonal indices
- Average the de-trended data for each m types of season present
- In example: group corresponding quarters together and take averages

**Slide: Seasonal indices adjustment (p86)**
- Under multiplicative model: if no seasonal component, $S_t = 1$ for all $m$ seasons
- Sum of all $S_t$ would equal $1 \times m = m$
- Property also applies when seasonal component present; indices fluctuate around 1
- Must adjust $m$ seasonal indices so sum equals $m$ (average for $m$ seasons equals 1)
- Indices often don't sum exactly to $m$ because of random variation influence
- Correction factor = $\frac{m}{\text{sum of } m \text{ seasonal indices}}$

**Slide: Adjusted seasonal indices (p88)**
Example calculation:
- $S_1 = 0.839$: Q1 values average 16.1% below annual average earnings ($100 \times |0.839-1|$)
- $S_2 = 1.057$: Q2 values average 5.7% above annual average earnings
- $S_3 = 1.275$: Q3 values average 27.5% above annual average earnings
- $S_4 = 0.829$: Q4 values average 17.1% below annual average earnings

**Slide: Interpreting seasonal indices (p89)**
- If no seasonal component: $S_t = 1$ in every time period
- When seasonality present: indices fluctuate above and below 1
- $S_t > 1$: on average, values in that season are $100 \times |S_t - 1|$% above seasonal average (where seasonal = length of seasonal variation)
- $S_t < 1$: on average, values in that season are $100 \times |S_t - 1|$% below seasonal average

**Slide: Step 4 - Extract random component (p91)**
- Divide original time series by product of trend and seasonal estimates
- $R_t = \frac{Y_t}{\hat{S}_t \times CMA(k)_t}$

**Slide: Step 5 - Deseasonalize series (p93)**
- Divide observed series value by corresponding adjusted seasonal index
- Deseasonalized multiplicative model: $\frac{Y_t}{\hat{S}_t} \approx T_t \times R_t = DS_t$
- Deseasonalized series smoother, easier to estimate trend
- Removal of seasonal component leaves trend and random

**Slide: Step 6 - Fit regression to deseasonalized data (p97)**
- If trend linear: $\hat{T}_t = \hat{\beta}_0 + \hat{\beta}_1 t$
- Regress deseasonalized observations on time $t$
- Provides good estimate of trend component if trend looks linear
- Now have more precise estimates of both seasonal component (via seasonal indices) and trend component (via regression analysis)
### Forecasting with Classical Decomposition (p99)
**Slide: Forecast equation (p99)**
- $\hat{Y}_t = (\hat{\beta}_0 + \hat{\beta}_1 t) \times \hat{S}_t$
- Multiply trend forecast by corresponding seasonal index
- For future period $T+h$, use seasonal index from same season $h$ periods back
- Don't cover forecasting example here since not recommended for forecasting
- Try past examples in tutorials and tests to get practice
### Drawbacks of Classical Decomposition (p100)
**Slide: Why not recommended (p100)**
- Trend estimate unavailable for first few and last few observations (due to MA smoothing)
- No remainder component estimate for same periods
- Trend tends to over-smooth rapid rises and falls
- Assumes seasonal component repeats year-to-year; doesn't capture seasonal changes over time in longer series
- Not robust to unusual values; small number of particularly unusual observations can distort results
- More sophisticated methods now available
