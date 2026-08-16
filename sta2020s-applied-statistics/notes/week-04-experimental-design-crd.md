---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/lectures/week-04/Experimental Design & ANOVA.pdf|main deck]], [[materials/lectures/week-04/Definitions.pdf|definitions]], [[materials/lectures/week-04/onewayANOVA_degreesoffreedom.pdf|df explainer]], [[materials/lectures/week-04/ExtraANOVA.pdf|extra ANOVA]], [[materials/lectures/week-04/Student Questions ANOVA.pdf|student Q&A]].
## Experimental Design
Page refs: (pNN) = PDF page in [[materials/lectures/week-04/Experimental Design & ANOVA.pdf|main deck]] (87 slides).
### Observational vs Experimental Studies (p5-13)
**Slide: Observational Study (p5)**
No intervention. Measurements taken as they occur in nature. Values of independent variables are not controlled (set in advance).
- Example: house price prediction using existing sale data (bedrooms, location, size).
- Simply record explanatory variables without manipulation.
**Slide: Experimental Study (p8)**
Researchers actively manipulate conditions to investigate specific questions. Values of independent variables are controlled (set in advance).
- Example: randomly assign students to two teaching methods and measure performance differences.
**Slide: Experiments enable cause-and-effect claims (p13)**
Experiments control and hold constant (as best possible) all other factors that might affect the response, isolating the treatment effect.
- Observational studies suffer from confounding variables: variables related to both response and explanatory variables, making true relationships difficult to determine.
- Correlation ≠ causation. A statistically significant relationship does not imply a cause-and-effect relationship.
### Working Example: Playback Speed Study (p15-16)
**Slide: Does playback speed affect comprehension? (p15-16)**
Study conducted by Chen et al. (2024). Objective: investigate whether increasing playback speed affects comprehension of audio-only content.
- Method: 180 undergraduate participants listened to two podcasts at either 1x, 1.5x, 2x, or 2.5x speed.
- Randomly assigned one of the four playback speeds.
- Completed multiple-choice comprehension tests after listening.
- Average score taken as final outcome.
### Experimental Design Terminology (p17-18)
**Slide: Key terms (p17)**
- Response Variable: the outcome measured in the experiment.
- Factor: variable being manipulated (explanatory variables in regression).
- Factor levels: different levels/settings of the factor set in advance.
- Treatments: levels or combination of treatment levels being compared.
- Experimental Units: subjects or objects to which treatments are applied.
- Observational Units: entities on which the response is measured (often same as experimental units).
- Replicates: number of experimental units per treatment.

**Slide: Example (p18)**
Teaching method study: three groups taught using lectures, online videos, or group discussions. Test scores measured.
- Response: test score.
- Factor: teaching method.
- Factor levels: lectures, online videos, group discussions.
- Treatments: same as factor levels (single factor).
- Experimental units: groups of students.
- Observational units: students (same as experimental units).

Shelf placement study: cereal placed on bottom, middle, or top shelf each week for 4 weeks. Weekly sales recorded.
- Response: weekly sales.
- Factor: shelf placement.
- Factor levels: bottom, middle, top.
- Treatments: same as factor levels.
- Experimental units: shelf positions.
- Observational units: sales measurements (same as experimental units).
### The Three R's of Experimental Design (p19-31)
**Slide: Designing good experiments (p19-20)**
A good experiment detects differences in the response between treatments (if present). Ensure the signal (differences in means) is not drowned out by noise (variability).
- Standard error is proportional to $\sigma$ (data variation or noise) and inversely proportional to sample size (signal volume).
- Smaller standard errors = more precise estimates and greater confidence.
**Slide: Randomisation (p21-25)**
Assignment of treatments to experimental units at random. Random means with equal probability, not haphazard.
- Prevents confounding: averages out systematic effects and extraneous factors not directly controlled.
- Separates treatment effect from experimental unit effect.
- Example: playback speed randomly assigned to each student.

```R
set.seed(123)
treats <- c("1x","1.5x","2x","2.5x")
exp_units <- 1:180
random <- sample(treats, 180, replace = TRUE)
```

**Slide: Why randomise? (p25)**
Without randomisation, any difference between treatments could be due to differences in experimental units themselves, confounding effects.

**Slide: Replication (p26-28)**
When a treatment is applied independently to more than one experimental unit, it is replicated. Replication allows us to:
- Quantify variability within each treatment group (experimental error variance).
- Compare within-group variation to between-group variation.
- Increase signal volume (more data).
- Quantify noise (within-group variation).

Experimental error variance: differences among experimental units within the same treatment.

**Slide: Reduce experimental error variance (p29-31)**
Decrease noise by: controlling experimental conditions, choosing similar experimental units, and randomisation. If clear differences exist between groups of experimental units that might influence response, use blocking.

Blocking: technique where similar experimental units are grouped into blocks. Account for differences between blocks to isolate differences between treatments.
- Example: test three inventory strategies (A, B, C) by blocking by day. Each day, randomly apply each strategy at different times (e.g., Day 1: A, C, B; Day 2: B, C, A).
### Design Structures (p32-38)
**Slide: Designing an experiment (p32)**
Must decide: What are treatment factors and treatments? What is the outcome/response? What are experimental units? Any blocking factors? How many replicates? How will randomisation be applied?

**Slide: Treatment structure (p33)**
- Single-factor: treatments are different levels of one factor (e.g., playback speed: 1x, 1.5x, 2x, 2.5x).
- Factorial: more than one factor tested simultaneously. Treatments are combinations of factor levels (e.g., playback speed times noise level).

**Slide: Blocking structure (p34-35)**
Determined by available experimental units or conditions of experimental setup.
- Example: test effect of temperature on plant growth with two greenhouses. Block by greenhouse and randomly assign plants to different temperature treatments within each greenhouse.

**Slide: Designs we cover (p36)**
- Completely Randomized Design (CRD): when all experimental units are homogeneous. Treatments randomly assigned to all experimental units. Example: randomly assign patients to Drug A or Drug B without grouping.
- Randomized Block Design (RBD): when experimental units are not homogeneous (blocking required). Treatments randomized within each block. Example: divide students into blocks by proficiency level before testing different teaching methods.

**Slide: Design dictates analysis (p37)**
- Single-factor CRD leads to one-way ANOVA.
- Single-factor RBD leads to two-way ANOVA without interaction.
- Factorial treatment structure (CRD or RBD) leads to two-way or multi-way ANOVA with interaction(s).
### Single-Factor CRD and ANOVA Model (p39-52)
**Slide: Single-Factor CRD (p39)**
Simplest design. Factor A with $a$ levels (e.g., playback speed: 1x, 1.5x, 2x, 2.5x). The $a$ treatments are randomly assigned to $r$ experimental units.
- Total observations: $N = a \times r$.
- Playback example: $a = 4$, $r = 45$, $N = 180$.
- Response variable $Y_{ij}$ for each treatment $i$ from 1 to $a$ and replicate $j$ from 1 to $r$.

**Slide: Playback data (p40)**
```R
playback <- read.csv("Data/playback.csv")
head(playback)
```
Participant.ID | Condition | Comprehension
---|---|---
76b0823c2f | 2.0x | 33.33
24ae54af6f | 2.0x | 50.00
3add152a7f | 1.5x | 65.00
e7d55aa954 | 2.0x | 36.67
f4f7a8b549 | 1.0x | 53.33
3ad6d70ab2 | 1.0x | 41.67

Goal: Build statistical model to compare treatment means.

**Slide: ANOVA Model (p42-49)**
Initial model: $Y_{ij} = \mu_i + e_{ij}$ says each observation comes from a group-specific population mean plus error.

Reparameterised model: $Y_{ij} = \mu + A_i + e_{ij}$ where:
- $\mu$ is the grand mean (average across all groups).
- $A_i$ is the effect of treatment $i$: how much group $i$ differs from average.
- $e_i$ is the error.

For this reparameterisation to be valid: $\mu = \frac{1}{N} \sum_{i=1}^{N} Y_i$ (overall mean) and $\sum_{i=1}^{a} A_i = 0$ (sum of treatment effects is zero).

**Slide: Hypotheses (p49-50)**
- $H_0: \mu_1 = \mu_2 = \mu_3 = \mu_4 = \mu$ (all means are same) or equivalently $A_1 = A_2 = A_3 = A_4 = 0$ (all treatment effects are zero).
- $H_1$: at least one $\mu_i$ differs (not that all means are different) or equivalently at least one $A_i \neq 0$ (at least one treatment effect is non-zero).

**Slide: Why this model? (p51-52)**
- Allows us to conduct a global hypothesis test.
- Leads to quantities needed for ANOVA procedure.
- ANOVA partitions total variation into sources: between-group (treatment) and within-group (error).
- If between-group variation significantly larger than within-group variation, conclude at least one mean differs.
### Multiple Testing Problem (p53-55)
**Slide: Why a single global test? (p54)**
Single hypothesis test at 5% significance level means we reject true null hypothesis 5% of time (Type I error). With multiple tests, overall Type I error rate increases.

With 20 tests at 5% level: $P(\text{at least one Type I error}) = 1 - (1 - 0.05)^{20} \approx 0.64$.

**Slide: Post-hoc tests (p55)**
If null hypothesis rejected in global test, we know at least one mean differs but not which. Perform post-hoc tests with multiple comparison adjustments to identify which specific means differ.
### Estimation (p56-68)
**Slide: Parameter estimation (p58)**
Unknown population parameters: $\mu, A_i, \sigma^2$. Find least squares estimates minimising error sum of squares:
$$SSE = \sum_i \sum_j (Y_{ij} - \hat{Y}_{ij})^2 = \sum_i \sum_j (Y_{ij} - \mu - A_i)^2$$

Estimate using sample means:
- $\hat{\mu} = \bar{Y}_{..}$ (overall mean).
- $\hat{\mu}_i = \bar{Y}_{i.}$ (group mean).

**Slide: Playback data - Overall mean (p60)**
```R
overall_mean <- mean(playback$Comprehension)
overall_mean
```
[1] 42.972

**Slide: Playback data - Treatment means (p62)**
```R
treatment_means <- tapply(playback$Comprehension, playback$Condition, mean)
treatment_means
```
1.0x | 1.5x | 2.0x | 2.5x
---|---|---|---
45.11111 | 43.22178 | 43.59267 | 39.96244

**Slide: Playback data - Treatment effects (p64)**
```R
treatment_means - overall_mean
```
1.0x | 1.5x | 2.0x | 2.5x
---|---|---|---
2.1391111 | 0.2497778 | 0.6206667 | -3.0095556

**Slide: Residuals (p66)**
- $e_{ij} = Y_{ij} - (\mu + A_i)$
- $e_{ij} = Y_{ij} - (\mu + (\mu_i - \mu))$
- $e_{ij} = Y_{ij} - \mu_i$
- $\hat{e}_{ij} = Y_{ij} - \hat{\mu}_i$

**Slide: Fitting the model in R (p68)**
```R
model <- aov(Comprehension ~ Condition, data = playback)
```

**Slide: Extract model estimates - Means (p69)**
```R
model.tables(model, type = "means", se = TRUE)
```
Tables of means:
- Grand mean: 42.972
- Condition means: 1.0x 45.11, 1.5x 43.22, 2.0x 43.59, 2.5x 39.96
- Standard errors for differences of means: 2.687 (replicates: 45)

**Slide: Extract model estimates - Effects (p70)**
```R
model.tables(model, type = "effects", se = TRUE)
```
Tables of effects:
- Condition: 1.0x 2.1391, 1.5x 0.2498, 2.0x 0.6207, 2.5x -3.0096
- Standard errors of effects: 1.9 (replicates: 45)
### Experimental Error Variance (p71-72)
**Slide: Understanding error variance (p71)**
$e_{ij} \sim N(0, \sigma^2)$. Errors are deviations of response values from their group mean. Variance of errors is how much response values deviate from their group mean.

**Slide: Estimating error variance (p72)**
$\sigma^2$ is experimental error variance: how much experimental units deviate within a treatment. Constant across groups.

Estimator:
$$s^2 = \frac{1}{N-a} \sum_i \sum_j (Y_{ij} - \bar{Y}_{i.})^2$$

Average of observed variability across all groups.
### ANOVA Assumptions (p73-87)
**Slide: Model assumptions (p71)**
ANOVA model assumptions:
1. No severe outliers.
2. Equal population variance (homoscedasticity).
3. Normally distributed errors.
4. Independent errors.

There are formal techniques to test some of these; we stick to informal techniques.

**Slide: Robustness of ANOVA (p72)**
Statistical procedure is robust to departures from assumptions if results remain unbiased even when assumption not met. For ANOVA:
1. Only severe departures from normality (long-tailed, skewed) problematic.
2. Independence within and among groups is extremely important.
3. Robust to violations of equal variance as long as no outliers, sample sizes large, sample variances relatively equal.
4. Not resistant to severely outlying observations.

**Slide: Outliers (p73)**
- Data entry or recording errors.
- Interesting outliers.
- Distort estimates.
- Check for outliers by plotting data.

**Slide: Equal population variance (p75-76)**
Assume treatment populations have same variance: $e_{ij} \sim N(0, \sigma^2)$. Simplifies mathematics and interpretation. Sample variances need to be similar enough.

Check: interquartile ranges and standard deviations should be comparable. Use boxplots or look at sample statistics.

```R
sort(tapply(playback$Comprehension, playback$Condition, sd))
```
2.5x | 2.0x | 1.5x | 1.0x
---|---|---|---
9.818431 | 12.588622 | 14.005073 | 14.095302

**Slide: Normally distributed errors (p77)**
Errors are normally distributed, not raw response. If response clearly non-normal, errors probably also non-normal. Check with boxplots or Q-Q plots. Look for severe asymmetry. Check again after model fitting with residuals.

**Slide: Independence (p79-80)**
Trickiest assumption. Errors determined by independent observations via proper experimental design. There should be independence within and among treatments.

Dependence can be caused by: not randomising observation order, measurement drift, applying treatments to same group of experimental units.

**Slide: Checking assumptions after model fitting (p82-85)**
Residuals vs. fitted values:
```R
plot(model, which = 1)
```

Q-Q plot:
```R
plot(model, which = 2)
```

Histogram of residuals:
```R
hist(resid(model))
```

Residuals vs. order of observations (check independence):
```R
plot(resid(model) ~ seq_along(resid(model)),
     xlab = "Order of Observations",
     ylab = "Residuals",
     main = "Residuals vs. Order")
abline(h = 0, col = "red")
```
## One-way ANOVA
Page refs: (pNN) = PDF page in [[materials/lectures/week-04/Experimental Design & ANOVA.pdf|main deck]] (sections mirrored above in Experimental Design cover the full theory). See supplementary materials for additional perspective.
### ANOVA Table and Hypothesis Test
**Slide: Testing equality of group means**
Test whether means of $a$ groups differ: $H_0: \mu_1 = \mu_2 = \ldots = \mu_a$ vs at least one differs.

Idea: partition total variation into between-group (treatment) and within-group (error) components.

- $SS_{\text{Total}} = \sum_i \sum_j (y_{ij} - \bar{y}_{..})^2$, df $= N - 1$
- $SS_{\text{treatment}} = \sum_i r(\bar{y}_{i.} - \bar{y}_{..})^2$, df $= a - 1$ (where $r$ = number of replicates)
- $SSE = \sum_i \sum_j (y_{ij} - \bar{y}_{i.})^2$, df $= N - a$
- Test statistic: $F = MS_{\text{treatment}}/MSE$ where $MS = SS/\text{df}$. Reject $H_0$ for large $F$.

**Slide: ANOVA table**

| Source | SS | df | MS | F |
|--------|----|----|----|----|
| Treatment | $SS_A$ | $a-1$ | $MS_A = SS_A/(a-1)$ | $F = MS_A/MSE$ |
| Error | $SSE$ | $N-a$ | $MSE = SSE/(N-a)$ | |
| Total | $SS_{\text{total}}$ | $N-1$ | | |
### Post-Hoc Tests
**Slide: Pairwise comparisons**
If null hypothesis rejected in one-way ANOVA, use post-hoc tests to identify which specific means differ. Common approaches include t-tests with Bonferroni or other multiple comparison corrections.

**Slide: Tukey HSD (Honestly Significant Difference)**
Compares all pairs of means and controls family-wise error rate. More powerful than Bonferroni for all-pairs comparisons.
### In R
**Slide: Fitting one-way ANOVA and post-hoc tests**
```R
model <- aov(y ~ group, data = df)
summary(model)
TukeyHSD(model)
```

Interpretation:
- `summary()` shows p-values for each effect. If p < 0.05, reject null (means differ).
- `TukeyHSD()` gives pairwise confidence intervals; intervals not containing zero indicate significant differences.
## Understanding One-Way ANOVA (Conceptual Deep Dive)
Page refs: (pNN) = content from [[materials/lectures/week-04/ExtraANOVA.pdf|extra ANOVA]] (5 pages - Korean Journal of Anesthesiology article).
### Why ANOVA Instead of Multiple t-tests (p1-2)
**Slide: Significance level inflation**
When comparing means of 3 or more groups using pairwise t-tests, Type I error rate inflates. Even if null hypothesis is true, probability of rejecting it increases.

For 3 groups with 3 pairwise comparisons, if each test is at $\alpha = 0.05$:
$$P(\text{at least one Type I error}) = 1 - (1 - 0.05)^3 \approx 0.143$$

| Number of comparisons | Significance level |
|---|---|
| 1 | 0.05 |
| 2 | 0.098 |
| 3 | 0.143 |
| 4 | 0.185 |
| 5 | 0.226 |
| 6 | 0.265 |

ANOVA avoids this problem by testing a single global hypothesis.
### ANOVA Table Interpretation (p2-3)
**Slide: ANOVA partitions variance**
ANOVA is analysis of variance. Despite testing means, ANOVA analyzes variance differences.

Example: students' heights in three different classes (30 students each).

ANOVA table from example:

| Source | Sum of squares | Freedom | Mean sum of squares | F | Significance |
|--------|---|---|---|---|---|
| Intergroup | $\sum_{i=1}^{k} n_i(\bar{Y}_i - \bar{Y})^2$ | $K - 1$ | $\sum_{i=1}^{k} n_i(\bar{Y}_i - \bar{Y})^2 / (K-1)$ | 3.629 | 0.031 |
| Intragroup | $\sum_{ij} (Y_{ij} - \bar{Y}_i)^2$ | $N - K$ | $\sum_{ij} (Y_{ij} - \bar{Y}_i)^2 / (N-K)$ | | |
| Total | $\sum_{ij} (Y_{ij} - \bar{Y})^2$ | $N - 1$ | | | |
### Between-Group vs Within-Group Variance (p3)
**Slide: Visualizing variance partitioning**
Instead of comparing group means directly, compare distances from overall mean to group means (between-group variance) with distances from group means to individual observations (within-group variance).

- Distance from overall mean to group means represents inter-group variance.
- Distance from group means to individual data represents intra-group variance.

Valid to divide data into groups only when inter-group variance is substantially larger than intra-group variance. When boundaries between groups become clear and explaining with group means is more logical than using overall mean.
### F-statistic and Degrees of Freedom (p3-4)
**Slide: F-statistic formula**
$$F = \frac{\text{Intergroup variance}}{\text{Intragroup variance}} = \frac{\sum_{i=1}^{K} n_i(\bar{Y}_i - \bar{Y})^2 / (K-1)}{\sum_{ij} (Y_{ij} - \bar{Y}_i)^2 / (N-K)}$$

where:
- $\bar{Y}_i$ is mean of group $i$.
- $n_i$ is number of observations in group $i$.
- $\bar{Y}$ is overall mean.
- $K$ is number of groups.
- $Y_{ij}$ is $j$-th observation in group $i$.
- $N$ is total number of observations.

F distribution is formed by variance ratios. Comes from statistician Ronald Fisher. ANOVA test also called F test.
### Post-Hoc Tests and Adjustments (p4-5)
**Slide: Post-hoc tests for identifying differences**
When ANOVA null hypothesis is rejected, conclusions are limited: we know at least one mean differs, but not which groups. Post-hoc tests identify which specific means differ.

Significance level adjusted by various methods:
- Bonferroni's correction: divide significance level by number of comparisons. For 3 groups with 3 comparisons: $\alpha = 0.05/3 = 0.017$ per comparison.
- Tukey, Scheffe, and Holm methods: all applicable when equal variance assumption satisfied.
- Games Howell method: when equal variance assumption not satisfied.

Results can vary by method; good practice to prepare at least 3 post-hoc tests prior to study. Use most frequent results to interpret differences.
## Handout Summaries
**Definitions handout**: covers experimental unit (physical entity to which treatment is assigned), three key experimental design principles (randomisation, replication, blocking), and CRD definition.

**Degrees of freedom explainer**: breaks down how degrees of freedom are used in each ANOVA sum of squares component ($SS_{\text{total}}$, $SS_{\text{error}}$, $SS_{\text{model}}$) and why $N-1$, $a-1$, and $N-a$ are the respective degrees of freedom.

**Student Q&A**: addresses why MS (mean squares) column is in ANOVA table (tests significance of treatments), why tests are based on variance to conclude equality of group means (due to sampling error, must compare between-group and within-group variation), and clarifies grand mean $\bar{Y} = \frac{y_1 + y_2 + \ldots + y_n}{n}$ versus CRD mean.
