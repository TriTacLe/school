---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
# Lecture Slides
## Introduction Lecture
**Where we are (p2)**
Regression relates a response to explanatory variables, usually measured as they are. This section compares group means: did actively changing something (a treatment) change the outcome?

**The motivating example (p3-4)**
Chen et al. (2024). 180 participants listened to podcasts at 1x, 1.5x, 2x or 2.5x speed. Speed randomly assigned. Comprehension measured with a multiple-choice test.

**Where this section is going (p5)**
1. How to design a good experiment (randomisation, replication, blocking).
2. How to build a model for comparing group means.
3. How to test whether group means differ, and check the model is valid.

Same overall goal as regression: build a model, then use it to answer a question about the world. ANOVA is not a brand-new idea, it is the same idea dressed differently.

**Regression vs ANOVA (p6-7)**
- Regression: response $Y$, explanatory variable $X$ that helps explain or predict $Y$.
- ANOVA: same response $Y$, but the explanatory variable is **group membership** (e.g. playback speed).
- What is new: we now also care about **how the data was collected**. Treatments come from a designed experiment.

**The same underlying idea (p8)**
Both regression and ANOVA:
- Build a model of the form: response = explained part + leftover error.
- Estimate that model by making the leftover error as small as possible.
- Ask the same question: does knowing X tell us anything about Y?

No real modelling difference at all. Regression and ANOVA are not two different tools for two different kinds of data.

**Signal vs noise (p9)**
In regression a model is only useful if it explains more variation in $Y$ than you would expect by chance. ANOVA asks exactly the same thing, about groups instead of a line:
- How much does $Y$ vary **between** groups (differences we might care about)?
- How much does $Y$ vary **within** a group (just noise)?

If between-group differences are big relative to the noise, we suspect a real effect.

**Isn't ANOVA that table from regression? (p10)**
Yes. ANOVA is a *procedure*: partition total variability in $Y$ into an explained piece and a leftover piece, then compare them. In the regression course you met it as one part of the output, the ANOVA table. In this section, ANOVA is the name of the whole topic.

**Same model, different notation (p11)**

| Regression parametrisation | ANOVA parametrisation |
| --- | --- |
| $Y_i = \beta_0 + \beta_1 X_i + e_i$ | $Y_{ij} = \mu + A_i + e_{ij}$ |
| Natural when $X$ is numeric, or when you want a prediction equation. | Natural once you are comparing group means rather than predicting along a line. |
| Works perfectly well on experimental data too, nothing stops you dummy-coding treatments and running `lm()`. | Same underlying linear model, written in terms of a grand mean and group effects instead of an intercept and slopes. |

Neither parametrisation is tied to whether the data is observational or experimental. The $\mu + A_i$ form just becomes more convenient later.

**Same test (p12)**
The F-test in regression's ANOVA table and the F-test for comparing group means are the same formula:

$$F = \frac{MS_{\text{explained}}}{MS_{\text{error}}} = \frac{SS_{\text{explained}}/df_{\text{explained}}}{SS_{\text{error}}/df_{\text{error}}}$$

- Regression: $df_{\text{explained}}$ = number of predictors in the model.
- Group-mean ANOVA: $df_{\text{explained}}$ = number of groups $- 1$.

**Literally the same table (p13)**

| Source | df | SS | MS | F |
| --- | --- | --- | --- | --- |
| Explained (regression: the line / groups: between-group) | $df_1$ | $SS_{\text{explained}}$ | $SS_{\text{explained}}/df_1$ | $MS_{\text{explained}}/MS_{\text{error}}$ |
| Error (regression: residual / groups: within-group) | $df_2$ | $SS_{\text{error}}$ | $SS_{\text{error}}/df_2$ | |
| Total | $df_1 + df_2$ | $SS_{\text{total}}$ | | |

**Why taught as different things? (p14)**
Purely historical. Regression came from Galton and Pearson in the late 1800s, working on continuous variables like height and heredity, mostly observed data. ANOVA came from Ronald Fisher in the 1920s on crop trials at Rothamsted, comparing yields across experimental treatments. Different eras, different disciplines, different notation.

**So what is actually new? (p16)**
- Not a new statistical model, a new parameterisation of a linear model.
- Establishing **causal** relationships through experimental design.
## Experimental Design & ANOVA
### Observational vs Experimental Studies (p5-13)

**Observational Study**
No intervention. Measurements taken as they occur in nature. Values of independent variables are not controlled (set in advance).
- Example: house price prediction using existing sale data (bedrooms, location, size).
- Simply record explanatory variables without manipulation.

**Experimental Study**
Researchers actively manipulate conditions to investigate specific questions. Values of independent variables are controlled (set in advance).
- Example: randomly assign students to two teaching methods and measure performance differences (p9).

**Experiments enable cause-and-effect claims (p13)**
Experiments control and hold constant (as best possible) all other factors that might affect the response, isolating the treatment effect.
- Observational studies suffer from confounding variables: variables related to both response and explanatory variables, making true relationships difficult to determine.
- Correlation is not causation. A statistically significant relationship does not imply a cause-and-effect relationship.

**Goal (p14)**
Analyse data from comparative experiments where the aim is to compare group means.
### Working Example: Playback Speed Study (p15-16)
Study by Chen et al. (2024). Objective: investigate whether increasing playback speed affects comprehension of audio-only content.
- 180 undergraduate participants listened to two podcasts at either 1x, 1.5x, 2x or 2.5x speed.
- Randomly assigned one of the four playback speeds.
- Completed multiple-choice comprehension tests after listening.
- Average score taken as final outcome.
### Experimental Design Terminology (p17-18)
**Key terms (p17)**
- Response Variable: the outcome measured in the experiment.
- Factor: variable being manipulated (explanatory variables in regression).
- Factor levels: different levels/settings of the factor set in advance.
- Treatments: levels or combination of treatment levels being compared.
- Experimental Units: subjects or objects to which treatments are applied.
- Observational Units: entities on which the response is measured (often same as experimental units).
- Replicates: number of experimental units per treatment.

**Exam-phrasing versions** *(source: Definitions.pdf)*

These are the wordings to reproduce when a question says "define".

- **Experimental unit**: the physical entity to which a treatment is assigned. Example: participants in a clinical trial for a new vaccine.
- **Randomisation**: treatments should always be assigned at random to the experimental units, in such a way that each unit is equally likely to receive a given treatment. Mitigates bias.
- **Replication**: replication has occurred when each treatment has been applied independently to more than one experimental unit. Needed to ensure valid comparisons between treatments, so the difference seen is related to the treatment and not to experimental unit variation.
- **Completely Randomised Design (CRD)**: an experimental design where the treatments are allocated to the experimental units completely at random.

The same sheet names the three key principles of experimental design: randomisation, replication, blocking.

**Examples (p18)**

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

### Designing Experiments (p19-20)
A good experiment detects differences in the response between treatments (if present). Ensure the signal (differences in means) is not drowned out by noise (variability).
- Standard error is proportional to $\sigma$ (data variation or noise) and inversely proportional to sample size (signal volume).
- Smaller standard errors mean more precise estimates and greater confidence.

### The Three R's of Experimental Design (p21-31)

Listed on p21: 1. Randomisation, 2. Replication, 3. Reduction of experimental error variance.

**Randomisation (p22-25)**
Assignment of treatments to experimental units at random. Random means with equal probability, not haphazard.
- Prevents confounding: averages out systematic effects and extraneous factors not directly controlled.
- Separates treatment effect from experimental unit effect.

```R
set.seed(123)
exp_units <- 1:180
treats <- c("1x", "1.5x", "2x", "2.5x")
random <- sample(treats, 180, replace = TRUE)
cbind(exp_units, random)[1:10, ]
```

**Why randomise? (p25)**
Enhance the signal. Without randomisation, any difference between treatments could be due to differences in the experimental units themselves, confounding effects.

**Replication (p26-28)**
When a treatment is applied independently to more than one experimental unit, it is replicated. Replication allows us to:
- Quantify variability within each treatment group (experimental error variance).
- Compare within-group variation to between-group variation.
- Increase signal volume (more data).
- Quantify noise (within-group variation).

Experimental error variance (p27): differences among experimental units within the same treatment. All things vary.

**Reduce experimental error variance (p29-31)**
Decrease noise by: controlling experimental conditions, choosing similar experimental units, and randomisation. If clear differences exist between groups of experimental units that might influence response, use blocking.

Blocking (p30): technique where similar experimental units are grouped into blocks. Account for differences between blocks to isolate differences between treatments.
- Example (p31): test three inventory strategies (A, B, C) by blocking by day. Each day, randomly apply each strategy at different times (e.g. Day 1: A, C, B; Day 2: B, C, A).

### Design Structures (p32-38)

**Designing an experiment (p32)**
Must decide: What are treatment factors and treatments? What is the outcome/response? What are experimental units? Any blocking factors? How many replicates? How will randomisation be applied?

**Treatment structure (p33)**
- Single-factor: treatments are different levels of one factor (e.g. playback speed: 1x, 1.5x, 2x, 2.5x).
- Factorial: more than one factor tested simultaneously. Treatments are combinations of factor levels (e.g. playback speed by noise level).

**Blocking structure (p34-36)**
Determined by available experimental units or conditions of experimental setup.
- Example: test effect of temperature on plant growth with two greenhouses. Block by greenhouse and randomly assign plants to different temperature treatments within each greenhouse (p36).

**Designs we cover (p37)**
- Completely Randomized Design (CRD): when all experimental units are homogeneous. Treatments randomly assigned to all experimental units. Example: randomly assign patients to Drug A or Drug B without grouping.
- Randomized Block Design (RBD): when experimental units are not homogeneous (blocking required). Treatments randomized within each block. Example: divide students into blocks by proficiency level before testing different teaching methods.

**Design dictates analysis (p38)**
- Single-factor CRD leads to one-way ANOVA.
- Single-factor RBD leads to two-way ANOVA without interaction.
- Factorial treatment structure (CRD or RBD) leads to two-way or multi-way ANOVA with interaction(s).

### Single-Factor CRD and the ANOVA Model (p39-52)

**Single-Factor CRD (p39)**
Simplest design. Factor A with $a$ levels (e.g. playback speed: 1x, 1.5x, 2x, 2.5x). The $a$ treatments are randomly assigned to $r$ experimental units.
- Total observations: $N = a \times r$.
- Playback example: $a = 4$, $r = 45$, $N = 180$.
- Response variable $Y_{ij}$ for each treatment $i$ from 1 to $a$ and replicate $j$ from 1 to $r$.

**Playback data (p40-41)**
```R
playback <- read.csv("../data/playback.csv")
head(playback)
```

| Participant.ID | Condition | Comprehension |
| --- | --- | --- |
| 76b0823c2f | 2.0x | 33.33 |
| 24ae54af6f | 2.0x | 50.00 |
| 3add152a7f | 1.5x | 65.00 |
| e7d55aa954 | 2.0x | 36.67 |
| f4f7a8b549 | 1.0x | 53.33 |
| 3ad6d70ab2 | 1.0x | 41.67 |

Goal: build a statistical model to compare treatment means.

**Building the model (p42-43)**
Regression was $Y_i = \beta_0 + \beta_1 X_i + e_i$. The simplest model we can hypothesise here:

$$Y_{ij} = \mu_i + e_{ij}$$

Each observation comes from a group-specific population mean plus error.

**Reparameterising (p46-48)**

$$Y_{ij} = \mu + A_i + e_{ij}$$

where:
- $\mu$ is the grand mean (average across all groups).
- $A_i$ is the effect of treatment $i$: how much group $i$ differs from average.
- $e_{ij}$ is the error.

**The grand mean (p49)**
For the reparameterisation to be valid: $\mu = \frac{1}{N}\sum_{i=1}^{N} Y_i$ (overall mean of all observations) and $\sum_{i=1}^{a} A_i = 0$ (treatment effects sum to zero).

**Hypotheses (p50-51)**
- $H_0: \mu_1 = \mu_2 = \mu_3 = \mu_4 = \mu$ (all means the same), equivalently $A_1 = A_2 = A_3 = A_4 = 0$ (all treatment effects zero).
- $H_1$: at least one $\mu_i$ differs (not that all means differ), equivalently at least one $A_i \neq 0$.

**Why this model? (p52)**
- Allows us to conduct a global hypothesis test.
- Leads to quantities needed for the ANOVA procedure.
- ANOVA partitions total variation into sources: between-group (treatment) and within-group (error).
- If between-group variation is significantly larger than within-group variation, conclude at least one mean differs.

### Multiple Testing and Post-Hoc (p53-56)

**Do not overcomplicate this (p53)**
We want to compare means, so we built a model of means, so we perform a single test.

**Why a single global test? (p54-55)**
A single hypothesis test at 5% significance means we reject a true null 5% of the time (Type I error). With multiple tests, the overall Type I error rate inflates.

With 20 tests at the 5% level: $P(\text{at least one Type I error}) = 1 - (1 - 0.05)^{20} \approx 0.64$.

**How fast it inflates** *(source: ExtraANOVA.pdf p1-2)*

For 3 groups there are 3 pairwise comparisons, so at $\alpha = 0.05$:

$$P(\text{at least one Type I error}) = 1 - (1 - 0.05)^3 \approx 0.143$$

| Number of comparisons | Effective significance level |
| --- | --- |
| 1 | 0.05 |
| 2 | 0.098 |
| 3 | 0.143 |
| 4 | 0.185 |
| 5 | 0.226 |
| 6 | 0.265 |

ANOVA avoids this by testing a single global hypothesis instead.

**What comes after the single test? (p56)**
If the null is rejected in the global test, we know at least one mean differs but not which. Perform post-hoc tests with multiple comparison adjustments to identify which specific means differ.

**Choosing a post-hoc method** *(source: ExtraANOVA.pdf p4-5)*
- Bonferroni correction: divide the significance level by the number of comparisons. For 3 groups with 3 comparisons, $\alpha = 0.05/3 = 0.017$ per comparison.
- Tukey, Scheffe and Holm: all applicable when the equal variance assumption is satisfied.
- Games-Howell: when the equal variance assumption is not satisfied.
- Tukey HSD compares all pairs of means and controls the family-wise error rate; more powerful than Bonferroni for all-pairs comparisons.

Results can vary by method. Good practice is to decide on at least 3 post-hoc tests before the study and use the most frequent result to interpret differences.

```R
model <- aov(y ~ group, data = df)
summary(model)
TukeyHSD(model)
```

- `summary()` shows p-values for each effect. If p < 0.05, reject the null (means differ).
- `TukeyHSD()` gives pairwise confidence intervals; intervals not containing zero indicate significant differences.

### Estimation (p57-69)

**Parameter estimation (p57)**
Unknown population parameters: $\mu, A_i, \sigma^2$. Find least squares estimates minimising error sum of squares:

$$SSE = \sum_i \sum_j (Y_{ij} - \hat{Y}_{ij})^2 = \sum_i \sum_j (Y_{ij} - \mu - A_i)^2$$

Estimate using sample means:
- $\hat{\mu} = \bar{Y}_{..}$ (overall mean).
- $\hat{\mu}_i = \bar{Y}_{i.}$ (group mean).

Do not confuse the two *(source: Student Questions ANOVA.pdf)*. The grand mean $\bar{Y} = \frac{y_1 + y_2 + \ldots + y_n}{n}$ averages every observation in the dataset. A treatment mean averages only the observations that received that treatment.

**Overall mean (p59-60)**
```R
overall_mean <- mean(playback$Comprehension)
overall_mean
```
```
[1] 42.972
```

**Treatment means (p61-62)**
```R
playback$Condition <- factor(playback$Condition)
treatment_means <- tapply(playback$Comprehension, playback$Condition, mean)
treatment_means
```

| 1.0x | 1.5x | 2.0x | 2.5x |
| --- | --- | --- | --- |
| 45.11111 | 43.22178 | 43.59267 | 39.96244 |

**Treatment effects (p63-64)**
```R
treatment_means - overall_mean
```

| 1.0x | 1.5x | 2.0x | 2.5x |
| --- | --- | --- | --- |
| 2.1391111 | 0.2497778 | 0.6206667 | -3.0095556 |

**Residuals (p65-66)**
- $e_{ij} = Y_{ij} - (\mu + A_i)$
- $e_{ij} = Y_{ij} - (\mu + (\mu_i - \mu))$
- $e_{ij} = Y_{ij} - \mu_i$
- $\hat{e}_{ij} = Y_{ij} - \hat{\mu}_i$

**Fitting the model in R (p67)**
```R
model <- aov(Comprehension ~ Condition, data = playback)
```

**Extract model estimates, means (p68)**
```R
model.tables(model, type = "means", se = TRUE)
```
Tables of means:
- Grand mean: 42.972
- Condition means: 1.0x 45.11, 1.5x 43.22, 2.0x 43.59, 2.5x 39.96
- Standard errors for differences of means: 2.687 (replicates: 45)

**Extract model estimates, effects (p69)**
```R
model.tables(model, type = "effects", se = TRUE)
```
Tables of effects:
- Condition: 1.0x 2.1391, 1.5x 0.2498, 2.0x 0.6207, 2.5x -3.0096
- Standard errors of effects: 1.9 (replicates: 45)

### Experimental Error Variance (p70-71)

**Understanding error variance (p70)**
$e_{ij} \sim N(0, \sigma^2)$. Errors are deviations of response values from their group mean. Variance of errors is how much response values deviate from their group mean.

**Estimating error variance (p71)**
$\sigma^2$ is experimental error variance: how much experimental units deviate within a treatment. Constant across groups.

$$s^2 = \frac{1}{N-a} \sum_i \sum_j (Y_{ij} - \bar{Y}_{i.})^2$$

Average of observed variability across all groups.

### ANOVA Assumptions (p72-87)

**Model assumptions (p72)**
1. No severe outliers.
2. Equal population variance (homoscedasticity).
3. Normally distributed errors.
4. Independent errors.

There are formal techniques to test some of these; we stick to informal techniques.

**Robustness of ANOVA (p73)**
A statistical procedure is robust to departures from an assumption if results remain unbiased even when the assumption is not met. For ANOVA:
1. Only severe departures from normality (long-tailed, skewed) are problematic.
2. Independence within and among groups is extremely important.
3. Robust to violations of equal variance as long as there are no outliers, sample sizes are large, and sample variances are relatively equal.
4. Not resistant to severely outlying observations.

**Outliers (p74-75)**
- Data entry or recording errors.
- Interesting outliers.
- Distort estimates.
- Check for outliers by plotting data.

**Equal population variance (p76-77)**
Assume treatment populations have the same variance: $e_{ij} \sim N(0, \sigma^2)$. Simplifies mathematics and interpretation. Sample variances need to be similar enough.

Check: interquartile ranges and standard deviations should be comparable. Use boxplots or look at sample statistics.

```R
sort(tapply(playback$Comprehension, playback$Condition, sd))
```

| 2.5x | 2.0x | 1.5x | 1.0x |
| --- | --- | --- | --- |
| 9.818431 | 12.588622 | 14.005073 | 14.095302 |

**Normally distributed errors (p78-79)**
Errors are normally distributed, not the raw response. If the response is clearly non-normal, errors probably also are. Check with boxplots or Q-Q plots. Look for severe asymmetry. Check again after model fitting with residuals.

**Independence (p80-83)**
Trickiest assumption. Errors are determined by independent observations via proper experimental design. There should be independence within and among treatments.

Dependence can be caused by: not randomising observation order, measurement drift, applying treatments to the same group of experimental units.

Check dependence between successive observations with a dot chart (p82).

**Checking assumptions after model fitting (p84-87)**

Residuals vs fitted values (p84):
```R
plot(model, which = 1)
```

Q-Q plot (p85):
```R
plot(model, which = 2)
```

Histogram of residuals (p86):
```R
hist(resid(model))
```

Residuals vs order of observations, checks independence (p87):
```R
plot(resid(model) ~ seq_along(resid(model)),
     xlab = "Order of Observations",
     ylab = "Residuals",
     main = "Residuals vs. Order")
abline(h = 0, col = "red")
```

### The ANOVA table and the F-test

Not in this week's 87 slides. The deck stops at assumption checking and the SS partitioning arrives in Week 5. Kept here because the Week 4 tutorial and the Resources PDFs already lean on it.

**Why we test variances to conclude something about means** *(source: Student Questions ANOVA.pdf)*
Because of sampling error, group means will differ a bit even when the populations are identical. Eyeballing the means cannot tell you whether a gap is real. So instead of comparing means directly, compare the distance from the overall mean to the group means (between-group variation) against the distance from group means to individual observations (within-group variation). Splitting the data into groups is only justified when between-group variation is clearly larger than within-group variation, that is, when explaining the data with separate group means beats explaining it with one overall mean.

**Partitioning the variation**
$H_0: \mu_1 = \mu_2 = \ldots = \mu_a$ against at least one differing.

- $SS_{\text{Total}} = \sum_i \sum_j (y_{ij} - \bar{y}_{..})^2$
- $SS_{\text{treatment}} = \sum_i r(\bar{y}_{i.} - \bar{y}_{..})^2$ (where $r$ = number of replicates)
- $SSE = \sum_i \sum_j (y_{ij} - \bar{y}_{i.})^2$

**Where the degrees of freedom come from** *(source: onewayANOVA_degreesoffreedom.pdf)*

Think in terms of the number of deviations being squared, then subtract one df per parameter estimated.

| Sum of squares | Deviations squared | Estimates used | df |
| --- | --- | --- | --- |
| $SS_{\text{Total}}$ | $N$ observations around the grand mean | grand mean (1) | $N - 1$ |
| $SS_{\text{treatment}}$ | $a$ group means around the grand mean | grand mean (1) | $a - 1$ |
| $SSE$ | $N$ observations around their own group mean | $a$ group means | $N - a$ |

When balanced with $n$ per group, $N - a = a(n-1)$.

**Why the MS column exists** *(source: Student Questions ANOVA.pdf)*
Sums of squares are not comparable on their own, they grow with the number of terms added up. Dividing each SS by its df turns it into a mean square, an average squared deviation. Only then can treatment and error variation be compared on the same scale, which is what makes the significance test possible.

**The table**

| Source | SS | df | MS | F |
| --- | --- | --- | --- | --- |
| Treatment (between-group) | $SS_A$ | $a-1$ | $MS_A = SS_A/(a-1)$ | $F = MS_A/MSE$ |
| Error (within-group) | $SSE$ | $N-a$ | $MSE = SSE/(N-a)$ | |
| Total | $SS_{\text{total}}$ | $N-1$ | | |

**The F statistic** *(source: ExtraANOVA.pdf p3-4)*

$$F = \frac{\text{Between-group variance}}{\text{Within-group variance}} = \frac{\sum_{i=1}^{K} n_i(\bar{Y}_i - \bar{Y})^2 / (K-1)}{\sum_{ij} (Y_{ij} - \bar{Y}_i)^2 / (N-K)}$$

where $\bar{Y}_i$ is the mean of group $i$, $n_i$ the number of observations in group $i$, $\bar{Y}$ the overall mean, $K$ the number of groups, $Y_{ij}$ the $j$-th observation in group $i$, and $N$ the total number of observations.

Reject $H_0$ for large $F$. The F distribution is formed by ratios of variances and is named after Ronald Fisher, which is why the ANOVA test is also called the F test.

Worked example in ExtraANOVA: heights of students in three classes, 30 students each, giving $F = 3.629$ with significance 0.031, so reject at 5%.

# Resources

Four supporting PDFs. Their content has been merged into the lecture sections above so each idea lives in one place. Pointers below.

| File | Pages | What it adds | Merged into |
| --- | --- | --- | --- |
| [[materials/lectures/week-04/Definitions.pdf\|Definitions.pdf]] | 1 | Exam-phrasing definitions of experimental unit, randomisation, replication, CRD | Experimental Design Terminology |
| [[materials/lectures/week-04/onewayANOVA_degreesoffreedom.pdf\|onewayANOVA_degreesoffreedom.pdf]] | 1 | Why each SS has the df it has | The ANOVA table and the F-test |
| [[materials/lectures/week-04/Student Questions ANOVA.pdf\|Student Questions ANOVA.pdf]] | 3 | Why the MS column exists, why variances test means, grand vs treatment mean | The ANOVA table and the F-test, Estimation |
| [[materials/lectures/week-04/ExtraANOVA.pdf\|ExtraANOVA.pdf]] | 5 | Type I error inflation table, between vs within variance intuition, F formula, post-hoc method choice | Multiple Testing and Post-Hoc, The ANOVA table and the F-test |

Notes on the sources themselves:
- Definitions and onewayANOVA_degreesoffreedom are handwritten scans, one page each.
- Student Questions ANOVA is an image-only scan with no extractable text; the three points above are its whole content.
- ExtraANOVA is a Korean Journal of Anesthesiology article, the only one worth reading end to end on its own.

# Data

## multitask_performance.csv

120 rows, 2 columns. Single-factor CRD, balanced, 40 replicates per treatment.

| Column | Type | Values |
| --- | --- | --- |
| `Group` | chr | `Control`, `Exp1`, `Exp2` (40 each) |
| `Posttest` | num | post-test score |

## playback.csv

180 rows, 3 columns. The deck's running example. Balanced, 45 replicates per treatment.

| Column | Type | Values |
| --- | --- | --- |
| `Participant.ID` | chr | 180 unique 10-char ids |
| `Condition` | chr | `1.0x`, `1.5x`, `2.0x`, `2.5x` |
| `Comprehension` | num | test percentage |

The Amathuba source file is named `playback - Copy.csv`; saved locally as `playback.csv`.

## test_anxiety.csv

15 rows, 2 columns. Used by Tutorial 1 Question 1. Balanced, 5 replicates per treatment.

| Column | Type | Values |
| --- | --- | --- |
| `Group` | chr | `Group 1`, `Group 2`, `Group 3` |
| `Score` | int | Test Anxiety Index (TAI) |

| Group 1 | Group 2 | Group 3 |
| --- | --- | --- |
| 48 | 55 | 51 |
| 50 | 52 | 52 |
| 53 | 53 | 50 |
| 52 | 55 | 53 |
| 50 | 53 | 50 |

# Tutorial

## Tutorial 1

Experimental design and CRD / One-way ANOVA. 4 pages, two questions plus extras.

### Question 1: Test anxiety therapy

Three groups of students, 5 in each, receiving therapy for severe test anxiety in a CRD. Group 1 got 5 hours of therapy, group 2 got 10 hours, group 3 got 15 hours. At the end each subject completed an evaluation of test anxiety (the dependent variable). Did the amount of therapy affect the level of test anxiety? Data in `test_anxiety.csv`.

1. Identify: (a) treatment factor, (b) factor levels, (c) treatments, (d) response, (e) experimental units, (f) number of replicates.
2. What is the treatment structure and how has randomisation been conducted?
3. What would be the problem if we said group was the experimental units?
4. Write down the model equation used for analysing data from this type of experiment. Be specific.
5. Calculate by hand, and note the R code for the first three: (a) overall mean, (b) treatment means, (c) treatment effects, (d) estimated error variance.
6. Write out the separate model equations for each treatment.
7. What is the error term for observation $Y_{ij}$?
8. What is the standard error of treatment means? Of differences between treatment means? Calculate without using R (you will not have R in the exam).
9. What are the assumptions of this model and how would you check each? Remember assumptions can be checked before and after model fitting.
10. Plot the data per treatment as box plots with points overlayed. Select the options that apply: (a) the boxplots indicate severe outliers, (b) it is hard to tell if the data are normally distributed because the sample sizes are so small, (c) the heights of the boxplots look comparable.
11. Besides boxplots, what other visualisation checks normality?
12. Which assumption(s) do we need to check after model fitting as well? Why?
13. What is the ratio of largest to smallest standard deviations of the treatments?
14. If the sample standard deviations are different, that means the groups do not have equal population variance. True or false? Motivate.

### Question 2: Baking temperature

A food scientist investigates whether four baking temperatures affect the average rise height (cm) of a bread.
- Temperatures: 180C, 190C, 200C, 210C.
- For each temperature the scientist prepares 12 loaves, same recipe and ingredients.
- Each loaf is baked independently at its assigned temperature.
- After baking, rise height of each loaf is measured once.
- Loaves are baked in random order.

1. How many replicates does this experiment have?
2. What is the experimental unit?
3. Why is it important that each loaf is baked independently?
4. True or false: randomising the baking order helps ensure differences in rise height are due to temperature rather than time-related effects.
5. Is this experiment balanced or unbalanced?
6. Suppose the scientist measured rise height of each loaf three times and recorded the average. Would this change the number of replicates? Explain.
7. If loaves had been baked one temperature per day (all 180C on Day 1, all 190C on Day 2, etc.), what problem could arise?
8. State the null and alternative hypothesis for analysing this experiment with ANOVA.
9. Write down the model equation. Be specific.
10. Use the simulation code below and check the assumptions.

```R
set.seed(123)  # ensures you get the same data every time

# Factor: baking temperature, 12 loaves (replicates) per temperature
temp <- factor(rep(c("180", "190", "200", "210"), each = 12))

# Simulated rise heights (cm)
rise <- c(
  rnorm(12, mean = 6.0, sd = 0.5),
  rnorm(12, mean = 6.4, sd = 0.5),
  rnorm(12, mean = 6.3, sd = 0.5),
  rnorm(12, mean = 5.8, sd = 0.5)
)

bread <- data.frame(temp, rise)
```

### More questions

Use the lecture slides and notebook.

2. Explain the difference between an observational study and an experiment.
3. What is one key principle of experiments that allows the establishment of causal relationships?
4. Why is it difficult to establish causal effects through observational studies?
5. Define, in terms of experimental design: (a) response, (b) factor, (c) treatments, (d) experimental units.
6. What is an experiment called where treatments are combinations of factor levels?
7. Why is having more than one response value per experimental unit problematic?
8. What design principle can be used when experimental units are not homogeneous? How is randomisation applied in this procedure?
9. Suppose a researcher conducts 10 independent hypothesis tests, each at a 5% significance level. If all null hypotheses are true, calculate the probability that the researcher makes at least one Type I error.

## Tutorial 1 Memo

9 pages. Full worked solutions to both questions. Do not open until you have attempted the tutorial. File: [[practice/week-04/tutorial1_memo.pdf|tutorial1_memo.pdf]].

## Tutorial 1 R Script

[[practice/week-04/Tutorial1.R|Tutorial1.R]]. Question 1 works `test_anxiety.csv` by hand-rolling every quantity before calling `aov()`, which is exactly the by-hand-then-check pattern the exam wants.

Question 1 structure:
```R
data <- read.csv("Data/test_anxiety.csv")

overall_mean <- mean(data$Score)

mean1 <- mean(data$Score[data$Group == "Group 1"])
mean2 <- mean(data$Score[data$Group == "Group 2"])
mean3 <- mean(data$Score[data$Group == "Group 3"])
treatment_means <- c(mean1, mean2, mean3)

treatment_effects <- treatment_means - overall_mean

# error variance: within-group SS, pooled
group1_sum_squares <- sum((data$Score[data$Group == "Group 1"] - mean1)^2)
group2_sum_squares <- sum((data$Score[data$Group == "Group 2"] - mean2)^2)
group3_sum_squares <- sum((data$Score[data$Group == "Group 3"] - mean3)^2)
sum_squares <- sum(group1_sum_squares, group2_sum_squares, group3_sum_squares)

N <- nrow(data)
a <- 3
MSE <- sum_squares / (N - a)
```

Assumption checks:
```R
boxplot(Score ~ Group, data = data,
        ylab = "Score", main = "Score Distribution by Group", las = 1, outline = FALSE)
stripchart(Score ~ Group, data = data, vertical = TRUE, add = TRUE, method = "jitter")

sort(tapply(data$Score, data$Group, sd))

par(mfrow = c(2, 2))
qqnorm(data$Score[data$Group == "Group 1"], main = "Q-Q Plot: Group 1", col = "blue")
qqline(data$Score[data$Group == "Group 1"], col = "red")
# repeat for groups 2 and 3

dotchart(data$Score, ylab = "Order of Observation",
         xlab = "Post Treatment Data Score", main = "Dot Plot of Scores")
```

Fit and report:
```R
mod1 <- aov(Score ~ Group, data = data)
model.tables(mod1, type = "means", se = TRUE)
model.tables(mod1, type = "effects", se = TRUE)
summary(mod1)
```

Question 2 repeats the same assumption-check block on the simulated `bread` data.

The script reads `"Data/test_anxiety.csv"`. Locally the file is at `data/test_anxiety.csv`, so adjust the path or set the working directory.
