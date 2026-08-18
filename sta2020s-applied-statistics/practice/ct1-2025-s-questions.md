---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course, test-prep]
summary: Answer-free question paper reconstructed from the STA2020S 2025 Class Test 1 memo (5 September 2025). Section C is ANOVA, out of scope for CT1 2026.
---
Questions only. Answers live in [[past-papers/ct1-2025-sta2020s-memo.pdf|the memo]]. Do not open it until you have finished.

**Open the memo PDF alongside this file for the R output.** Section B leans on `summary()` tables, residual plots, a confusion matrix and a stepwise trace that are images in the PDF and cannot be transcribed here.

**Section C is ANOVA. Not examinable in CT1 2026. Skip it.** In-scope total is 40 marks (Section A 10, Section B 30).

Time: 90 minutes for the full 50-mark paper.

**Round all answers to 2 decimal places unless otherwise specified.**
**Do not round intermediary calculations.**

# Section A: MCQ [10]

Use the following information to answer questions 1 and 2.

A correlation analysis is done between a continuous dependent variable $y$ and a continuous independent variable $x$, to determine whether the correlation coefficient between these two variables is significant. It is known that the test statistic for this test equals $-1.6132$, and that

$$SS_x = \sum_{i=1}^{50}(x_i - \bar{x})^2 = 12\,976.59$$
$$SS_y = \sum_{i=1}^{50}(y_i - \bar{y})^2 = 6\,031\,094$$
$$SS_{xy} = \sum_{i=1}^{50}(x_i - \bar{x})(y_i - \bar{y}) = -63\,441.65$$

## Question 1 **(2)**

Choose the **correct** answer about this correlation analysis:

- A. Under the null hypothesis, the test statistic follows a $t$ distribution with 49 degrees of freedom.
- B. The null hypothesis is that the population correlation coefficient is equal to 0.
- C. Under the null hypothesis, the test statistic follows a standard normal distribution.
- D. The alternative hypothesis is that the sample correlation coefficient is not equal to 0.
- E. Correlation is a measure of $x$'s strength to predict $y$.

## Question 2 **(2)**

Choose the **incorrect** answer about this correlation analysis:

- A. The sample correlation coefficient indicates a negative linear relationship between $x$ and $y$.
- B. At a 5% level of significance, we would conclude that there is no significant linear relationship between $x$ and $y$.
- C. At a 10% level of significance, we would conclude that there is a significant linear relationship between $x$ and $y$.
- D. The size of the sample correlation coefficient is indicative of a weak linear relationship between $x$ and $y$.
- E. The correct code for conducting this correlation analysis in R would be `cor.test(x,y)`.

## Question 3 **(2)**

A logistic regression model was fit for $n = 36$ observations of a binary dependent variable (1 = event occurs, 0 = event does not occur) and two continuous explanatory variables, that is

$$logit(p_i) = \beta_0 + \beta_1 x_1 + \beta_2 x_2$$

It is known that the lower bound of the 95% confidence interval for $\beta_2$ is $-1.14$ and $se(\hat{\beta}_2) = 0.11$. Choose the correct answer, given this information.

- A. $\hat{\beta}_2 = -0.924$, rounded to three decimal places.
- B. $\hat{\beta}_2 = -1.363$, rounded to three decimal places.
- C. $\hat{\beta}_2 = -1.356$, rounded to three decimal places.
- D. $\hat{\beta}_2 = -0.916$, rounded to three decimal places.
- E. $\hat{\beta}_2 = -0.959$, rounded to three decimal places.

## Question 4 **(2)**

Two multiple linear regression models are fit to the same dataset, which contains a continuous dependent variable and two continuous independent variables. The following table contains important information about the two models:

| | Model A: $y \sim \beta_0 + \beta_1 x_1 + \beta_2 x_2$ | Model B: $y \sim \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \beta_3 x_1 x_2$ |
| --- | --- | --- |
| RSE | 21.56 | 16.22 |
| AIC | 306.23 | 308.12 |
| $R^2$ | 0.87 | 0.89 |

Choose the **incorrect** answer about the two models:

- A. Given the higher RSE value, it is plausible to deduce that the accuracy of the predictions of Model A is better than that of Model B.
- B. A possible reason for observing a higher AIC value for Model B could be that we include an additional parameter to be estimated in this model.
- C. The coefficient of determination indicates that the independent variables in both models explain at least 85% of the variation in the dependent variable.
- D. A lower RSE value indicates a lower sum of squared errors.
- E. The tabled results are implausible because Model B has a lower RSE than Model A, so it must also have a lower AIC.

## Question 5 **(2)**

*(ANOVA. Out of scope for CT1 2026, but it is a one-line answer, so read it once.)*

A psychologist wants to compare average stress levels between three relaxation techniques: yoga, meditation, and breathing exercises. She recruits 30 students and assigns 10 to each technique. The yoga group consists of friends from the same sports club, the meditation group are all classmates from one seminar, and the breathing group are strangers recruited individually.

Which assumption of the one-way ANOVA is most likely violated, and why?

- A. Equal variance, because stress levels may vary more in some groups than others.
- B. Normality, because stress scores may not follow a normal distribution.
- C. Independence, because students within the same group may influence each other's stress levels.
- D. Random sampling, because the researcher did not select participants randomly from the population.
- E. Additivity, because the effects of the techniques may interact with one another.

# Section B: Regression questions [30]

## Question 1 [8]

Shoes by Randy is a chain of stores that specialises in stocking trainers and sneakers. The executive committee wants to understand what drives the monthly sales revenue of retail outlets. The committee tasks their in-house data analyst to review the data from the past 50 months.

The following variables are available:

- Monthly Sales Revenue (`SalesRev`): measured in ten thousands of Rands (R10 000).
- Advertising Spend (`AdSpend`): measured in thousands of Rands (R1 000).

The analyst fits a model to the data in RStudio and generates the **partial output in the PDF**. It is further known that the sum of squared error terms is 4 314 730.

- **1.1** The analyst tasks you with conducting a hypothesis test to assess the significance of the slope estimate. The test statistic has been calculated, but the analyst is unsure about the p-value. Determine the p-value as accurately as possible and inform the analyst of the conclusions for the test. Use a significance level of 5%. **(2)**
- **1.2** Interpret the value of the coefficient of determination within the context of the fitted model. What does this value imply about the model fit? **(2)**
- **1.3** The analyst is confused about the results he is obtaining from investigating the underlying model assumptions. Plot A and Plot B in the PDF were generated in R. Explain the difference between the two plots by indicating which model assumption each is testing. State whether the model assumptions under consideration are being met in each case. **(3)**
- **1.4** Suppose it is known that **(1)**

$$\sum_{i=1}^{50}(AdSpend_i - \overline{AdSpend})^2 = 264\,702.5$$

  Calculate the value of the residual standard error.

## Question 2 [13]

Shoes by Randy decides to include additional variables in their quest towards understanding the drivers of their monthly sales revenue. The data analyst is tasked with adapting the current model to include the full set of variables listed below:

- Monthly Sales Revenue (`SalesRev`): in ten thousands of Rands (R10 000).
- Advertising Spend (`AdSpend`): in thousands of Rands (R1 000).
- Number of Active Customers (`Customers`): in hundreds of customers.
- Regions of town where the stores are located (`Region`): North, South, East, West.
- Store Size (`StoreSize`): in square meters (m²).
- Average Price of Key Product (`AvgPrice`): in Rands per unit.
- Store Type (`StoreType`): Franchise, Independent.

The analyst fits a model to the data in RStudio and generates the **partial output in the PDF**.

- **2.1** The analyst is interested in assessing the overall model significance. It is known that $SS_{resid} = 348\,866.4$ and $MS_{reg} = 631\,358.6$.
  - **a)** Write down the null and alternative hypotheses for the test that the analyst needs to conduct. **(1)**
  - **b)** Calculate the relevant test statistic. **(1)**
  - **c)** Using the p-value approach, with a significance level of 5%, what should the analyst conclude about overall model significance? **(1)**
- **2.2** It was found that the correlation between `AdSpend` and `Customers` is $-0.57$.
  - **a)** What undesirable property does this value imply? **(1)**
  - **b)** Give one consequence of the property that you identified in 2.2a. **(1)**
- **2.3** Why would the analyst be interested in including an interaction term in the model? **(2)**
- **2.4** Write down the regression equation for the full model when `Region` is East and `StoreType` is Independent. Use the variable names in your equation and not nondescript $x$ and $y$ variables. **(2)**
- **2.5** Calculate the predicted sales revenue for a month where there is no advertising spend, there are 400 customers, the store size is 32 m², and the average price of the product is R200.00. The store is a franchise in the Northern parts of town. Show all your calculations. **(2)**
- **2.6** Interpret the estimated coefficient for `RegionNorth` in the R output. **(2)**

## Question 3 [9]

A retailer runs targeted campaigns and wants to predict whether a customer will make a purchase this month. They have data over 40 months on whether customers make a purchase, how much discount was offered to the customer, and via which marketing channel the customer was contacted.

- Purchase Made (`Purchase`): Yes (1) if the customer made a purchase this month, No (0) otherwise.
- Discount Offered (`Discount`): percentage points (e.g. 0 to 100, not a fraction).
- Marketing Channel (`Channel`): Email, social media (Social), independent internet search (Search).

The retailer has tasked a young statistician with choosing the correct model for this data and coming up with an answer to their question. **Consult the RStudio output in the PDF.**

- **3.1** Interpret the coefficient associated with the outcome that the marketing channel is social media, in terms of the odds. State your answer in terms of a percentage and indicate whether the odds increase or decrease. **(2)**
- **3.2** Calculate the predicted probability of a purchase when a discount of 18% is offered to a contact who was reached through independent internet search. Show all your calculations. **(3)**
- **3.3** The following incomplete confusion matrix was created for a probability threshold of 0.4. It is known that Sensitivity = 0.85 and PPV = 0.7391. Use this information to determine the values of A and B. **(2)**

| | | Observed 1 | Observed 0 |
| --- | --- | --- | --- |
| **Predicted** | 1 | 17 | A |
| | 0 | B | 14 |

- **3.4** The **output in the PDF** was generated from a model-building exercise that the statistician undertook to determine the best model to fit for this dataset.
  - **a)** Which model-building method was implemented to produce this output? **(1)**
  - **b)** Why should we be cautious about including too many independent variables in our model fit? **(1)**

# Section C: ANOVA questions [10]

**Out of scope for CT1 2026. This is CT2 material. Skip.**
