---
type: note
status: active
project: ntnu
course: BI3051
tags: [ntnu, biologi, r, solutions]
---

## Solutions: Getting started with R (BI3051)

Worked answers to `materials/Introduction/Exercises_ intro_R_2026.pdf`.
Every number below was produced by running the code against
`materials/Introduction/seedling.txt`, not read off the sheet. Reference
material, not something to hand in.

Set the working directory to the Introduction folder first, then every
`read.table` call below works with a plain relative path:

```r
setwd("~/vault/school/bi3051-quantitative-analyses-in-biology/materials/Introduction")
```

### Warm-up arithmetic

```r
1 + 2 * (3 + 4)      # 15   R applies * before +, the brackets bind (3+4) first
4^3 + 3^2            # 73   this is what the sheet means, the PDF loses the superscripts
sqrt(4 + 3) * (2 + 1)  # 7.937254, same as (4+3)^0.5 * (2+1)
sqrt(3 - 4) * (2 + 1)  # NaN, plus "Warning message: NaNs produced"
2 * pi               # 6.283185
log(12)              # 2.484907  natural log
log(12, 10)          # 1.079181  log base 10, identical to log10(12)
```

`sqrt(-1)` returning `NaN` with a warning rather than an error is the point of
that line. R keeps going and quietly poisons everything downstream with `NaN`,
so a warning in your console is worth reading.

### Rounding functions, x = 2.56

| Call | Result | What it does |
|---|---|---|
| `ceiling(x)` | 3 | smallest integer not less than x |
| `floor(x)` | 2 | largest integer not greater than x |
| `trunc(x)` | 2 | drops the decimals, so it moves toward zero |
| `round(x, 1)` | 2.6 | round to 1 decimal |
| `round(x, 0)` | 3 | round to integer |

`floor` and `trunc` differ for negatives: `floor(-2.56)` is -3, `trunc(-2.56)`
is -2. And R rounds half to even, so `round(2.5)` is 2 while `round(3.5)` is 4.
That is IEC 60559, not a bug.

### The small data set

```r
ind  <- 1:10
cat  <- rep(1:2, each = 5)
mass <- c(2, 2.3, 2.4, 1.4, 1.5, 2, 2.3, 4, 2.1, 3)
data1 <- data.frame(cbind(ind, cat, mass))

mean(data1$mass)   # 2.3
var(data1$mass)    # 0.5622222
sd(data1$mass)     # 0.7498148

with(data1, mean(mass[cat == 2]))   # 2.68
tapply(data1$mass, data1$cat, mean) # cat 1: 1.92, cat 2: 2.68
```

Naming an object `cat` shadows the base function `cat()`. It works here because
R looks up functions and variables separately, but rename it if you ever want to
print with `cat()`.

### Vector subsetting

```r
weights <- c(21, 34, 39, 54, 55)
weights[c(TRUE, FALSE, TRUE, TRUE, FALSE)]  # 21 39 54
weights > 50                                # FALSE FALSE FALSE TRUE TRUE
weights[weights > 50]                       # 54 55
weights[weights <= 39]                      # 21 34 39
weights[weights < 30 | weights > 50]        # 21 54 55
weights[weights <= 35 & weights != 21]      # 34
weights[weights > 35 & weights < 50]        # 39
```

Negative indexing drops rather than counts back: `animals[-c(3,2)]` gives
`"orangutan" "bee"`. There is no `animals[-1]` meaning "last element" in R.

### Seedling exercise

Dalechampia scandens, 135 seedlings.

```r
seedling <- read.table("seedling.txt", header = TRUE)
```

**1. Total observations and observations per hybrid category**

```r
nrow(seedling)          # 135
table(seedling$hybrid)  # non-hybrid (0): 73, hybrid (1): 62
```

**2. Observations per cross by hybrid**

```r
table(seedling$cross, seedling$hybrid)
```

| cross | non-hybrid | hybrid |
|---|---|---|
| 1 | 0 | 19 |
| 3 | 0 | 20 |
| 5 | 10 | 0 |
| 6 | 0 | 11 |
| 7 | 0 | 12 |
| 8 | 12 | 0 |
| 11 | 35 | 0 |
| 12 | 16 | 0 |

Each cross type is either hybrid or not, never both. `cross` is nested inside
`hybrid`, it does not cross with it. That matters later: you cannot fit
`hybrid * cross` as a factorial design, the interaction is not estimable.

**3. Are the variables normally distributed (visual only)**

```r
par(mfrow = c(2, 2))
hist(seedling$seedset)
hist(seedling$sdwght, 20)
hist(seedling$lobe)
hist(seedling$biomass)
```

What you should see, and what the summary confirms:

```r
summary(seedling[, 4:7])
```

- `seedset` (min 2, median 8, max 9) is bounded at 9 and piles up at the ceiling.
  Strongly left-skewed, a count, not normal.
- `sdwght` is clearly bimodal, mean 0.0281 but the two seed categories sit around
  0.035 and 0.015. That is not one distribution, it is two.
- `lobe` (median 35.6, mean 36.3) and `biomass` (median 0.249, mean 0.246) both
  look roughly symmetric and unimodal, so normal is defensible for them.

Also worth noticing before you model anything: `lobe` has 36 missing values and
`biomass` has 35, out of 135. Those are seedlings that died before the one month
measurement, so the missingness is not random.

**4. Correlations between variables**

```r
dataset <- with(seedling, cbind(seedset, sdwght, lobe, biomass))
pairs(dataset)
cor(dataset, use = "complete.obs")
```

- `lobe` and `biomass`: r = 0.849. Strong, and unsurprising, both are size.
- `sdwght` and `biomass`: r = 0.546. Bigger seed, bigger seedling at one month.
  This is the biologically interesting one, a maternal effect on early growth.
- `seedset` and `sdwght`: r = -0.049, effectively nothing. No trade-off between
  seed number and seed size visible here.

**5. Seed mass against biomass, by seed category**

Two panels:

```r
par(mfrow = c(1, 2))
for (k in 1:2) {
  with(subset(seedling, seedcat == k),
       plot(sdwght, biomass, xlab = "seed mass (g)", ylab = "biomass (g)",
            main = paste("seed category", k)))
}
```

One panel, two symbols:

```r
par(mfrow = c(1, 1))
with(seedling,
     plot(sdwght, biomass, col = as.numeric(seedcat), pch = as.numeric(seedcat),
          xlab = "seed mass (g)", ylab = "biomass (g)"))
legend("topleft", legend = c("cat 1", "cat 2"), col = 1:2, pch = 1:2)
```

The single graph is the one that tells the story: the two categories form two
separate clouds along the x axis. Any regression of biomass on seed mass fitted
across both categories is fitting the gap between categories, not the
within-category relationship.

**6. Mean and sd of seed mass by hybrid and seed category**

```r
with(seedling, tapply(sdwght, list(seedcat, hybrid), mean, na.rm = TRUE))
with(seedling, tapply(sdwght, list(seedcat, hybrid), sd,   na.rm = TRUE))
```

| seedcat | hybrid | mean sdwght (g) | sd | n |
|---|---|---|---|---|
| 1 | non-hybrid | 0.03745 | 0.004665 | 51 |
| 1 | hybrid | 0.03105 | 0.005208 | 39 |
| 2 | non-hybrid | 0.01564 | 0.001847 | 22 |
| 2 | hybrid | 0.01431 | 0.002107 | 23 |

The sheet asks for sd, but the script in the room computes the standard error
instead, `SE <- sqrt(variance / samplesize)`. Both are worth having and they
answer different questions: sd describes the seeds, SE describes how well you
know the mean. Do not report one as the other.

```r
with(seedling, interaction.plot(factor(hybrid), factor(seedcat), sdwght))
```

Reading the interaction plot: category 1 seeds are about 2.4 times heavier than
category 2, and hybrids are lighter than non-hybrids in both categories. The
hybrid penalty is 0.0064 g in category 1 and 0.0013 g in category 2, so the lines
are not parallel and there is an interaction on the raw scale. On a log scale the
penalty is 17 percent versus 8.5 percent, which is closer to parallel. Whether you
call that an interaction depends on the scale you choose, so choose it before you
look.

### Part 2, dplyr

The script `Script_Exercise_intro_R_2026.r` already ships answers under each
`YOU TRY` comment. Two spots are worth a second look.

The sort exercise:

```r
moose[order(moose$Season, moose$CalfWeight, decreasing = c(TRUE, FALSE),
            method = "radix"), ]
```

Per-column `decreasing` only works with `method = "radix"`. Drop the method
argument and R silently recycles the first value to both columns, so you get a
wrong sort and no warning.

The load step assumes `data/MooseData.csv`, but in this room the csv sits next to
the script:

```r
moose_full <- read.csv("MooseData.csv")
```

`aggregate(b ~ group, data = combined, FUN = sum, subset = e > 20)` applies the
filter before the grouping, so a group whose rows all fail the filter disappears
from the output entirely rather than showing zero.

### Links

- [[README]] for course and exam details
