---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/reference/formulae-sta2020-2025.pdf|formula sheet]], [[materials/lectures/week-05/Week 5 - RCBD.pdf|RCBD deck]] (32 pages), [[materials/lectures/week-05/Week 5 New.pdf|one-way ANOVA deck]] (38 pages), [[materials/lectures/week-05/Independence.pdf|independence]] (8 pages), [[materials/lectures/week-05/ExtraANOVAExplanation.pdf|ANOVA explanation]] (6 pages).
## Randomised Complete Block Design (RCBD)
Page refs: (pNN) = PDF page in [[materials/lectures/week-05/Week 5 - RCBD.pdf|RCBD deck]] (32 pages).
### Introduction: Why Blocking (p2-7)
**Slide: Why use blocks? (p2)**
In Completely Randomised Design (CRD), treatments are assigned to experimental units completely at random. Randomisation assumes all units are homogeneous and differences in group means due to treatments are valid because possible unit differences average out across treatment groups.

**Slide: Important sources of variability (p3)**
Often there is important variation in additional variables not directly of interest. Randomisation does not always guarantee perfect balance, especially with strong sources of variation. If we group units by these sources to make units more similar within groups, we get a more powerful design.

**Slide: Quick Example (p4)**
A researcher tests two fertilizers (A and B) on plant growth. The greenhouse consistently receives more sunlight in one part, and sunlight affects growth. Instead of unrestricted randomisation, we can block by sunlight level (low, medium, high) and randomise fertiliser assignment within each block. This groups similar units and isolates treatment effects.

**Slide: When to use blocking? (p5)**
Use blocking when there is a known source of variation that impacts the response but is not of interest. We want to control for this variation to isolate treatment effects more clearly.

**Slide: Common blocking factors (p6)**
- **Geographic location**: field, site, regions, cities with similar conditions
- **Time**: experimental replication over different days or weeks (seasonal effects)
- **Subject**: person, plant, business, phenotype
- **Demographic groups**: age, gender, income, education, consumer segments
- **Equipment**: container types, growth chambers

**Slide: Example #1 (p7)**
Three fertilizers (A, B, C) tested on wheat yield. Soil quality varies across field. Solution: divide field into blocks by soil type (sandy, loamy, clayey). Within each block, randomly assign three fertilizers to plots. Measure wheat yield (kg per plot) at season end.

**Slide: Example #2 (p8)**
Testing three teaching methods (lecture, group discussion, problem-solving) on student performance across classrooms. Different teachers may influence results. Solution: use Randomised Complete Block Design with teacher as blocking variable, average classroom grade as response. Each teacher teaches all three methods.

**Slide: Example #3 (p9)**
Comparing three exercises (cycling, running, rowing) on heart rate recovery. Participants grouped by fitness level (low, moderate, high). Within each fitness level, randomly assign three exercises. Measure heart rate recovery time (seconds to return to resting) as response.
### RCBD Structure (p10-13)
**Slide: RCBD Setup (p10)**
- We wish to compare $a$ treatments with $N$ experimental units arranged in $b$ blocks
- Each block contains $a$ homogeneous experimental units, so $N = ab$
- The $a$ treatments are randomly assigned to units in the $j$-th block
- Each treatment is replicated $b$ times (once per block)

**Slide: Example datasets #1 (p11)**
Wheat yield (kg) across different fertilizer treatments:

| Soil | A | B | C |
|---|---|---|---|
| Sandy | 37.94 | 41.12 | 47.22 |
| Loamy | 39.78 | 45.23 | 50.35 |
| Clayey | 48.87 | 53.68 | 59.52 |

**Slide: Example datasets #2 (p12)**
Test scores across different teaching methods:

| Teacher | Lecture | Group Discussion | Problem Solving |
|---|---|---|---|
| Teacher 1 | 75 | 79 | 52 |
| Teacher 2 | 80 | 58 | 94 |
| Teacher 3 | 68 | 85 | 61 |
| Teacher 4 | 90 | 73 | 88 |
| Teacher 5 | 65 | 84 | 60 |

**Slide: Example datasets #3 (p13)**
Heart rate recovery (seconds) across different exercises:

| Fitness Level | Cycling | Running | Rowing |
|---|---|---|---|
| Low | 65 | 80 | 50 |
| Moderate | 60 | 78 | 45 |
| High | 55 | 72 | 42 |
### The RCBD Model (p14-17)
**Slide: One-way ANOVA model (p14)**
The one-way ANOVA model (without blocking):
$$Y_{ij} = \mu + A_i + e_{ij}$$

where:
- $i = 1, \ldots, a$ (number of treatments)
- $j = 1, \ldots, r$ (number of replicates)
- $Y_{ij}$ = response value of the $j$-th unit receiving treatment $i$
- $\mu$ = overall or general mean
- $A_i$ = effect of the $i$-th level of treatment factor A
- $e_{ij}$ = random error with $e_{ij} \sim N(0, \sigma^2)$

**Slide: Problem without blocking when necessary (p15)**
If we ignore the blocking factor when one exists, some variation in $e_{ij}$ reflects systematic block differences rather than pure randomness. Examples:
- **Fertiliser experiment**: soil type affects yield but if not included in model, error term contains both random variation and soil-type differences
- **Teacher experiment**: if teacher affects performance but not included, error term mixes random variation with teacher effects
- **Fitness experiment**: if fitness level affects heart rate but not included, error term mixes random variation with fitness-level differences

**Slide: Visualisation (p16)**
(content is a figure: comparison of CRD vs RCBD scatter plots showing treatment groups and within-group variability)

**Slide: Introducing a blocking term (p17)**
To account for block variation, we modify the model:
$$Y_{ij} = \mu + A_i + B_j + e_{ij}$$

where $B_j$ (block effect) represents systematic differences due to blocks (e.g., soil type, teacher, fitness level). Block effect is interpreted like treatment effect: difference between block mean and overall mean. Estimation uses least squares (sample means).
### Sums of Squares Decomposition (p18-20)
**Slide: Sums of squares (p18)**
With two factors, we have an extra source of variability. Starting from:
$$Y_{ij} = \mu + A_i + B_j + e_{ij}$$

Rewrite as:
$$Y_{ij} - \bar{Y} = (\bar{Y}_i - \bar{Y}) + (\bar{Y}_j - \bar{Y}) + (Y_{ij} - \bar{Y}_i - \bar{Y}_j + \bar{Y})$$

Square and sum across indices:
$$\sum_i \sum_j (Y_{ij} - \bar{Y})^2 = \sum_i \sum_j (\bar{Y}_i - \bar{Y})^2 + \sum_i \sum_j (\bar{Y}_j - \bar{Y})^2 + \sum_i \sum_j (Y_{ij} - \bar{Y}_i - \bar{Y}_j + \bar{Y})^2$$

This gives us:
$$SS_{\text{total}} = SS_A + SS_B + SSE$$

**Slide: Comparison to CRD (p19)**
CRD decomposition:
$$SS_{\text{total}} = SS_{\text{treatments}} + SS_{\text{within groups}}$$

RCBD decomposition:
$$SS_{\text{total}} = SS_{\text{treatments}} + SS_{\text{blocks}} + SS_{\text{within groups}}$$

If we had used CRD when blocking was necessary:
$$SS_{\text{total}} = SS_{\text{treatments}} + [SS_{\text{blocks}} + SS_{\text{within groups}}]$$

This inflates error, reducing power to detect real treatment effects.

**Slide: ANOVA Table (p20)**

| Source | SS | df | MS | F |
|--------|----|----|----|----|
| Treatments A | $SS_A = b\sum_i (\bar{Y}_i - \bar{Y}_{..})^2$ | $a-1$ | $MS_A = SS_A/(a-1)$ | $F_A = MS_A/MSE$ |
| Blocks B | $SS_B = a\sum_j (\bar{Y}_j - \bar{Y}_{..})^2$ | $b-1$ | $MS_B = SS_B/(b-1)$ | $F_B = MS_B/MSE$ |
| Error | $SSE = \sum_i \sum_j (Y_{ij} - \bar{Y}_i - \bar{Y}_j + \bar{Y}_{..})^2$ | $(a-1)(b-1)$ | $MSE = SSE/[(a-1)(b-1)]$ | |
| Total | $SS_{\text{total}} = \sum_i \sum_j (Y_{ij} - \bar{Y}_{..})^2$ | $ab-1$ | | |
### Application to Data (p21-32)
**Slide: In R - Comparison of CRD vs RCBD (p21)**
Using fertilizer data:

CRD analysis (ignoring soil type):
```R
crd_model <- aov(Yield ~ Fertilizer, data = fertilizer_long)
summary(crd_model)
# Output:
#           Df Sum Sq Mean Sq F value Pr(>F)
# Fertilizer 2 155.8  77.88   2.012  0.214
# Residuals  6 232.2  38.71
```

RCBD analysis (including soil type):
```R
rcbd_model <- aov(Yield ~ Fertilizer + Soil, data = fertilizer_long)
summary(rcbd_model)
# Output:
#           Df Sum Sq Mean Sq F value Pr(>F)
# Fertilizer 2 155.77 77.88   210.6   8.85e-05 ***
# Soil       2 230.75 115.38  312.0   4.06e-05 ***
# Residuals  4 1.48   0.37
```

Notice: blocking reduces MSE dramatically (38.71 to 0.37), increases F-statistic (2.012 to 210.6), making treatment effect highly significant.

**Slide: ANOVA Hypotheses (p22)**
Two sets of hypotheses to test:

**Treatments:**
- $H_0$: all treatment means are equal
- $H_1$: at least one treatment mean differs

**Blocks:**
- $H_0$: all block means are equal
- $H_1$: at least one block mean differs

**Slide: F-test for blocks (p23)**
- If $F > 1$: blocking reduced unexplained error variance, confirming blocking effectiveness
- If $F \approx 1$: blocks did not improve experiment power; CRD would have worked equally well
- If $F < 1$ (rare): blocking increased variability, suggesting poor block choice or strong block-treatment interactions

**Slide: Analysis of RCBDs (p24)**
To analyse RCBD data, we use two-way ANOVA without interactions. This assumes treatment effects are similar across all blocks.

**Slide: Additivity assumption (p25)**
The model assumes treatment effect does not differ by block. Examples of this assumption:
- **Teacher experiment**: the effect of each teaching method is the same across teachers
- **Fertiliser experiment**: the effect of each fertiliser is the same across soil types
- **Fitness experiment**: the effect of each exercise type is the same across fitness levels

Violations indicate treatment-block interaction, which requires a more complex model.

**Slide: Check in R (p26)**
(content is a figure: diagnostic plot for checking additivity assumption)

**Slide: Assumptions of RCBD (p27)**
RCBD assumes the same four conditions as one-way ANOVA:
1. Independent errors
2. Normally distributed errors
3. Homogeneous variance across treatments
4. No severe outliers
5. Additivity: treatment and block effects are additive (no interaction)
### Worked Example: Heart Rate Recovery (p28-32)
**Slide: Apply to example (p28)**
Heart rate recovery (seconds) across different exercises:

| Fitness Level | Cycling | Running | Rowing |
|---|---|---|---|
| Low | 65 | 80 | 50 |
| Moderate | 60 | 78 | 45 |
| High | 55 | 72 | 42 |

**Slide: In R (p29)**
```R
rcbd_model <- aov(Score ~ Exercise_Type + Fitness_Level,
                  data = exercise_long)
```

**Slide: Model estimates - means (p30)**
```R
model.tables(rcbd_model, type = "means")
# Tables of means
# Grand mean
# 60.77778
#
# Exercise_Type
#        Cycling   Rowing  Running
#       60.00    45.67   76.67
#
# Fitness_Level
#        High      Low    Moderate
#       56.33    65.00    61.00
```

**Slide: Model estimates - effects (p31)**
```R
model.tables(rcbd_model, type = "effects")
# Tables of effects
# Exercise_Type
#       Cycling   Rowing  Running
#      -0.778   -15.111  15.889
#
# Fitness_Level
#        High      Low    Moderate
#      -4.444    4.222    0.222
```

**Slide: ANOVA in R (p32)**
```R
summary(rcbd_model)
#              Df Sum Sq Mean Sq F value Pr(>F)
# Exercise_Type 2 1444.2  722.1  649.9   9.41e-06 ***
# Fitness_Level 2  112.9   56.4   50.8   0.00143 **
# Residuals     4    4.4    1.1
```

Interpretation: both exercise type ($F = 649.9$, p < 0.001) and fitness level ($F = 50.8$, p = 0.001) significantly affect heart rate recovery. Blocking by fitness level was highly effective in reducing error variance.
## One-way ANOVA Foundations
Page refs: (pNN) = PDF page in [[materials/lectures/week-05/Week 5 New.pdf|one-way ANOVA deck]] (38 pages).

This deck provides foundational concepts for ANOVA, building intuition for the decomposition of variation and hypothesis testing used in RCBD.
### ANOVA Recap and Concepts (p2-7)
**Slide: Recap (p2)**
To compare treatment group means, use the statistical model:
$$Y_{ij} = \mu + A_i + e_{ij}$$

where $i = 1, \ldots, a$ (treatments), $j = 1, \ldots, r$ (replicates), $Y_{ij}$ = response, $\mu$ = overall mean, $A_i$ = treatment effect, $e_{ij} \sim N(0, \sigma^2)$.

**Slide: This model is equivalent to a regression model (p3)**
ANOVA and regression are equivalent, just parameterised differently:
- ANOVA uses $\mu$ and $A_i$ coefficients
- Regression uses $\beta_0$ (baseline category mean) and $\beta_i$ (difference from baseline)

Both models test differences between group means using the same data, just different notation.

**Slide: Why ANOVA model? (p4)**
When all explanatory variables are categorical, ANOVA notation is more convenient. The $A_i$ notation is concise and leads directly to Analysis of Variance decomposition.

**Slide: ANOVA - Hypothetical Experiment (p5)**
Compare two experiments with same means ($A = 40$, $B = 50$, $C = 60$) but different within-group variability:

**Experiment 1** (low within-group variance):
- Treatment A: 40, 42, 38 (avg 40)
- Treatment B: 48, 50, 52 (avg 50)
- Treatment C: 58, 62, 60 (avg 60)

**Experiment 2** (high within-group variance):
- Treatment A: 40, 25, 55 (avg 40)
- Treatment B: 65, 35, 50 (avg 50)
- Treatment C: 45, 75, 60 (avg 60)

**Slide: Plot of hypothetical data (p6)**
(content is a figure: scatter plot comparing low vs high within-group variance with same treatment means)

**Slide: Interpretation (p7)**
Both experiments have identical treatment means, but within-treatment variability differs:
- Experiment 1 has small within-group variation, so treatment differences stand out clearly
- Experiment 2 has large within-group variation, obscuring treatment differences

We are more confident treatment means differ in Experiment 1. This difference is the basis of ANOVA.
### ANOVA Concepts and Decomposition (p8-12)
**Slide: ANOVA (p8)**
ANOVA compares between-treatment variation (signal: differences in group means) to within-treatment variation (noise: differences within groups) as a ratio:
$$\frac{\text{Between variation}}{\text{Within variation}}$$

- Large ratios: signal is large relative to noise, evidence for treatment differences
- Small ratios (near 1): signal is small relative to noise, no evidence for treatment differences

**Slide: How do we measure between and within variation? (p9)**
Many measures of variability exist (IQR, SD, range). A common measure is sums of squares (SS): sum of squared deviations from a mean.

Sums of squares relate to variance:
$$\text{Variance} = \frac{\text{Sums of Squares}}{\text{Degrees of Freedom}} = \frac{\sum (Y_{ij} - \bar{Y})^2}{N-1}$$

**Slide: Sums of squares (p10)**
Using the model, decompose total sums of squares into:
- **Between groups / due to treatments** ($SS_B$, $SS_{\text{TREAT}}$, $SS_A$): variation due to treatment differences
- **Within groups** ($SS_W$, $SSE$): variation within groups (error)

$$SS_{\text{total}} = \sum (Y_{ij} - \bar{Y})^2 = \sum_i r(\bar{Y}_i - \bar{Y})^2 + \sum_i \sum_j (Y_{ij} - \bar{Y}_i)^2$$

**Slide: Decomposition of the Total Sum of Squares (p11)**
Starting from the model: $Y_{ij} = \mu + A_i + e_{ij}$

Rewrite in terms of means:
$$Y_{ij} = \bar{Y} + (\bar{Y}_i - \bar{Y}) + (Y_{ij} - \bar{Y}_i)$$

Rearrange:
$$Y_{ij} - \bar{Y} = (\bar{Y}_i - \bar{Y}) + (Y_{ij} - \bar{Y}_i)$$

**Slide: Square and sum across indices (p12)**
Square both sides and sum across all $i$ and $j$:
$$\sum_i \sum_j (Y_{ij} - \bar{Y})^2 = \sum_i \sum_j (\bar{Y}_i - \bar{Y})^2 + \sum_i \sum_j (Y_{ij} - \bar{Y}_i)^2$$

Simplify:
$$SS_{\text{total}} = r \sum_i (\bar{Y}_i - \bar{Y})^2 + \sum_i \sum_j (Y_{ij} - \bar{Y}_i)^2$$
$$SS_{\text{total}} = SS_{\text{between groups}} + SS_{\text{within groups}}$$
### Application to Hypothetical Data (p13-18)
**Slide: Apply to hypothetical example (Experiment 1) (p13)**
(content is a figure: calculation of sums of squares for Experiment 1)

**Slide: From sums of squares to variance (p14)**
Divide sums of squares by appropriate degrees of freedom to get mean squares (MS):
$$MS = \frac{SS}{df}$$

This converts a sum of squared deviations into an average squared deviation, which is a measure of variance.

**Slide: Mean squares for group differences (p15)**
Mean square for between-group differences:
$$MS_B = \frac{SS_B}{a-1}$$

Mean square for within-group differences (error):
$$MS_E = \frac{SS_E}{N-a}$$

**Slide: The F-ratio (p16)**
The F-ratio is the ratio of two mean squares:
$$F = \frac{MS_B}{MS_E}$$

**Slide: F-ratio and our hypothesis (p17)**
- When $MS_B \approx MS_E$: no evidence against $H_0: \mu_1 = \mu_2 = \mu_3 = \mu_4 = \mu$
- When $MS_B >> MS_E$: evidence against $H_0$, suggesting $H_1$: at least one treatment mean differs
### Hypothesis Testing with F-distribution (p19-22)
**Slide: But how large is large enough? (p19)**
Perform a hypothesis test:
1. Get sampling distribution of test statistic
2. Compare test statistic to sampling distribution
3. Get p-value

The F-ratio follows an F-distribution under null hypothesis of equal means:
$$\frac{MS_B}{MS_E} \sim F_{df1, df2} = F_{a-1, N-a}$$

**Slide: Meet the F-distribution (p20)**
(content is a figure: F-distribution curves showing shape dependence on numerator and denominator degrees of freedom)

**Slide: Get the p-value and make a conclusion (p21)**
P-value: probability of observing our test statistic (or more extreme) under the null hypothesis.
- Small p-value: unlikely to observe this test statistic if null hypothesis true, so reject $H_0$
- Large p-value: likely to observe this test statistic if null hypothesis true, so fail to reject $H_0$

**Slide: Get the p-value and make a conclusion - example (p22)**
(content is a figure: F-distribution with shaded p-value region)
### ANOVA Table and Practical Examples (p23-38)
**Slide: Summarise the hypothesis test in an ANOVA table (p24)**

| Source | SS | df | MS | F |
|--------|----|----|----|----|
| Treatment | $\sum_i r(\bar{Y}_i - \bar{Y})^2$ | $a-1$ | $MS_B = SS_A/(a-1)$ | $MS_B/MS_E$ |
| Residuals (Error) | $\sum_i \sum_j (Y_{ij} - \bar{Y}_i)^2$ | $N-a$ | $MS_E = SS_E/(N-a)$ | |
| Total | $\sum_i \sum_j (Y_{ij} - \bar{Y})^2$ | $N-1$ | | |

**Slide: Hypothetical example ANOVA table (p25)**
For Experiment 1:

| Source | SS | df | MS | F |
|--------|----|----|----|----|
| Treatment | 600 | 2 | 300 | 75 |
| Residuals | 24 | 6 | 4 | |
| Total | 624 9 | | | |

**Slide: P-value in R (p23)**
```R
pf(q = 75, df1 = 2, df2 = 6, lower.tail = FALSE)
# [1] 5.689577e-05
```

p-value is extremely small, so we reject $H_0$ and conclude treatment means differ.

**Slide: Playback Experiment in R (p26)**
```R
summary(model)
#          Df Sum Sq Mean Sq F value Pr(>F)
# Condition 3    634   211.2     1.3  0.276
# Residuals  176  28587   162.4
```

**Slide: Conclusion (p27)**
ANOVA results indicate no significant effect of playback condition on mean comprehension score ($F = 1.3$, p-value = 0.276). This suggests playback speed does not impact comprehension of audio-only content.

**Slide: Another Example (p28)**
A music therapy researcher investigates how background music influences stress reduction in young adults. Participants randomly assigned to listen to one of three music types (or control, no music) for 30 minutes after a mentally demanding task:
1. Lo-fi beats: smooth, downtempo music for relaxation
2. Nature sounds with soft instrumental: birdsong, rain, calming melodies
3. Upbeat instrumental electronic: energetic but non-distracting
4. Control: no music

Participants complete stress assessment (0 = completely relaxed to 100 = highly stressed).

**Slide: Data (p29)**
Stress scores by music type:

| Lo-fi Beats | Nature Sounds | No Music | Upbeat Electronic |
|---|---|---|---|
| 40 | 36 | 56 | 44 |
| 53 | 19 | 63 | 46 |
| 19 | 33 | 49 | 57 |
| 47 | 38 | 52 | 53 |
| 41 | 47 | 52 | 46 |
| 42 | 41 | 58 | 50 |

**Slide: Assumptions (p30)**
(content is a figure: boxplot showing stress scores by music type)

**Slide: Q-Q Plots (p31)**
(content is a figure: Q-Q plots for checking normality by group)

**Slide: Independence (p32)**
(content is a figure: scatter plot for checking independence of residuals)

**Slide: In R: Exploratory Data Analysis (p33)**
```R
head(data_long)
# A tibble: 6 x 2
#   Music_Type Stress_Score
#   <fct>           <dbl>
# 1 Lo.fi.Beats        40
# 2 Nature.Sounds      36
# 3 No.Music           56
# 4 Upbeat.Electronic  44
# 5 Lo.fi.Beats        53
# 6 Nature.Sounds      19

summary(data_long)
#        Music_Type    Stress_Score
# Lo.fi.Beats :6  Min. :19.00
# Nature.Sounds :6  1st Qu.:40.75
# No.Music :6      Median :46.50
# Upbeat.Electronic:6  Mean :45.08
#                  3rd Qu.:52.25
#                  Max. :63.00

class(data_long$Music_Type)
# [1] "factor"
```

**Slide: In R: Model Fitting (p35)**
```R
model <- aov(Stress_Score ~ Music_Type, data = data_long)
```

**Slide: Parameter estimates: means (p36)**
```R
model.tables(model, type = "means", se = TRUE)
# Tables of means
# Grand mean
# 45.08333
#
# Music_Type
#              Lo.fi.Beats  Nature.Sounds  No.Music  Upbeat.Electronic
#                  40.33         35.67      55.00          49.33
#
# Standard errors for differences of means
# Music_Type
# 4.764
# replic. 6
```

**Slide: Parameter estimates: effects (p37)**
```R
model.tables(model, type = "effects", se = TRUE)
# Tables of effects
# Music_Type
#            Lo.fi.Beats  Nature.Sounds  No.Music  Upbeat.Electronic
#              -4.750        -9.417       9.917           4.250
#
# Standard errors of effects
# Music_Type
# 3.369
# replic. 6
```

**Slide: ANOVA (p38)**
```R
summary(model)
#          Df Sum Sq Mean Sq F value Pr(>F)
# Music_Type 3   1366   455.3   6.685  0.00263 **
# Residuals  20   1362    68.1
# ---
# Signif. codes: 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

Interpretation: music type significantly affects stress scores ($F = 6.685$, p = 0.003). Nature sounds and lo-fi beats result in lower stress, while no music results in higher stress.
## Independence Assumption
Page refs: (pNN) = PDF page in [[materials/lectures/week-05/Independence.pdf|independence deck]] (8 pages).
### What is Independence (p2)
**Slide: Independence (p2)**
**Definition**: when the value of one observation does not influence or affect the value of another observation. They are genuinely separate and not influenced by each other.

**When are observations dependent?** Observations are dependent in experiments with:
- Repeated measurements on the same subject
- Measurements from related subjects
- Time series data where sequential observations may be correlated
- Experimental units connected in some way and randomisation not implemented
### Types of Dependence in Experiments (p3-6)
**Slide: Independence in experimental design (p3)**
We can check for certain dependence types using residuals after model fitting. Beforehand, we can scrutinise the study design and examine the observations themselves.

**Slide: Dependence due to experimental design (p4)**
Applying treatments to the same group of students and measuring individual performance violates independence. A study testing new teaching methods on several classrooms using individual student test scores violates independence because students within classrooms are not independent of each other.

This includes anything indicating experimental units are connected/related or could have influenced one another.

**Slide: Spatial or temporal dependence (p5)**
When observations collected over space or time, they may be correlated:
- **Spatial**: measuring air pollution at nearby city locations reveals similar levels at nearby sites
- **Temporal**: daily temperature readings over a year show consecutive-day correlation

Dependence can occur when samples collected in non-random sequence. Some other variable introduces dependence between successive observations.

**Slide: Example of temporal dependence (p6)**
Suppose you measure plant growth daily, always measuring Treatment A first, then Treatment B. If mornings warm as sun rises (or you get tired and sloppy later), differences might reflect time of day, not treatment.

The danger: we might wrongly conclude a treatment is effective when it is actually correlated with measurement order. This confounds treatment effects with temporal trends.
### Checking for Independence Violations (p7-8)
**Slide: How to check spatial or temporal dependence (p7)**
If we have data on spatial arrangement or time sequence of observations, we can check using visualisations. If we assume data order in dataset = collection order, we can check for dependence using visualisations.

**Slide: Visual checks for independence (p8)**
Plot the response or residuals against the order of data collection (or time). Look for patterns or trends:
- **Random scatter**: indicates independence
- **Systematic trends or clustering**: indicates dependence (temporal or spatial)
## ANOVA Explanation
Page refs: (pNN) = PDF page in [[materials/lectures/week-05/ExtraANOVAExplanation.pdf|ANOVA explanation deck]] (6 pages).
### Aim of ANOVA (p2-5)
**Slide: Aim (p2)**
We want to know whether deliberate manipulation of conditions (the treatments) has introduced systematic variation in the response, beyond what we would expect from random noise.

Two scenarios:
- **Assume treatments had no effect**: all observations come from the same population with common mean $\mu$
- **Assume treatments had an effect**: observations come from populations with different means ($\mu_1, \mu_2, \ldots, \mu_k$). Treatments "carve up" original single population into several sub-populations with different means.

**Slide: Treatments had no effect (p3)**
(content is a figure: histogram showing all observations from single population with mean μ)

**Slide: Treatments had effect (p4)**
(content is a figure: three histograms showing observations from three populations with different means)

**Slide: Analysis of variance (p5)**
By comparing variation between groups in terms of differences between means to variation within groups, we can make conclusions about means.
### Decomposing Total Variation (p6-7)
**Slide: Getting to measures of between and within variability (p6)**
Use the model to decompose total sums of squares into:
- Sums of squares due to treatments (differences among means)
- Sums of squares due to error (differences within groups)

This decomposition is the foundation of ANOVA inference.
