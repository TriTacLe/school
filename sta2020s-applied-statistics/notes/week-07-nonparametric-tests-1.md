---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[materials/reference/statistical-tables.pdf|tables]], [[materials/lectures/week-07/NP L1 to L4 R Examples.pdf|R examples]].
## Lecture 1: Introduction to Nonparametric Techniques
Page refs: (pNN) = PDF page in [[materials/lectures/week-07/L1_L4_NP.pdf|L1-L4 nonparametric deck]] (94 slides).
### Learning Outcomes (p2)
- Understand what nonparametric statistical techniques are and when they are useful
- Know the difference between parametric and nonparametric techniques
- Understand the different data types and be able to classify any data into its type
- Know how to rank a sample of data values
- Understand how to deal with ties in the data values
### Parametric Techniques (p3)
**Slide: Introduction to Parametric Techniques (p3)**
- Statistical techniques up to this point have required knowing the underlying distribution (typically normal)
- Sample size must be sufficient to rely on the central limit theorem for normality
- Based on these assumptions, sampling distribution of test statistics derived and inferences made about unknown parameters
- Applicable only to quantitative data

**Slide: Examples of Parametric Approaches (p4)**
- Estimating population mean $\mu$ when population variance $\sigma^2$ is unknown and $n < 30$
- Hypothesis tests for $\sigma^2$
- Both assume underlying population distribution is normal
### Nonparametric Techniques (p4-5)
**Slide: What about unknown distributions, small samples, and qualitative data? (p4)**
Nonparametric techniques address situations where:
- Distribution is unknown or non-normal
- Sample sizes are small
- Data are qualitative (nominal or ordinal)

**Slide: Introduction to Non-Parametric Techniques (p4-5)**
Nonparametric techniques make only weak assumptions:
- Make weak assumptions about underlying distribution (may assume symmetry)
- Do not refer to any specific parameter of a population's distribution
- Independence of observations and random samples still required
- Most test statistics do not depend on actual numerical values; performed on ranks of data
- Also called distribution-free statistics

**Slide: When to use Nonparametric tests (p5-6)**
- Used for non-normal (or when doubt about) quantitative, nominal, and ordinal data
- If normally distributed quantitative data, parametric tests preferred (more statistical power)
- Power = probability that test rejects $H_0$ when $H_a$ is true (probability of not committing Type II error)
- Nonparametric tests are always valid, though sometimes not optimal in power
### Data Types (p6-11)
**Slide: Review of Data Types (p6)**
Classification of random variables:
- **Qualitative (Categorical)**: Nominal, Ordinal
- **Quantitative (Numeric)**: Interval, Ratio-scaled

**Slide: Data Types (p7)**
- **Nominal**: categories without order (e.g. ZIP code, color, gender). Cannot interpret differences as meaningful.
- **Ordinal**: categories with order (e.g. grade symbol, Likert scale, business size). Can be ranked but differences between categories are not necessarily meaningful.
- **Interval**: numeric, equal spacing, no true zero (e.g. temperature in C, money, time). Ratios between values not meaningful.
- **Ratio-scaled**: numeric, equal spacing, true zero (e.g. height, weight, temperature in K). Ratios between values meaningful.

**Slide: Interval vs Ratio - Clock time (p8)**
- Time has natural order
- Differences between points equal (12pm to 1pm = 4pm to 5pm = 1 hour)
- No meaningful zero point (no "zero time")
- Ratios not meaningful: 2pm is NOT twice as "old" as 1pm

**Slide: Interval vs Ratio - Duration (p8-9)**
- Duration/length of time (e.g. seconds) has natural order and equal distances
- Has true zero: 0 seconds is meaningful
- Ratios ARE meaningful: 10 seconds is twice as long as 5 seconds

**Slide: Examples 1-5 (p9)**
Classify these as nominal, ordinal, interval, or ratio:
1. Number of students in statistics class
2. Make of car driven by executives
3. Rating (Extremely poor[1] to Excellent[7]) for TV program
4. Weekly closing price of gold throughout year
5. Month of highest sales for each firm

**Slide: Examples 6-10 (p10)**
6. Socioeconomic status of Cape Town residents (upper/middle/lower class)
7. Five-point rating (1=Strongly Disagree to 5=Strongly Agree) for statement about time zones
8. Gender of UCT employees
9. Maximum temperature in March 2013 (in C)
10. Rating (excellent/good/fair/poor) for TV program
### Overview of Nonparametric Tests (p11-15)
**Slide: Tests for a single population (p12)**
Tests for randomness of order (RUNS test): nominal data, independent observations
Chi-square Goodness-of-fit test: nominal data, independent observations

**Slide: Tests to compare two populations (p12-13)**

| Test | Data Type | Data Structure | Parametric Equivalent |
|------|-----------|-----------------|----------------------|
| Wilcoxon Rank Sum (Mann-Whitney U) | Ordinal or non-normal quantitative | Independent samples | t-test for difference of means |
| Wilcoxon Signed Rank Sum | Non-normal quantitative | Matched/paired samples | Matched pairs t-test |
| Sign Test | Ordinal | Matched/paired/dependent samples | Matched pairs t-test |

**Slide: Tests to compare three or more populations (p13-14)**

| Test | Data Type | Data Structure | Parametric Equivalent |
|------|-----------|-----------------|----------------------|
| Kruskal-Wallis | Ordinal or non-normal quantitative | Independent samples | Single factor one-way ANOVA |
| Friedman | Ordinal or non-normal quantitative | Matched/blocked dependent samples | Randomized block ANOVA |

**Slide: Tests for relationship between two variables (p14-15)**

| Test | Data Type | Data Structure | Parametric Equivalent |
|------|-----------|-----------------|----------------------|
| Spearman's Rank Correlation | Ordinal or non-normal quantitative | Two random samples | Pearson's correlation coefficient |
### Ranking of Data (p16-19)
**Slide: Ranking of Data (p16)**
To rank data:
- Order/arrange data in sequence (usually ascending)
- Identify relative position of each value in ordered data
- If no ties (two or more observations with same value): rank = relative position
- If ties exist: rank of tied observations = average of their relative positions

**Slide: Ranking Data - Example 1 (p17)**
Rank: 4, 9, 6, 7, 5, 2, 8

| Data | 4 | 9 | 6 | 7 | 5 | 2 | 8 |
|------|---|---|---|---|---|---|---|
| Ordered | 2 | 4 | 5 | 6 | 7 | 8 | 9 |
| Rank | 1 | 2 | 3 | 4 | 5 | 6 | 7 |

No ties, so ranks are as above.

**Slide: Ranking Data - Example 2 (p18)**
Rank: 29, 18, 29, 19, 20, 21, 34, 33, 30, 23

| Data | 29 | 18 | 29 | 19 | 20 | 21 | 34 | 33 | 30 | 23 |
|------|----|----|----|----|----|----|----|----|----|----|
| Ordered | 18 | 19 | 20 | 21 | 23 | 29 | 29 | 30 | 33 | 34 |
| Rank | 1 | 2 | 3 | 4 | 5 | 6.5 | 6.5 | 8 | 9 | 10 |

Ties: 29 appears twice (ranks 6 and 7) → assign 6.5 to both.

**Slide: Ranking Data - Example 3 (p19)**
Rank: 29, 18, 29, 19, 20, 21, 20, 33, 30, 23, 33, 33, 24

| Data | 29 | 18 | 29 | 19 | 20 | 21 | 20 | 33 | 30 | 23 | 33 | 33 | 24 |
|------|----|----|----|----|----|----|----|----|----|----|----|----|
| Ordered | 18 | 19 | 20 | 20 | 21 | 23 | 24 | 29 | 29 | 30 | 33 | 33 | 33 |
| Rank | 1 | 2 | 3.5 | 3.5 | 5 | 6 | 7 | 8.5 | 8.5 | 10 | 12 | 12 | 12 |

Ties: 20 (ranks 3-4 → 3.5), 29 (ranks 8-9 → 8.5), 33 (ranks 11-13 → 12).
### Sign Test (User Notes)
**Overview:** Tests whether median difference is zero for two paired/dependent samples. Uses only direction of differences, not magnitude. Less powerful than Wilcoxon signed-rank test but simpler.

**When appropriate:**
- Two dependent samples (paired observations)
- Ordinal or quantitative data
- Parametric assumptions fail or sample very small
- Only direction of difference matters

**Hypotheses:**
- $H_0$: median of differences = 0 (no difference)
- $H_a$ (two-sided): median of differences ≠ 0, OR (one-sided >): > 0, OR (one-sided <): < 0

**Procedure:**
1. For each pair: $d_i = X_i - Y_i$
2. Count: $S^+$ = number of positive differences, $S^-$ = number of negative
3. Discard zero differences (tied pairs); reduces n
4. Test statistic: $S = S^+$ (or equivalently $S^-$ depending on direction)
5. For $n \le 20$: use exact binomial table
6. For $n > 20$: $z = \frac{S - np}{\sqrt{np(1-p)}}$ with $p = 0.5$ under $H_0$
## Lecture 2: Wilcoxon Signed Rank Sum Test
Page refs: (pNN) = PDF page in [[materials/lectures/week-07/L1_L4_NP.pdf|L1-L4 nonparametric deck]].
### Learning Outcomes (p21)
- Know conditions (data type, number of samples, relationship between samples, objective) for Wilcoxon Signed Rank Sum test
- Know assumptions and objective of test, able to conduct test for two matched/paired populations
### Quick Recap of Lecture 1 (p20)
**Slide: Quick recap (p20)**
1. Parametric techniques assume data from population with known/hypothesized distribution
2. Nonparametric techniques used for data not from known/hypothesized distribution; distribution free; use ranks, signs, or frequencies
3. Data types: Qualitative (Nominal, Ordinal), Quantitative (Interval, Ratio)
4. Ranking of data: order, rank, deal with ties
### When Is It Appropriate? (p22)
**Slide: Wilcoxon Signed Rank Sum Test (p22)**
Compare two matched/paired samples of quantitative (interval or ratio-scaled) data with respect to central locations (medians) to determine whether they come from same population.
- Equivalent to parametric paired t-test but uses ranks instead of means
- Parametric paired t-test: looks at mean of differences
- Wilcoxon: looks at median (central tendency) of differences
### Hypotheses (p22-23)
**Slide: Hypotheses (p22-23)**
$$H_0: \text{The location of paired differences} = 0 \text{ / The median difference} = 0$$
(Samples come from same population; no difference between samples)

Either:
$$H_1: \text{The median/location of paired difference} \ne 0 \text{ (two-sided test)}$$
OR:
$$H_1: \text{The median/location of paired difference} > 0 \text{ (one-sided test)}$$
OR:
$$H_1: \text{The median/location of paired difference} < 0 \text{ (one-sided test)}$$

Note: State hypotheses using information from question context; do not simply state theoretical hypotheses in test or exam.
### Data and Assumptions (p24-25)
**Slide: Data and Assumptions (p24-25)**
- Two paired samples
- Data quantitative but not normal
- Under $H_0$, distribution of population of differences within pairs is symmetric around median
- $n$ paired differences are independent
### Calculating the Test Statistic (p25)
**Slide: Calculating the test statistic (p25)**
1. Calculate difference for each pair
2. Eliminate all differences equal to 0
3. $n$ = number of non-zero paired differences
4. Record sign of paired differences
5. Rank absolute value of paired differences
6. $W$ = sum of signed ranks of paired differences

Note: useful to construct table to complete steps 1-5.
### Logic Behind the Test (p26-28)
**Slide: Logic behind the test (p26-27)**
Under $H_0$ (median difference is zero), expect:
- Distribution of differences between paired observations is symmetric around zero
- As many positive differences as negative differences
- Example: weight before/after weight loss drug. If drug not effective, expect roughly equal number who lost weight and gained weight
- No consistent pattern in differences
- Test ranks absolute values regardless of sign, then re-applies sign
- If $H_0$ true, distribution of positive and negative ranks should be random across ranks
- No systematic bias where larger/smaller ranks consistently positive/negative
- Sum of signed ranks ($W$) should be close to zero

**Slide: Logic behind the test (continued) (p27-28)**
- If larger ranks more positive, first sample tends to be greater than second sample; null hypothesis not valid
- Expect $W$ greater than zero
- Example: weight loss study. If consistently see all large ranks (large differences) positive, suggests systematic change, contradicts null hypothesis
- Ask: how far from zero does $W$ have to be (either direction for two-sided) to reject $H_0$?
### Sampling Distribution of W (p28-30)
**Slide: Sampling distribution of W (p28-29)**
- For small $n$, possible to deduce properties of sampling distribution of $W$ through enumeration
- Example with $n = 3$ (ranks 1, 2, 3): $W$ can equal +6, +4, +3, 0, 0, -2, -4, -6
- For small $n$, specific table of critical values exists
- For $n > 10$, sampling distribution of $W$ becomes approximately normal

**Slide: Sampling distribution of W (large sample) (p30)**
For $n > 10$:
$$z = \frac{W - \mu_W}{\sigma_W} \text{ where } \mu_W = 0 \text{ and } \sigma_W = \sqrt{\frac{n(n+1)(2n+1)}{6}}$$

**Critical region:**
- Reject $H_0$ if $|z| \ge z_{\alpha/2}$ (two-sided test)
- OR if $z > z_\alpha$ (one-sided > test)
- OR if $z < -z_\alpha$ (one-sided < test)
- OR if calculated p-value $\le \alpha$ (p-value approach)
### Example 1: Flexitime Work Schedule (p31-43)
**Slide: Flexitime example context (p31)**
Does a flexitime work schedule help reduce worker travel time to work? Random sample of 32 workers recorded travel time before and after program implementation. Test at 5% significance level using p-value approach.

**Slide: Flexitime data (p32-35)**

| Worker | 8:00-Arr | Flextime | Worker | 8:00-Arr | Flextime |
|--------|----------|----------|--------|----------|----------|
| 1 | 34 | 31 | 17 | 41 | 38 |
| 2 | 35 | 31 | 18 | 25 | 23 |
| 3 | 43 | 44 | 19 | 17 | 14 |
| 4 | 46 | 44 | 20 | 26 | 21 |
| 5 | 16 | 15 | 21 | 44 | 40 |
| 6 | 26 | 28 | 22 | 30 | 33 |
| 7 | 68 | 63 | 23 | 19 | 18 |
| 8 | 38 | 39 | 24 | 48 | 51 |
| 9 | 61 | 63 | 25 | 29 | 33 |
| 10 | 52 | 54 | 26 | 24 | 21 |
| 11 | 68 | 65 | 27 | 51 | 50 |
| 12 | 13 | 12 | 28 | 40 | 38 |
| 13 | 69 | 71 | 29 | 26 | 22 |
| 14 | 18 | 13 | 30 | 20 | 19 |
| 15 | 53 | 55 | 31 | 19 | 21 |
| 16 | 18 | 19 | 32 | 42 | 38 |

**Slide: Flexitime hypotheses (p33)**
$H_0$: There is no difference in travel time between normal work-hour and flexitime programs. Median difference is zero.

$H_1$: Workers take longer to travel during normal work-hour program, i.e. workers take less time during flexitime. Median difference greater than zero (one-sided > test).

**Slide: Flexitime ranking table (p36-39)**
After calculating differences, absolute values, ranks, and signed ranks, with multiple ties (especially |Diff| = 3 and 2 appearing 8 times, requiring average ranks):
- Difference magnitude 1: average rank 4.5
- Difference magnitude 2: average rank 13
- Difference magnitude 3: average rank 21
- Difference magnitude 4: average rank 27
- Difference magnitude 5: average rank 31

$$W = \text{sum of positive signed ranks} = 207$$
$$n = 32 \text{ (number of non-zero differences)}$$

**Slide: Flexitime test statistic (p40-41)**
$n = 32 > 10$, use normal approximation.
$$\sigma_W = \sqrt{\frac{32(33)(65)}{6}} = \sqrt{\frac{68640}{6}} = \sqrt{11440} \approx 106.958$$
$$z = \frac{207 - 0}{106.958} \approx 1.935 \approx 1.94$$

**Slide: Flexitime p-value and conclusion (p42-43)**
p-value = $1 - 0.9738 = 0.0262$

Since p-value $= 0.0262 < 0.05$, reject $H_0$ at 5% significance level. Conclude that workers do take longer to travel during normal hours than flexitime; sufficient evidence that flexitime reduces workers' travel time.
### Example 2: Student Probability Test Understanding (p43-47)
**Slide: Probability test example context (p43)**
16 students answer two basic probability questions (A and B), rate confidence in answers. Instructor hypothesizes: if students understand probability, will give higher probabilities for A than B. If not listened in class, answers random with no tendency.

**Slide: Probability test data (p44)**
$$H_0: \text{Median of differences between probabilities for A and B is zero. No difference.}$$
$$H_1: \text{Median of differences between probabilities for A and B is greater than zero. Probabilities for A higher than B.}$$

| Subject | $X_A$ | $X_B$ | $X_A - X_B$ |
|---------|-------|-------|-------------|
| 1 | 78 | 78 | 0 |
| 2 | 24 | 24 | 0 |
| 3 | 64 | 62 | +2 |
| 4 | 45 | 48 | -3 |
| 5 | 64 | 68 | -4 |
| 6 | 52 | 56 | -4 |
| 7 | 30 | 25 | +5 |
| 8 | 50 | 44 | +6 |
| 9 | 64 | 56 | +8 |
| 10 | 50 | 40 | +10 |
| 11 | 78 | 68 | +10 |
| 12 | 22 | 36 | -14 |
| 13 | 84 | 68 | +16 |
| 14 | 40 | 20 | +20 |
| 15 | 90 | 58 | +32 |
| 16 | 72 | 32 | +40 |

Median difference = +5.5

**Slide: Probability test ranking and signed ranks (p44-45)**
After ranking absolute differences with tie handling:
- $|X_A - X_B| = 4$ (subjects 5, 6): ranks 3.5
- $|X_A - X_B| = 10$ (subjects 10, 11): ranks 8.5
$$W = 67.0 \text{ (sum of positive signed ranks: 1 + 5 + 6 + 7 + 8.5 + 8.5 + 11 + 12 + 13 + 14)}$$
$$n = 14 \text{ (excluding two zero differences)}$$

**Slide: Probability test statistic (p45-46)**
$n = 14 > 10$, use normal approximation.
$$\sigma_W = \sqrt{\frac{14(15)(29)}{6}} = \sqrt{\frac{6090}{6}} = \sqrt{1015} \approx 31.86$$
$$z = \frac{67 - 0}{31.86} \approx 2.10$$

**Slide: Probability test p-value and conclusion (p46-47)**
p-value = $1 - 0.9821 = 0.0179$

Since p-value $= 0.0179 < 0.05$, reject $H_0$ at 5% significance level. Conclude that median of differences between probabilities for A and B is greater than zero. Students give higher probabilities for question A than question B.
## Lecture 3: Mann-Whitney-Wilcoxon Test
Page refs: (pNN) = PDF page in [[materials/lectures/week-07/L1_L4_NP.pdf|L1-L4 nonparametric deck]].
### Learning Outcomes (p50)
- Know differences between Wilcoxon Signed Rank Sum Test and Mann-Whitney-Wilcoxon Test
- Know conditions (data type, number of samples, relationship between samples, objective) for Mann-Whitney-Wilcoxon test
- Know data assumptions
- Be able to conduct the test
### Quick Recap of Lecture 2 (p49)
**Slide: Quick recap (p49)**
1. Wilcoxon Signed Rank Sum test used for two paired samples of non-normal quantitative data
2. Tests null hypothesis that median difference is zero
3. Achieves this by ranking differences between samples, re-applying sign to ranks, calculating sum of signed ranks as test statistic
4. For sample sizes > 10, test statistic approximately normally distributed; use z-score
### When Is It Appropriate? (p51-52)
**Slide: Mann-Whitney-Wilcoxon Test (p51-52)**
Also called U-test, Wilcoxon Rank Sum Test, or just Rank Sum Test.

Objective: determine whether two independent samples of ordinal or quantitative data have same location (median), i.e., are from same population.
- Equivalent of t-test for two samples of normal data
### Data and Assumptions (p51-52)
**Slide: Data and Assumptions (p51-52)**
- 2 random samples of size $n_1$ and $n_2$
- Data either ordinal or quantitative (but not normal)
- Samples and observations within samples are independent
- Distributions of two populations differ with respect to location only (if they differ at all)
### Hypotheses (p52)
**Slide: Hypotheses (p52)**
$$H_0: \text{The two population locations are the same / identical distributions}$$

Either:
$$H_1: \text{The two populations differ in locations (two-sided test)}$$
OR:
$$H_1: \text{The location of first population is to the right of second population (one-sided >)}$$
OR:
$$H_1: \text{The location of first population is to the left of second population (one-sided <)}$$
### Calculating the Test Statistic (p53)
**Slide: Calculating the test statistic (p53)**
Test statistic depends on $n_1$ and $n_2$:
1. Combine two samples
2. Rank all observations from smallest (1) to largest ($n_1 + n_2$)
3. $T_1$ = sum of ranks of first sample, $T_2$ = sum of ranks of second sample

Note: $T_1 + T_2 = \frac{(n_1 + n_2)(n_1 + n_2 + 1)}{2}$
### Logic of the Test (p54)
**Slide: Logic of the test (p54)**
- If locations of two populations about same ($H_0$ true), expect ranks evenly spread between samples and sums similar
- If $T_1$ sufficiently small, most smaller observations in population 1
  - Location of population 1 to left of population 2
  - Reject $H_0$
- If $T_1$ sufficiently large, most larger observations in population 1
  - Location of population 1 to right of population 2
  - Reject $H_0$
### Small Sample Test: n1 AND n2 < 10 (p56-57)
**Slide: Small sample Wilcoxon Rank Sum Test (p56)**
Test statistic: $T = T_1$

Critical region: When both $n_1$ AND $n_2 < 10$, critical values $T_L$ found in table. $T_U$ calculated as:
$$T_U = n_1(n_1 + n_2 + 1) - T_L$$

Reject $H_0$ if $T \le T_L$ or $T \ge T_U$.
### Large Sample Test: n1 AND/OR n2 ≥ 10 (p57)
**Slide: Large sample Wilcoxon Rank Sum Test (p57)**
$T$ approximately normally distributed.
$$z = \frac{T - \mu_T}{\sigma_T} \text{ where } \mu_T = \frac{n_1(n_1 + n_2 + 1)}{2} \text{ and } \sigma_T = \sqrt{\frac{n_1 n_2 (n_1 + n_2 + 1)}{12}}$$

**Critical region:**
- Reject $H_0$ if $|z| \ge z_{\alpha/2}$ (two-sided test)
- OR if $z > z_\alpha$ (one-sided > test)
- OR if $z < -z_\alpha$ (one-sided < test)
- OR if calculated p-value $\le \alpha$ (p-value approach)
### Example 1: Word-Processing Training (p58-64)
**Slide: Word-processing training context (p58)**
ABC Company sent 13 employees to word-processing training: 6 from data-processing (DP) department, 7 from typing (T) pool. Each received score out of 100. Is there difference in performance of two groups? Test at 5% significance level.

**Slide: Training data (p59)**

| DP | T |
|----|---|
| 70 | 59 |
| 52 | 70 |
| 46 | 75 |
| 65 | 85 |
| 60 | 50 |
| 40 | 82 |
| | 64 |

$n_1 = 6$ (DP), $n_2 = 7$ (T).

Since $n_1$ AND $n_2 < 10$: **Small Sample Test**

**Slide: Hypotheses and ranking (p60-61)**
$H_0$: There is no difference in performance between two groups on word processing program.

$H_1$: There is difference in performance between two groups (two-sided test).

Combined ranking (handling tie at 70, ranks 9-10 → average 9.5):

| Value | 40 | 46 | 50 | 52 | 59 | 60 | 64 | 65 | 70 | 70 | 75 | 82 | 85 |
|-------|----|----|----|----|----|----|----|----|----|----|----|----|
| Rank | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9.5 | 9.5 | 11 | 12 | 13 |
| Group | DP | DP | T | DP | T | DP | T | DP | DP | T | T | T | T |

**Slide: Test statistic (p62-63)**
$$T_1 \text{ (sum of DP ranks)} = 1 + 2 + 4 + 6 + 8 + 9.5 = 30.5$$
$$T_2 \text{ (sum of T ranks)} = 3 + 5 + 7 + 9.5 + 11 + 12 + 13 = 60.5$$

Check: $T_1 + T_2 = 91 = 13 \times 14 / 2$ ✓

**Slide: Critical region and conclusion (p64)**
Reject $H_0$ if $T \le T_L$ or $T \ge T_U$.

From Mann-Whitney-Wilcoxon table ($\alpha = 0.05$, $n_1 = 6$, $n_2 = 7$):
- $T_L = 28$
- $T_U = 6(6 + 7 + 1) - 28 = 84 - 28 = 56$

Since $28 < T_1 = 30.5 < 56$, do NOT reject $H_0$. Conclude there is no significant difference in performance of two groups in word-processing programme at 5% significance level.
### Example 2: Pharmaceutical Painkiller Study (p65-72)
**Slide: Painkiller study context (p65-66)**
Pharmaceutical company testing new painkiller vs aspirin. 30 people randomly selected: 15 received new drug (Sample 1), 15 received aspirin (Sample 2). Each indicated which of five statements best represented drug effectiveness:
- (5) Extremely effective
- (4) Quite effective
- (3) Somewhat effective
- (2) Slightly effective
- (1) Not at all effective

Can we conclude new painkiller more effective? Test at 5% significance level.

**Slide: Painkiller data and hypotheses (p66-67)**
$$H_0: \text{There is no difference in effectiveness between two painkillers}$$
$$H_1: \text{The new painkiller is more effective (one-sided > test)}$$

$n_1 = 15$, $n_2 = 15$.

Since $n_1$ and $n_2 > 10$: **Large Sample Test**

Data (pairs: New Drug, Aspirin):
(3,4), (5,1), (4,3), (3,2), (2,4), (5,1), (1,3), (4,4), (5,2), (3,2), (3,2), (5,4), (5,3), (5,4), (4,5)

**Slide: Combined ranking with ties (p68-70)**
Combined all 30 values. Rank summary:
- Value 1 (count 4): average rank 2.5
- Value 2 (count 6): average rank 7.5
- Value 3 (count 6): average rank 13.5
- Value 4 (count 8): average rank 20.5
- Value 5 (count 6): average rank 27.5

After assigning ranks to each observation:
$$T_1 = 276.5 \text{ (sum of ranks for new drug)}$$
$$T_2 = 188.5 \text{ (sum of ranks for aspirin)}$$

Check: $T_1 + T_2 = 465 = 30 \times 31 / 2$ ✓

**Slide: Test statistic (p70-71)**
$$\mu_T = \frac{15(15 + 15 + 1)}{2} = \frac{15 \times 31}{2} = 232.5$$
$$\sigma_T = \sqrt{\frac{15 \times 15 \times 31}{12}} = \sqrt{581.25} \approx 24.11$$
$$z = \frac{276.5 - 232.5}{24.11} = \frac{44}{24.11} \approx 1.82$$

**Slide: Critical region and conclusion (p71-72)**
Reject $H_0$ if $z \ge 1.645$ (one-sided > test at $\alpha = 0.05$).

p-value = $1 - 0.9656 = 0.0344$

Since $1.82 > 1.645$ and p-value $\approx 0.0344 < 0.05$, reject $H_0$ and conclude that new painkiller is more effective at 5% level of significance.
## Lecture 4: Kruskal-Wallis Test
Page refs: (pNN) = PDF page in [[materials/lectures/week-07/L1_L4_NP.pdf|L1-L4 nonparametric deck]].
### Learning Outcomes (p75)
- Know conditions (data type, number of samples, relationship between samples, objective) for Kruskal-Wallis test
- Know data assumptions
- Be able to conduct the test
### Quick Recap of Lecture 3 (p74)
**Slide: Quick recap (p74)**
1. Mann Whitney U test used for two independent samples of ordinal or non-normal quantitative data
2. Tests null hypothesis that medians of two populations are same
3. Achieves this by combining samples, ranking values, calculating sum of ranks for each sample
4. For small sample sizes < 10, use table of exact probabilities
5. For larger sample sizes, test statistic approximately normally distributed; use z-score
### When Is It Appropriate? (p76)
**Slide: Kruskal-Wallis Test (p76)**
When comparing more than two independent groups/samples of ordinal or quantitative data with respect to locations (medians) to determine whether they all come from same population.
- Equivalent of single factor one-way ANOVA
### Data and Assumptions (p76)
**Slide: Data and Assumptions (p76)**
- Data either ordinal or quantitative but not necessarily normal
- Treatment levels and observations within treatment levels are independent
- At least three observations per sample ($n_i \ge 3$)
- Distributions of all populations differ with respect to location only (if they differ at all)
### Hypotheses (p77)
**Slide: Hypotheses (p77)**
$$H_0: \text{The locations of all } k \text{ populations (groups) are the same}$$
$$H_1: \text{At least two population locations differ}$$
### Calculating the Test Statistic (p77-78)
**Slide: Calculating the test statistic (p77-78)**
1. Combine observations from all $k$ groups to form one sample ($n_T = \sum n_i$)
2. Rank observations from 1 (smallest) to $n_T$ (largest)
3. Average ranks of tied observations
4. Calculate rank sums $T_1, T_2, \ldots, T_k$ for all $k$ groups

(Check that $\sum_{i=1}^{k} T_i = \frac{n_T(n_T + 1)}{2}$)
### Test Statistic and Logic (p78-79)
**Slide: Test statistic (p78)**
$$H = \frac{12}{n_T(n_T + 1)} \sum_{i=1}^{k} \frac{T_i^2}{n_i} - 3(n_T + 1)$$

**Slide: Logic of test (p78-79)**
If all populations have same location ($H_0$ true), ranks should be evenly distributed among $k$ samples and statistic $H$ will be small.

Example:
- Uneven distribution: Sample 1 has values (1,2,3) with ranks (1,2,3), $T_1 = 6$; Sample 2 has (4,5,6) with ranks (4,5,6), $T_2 = 15$; Sample 3 has (7,8,9) with ranks (7,8,9), $T_3 = 24$ → $H = 7.2$
- Even distribution: Sample 1 has (1,4,9) with ranks (1,4,9), $T_1 = 14$; Sample 2 has (2,5,8) with ranks (2,5,8), $T_2 = 15$; Sample 3 has (3,6,7) with ranks (3,6,7), $T_3 = 16$ → $H = 0.0888$
### Critical Region (p79-80)
**Slide: Critical region (p79-80)**
When sample sizes (of all $k$ groups) $\ge 3$, $H$ is approximately chi-squared distributed with $k - 1$ degrees of freedom.

Test is one-sided: all critical region probability (significance level) falls in upper tail.

Reject $H_0$ if $H$ is too large:
- Reject $H_0$ if $H \ge \chi^2_{\alpha, k-1}$ or
- Reject $H_0$ if approximate/exact p-value $\le \alpha$
### Example 1: Restaurant Customer Service Speed (p81-87)
**Slide: Restaurant example context (p81)**
How do customers rate three shifts (4:00-mid, mid-8:00, 8:00-4:00) with respect to speed of service in 24-hr restaurant? Three samples of 10 customer response-cards randomly selected, one sample from each shift. Customer ratings (1 = very slow to 5 = very quick):

**Slide: Restaurant data (p81)**

| 4:00-mid | Mid-8:00 | 8:00-4:00 |
|----------|----------|-----------|
| 4 | 3 | 3 |
| 4 | 4 | 1 |
| 3 | 2 | 3 |
| 4 | 2 | 2 |
| 3 | 3 | 1 |
| 3 | 4 | 3 |
| 3 | 3 | 4 |
| 3 | 3 | 2 |
| 2 | 2 | 4 |
| 3 | 3 | 1 |

Can we conclude customers perceive speed to be different among three shifts at 5% significance level?

**Slide: Hypotheses (p82)**
$H_0$: Locations of three populations are same; customers perceive service speeds equally across shifts.

$H_1$: At least two locations differ; customers perceive different service speeds among shifts.

$k = 3$, $n_1 = n_2 = n_3 = 10$, $n_T = 30$

**Slide: Ranking combined sample (p83-85)**
Ranking all 30 combined values with tie handling:
- Value 1 (count 3): ranks 1-3 → average rank 2
- Value 2 (count 6): ranks 4-9 → average rank 6.5
- Value 3 (count 14): ranks 10-23 → average rank 16.5
- Value 4 (count 7): ranks 24-30 → average rank 27

Rank sums by group:
- Group 1 (4:00-mid): $T_1 = 27 + 27 + 16.5 + 27 + 16.5 + 16.5 + 16.5 + 16.5 + 6.5 + 16.5 = 186.5$
- Group 2 (mid-8:00): $T_2 = 16.5 + 27 + 6.5 + 6.5 + 16.5 + 27 + 16.5 + 16.5 + 6.5 + 16.5 = 156$
- Group 3 (8:00-4:00): $T_3 = 16.5 + 2 + 16.5 + 6.5 + 2 + 16.5 + 27 + 6.5 + 27 + 2 = 122.5$

Check: $T_1 + T_2 + T_3 = 465 = 30 \times 31 / 2$ ✓

**Slide: Test statistic (p85-86)**
$$H = \frac{12}{30(31)} \left(\frac{186.5^2}{10} + \frac{156^2}{10} + \frac{122.5^2}{10}\right) - 3(31)$$
$$= \frac{12}{930}(3478.225 + 2433.6 + 1500.625) - 93$$
$$= 7412.45 \times \frac{12}{930} - 93$$
$$= 95.47 - 93 = 2.645$$

**Slide: Critical region and conclusion (p86-87)**
Reject $H_0$ if $H \ge \chi^2_{0.05, 2} = 5.991$.

Since $2.645 < 5.991$ (and p-value > 0.10), do NOT reject $H_0$. No significant difference in customers' perceptions of speed of service among three shifts at 5% level.
## In R
Reference: [[materials/lectures/week-07/NP L1 to L4 R Examples.pdf|NP L1 to L4 R Examples]]
### Wilcoxon Signed Rank Test (Lecture 2)
```R
wilcox.test(x = data$Normal, y = data$Flexi, exact = FALSE, paired = TRUE, alternative = "greater")
```

Notes:
- `paired = TRUE` for paired samples (Wilcoxon signed rank); `paired = FALSE` for independent samples (Mann-Whitney U)
- `exact = FALSE` when ties present; uses normal approximation
- `alternative = "greater"`, `"less"`, or `"two.sided"`
- **V output is sum of positive ranks** ($W$ in lecture notes)
### Mann-Whitney U Test / Wilcoxon Rank Sum Test (Lecture 3)
```R
wilcox.test(x = data$Sample1, y = data$Sample2, exact = FALSE, paired = FALSE, alternative = "greater")
```

Notes:
- `paired = FALSE` for independent samples
- `exact = FALSE` when sample size large or ties present
- Test compares two independent samples
- Output U statistic corresponds to sum of ranks $T_1$ in lecture notes
### Kruskal-Wallis Test (Lecture 4)
```R
kruskal.test(formula = y ~ group, data = df)
```

Notes:
- Compare 3+ independent samples
- `formula` syntax: dependent variable ~ grouping factor
- Works with equal or unequal sample sizes per group
- Output $H$ statistic and p-value for chi-squared test with $k-1$ degrees of freedom
