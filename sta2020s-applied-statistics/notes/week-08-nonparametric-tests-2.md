---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[materials/reference/statistical-tables.pdf|tables]], [[week-07-nonparametric-tests-1|week 7 nonparametric tests]].
## Friedman Test
Page refs: (pNN) = PDF page in [[materials/lectures/week-08/Lecture5_NP.pdf|Lecture 5: Friedman Test]] (24 slides).
### Lecture 5: Quick Recap and Motivation (p2-3)
**Slide: Quick recap of Kruskal-Wallis (p2)**
- Kruskal-Wallis test is for 3+ independent samples of ordinal or non-normal quantitative data
- Tests null hypothesis that medians of k populations are the same
- Combines samples, ranks values, and calculates sum of ranks for each sample
- Requires 3+ observations per group
- For larger samples: test statistic approximately chi-squared distributed with k-1 degrees of freedom

**Slide: Learning outcomes (p3)**
- Know conditions for when Friedman test is appropriate (data type, number of samples, relationship between samples)
- Know data assumptions of Friedman test
- Be able to conduct the Friedman test
### When Is the Friedman Test Appropriate? (p4-5)
**Slide: Friedman Test overview (p4)**
The Friedman test compares 3+ groups/samples of ordinal or quantitative (non-normal) data using matched or blocked samples, testing whether they come from the same population with respect to their medians. Equivalent to randomised block design two-way ANOVA.

**Data and assumptions:**
- Data are ordinal or quantitative (not necessarily normal)
- Blocked experiment with b blocks
- Measurements within a block are dependent/related
- Measurements between blocks are independent
- No block-treatment interaction (relative ordering of treatments consistent across blocks)

**Slide: Randomised block design concepts (p5)**
- Treatments: what is administered to experimental units; populations/variables being compared in the test
- Blocking: grouping experimental units into blocks (of equal size to number of treatments) to improve comparison by controlling for unit characteristics
### Hypotheses and Test Statistic (p6-7)
**Slide: Hypotheses and calculating the test statistic (p6)**
**H₀:** The locations (medians) of all k populations (treatments) are the same.

**H₁:** At least two population locations differ.

Note: Interpret your hypotheses from the question context.

**Calculating the test statistic:**
1. Rank observations from smallest to largest within each block
2. Average ranks of tied observations within the same block
3. Calculate rank sums T₁, T₂, ..., Tₖ for all k treatments

**Slide: Friedman test statistic and critical region (p7)**
$$F_r = \frac{12}{bk(k+1)} \sum_{j=1}^{k} T_j^2 - 3b(k+1)$$

where b = number of blocks, k = number of treatments.

For samples with either k or b ≥ 5, the test statistic F_r is approximately chi-squared distributed with k-1 degrees of freedom.

**Critical region:**
- Reject H₀ if F_r ≥ χ²_α,k-1 (critical value approach), or
- Reject H₀ if p-value ≤ α (p-value approach)
### Example 1: Job Interview Evaluation (p8-17)
**Slide: Example 1 context (p8)**
Four managers evaluate job applicants at an accounting firm on academic credentials, previous work experience, and personal suitability. Each manager rates candidates on a 5-point scale (1 = bottom 50%, 5 = top 5%). Eight applicants randomly selected. Question: Do managers differ in how they evaluate candidates?

**Slide: Example 1 data (p9)**

| Applicant | Manager 1 | Manager 2 | Manager 3 | Manager 4 |
|-----------|-----------|-----------|-----------|-----------|
| A | 3 | 1 | 4 | 2 |
| B | 2 | 1 | 4 | 3 |
| C | 2.5 | 1 | 4 | 2.5 |
| D | 1.5 | 1.5 | 4 | 3 |
| E | 2 | 1 | 3.5 | 3.5 |
| F | 2 | 1 | 4 | 3 |
| G | 2 | 1 | 4 | 3 |
| H | 2.5 | 1 | 3.5 | 3.5 |

**Slide: Example 1 setup (p10)**
We want to compare four dependent samples (ordinal data) arranged in a block design, so we use the Friedman test.

- H₀: There is no difference in the way that managers evaluate candidates
- H₁: There is a difference in the way that managers evaluate candidates
- k = 4 treatments (managers)
- b = 8 blocks (applicants)

**Slide: Example 1 ranking within blocks (p11-14)**
Rank the observations from 1 (smallest) to 4 (largest) within each applicant block, averaging tied ranks:

| Applicant | Manager 1 | Manager 2 | Manager 3 | Manager 4 |
|-----------|-----------|-----------|-----------|-----------|
| A | 2 (3) | 1 (1) | 2 (3) | 2 (3) |
| B | 4 (4) | 2 (1.5) | 3 (3) | 2 (1.5) |
| C | 2 (2) | 2 (2) | 2 (2) | 3 (4) |
| D | 3 (3.5) | 1 (1) | 3 (3.5) | 2 (2) |
| E | 3 (2.5) | 2 (1) | 3 (2.5) | 5 (4) |
| F | 2 (1.5) | 2 (1.5) | 3 (3) | 4 (4) |
| G | 4 (2) | 1 (1) | 5 (3.5) | 5 (3.5) |
| H | 3 (2.5) | 2 (1) | 5 (4) | 3 (2.5) |
| Sum | 21 | 10 | 24.5 | 24.5 |

T₁ = 21, T₂ = 10, T₃ = 24.5, T₄ = 24.5

Check: T₁ + T₂ + T₃ + T₄ = 80 = 8 × 4 × 5 / 2 ✓

**Slide: Example 1 test statistic calculation (p15)**
$$F_r = \frac{12}{8 \times 4 \times 5} \times (21^2 + 10^2 + 24.5^2 + 24.5^2) - 3(8)(5)$$
$$= \frac{12}{160} \times (441 + 100 + 600.25 + 600.25) - 120$$
$$= \frac{12}{160} \times 1741.5 - 120$$
$$= 0.075 \times 1741.5 - 120$$
$$= 130.6125 - 120$$
$$= 10.61$$

**Slide: Example 1 critical value and p-value (p16)**
- Critical value: χ²_0.05,3 = 7.815
- P-value: ≈ 0.0175

**Slide: Example 1 conclusion (p17)**
**Conclusion (a):** Since 10.61 > 7.815, we reject H₀ at the 5% significance level and conclude that there are significant differences in the way managers evaluate candidates.

**Conclusion (b):** Since p-value ≈ 0.0175 < 0.05, we reject H₀ and conclude that there are significant differences in the way managers evaluate candidates.
### Example 2: Property Company Land Bids (p18-24)
**Slide: Example 2 context (p18)**
Four property development companies enter sealed bids for vacant land plots at auction. From a random sample of plots and bids (in thousands of Rands), does it appear some firms tend to make higher bids on average? Test at the 2.5% significance level.

| Plot | Company 1 | Company 2 | Company 3 | Company 4 |
|------|-----------|-----------|-----------|-----------|
| A | 37 | 32 | 43 | 36 |
| B | 127 | 110 | 139 | 130 |
| C | 15 | 12 | 16 | 15 |
| D | 340 | 340 | 390 | 360 |
| E | 100 | 90 | 120 | 120 |
| F | 225 | 210 | 240 | 230 |

**Slide: Example 2 setup (p19)**
We want to compare four dependent samples (quantitative data) arranged in a block design, so we use the Friedman test.

- H₀: There is no difference in the bids made by the four companies
- H₁: There is a difference in the bids made by the four companies
- k = 4 treatments (companies)
- b = 6 blocks (plots)

**Slide: Example 2 ranking within blocks (p20-21)**
Rank within each plot block:

| Plot | Company 1 | Company 2 | Company 3 | Company 4 |
|------|-----------|-----------|-----------|-----------|
| A | 37 (3) | 32 (1) | 43 (4) | 36 (2) |
| B | 127 (2) | 110 (1) | 139 (4) | 130 (3) |
| C | 15 (2.5) | 12 (1) | 16 (4) | 15 (2.5) |
| D | 340 (1.5) | 340 (1.5) | 390 (4) | 360 (3) |
| E | 100 (2) | 90 (1) | 120 (3.5) | 120 (3.5) |
| F | 225 (2) | 210 (1) | 240 (4) | 230 (3) |
| Sum | 13 | 6.5 | 23.5 | 17 |

T₁ = 13, T₂ = 6.5, T₃ = 23.5, T₄ = 17

**Slide: Example 2 test statistic calculation (p22)**
$$F_r = \frac{12}{6 \times 4 \times 5} \times (13^2 + 6.5^2 + 23.5^2 + 17^2) - 3(6)(5)$$
$$= \frac{12}{120} \times (169 + 42.25 + 552.25 + 289) - 90$$
$$= 0.1 \times 1052.5 - 90$$
$$= 105.25 - 90$$
$$= 15.25$$

**Slide: Example 2 critical value and p-value (p23)**
- Critical region: Reject H₀ if F_r ≥ χ²_0.025,3
- Critical value: χ²_0.025,3 = 9.348
- P-value: ≈ 0.00175

**Slide: Example 2 conclusion (p24)**
**Conclusion (a):** Since 15.25 > 9.348, we reject H₀ and conclude that there is a significant difference in the bids made by the four companies at the 2.5% significance level; some companies make higher bids than others.

**Conclusion (b):** Since p-value ≈ 0.00175 < 0.025, we reject H₀ and conclude that there is a significant difference in the bids made by the four companies at the 2.5% significance level.

**Interpretation note:** If ranks were evenly spread (T₁ = T₂ = T₃ = T₄ = 15), then F_r = 0, indicating no difference among treatments. Small F_r indicates H₀ is true.
## Spearman's Rank Correlation Test
Page refs: (pNN) = PDF page in [[materials/lectures/week-08/Lecture6_NP.pdf|Lecture 6: Spearman's Rank Correlation Test]] (20 slides).
### Lecture 6: Quick Recap and Motivation (p2-3)
**Slide: Quick recap of Friedman test (p2)**
- Friedman test for 3+ matched or blocked samples of ordinal or non-normal quantitative data
- Tests null hypothesis that medians of k populations are the same
- Ranks values within blocks and calculates sum of ranks for each treatment
- For k or b ≥ 5: test statistic is chi-squared with k-1 degrees of freedom

**Slide: Tests of association between populations (p3)**
Important: An association between two variables cannot be interpreted as implying a cause-and-effect relationship.

Two variables may have an association because:
- They interact with each other (one or both affects the other)
- Mere coincidence
- Both are affected by other unmeasured variables
### When Is Spearman's Test Appropriate? (p4-5)
**Slide: Learning outcomes (p4)**
- Know conditions for when Spearman's Rank Correlation Coefficient test is appropriate
- Know data assumptions of Spearman's test
- Be able to conduct Spearman's test

**Slide: Spearman Rank Correlation Coefficient Test overview (p5)**
When you want to measure association between two samples/variables of ordinal or quantitative data. The test is an equivalent of Pearson's Correlation Coefficient Test but works for non-normal data or ordinal data. Tests for monotonic association (not just linear), making it more robust to outliers.

**Data and assumptions:**
- Both variables are at least ordinal (possibly quantitative), and at least one variable is not normal
- n randomly selected paired observations (one pair per subject)

**Interpretation of Spearman's rank correlation coefficient (same as Pearson's):**

| Interpretation | Range |
|---|---|
| Very strong negative relationship | -1 |
| Moderate negative relationship | -0.5 |
| Weak negative relationship | -0.5 to 0 |
| No linear relationship | 0 |
| Weak positive relationship | 0 to 0.5 |
| Moderate positive relationship | 0.5 |
| Very strong positive relationship | +1 |
### Hypotheses (p6)
**Slide: Hypotheses (p6)**
**H₀:** ρ_s = 0 (no association exists between the two variables in the underlying population).

**Either:**
- **H₁:** ρ_s ≠ 0 (there is an association between the two variables) (two-sided test)

**OR:**
- **H₁:** ρ_s > 0 (correlation between the two variables is positive) (one-sided > test)

**OR:**
- **H₁:** ρ_s < 0 (correlation between the two variables is negative) (one-sided < test)
### Calculating the Test Statistic (p7)
**Slide: Calculating test statistic (p7)**
1. Rank populations X and Y separately
2. Calculate difference d within each pair of ranks: d_i = rank(x_i) - rank(y_i)
3. Calculate sum of squared differences: Σd_i²

$$r_s = 1 - \frac{6 \sum_{i=1}^{n} d_i^2}{n(n^2 - 1)}$$

where n = number of pairs in the data.

For large samples (n ≥ 10), the sampling distribution of r_s is approximately normal:

$$z = r_s \sqrt{n - 1}$$

where μ_{r_s} = 0 and σ_{r_s} = 1/√(n-1).
### Critical Region (p8)
**Slide: Critical region for Spearman's test (p8)**
**Reject H₀ if:**
- |z| ≥ z_{α/2} (two-sided test), OR
- z > z_α (one-sided > test), OR
- z < -z_α (one-sided < test)

where z_α is the critical value (critical value approach)

OR

if the calculated p-value ≤ α (p-value approach)
### Example 1: Study Time and Academic Performance (p9-17)
**Slide: Example 1 context (p9)**
Pat Statstud (a struggling statistics student) theorized: the longer one studied, the better one's grade. To test this theory, Pat surveyed 35 students in an economics course, asking each to report average study time and final mark (out of 100).

Question: Test to determine whether grade and study time are positively related.

**Slide: Example 1 data (p10)**
35 students' study times and final marks are ranked separately, differences in ranks calculated, and d_i² summed.

(Data shows all 35 pairs with ranks and calculations.)

Key summary: Σd_i² = 1962.5

**Slide: Example 1 setup and hypotheses (p11)**
- Sample size: n = 35 > 10 (large sample test)
- H₀: ρ_s = 0 (no rank correlation/association exists between length of study time and grade)
- H₁: ρ_s > 0 (length of study time and grade are positively rank correlated/associated) (one-sided > test)
- α = 0.05

**Slide: Example 1 test statistic calculation (p14)**
$$r_s = 1 - \frac{6 \times 1962.5}{35(35^2 - 1)} = 1 - \frac{11775}{35 \times 1224} = 1 - \frac{11775}{42840}$$
$$= 1 - 0.2749 = 0.7251$$

**Large sample test statistic:**
$$z = r_s \sqrt{n - 1} = 0.7251 \times \sqrt{34} = 0.7251 \times 5.831 \approx 4.228$$

**Slide: Example 1 critical value and p-value (p15)**
- Critical region: Reject H₀ if z ≥ z_{0.05} = 1.645 (one-sided > test)
- Test statistic: z = 4.228
- P-value: P(Z > 4.228) ≈ 1 - 0.9990 = 0.0001

**Slide: Example 1 conclusion (p16-17)**
**Conclusion (a):** Since 4.228 > 1.645, we reject H₀ and conclude that length of study time and grade are positively correlated at the 5% significance level.

**Conclusion (b):** Since p-value < 0.0001 (< 0.05), we reject H₀ and conclude that length of study time and grade are positively correlated at the 5% significance level.

**Additional questions on significance levels:**
- At 2.5% significance level: Yes, reject H₀ (z > z_{0.025} = 1.96)
- At 1% significance level: Yes, reject H₀ (z > z_{0.01} = 2.33)
### Advantages and Disadvantages of Nonparametric Tests (p18-20)
**Slide: Advantages and disadvantages section (p18)**
Title slide introducing advantages and disadvantages.

**Slide: Advantages of nonparametric tests (p19)**
- Tests can be used when parametric methods are inapplicable or the validity of their assumptions is uncertain
- Tests are useful when sample sizes are small
- Assumptions are usually few and easily met
- Tests are not restricted to quantitative data (work with ordinal and nominal data as well)

**Slide: Disadvantages of nonparametric tests (p20)**
- Information is lost by ranking or taking signs. Because information is lost, nonparametric procedures tend to be less efficient or "powerful" than the equivalent parametric test (when one is appropriate for the data). For similar sample sizes and significance levels, confidence intervals would be wider, and the null hypothesis may not be rejected as often.
- The theory is more complicated (and in this course we do not involve ourselves in the theory behind the tests).
## In R Examples
Page refs: (pNN) = PDF page in [[materials/lectures/week-08/NP L5 and L6 R Examples.pdf|NP L5 and L6 R Examples]] (2 slides).
### Friedman Test in R (p1-2)
**Slide: Friedman Test - Class Example 1 (ordinal data) (p1-2)**
```R
# Read in the data set (assuming working directory already set)
fr.1 <- read.csv("Lecture5_Example1.csv", header = TRUE, sep = ",")

# View the data set to verify import
View(fr.1)

# Friedman test in two different ways:
# (1): Specify y (numeric/observation column), groups, and blocks
friedman.test(y = fr.1$rating, groups = fr.1$manager, blocks = fr.1$applicant)

# (2): Use formula a~b|c where a = observations, b = groups/treatment, c = blocks
friedman.test(formula = rating ~ manager | applicant, data = fr.1)
```

Note: Output may differ from hand calculations but conclusion remains the same.

**Slide: Friedman Test - Class Example 2 (non-normal quantitative data) (p1-2)**
```R
# Read in the data set
fr.2 <- read.csv("Lecture5_Example2.csv", header = TRUE, sep = ",")

# View the data set to verify import
View(fr.2)

# Friedman test in two different ways:
# (1): Specify y (numeric/observation column), groups/treatment, and blocks
friedman.test(y = fr.2$bid, groups = fr.2$company, blocks = fr.2$plot)

# (2): Use formula a~b|c where a = observations, b = groups/treatment, c = blocks
friedman.test(formula = bid ~ company | plot, data = fr.2)
```

Note: Output may differ from hand calculations but conclusion remains the same.
### Spearman's Rank Correlation Test in R (p1-2)
**Slide: Spearman's Rank Correlation Test example (p1-2)**
```R
# Read in the data
sp <- read.csv("Lecture6_Example.csv")

# Check data import
View(sp)

# cor.test() with method="spearman"
# Specify the two paired samples - x = time and y = mark
# With ties: include exact = FALSE to obtain approximate p-value
# S = sum of squared differences
cor.test(x = sp$time, y = sp$mark, method = 'spearman', exact = FALSE)
```

Output includes:
- Spearman's rho (r_s): the rank correlation coefficient
- Test statistic (z or t depending on sample size)
- P-value: probability of observing test statistic under H₀
- Conclusion: Reject H₀ if p-value ≤ α
