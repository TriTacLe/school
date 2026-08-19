---
type: note
status: active
project: ntnu
course: BI3051
tags: [ntnu, biologi, r, anova, solutions]
---

## Solutions: linear models with factors as predictors (BI3051)

Worked answers for the three data sets in
`materials/Linear Models - Predictor variable(s) = Factor(s)/`. All output below
came from running the models, not from the slides. Reference material.

### Exercise 1: fertilizer, one-way ANOVA

30 plots, three fertilization levels, 10 each. Balanced.

```r
fert <- read.table("fertilizer.txt", header = TRUE)
model.1 <- lm(yield ~ factor(fertil), data = fert)
anova(model.1)
```

| source | Df | Sum Sq | Mean Sq | F | p |
|---|---|---|---|---|---|
| factor(fertil) | 2 | 10.823 | 5.4114 | 5.702 | 0.0086 |
| residuals | 27 | 25.622 | 0.9490 | | |

Fertilization level matters, F(2,27) = 5.70, p = 0.0086.

Group means: level 1 gives 5.445, level 2 gives 3.999, level 3 gives 4.487.

The `summary()` table says the same thing in treatment contrasts. The intercept
5.445 is the mean of level 1, not a grand mean, and the two coefficients are
differences from it: level 2 is 1.446 lower (p = 0.0026), level 3 is 0.958 lower
(p = 0.037). Refitting as `lm(yield ~ -1 + factor(fertil))` drops the intercept
and reports the three means directly with their standard errors. Same model, same
fit, different parameterisation. Only the second one lets you read the means off
the coefficient table.

R squared is 10.823 / (10.823 + 25.622) = 0.297. Adjusted is 0.245. With three
groups and 30 points, a fifth of the apparent fit is the cost of the extra
parameters.

**Assumptions.** Bartlett's test on equal variances is fine, p = 1.0. Normality
of residuals is not: Shapiro-Wilk gives p = 0.0084, driven by a right tail. The
residual quantile plot bends up at the top end. That is the reason for the next
part.

**Removing rows 6, 19 and 29.** Cook's distance ranks them 0.274, 0.226 and
0.125, the three largest, and no other point exceeds 0.09. None reaches the
conventional 1.0 cutoff, so none is an outlier by that rule.

| model | F | p | residual MS | R squared |
|---|---|---|---|---|
| full, n = 30 | 5.70 | 0.0086 | 0.949 | 0.297 |
| trimmed, n = 27 | 13.45 | 0.00012 | 0.401 | 0.528 |

The treatment sum of squares barely moves, 10.823 to 10.792. The residual sum of
squares collapses from 25.6 to 9.6. So the three points were not changing the
group means, they were inflating the error term, and dropping them almost doubles
R squared.

Do not report that trimmed model as your result. Three points removed out of 30
because they made the fit worse is not a defensible exclusion rule, and the
conclusion was already significant without it. The honest use of this exercise is
diagnostic: it shows the effect is not carried by a few unusual plots, which is
the opposite of what deleting them might suggest.

### Exercise 2: Daphnia, three crossed factors

72 observations. Water (2 rivers) by Detergent (4 brands) by Daphnia (3 clones),
three replicates in every one of the 24 cells. Fully crossed and balanced, which
is why the sums of squares below are orthogonal and the order of terms in the
formula does not change them.

```r
daph <- read.table("daphnia.txt", header = TRUE)
model1 <- lm(Growth.rate ~ Water * Detergent * Daphnia, data = daph)
anova(model1)
```

| term | Df | Sum Sq | F | p |
|---|---|---|---|---|
| Water | 1 | 1.985 | 2.850 | 0.098 |
| Detergent | 3 | 2.212 | 1.059 | 0.375 |
| Daphnia | 2 | 39.178 | 28.128 | 8.2e-09 |
| Water:Detergent | 3 | 0.175 | 0.084 | 0.969 |
| Water:Daphnia | 2 | 13.732 | 9.859 | 0.00026 |
| Detergent:Daphnia | 6 | 20.601 | 4.930 | 0.00053 |
| Water:Detergent:Daphnia | 6 | 5.848 | 1.400 | 0.234 |
| residuals | 48 | 33.428 | | |

R squared 0.715, adjusted 0.578.

Reading it from the bottom up, which is the only correct order with interactions
present:

- The three-way term is not supported, p = 0.234. Drop it.
- Two of the three two-way terms are strong. Clone by water p = 0.00026, clone by
  detergent p = 0.00053. Water by detergent is nothing at all, p = 0.969.
- Do not interpret the Detergent main effect, p = 0.375, as "detergent has no
  effect". Detergent appears in a significant interaction with clone, so its
  effect exists but has opposite signs across clones and averages out. The main
  effect line is answering a question you did not ask.

Model comparison confirms the simplification:

```r
model2 <- lm(Growth.rate ~ Water + Detergent + Daphnia +
             Water:Daphnia + Daphnia:Detergent + Water:Detergent, data = daph)
model3 <- lm(Growth.rate ~ Water + Detergent + Daphnia +
             Water:Daphnia + Daphnia:Detergent, data = daph)
anova(model3, model2, model1)
```

model3 against model2, F(3,54) = 0.084, p = 0.969. model2 against model1,
F(6,48) = 1.399, p = 0.234. Neither dropped term is needed, so model3 is the one
to report. Adjusted R squared is 0.559 for model2 and 0.581 for model3, so the
simpler model also describes the data slightly better once you pay for the
parameters.

AIC disagrees mildly: 193.0 for the full model against 199.1 for model3. AIC and
sequential F tests optimise different things, and with 72 points and 24 cells the
full model has 24 parameters. Report model3 and say why.

Biologically: clone identity dominates growth rate, and the clones respond
differently both to which river the water came from and to which detergent brand
they were exposed to. There is no general detergent toxicity ranking that holds
across clones.

`lm(Growth.rate ~ -1 + Water:Detergent:Daphnia)` gives the 24 cell means
directly, which is the useful table for a results section.

### Roe deer, the lecture question

514 animals from a Dutch population, culled over several years, with population
density scored low (1), intermediate (2), high (3) and age scored yearling (1),
subadult (2), adult (3).

Left and right antler correlate at r = 0.938, so use their mean rather than
picking a side or fitting both.

```r
roe <- read.table("roedeer.txt", header = TRUE)
roe$ant <- (roe$antsizel + roe$antsizer) / 2
anova(lm(ant ~ factor(dens), data = roe))
```

Density alone: F(2,511) = 0.785, p = 0.457. Adjusted R squared is essentially
zero. The naive answer is that density does not affect antler size.

That answer is wrong, and this is the point of the exercise.

```r
anova(lm(ant ~ factor(dens) + factor(agecat), data = roe))
```

| term | Df | Sum Sq | Mean Sq | F | p |
|---|---|---|---|---|---|
| factor(dens) | 2 | 40.4 | 20.2 | 2.44 | 0.088 |
| factor(agecat) | 2 | 8939.4 | 4469.7 | 539.48 | < 2e-16 |
| residuals | 509 | 4217.1 | 8.3 | | |

Age carries 8939 of the sums of squares. Adding it drops the residual mean square
from 25.7 to 8.3, roughly a threefold cut in error variance, and the same density
sum of squares now sits against a much smaller denominator. In the additive model
the high density contrast is -1.186, t = -3.18, p = 0.0016.

This is not confounding. Age composition hardly differs across densities: the
yearling share is 0.432, 0.400 and 0.395 going from low to high density. It is a
precision gain. Age was dumping variation into the error term and drowning a real
effect.

Adding the interaction changes nothing, F(4,505) = 1.174, p = 0.321, so the
additive model stands.

Where the effect actually lives, fitting density separately within each age class:

| age class | n | p for density | mean antler, low to high density |
|---|---|---|---|
| yearling | 209 | 0.0098 | 9.85, 8.86, 8.06 |
| subadult | 35 | 0.239 | 13.66, 14.06, 11.69 |
| adult | 270 | 0.475 | 18.00, 17.58, 17.39 |

The density effect is a yearling effect. Young animals growing up in a crowded
population grow smaller antlers, an 18 percent drop from low to high density,
while adults are barely touched. That is a sensible answer biologically: antler
growth in the first year competes with body growth for a limited budget, and
adults have already finished growing.

Note the subadult class has only 35 animals across three densities, so its flat
result is weak evidence of anything.

**One caveat on all three models.** These are repeated annual samples from one
population, so animals from the same year share weather, forage and cohort
effects, and `year` is in the data set but unused here. A mixed model with year
as a random effect would be the honest version. That is later in the course.

### Links

- [[Solutions - Getting started with R]]
- [[README]]
