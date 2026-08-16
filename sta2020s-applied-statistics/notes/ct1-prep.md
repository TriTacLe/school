---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course, test-prep]
aliases: [STA2020S class test 1, regression test prep, SLR, MLR]
summary: Working prep tutorial for STA2020S class test 1 covering simple and multiple linear regression with R.
---
Working tutorial for Class Test 1. Complete every checkbox and checkpoint in order. Sources: [[materials/STA2020S_2026_Course_Outline.pdf|course outline]], Amathuba announcements (checked 12 Aug), [[week-01-simple-linear-regression]], [[week-02-multiple-regression]], [[week-03-model-building-logistic-regression]].
## The test, verified on Amathuba 12 Aug
- **Monday 17 August, 18:00 to 19:40, Alumni Labs** (announced 12 Aug). **Arrive by 17:30**, doors 17:50, quiz visible at exactly 18:00 with a password given in the venue. Extra time and secluded writers: Scilab D Annex. More than 1 hour late = not allowed to write. No early sessions.
- Quiz name on Amathuba: **STA2020S CLASS TEST 1 2026**. Read the quiz Description before Start Quiz: rounding rules, links to formula sheet, statistical tables, RStudio cheat sheet, and the **.csv dataset. Download everything before starting.** Know how to import a csv into R.
- **Closed book.** Provided digitally: RStudio cheat sheet, formula sheet, statistical tables. Bring **pen, ruler, calculator, and phone for Amathuba two-step login** (ICTS before the test if login is broken).
- Alumni Labs PCs: save into the **Exam Storage (THAWSPACE) folder** on the desktop and set it as the R working directory (folder may look empty in the R file picker, click Open anyway). Survives a PC crash.
- Upload R code every 15 min to the assignment **STA2020S CLASS TEST 1 SUBMISSION FOLDER 2026** (backup only, not marked). Also write answers in the paper answer booklet as backup; hand it in when leaving.
- Internet restricted. Only the quiz, the submission folder, the linked resources, and RStudio may be open; anything else counts as cheating. No USB drives. No package installs, `library()` what is preinstalled.
- No leaving in the first hour or the last 20 min.
- Week 3 R lab quiz (MLR coding practice) releases after the last lab on Wed 13 Aug.
- **40 marks.** R coding is **15 to 25 percent** of them (6 to 10 marks).
- Scope per the course outline: **all Regression content (weeks 1 to 3)**. That includes model building and logistic regression conceptually. **R coding only on week 1 and 2 content** (SLR and MLR).
- The R function sheet is provided during the test ("you will be allowed to access this sheet during all assessments"). The formula sheet is [[materials/reference/formulae-sta2020-2025.pdf|here]]; know its layout before you walk in.
- Counts one third of the class record; class record is 40 percent of the final mark and needs 35 percent minimum for DP. Missing without a valid documented reason is a 0.
- Amathuba "STA2020 Past_Paper_Practice" opens **Wednesday 13 Aug, 08:00** under Resources. Do it the day it opens.
- Class tests resemble the weekly quizzes (outline 2.3.3). Redo every weekly quiz you have access to; they allow unlimited attempts.
## How marks are actually earned
From the 2026 F memo and 2025 S memo, the recurring mark units:
- The **6-step hypothesis test**, in order: $H_0$, $H_a$, $\alpha$, test statistic, p-value, conclusion in words. Writing the conclusion without the comparison loses the mark.
- Interpretation sentences have a fixed template. A full-mark coefficient interpretation contains all four parts: "**On average**, [y] [increases/decreases] by [value in original units] for a one-unit increase in [x] / compared to [reference category], **holding all else constant**." The 2026 memo splits half marks across exactly those parts.
- Round final answers to 2 decimals, **never round intermediate calculations**.
- Marks for intermediate work: write the formula, substitute, then compute.
- MCQs ask for the correct OR the incorrect statement. Read the stem twice.
## Day plan
Five days. Each day is 2 to 3 focused hours plus drills. Test is Monday.
- [ ] Tue 12 Aug: Part 1 (SLR) + R drill 1
- [ ] Wed 13 Aug: Part 2 (MLR) + R drill 2 + Past_Paper_Practice quiz on Amathuba (opens 08:00)
- [ ] Thu 14 Aug: Part 3 (model building) + Part 4 (logistic)
- [ ] Fri 15 Aug: Checkpoint A: F 2026 CT1 memo as a timed test
- [ ] Sat 16 Aug: Checkpoint B: S 2025 CT1 + F 2025 CT1, then weak-spot repair, then stop
## Part 1: Simple linear regression
Read [[week-01-simple-linear-regression]] alongside this. Do not move on until every "can I" box is ticked honestly.
### 1.1 Correlation
- $r$ measures strength and direction of a **linear** relation only. $r \in [-1,1]$. Guide: below 0.3 weak, 0.3 to 0.7 moderate, above 0.7 strong.
- From sums of squares: $r = \frac{SS_{xy}}{\sqrt{SS_x SS_y}}$. This exact computation was 1 mark on the 2026 F test.
- Significance test: $H_0: \rho = 0$, $t = \frac{r\sqrt{n-2}}{\sqrt{1-r^2}}$, $df = n-2$. The hypotheses are about $\rho$ (population), never $r$ (sample). A 2025 MCQ distractor hinged on exactly this.
- In SLR, testing $\rho = 0$ is equivalent to testing $\beta_1 = 0$ (True/False question on the 2026 F test).
- [ ] Can I compute $r$ from $SS_{xy}$, $SS_x$, $SS_y$ and run the full 6-step significance test?
### 1.2 Model and assumptions
- Population: $y_i = \beta_0 + \beta_1 x_i + \varepsilon_i$. Fitted: $\hat{y}_i = \hat{\beta}_0 + \hat{\beta}_1 x_i$ (no error term). Residual $e_i = y_i - \hat{y}_i$: observed minus predicted. One-sentence definition was a mark on the 2026 F test.
- Assumptions LINE: Linearity, Independence of errors, Normality of errors ($\varepsilon_i \sim N(0, \sigma^2)$), Equal variance. The 2026 F MCQ listed $e_i \sim N(0,\sigma^2)$ as correct and non-constant variance and $e_i \sim t_{n-2}$ as wrong.
- Least squares minimizes SSE. $\hat{\beta}_1 = \frac{SS_{xy}}{SS_x} = r\frac{s_y}{s_x}$, $\hat{\beta}_0 = \bar{y} - \hat{\beta}_1\bar{x}$. Line passes through $(\bar{x}, \bar{y})$.
- [ ] Can I state all four assumptions and recognize disguised versions in MCQ form?
### 1.3 Fit and inference numbers
Every one of these was asked on the 2026 F paper as a direct calculation. Given a fitted line plus a handful of metrics, produce:
- $R^2 = r^2$ (SLR only) $= \frac{SSR}{SST} = 1 - \frac{SSE}{SST}$. Interpretation: share of variation in $y$ explained by the model.
- Predicted value: plug $x_0$ into the fitted equation.
- $RSE = \sqrt{\frac{\sum e_i^2}{n-2}} = \sqrt{\frac{SSE}{n-2}}$. Typical distance from the line, in units of $y$.
- Slope test statistic: $t = \frac{\hat{\beta}_1}{SE(\hat{\beta}_1)}$, $df = n-2$.
- CI for slope: $\hat{\beta}_1 \pm t_{\alpha/2, n-2} \cdot SE(\hat{\beta}_1)$. For a 90 percent CI, $\alpha/2 = 0.05$. Look the t value up on the formula sheet tables; the memo used $t_{0.05, 48} = 1.677$.
- CI excludes 0 means significant at that level. Significant does NOT mean large effect (True/False trap on the 2026 F paper).
- Overall F-test: $F = MSR/MSE$, and in SLR $F = t^2$.
- [ ] Worked drill: fitted line $\hat{y} = 5.7 - 0.4x$, $n = 50$, $r = -0.7$, $\sum e_i^2 = 602$, $se(\hat{\beta}_1) = 0.13$. Compute $R^2$, $\hat{y}(5)$, RSE, the 90 percent CI lower bound for the slope, and the slope t statistic. Answers: 0.49, 3.7, 3.54, $-0.62$, $-3.08$. Do it cold with the formula sheet only.
### 1.4 Prediction and diagnostics
- Confidence interval: mean response at $x_0$, narrower. Prediction interval: single new individual, wider. Both narrowest at $\bar{x}$. MCQ on 2026 F: prediction intervals are wider and for individuals.
- Residuals vs fitted: want random scatter. Curve breaks linearity, funnel breaks equal variance. QQ-plot on the line means normality holds.
- Cautions: correlation is not causation; no extrapolation outside the range of $x$; influential points drag the line.
- [ ] Can I say which interval to use for "the average demand at price 5" vs "the demand of one new store at price 5"?
## Part 2: Multiple linear regression
Read [[week-02-multiple-regression]] alongside this. This is the heart of the test; the entire R section of the 2026 F paper was one MLR fit.
### 2.1 Model and interpretation
- $\hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \ldots + \hat{\beta}_p x_p$, $p$ predictors.
- Slope $\hat{\beta}_j$: average change in $y$ for a one-unit increase in $x_j$ **holding all other predictors constant**. Omitting the holding-constant clause costs half the marks.
- Intercept: average $y$ when all continuous predictors are 0 and categoricals are at reference level.
- Units matter. If $y$ is in thousands of rands and $\hat{\beta} = -9.2447$, the sentence says R 9 244.70, not 9.24.
- Degrees of freedom for each coefficient t-test: $n - p - 1$. The 2026 F paper asked this as a bare number ($n=30$, 4 predictors + dummies counted: answer 24; count the number of estimated slope coefficients, dummies count individually).
- [ ] Can I write a full-template interpretation for a continuous and a categorical coefficient without looking?
### 2.2 Categorical predictors
- k levels means k-1 dummies, one level is the **reference** (R default: alphabetically first).
- Dummy coefficient: change in $y$ compared to the reference category, holding all else constant. The comparison category must be named. "RegionSouth = -9.24" means South offices earn less **than North offices** (reference), on average, all else constant.
- `as.factor()`, `contrasts()` show the coding. Releveling changes coefficients but not fit.
- [ ] Given `summary()` output with RegionSouth and RegionWest rows, can I identify the reference and interpret both?
### 2.3 The rest of the machinery
- Adjusted $R^2 = 1 - \frac{SSE/(n-p-1)}{SST/(n-1)}$: penalizes complexity, use it to compare models with different predictor counts. Plain $R^2$ never decreases when adding variables.
- Overall F-test: $H_0$: all slopes zero. $F = \frac{MSR}{MSE} = \frac{SSR/p}{SSE/(n-p-1)}$. Last line of `summary()`.
- Multicollinearity: highly correlated predictors give inflated SEs, inflated p-values, unstable estimates. Detected via the correlation matrix among the x variables.
- Interactions: `x1 * x2` in R gives main effects plus product. With interaction, the effect of $x_1$ is $\hat{\beta}_1 + \hat{\beta}_3 x_2$. Interaction with a categorical means different slopes per category (non-parallel lines); additive means parallel lines.
- [ ] Given two categories A and B with interaction terms, can I write out the separate fitted equations per category?
### 2.4 Prediction in MLR
- Plug all $x_0$ values in, dummies as 0/1 according to the category.
- `predict(fit, newdata, interval = "confidence")` or `"prediction"`. The 2026 F paper asked for a predicted value and the upper bound of its 95 percent CI, both read from `predict()` output.
- [ ] Can I build the `newdata` data.frame with the factor level spelled exactly as in the data?
## Part 3: Model building
Read [[week-03-model-building-logistic-regression]] first half. Concept questions only (no coding marks), but the 2025 S paper spent MCQs here.
- Partial F-test: compares nested models. $F_{partial} = \frac{(SSE_{red} - SSE_{full})/r}{SSE_{full}/(n-p-1)}$ where $r$ = number of added variables. $H_0$: the added variables all have zero coefficients.
- Coefficient of partial determination: $R^2_{partial} = \frac{SSE_{red} - SSE_{full}}{SSE_{red}}$, share of remaining variation explained by the additions.
- AIC $= n\log(SS_{resid}/n) + 2p + 2$. **Lower is better.** Balances fit against complexity; a model can have lower RSE but higher AIC because of the parameter penalty. The 2025 S MCQ made exactly this point: lower RSE does not force lower AIC.
- Forward selection: start from intercept, add the variable that lowers AIC most, never remove. Backward elimination: start full, remove, never re-add. Stepwise: both directions. All stop when AIC stops improving; none guarantee the global optimum.
- `step(fit.intercept, direction = "forward", scope = list(lower = fit.intercept, upper = fit.full))`, `step(fit.full, direction = "backward")`, `direction = "both"`.
- Why analysts distrust the algorithms: they ignore domain knowledge and capitalize on chance features of the sample.
- [ ] Can I compare two models given RSE, AIC, $R^2$ and spot the implausible or incorrect statement?
## Part 4: Logistic regression
Read [[week-03-model-building-logistic-regression]] second half. Concept and interpretation marks; expect printed `glm` output to read, not code to write.
- Use when $y$ is binary. Model the log-odds: $\log\frac{p}{1-p} = \beta_0 + \beta_1 x_1 + \ldots$
- Odds $= \frac{p}{1-p}$. Odds ratio for one unit of $x_j$: $e^{\beta_j}$. Same formula for binary and continuous predictors.
- Interpretation template: "On average, the **odds** of [event] change by a factor of $e^{\hat{\beta}}$ for each one-unit increase in [x], holding all else constant." Convert to percent: factor 0.73 means 27 percent decrease.
- Coefficient tests use **z** (standard normal), not t: $z = \frac{\hat{\beta}}{SE(\hat{\beta})}$. CI: $\hat{\beta} \pm z_{\alpha/2} \cdot SE$. The 2025 S MCQ back-computed $\hat{\beta}$ from a CI bound and the SE: $\hat{\beta} = \text{bound} + z \cdot SE$; that arithmetic is worth practicing once.
- Prediction is two steps: log-odds by plugging in, then probability $p = \frac{1}{1+e^{-LO}}$. Both steps carry marks.
- Classification: threshold $\pi$ (default 0.5). Confusion matrix metrics: sensitivity (true positives caught), specificity (true negatives caught), PPV, NPV. Lower threshold raises sensitivity, lowers specificity.
- `glm(y ~ x, data = d, family = "binomial")`, `predict(fit, newdata, type = "response")` for probabilities, `type = "link"` for log-odds.
- [ ] Drill: $\log\frac{p}{1-p} = 5.3941 - 0.3084 \cdot \text{Temp}$. Compute the odds ratio per degree, the predicted probability at Temp 20, and interpret $\hat{\beta}_1$ on the odds scale. Answers: 0.73, 0.315, "odds of failure decrease about 27 percent per degree."
## R drills
Coding marks are weeks 1 and 2 only: fit a model on a supplied dataset, read the output. The whole game is `lm` plus `summary` plus `predict`. Work in `r/STA2020S.Rproj`, one script `ct1-drills.R`.
### Drill 1 (Tue): SLR end to end
- [ ] Load any dataset via `sta_data()`. Fit `m <- lm(y ~ x, data = d)`.
- [ ] From `summary(m)` alone, write down: both coefficients, their SEs, t values, p-values, RSE, $R^2$, F statistic. Say what each means out loud.
- [ ] `confint(m, level = 0.90)` and reproduce one bound by hand with the formula sheet.
- [ ] `predict(m, newdata = data.frame(x = 5), interval = "prediction")` and explain the three numbers.
- [ ] `plot(m)`: name the assumption each of the first two plots checks.
### Drill 2 (Wed): MLR with categoricals, mirroring the 2026 F test task
- [ ] Take a dataset with 3+ predictors including a factor. `str(d)` first, `as.factor()` anything categorical.
- [ ] Fit the full model. Identify the reference category with `contrasts()`.
- [ ] Answer, from output only: a named coefficient, the df of a coefficient test ($n - p - 1$), the number of independent variables, a full-template interpretation of one dummy.
- [ ] Predict for a new observation with a factor level, get the 95 percent CI, report both bounds.
- [ ] Speed target: full fit-and-read cycle under 10 minutes, since the test allocates roughly that.
## Checkpoints
Closed book except the formula sheet. Mark yourself with the memo, half marks included. A on this test means 30+ out of 40, so hold yourself to 75 percent minimum on every checkpoint; redo the relevant Part if below.
- [ ] Checkpoint A (Fri): [[past-papers/ct1-2026-sta2020f-memo.pdf|F 2026 CT1]] timed. Same year, same format, closest calibration that exists. Target 75 percent plus.
- [ ] Checkpoint B (Sat): [[past-papers/ct1-2025-sta2020s-memo.pdf|S 2025 CT1]] and [[past-papers/ct1-2025-sta2020f-memo.pdf|F 2025 CT1]]. Note the 2025 S paper includes ANOVA questions; skip those, ANOVA is CT2 material this year.
- [ ] Amathuba Past_Paper_Practice quiz, plus redo weekly quizzes for weeks 1 to 3.
- [ ] Weak-spot pass: for every question dropped, find the section above, redo its drill, re-attempt the question from scratch.
## Final checklist, Sunday night
- [ ] Time and venue confirmed on Amathuba (still unannounced as of 12 Aug; check daily).
- [ ] Know the formula sheet layout: where the CI formulas, t-table, and F-table live.
- [ ] Interpretation templates memorized: continuous slope, dummy, odds ratio.
- [ ] The five SLR hand-calculations (1.3 drill) reproduce cold.
- [ ] Fit-and-read MLR cycle under 10 minutes.
- [ ] Student card, pen, pencil for MCQ, working Amathuba login (lab-based test).
