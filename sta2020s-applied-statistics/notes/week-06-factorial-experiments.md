---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---
Materials: [[materials/lectures/week-06/Week 6 - Factorial Experiments.pdf|factorial deck]], [[materials/lectures/week-06/Summary (1).pdf|ANOVA summary]], [[materials/lectures/week-06/Are you ready.html|quiz]].
## Factorial Experiments
Page refs: (pNN) = PDF page in [[materials/lectures/week-06/Week 6 - Factorial Experiments.pdf|factorial deck]] (55 slides).
### Motivation: Single vs Multiple Factors (p2-5)
**Slide: Factorial experiments (p2)**
So far: single treatment factor. Variation in response cannot be explained by a single factor at a time, especially when factors interact. An interaction occurs when the effect of one factor depends on the level of the other factor.

**Slide: Factorial experiments (p3)**
More than one treatment factor. Each treatment factor has levels. Factor A has a levels and Factor C has c levels. Complete factorial experiment: a × c treatments.

**Slide: Examples of factorial studies (p4)**
The effect of playback speed and lecture modality on comprehension of lectures. The effect of advertising medium (Email list, Instagram, television ads) and discount level (10% and 20%) on product sales. The effect of fertiliser type (F1, F2) and irrigation level (I1, I2) on wheat yield.

**Slide: Factorial treatment structure and designs (p5)**
Can be either a completely randomised design (CRD) or randomised block design (RCBD). Example: Fertiliser (F1, F2) and Irrigation (I1, I2) creates treatments F1I1, F1I2, F2I1, F2I2. This is a 2 × 2 factorial experiment.
### Design and Replication (p6-8)
**Slide: Completely randomised design (p6)**
(Design diagram: one example per treatment, assigned randomly to experimental units)

**Slide: Randomised block design (p7)**
(Design diagram: treatments randomised within blocks)

**Slide: Replication (p8)**
Notice each treatment appeared more than once. RBD: each treatment appeared twice in a block, so four times in total. CRD: each treatment appeared four times. Replication of treatments is important in factorial experiments (requires more than two experimental units). Allows us to estimate the interaction effect separately from error.
### Effects: Main and Interaction (p9-16)
**Slide: Interactions (p9)**
Effect of a factor depends on the level of another factor, they interact. Define effect:
- Regression: effect of continuous explanatory variable (EV) = slope.
- Regression: effect of categorical EV = change in response relative to baseline.
- ANOVA model: change relative to overall mean.

**Slide: Main effects (p10)**
A main effect is the effect of a factor (e.g. fertiliser) on the response. Numerically, estimate it for each level of the factor as the difference between that level's mean (averaged over the other factors) and the overall mean. Broken down:
1. Average change in response
2. Averaged over all levels of the other factors
3. Relative to the overall mean

**Slide: Interaction effects (p11)**
A main effect is tied to a single factor; an interaction effect is tied to a combination of factors (i.e. treatment). Interaction effect: change in response relative to the main effects.

**Slide: Interaction plots (p12)**
(Diagram showing line plots with factors on axes)

**Slide: How to identify main effects (p13)**
Main effects:
1. Are there main effects of Fertiliser? Look at the average change in response averaged over the levels of irrigation.
2. Are there main effects of Irrigation? Look at the average change in response averaged over the levels of fertiliser

**Slide: How to identify interaction effects (p14)**
Interaction effects:
- Does the effect of fertiliser on the response depend on the irrigation level?
- Or does the effect of irrigation level on the response depend on the fertiliser type?
- Does changing from F1 to F2 differ at each level of irrigation?
- Does changing from I1 to I2 differ at each level of fertiliser?

**Slide: More plots! (p15)**
(Additional interaction plot examples)

**Slide: Interaction plots (p16)**
Qualitative sense of effects: are there main effects present? Is there an interaction? Assess this with plots by looking at the relative differences between treatment means. Doesn't give the numerical size of effect which is calculated relative to the overall mean.
### Model and Sums of Squares (p17-25)
**Slide: Model for factorial experiments (p17)**
Two treatment factors (A and C) and no blocking factors:
$$Y_{ijk} = \mu + A_i + C_j + (AC)_{ij} + e_{ijk}$$

where:
- $Y_{ijk}$ is the $k$th observation of the $(ij)$th treatment
- $\mu$ is the overall mean
- $A_i$ is the effect of factor A level $i$
- $C_j$ is the effect of factor C level $j$
- $(AC)_{ij}$ is the interaction between the $i$th level of A and the $j$th level of C (single symbol, not product of main effects)
- $e_{ijk}$ is the random error

Assumptions depend on the design used.

**Slide: Example (p18)**
We are studying the effects of Drug (Factor A) and Diet (Factor B) on blood pressure reduction.
- Factor A: Drug (Yes, No)
- Factor B: Diet (Healthy, Unhealthy)
- Treatments: Yes+Healthy, Yes+Unhealthy, No+Healthy, No+Unhealthy

**Slide: Data (p19)**
Responses for each treatment combination (in blood pressure reduction units):

| Diet | No Drug | Yes Drug |
|------|---------|----------|
| Healthy | 1.5, 2.2, 2.3 | 7.8, 8.1, 8.1 |
| Unhealthy | 3.8, 4.1, 4.2 | 5.8, 6.0, 6.2 |

**Slide: Means (p20)**
Treatment means for 2 × 2 factorial design:

| Drug | Diet | Mean Response |
|------|------|---|
| Yes | Healthy | 8 |
| Yes | Unhealthy | 6 |
| No | Healthy | 2 |
| No | Unhealthy | 4 |

**Slide: Main effects of Factor A (p21)**
Overall mean: $\hat{\mu} = (2 + 4 + 8 + 6) / 4 = 5$

Main effects of factor A (Drug):
- Level 1 (Yes): Mean of treatments with Drug = (8 + 6) / 2 = 7. Effect $\hat{A}_1 = 7 - 5 = 2$
- Level 2 (No): Mean of treatments without Drug = (2 + 4) / 2 = 3. Effect $\hat{A}_2 = 3 - 5 = -2$

**Slide: Main effects of Factor C (p22)**
Overall mean: $\hat{\mu} = 5$

Main effects of factor C (Diet):
- Level 1 (Healthy): Mean of treatments with Healthy diet = (8 + 2) / 2 = 5. Effect $\hat{C}_1 = 5 - 5 = 0$
- Level 2 (Unhealthy): Mean of treatments with Unhealthy diet = (4 + 6) / 2 = 5. Effect $\hat{C}_2 = 5 - 5 = 0$

**Slide: The interaction effect (p23)**
Do the observed treatment means equal what we would expect based on just main effects? Expected mean for treatment (Yes, Healthy): $\mu + A_1 + C_1 = 5 + 2 + 0 = 7$. Observed treatment mean: $\bar{Y}_{11} = 8$. Extra bit: $8 - 7 = 1$. The observed treatment mean is 1 unit higher than what we would expect if the factors worked independently. This extra effect is the interaction; it captures how the combination of Drug and Diet together changes the response beyond what their individual effects explain.

**Slide: The interaction term (p24)**
The interaction effect is calculated as:
$$(AC)_{ij} = \bar{Y}_{ij.} - (\mu + A_i + C_j)$$

If we don't have replication of treatments, we cannot estimate this term. With one observation per treatment, the error term is the same as the interaction term. Need replication to separate them!

**Slide: Decomposition of sums of squares (p25)**
Each term on the RHS is a deviation from a mean:
- Main effects are deviations from the overall mean $\mu$
- Interaction effects are deviations from $\mu + A_i + C_j$ (expected mean if no interaction)
- Error terms are deviations from treatment means

$$SS_{total} = SS_A + SS_C + SS_{AC} + SS_E$$
### ANOVA Table and Hypotheses (p26-29)
**Slide: ANOVA table (p26)**

| Source | SS | df | MS | F |
|--------|----|----|-----|-----|
| A Main Effects | $SS_A = nc \sum_i (\bar{Y}_{i..} - \bar{Y}_{...})^2$ | $a-1$ | $MS_A$ | $MS_A / MSE$ |
| C Main Effects | $SS_C = na \sum_j (\bar{Y}_{.j.} - \bar{Y}_{...})^2$ | $c-1$ | $MS_C$ | $MS_C / MSE$ |
| AC Interactions | $SS_{AC} = n \sum_{ij} (\bar{Y}_{ij.} - \bar{Y}_{i..} - \bar{Y}_{.j.} + \bar{Y}_{...})^2$ | $(a-1)(c-1)$ | $MS_{AC}$ | $MS_{AC} / MSE$ |
| Error | $SS_E = \sum_{ijk} (Y_{ijk} - \bar{Y}_{ij.})^2$ | $ac(n-1)$ | $MSE$ | |
| Total | $SS_{total} = \sum_{ijk} (Y_{ijk} - \bar{Y}_{...})^2$ | $acn-1$ | | |

where $a$ = levels of A, $c$ = levels of C, $n$ = replicates per treatment.

**Slide: Hypotheses (p27)**
There are three F-tests in the ANOVA table:
1. $H_{AC}: (AC)_{ij} = 0$ for all $i$ and $j$ (Factors A and C do not interact). $H_a$: at least one interaction effect is non-zero.
2. $H_A: A_i = 0$ $i = 1, \ldots, a$ (Factor A has no main effects). $H_a$: at least one A effect is non-zero.
3. $H_C: C_j = 0$ $j = 1, \ldots, c$ (Factor C has no main effects). $H_a$: at least one C effect is non-zero.

**Slide: The F-test (p28)**
The F-ratio always has mean square error in the denominator. It is a ratio of two variance estimates and can be seen as a signal-to-noise ratio: how large are the effects relative to experimental error variance?

**Slide: The test of $H_{AC}: (AC)_{ij} = 0$ (p29)**
If the interaction term is significant, the effect of A is different at each level of C, or the effect of C is different at each level of A. Interpretation of main effects is not very sensible when interaction is significant.

**Slide: Example (p30)**
Hypothetical 2 × 2 factorial with crossover pattern:

| | B = Low | B = High |
|---|---------|----------|
| A = Low | 10 | 20 |
| A = High | 20 | 10 |

This shows a strong interaction: the effect of A depends on level of B.
### Practical Example: Advertising and Discount (p31-48)
**Slide: Example of factorial studies: interactions (p31)**
The effect of advertising medium (Email list, Instagram, television ads) and discount level (10%, 20%) on product sales.
- For email ads, increasing the discount from 10% to 20% leads to a small increase in sales.
- For Instagram ads, the increase in discount leads to a large increase in sales.
- But for TV ads, sales are high regardless of the discount level.

Then the effect of discount (whether to increase, keep same, or decrease sales) is not the same across advertising medium.

**Slide: Example of factorial studies: interactions (p32)**
The effect of fertiliser type (F1, F2) and irrigation level (I1, I2) on wheat yield.
- With F1, changing irrigation from I1 to I2 gives a moderate yield increase.
- But with F2, the same change in irrigation leads to a very large yield increase.

Then the effect of irrigation level on yield depends on the fertiliser used.

**Slide: Advertising example (p33)**
Sales per ad medium and discount level (wide format):

| Ad_Medium | 10% | 20% |
|-----------|-----|-----|
| Email | 104, 105, 108 | 107, 110, 109 |
| Instagram | 104, 104, 107 | 121, 120, 119 |
| TV | 119, 115, 117 | 116, 113, 108 |

How many treatments? 6 (3 media × 2 discounts). How many replicates? 3 per combination.

**Slide: Calculating and interpreting effects (p34)**
Treatment means (i = 1 Email, 2 Instagram, 3 TV; j = 1 for 10%, 2 for 20%):
- $\bar{Y}_{11} = (104 + 105 + 108) / 3 = 105.67$
- $\bar{Y}_{12} = (107 + 110 + 109) / 3 = 108.67$
- $\bar{Y}_{21} = (104 + 104 + 107) / 3 = 105.00$
- $\bar{Y}_{22} = (121 + 120 + 119) / 3 = 120.00$
- $\bar{Y}_{31} = (119 + 115 + 117) / 3 = 117.00$
- $\bar{Y}_{32} = (116 + 113 + 108) / 3 = 112.33$

**Slide: Calculating and interpreting effects (p35)**
Overall mean: $\bar{Y}_{...} = (105.67 + 108.67 + 105.00 + 120.00 + 117.00 + 112.33) / 6 = 111.44$

Main effects of ad medium (A):
- Email: $\bar{\mu}_1 = (105.67 + 108.67) / 2 = 107.17$. Effect: $\hat{A}_1 = 107.17 - 111.44 = -4.28$

**Slide: Calculating and interpreting effects (p36)**
Main effects of ad medium (A):
- Instagram: $\bar{\mu}_2 = (105.00 + 120.00) / 2 = 112.50$. Effect: $\hat{A}_2 = 112.50 - 111.44 = 1.06$

**Slide: Calculating and interpreting effects (p37)**
Main effects of ad medium (A):
- TV: $\bar{\mu}_3 = (117.00 + 112.33) / 2 = 114.67$. Effect: $\hat{A}_3 = 114.67 - 111.44 = 3.22$

**Slide: Interpretation (p38)**
- $\hat{A}_1 = -4.28$: Mean sales using email ads are lower than the overall mean, on average.
- $\hat{A}_2 = 1.06$: Mean sales using Instagram ads are very close to average, just slightly above, on average.
- $\hat{A}_3 = 3.22$: TV ads yield roughly 3 units more than the grand mean, on average.

**Slide: Repeat for discount level (p39)**
Main effects of discount level (D):
- $\hat{D}_1 = (105.67 + 105.00 + 117.00) / 3 - 111.44 = 109.22 - 111.44 = -2.22$
- $\hat{D}_2 = (108.67 + 120.00 + 112.33) / 3 - 111.44 = 113.67 - 111.44 = 2.22$

**Slide: Repeat for discount level (p40)**
- $\hat{D}_1 = -2.22$: On average, sales when the discount level of 10% was applied were less than overall mean sales.
- $\hat{D}_2 = 2.22$: On average, sales when the discount level of 20% was applied were more than overall mean sales.

**Slide: Interaction effect (p41)**
Using the formula $(AD)_{ij} = \bar{Y}_{ij.} - (\mu + A_i + D_j)$:

Treatment 11 (Email and 10%):
$$(AD)_{11} = 105.67 - (111.44 - 4.28 - 2.22) = 105.67 - 104.94 = 0.72$$

Treatment 32 (TV and 20%):
$$(AD)_{32} = 112.33 - (111.44 + 3.22 + 2.22) = 112.33 - 116.88 = -4.56$$

**Slide: Interpretation (p42)**
An interaction effect shows how much a particular treatment combination (e.g. Instagram + 20% discount) deviates from what you would expect based on adding the main effects alone. If there was no interaction, the effect of one factor (like discount level) would be the same regardless of the level of the other factor (ad medium). So a non-zero interaction effect means the factors don't operate independently.

**Slide: Example (p43)**
- $(AD)_{11} = 0.72$: When using email ads with 10%, the mean sales is more than expected when considering the main effects alone.
- $(AD)_{32} = -4.56$: When using TV ads with 20% discount, the mean sales is slightly less than expected if the factors didn't interact.

These are abstract and difficult to understand; to understand the interaction we need to look at a plot.

**Slide: But first, how to fit this model in R (p44)**
```r
fact_model <- aov(Sales ~ Ad_Medium + Discount_Level + Ad_Medium:Discount_Level, 
                  data = sales_data)
# OR shorthand
fact_model <- aov(Sales ~ Ad_Medium * Discount_Level, data = sales_data)
```

**Slide: Extract estimates (p45)**
```r
means <- model.tables(fact_model, type = "means")
```

(Output shows table of treatment means)

**Slide: Extract estimates (p47)**
```r
effects <- model.tables(fact_model, type = "effects")
```

(Output shows table of main and interaction effects)

**Slide: Sums of squares (p49)**
Each sum of squares of the decomposition measures how much variation is explained by one component of the model:
- SST: Total variation in all observations around the grand mean
- SSA: Variation due to differences between levels of factor A (ad medium), ignoring factor D
- SSD: Variation due to differences between levels of factor D (discount), ignoring factor A
- SSAD: Variation due to the interaction effects
- SSE: Variation within each treatment group (random, unexplained variation)

**Slide: ANOVA table (p50)**
Example output from the advertising dataset:

| Source | Df | Sum Sq | Mean Sq | F value | Pr(>F) |
|--------|-------|---------|---------|---------|---------|
| Ad_Medium | 2 | 178.78 | 89.39 | 17.30 | 0.000292 *** |
| Discount_Level | 1 | 88.89 | 88.89 | 17.20 | 0.001352 ** |
| Ad_Medium:Discount_Level | 2 | 294.78 | 147.39 | 28.53 | 2.75e-05 *** |
| Residuals | 12 | 62.00 | 5.17 | | |

**Slide: Hypotheses (p51)**
Interaction:
- $H_0$: All interaction effects are equal to zero, the effect of advertising medium does not depend on discount level.
- $H_a$: At least one interaction effect is non-zero, the effect of advertising medium does depend on discount level (there is an interaction).

**Slide: Hypotheses (p52)**
Main effects A:
- $H_0$: All main effects of A are zero, there is no difference in average sales between advertising media.
- $H_a$: At least one main effect is non-zero, one or more advertising mediums resulted in different mean sales.

**Slide: Hypotheses (p53)**
Main effects D:
- $H_0$: All main effects of D are zero, there is no difference in average sales between discount levels.
- $H_a$: At least one main effect is non-zero, one or more discount percentages resulted in different mean sales.

**Slide: Interaction plot (p54)**
(Diagram showing non-parallel lines indicating interaction between factors)

**Slide: In words (p55)**
The effect of discount (difference between 10% and 20%) differs depending on advertising medium used. For example, sales decrease between 10% and 20% for TV ads, but for Instagram and email ads it increases (and more so for Instagram ads). Alternatively, the effect of advertising medium (difference between the levels) differs depending on discount level.
## In R
```r
# Fit model with interaction
fact_model <- aov(Sales ~ Ad_Medium + Discount_Level + Ad_Medium:Discount_Level, 
                  data = sales_data)
# Or shorthand
fact_model <- aov(Sales ~ Ad_Medium * Discount_Level, data = sales_data)

# View ANOVA table
summary(fact_model)

# Extract estimates
means <- model.tables(fact_model, type = "means")
effects <- model.tables(fact_model, type = "effects")

# Interpretation: Check p-values. If interaction p < 0.05, interaction significant.
# If interaction significant, interpret cell-by-cell, not marginal means.
# If interaction not significant, can interpret main effects.
```
## Key Takeaways
- Factorial designs test multiple factors simultaneously, revealing interactions
- Main effects alone misleading if interaction present
- Interaction means one factor's effect depends on another factor
- Test interaction first; if significant, interpret cell-by-cell, not marginal means
- Replication essential to separate interaction from error
- Interaction plots aid interpretation: parallel lines suggest no interaction; non-parallel lines confirm interaction
- Non-zero interaction means factors don't operate independently
