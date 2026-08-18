---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course, test-prep]
summary: Answer-free question paper reconstructed from the STA2020F 2026 Class Test 1 memo.
---
Questions only. Answers live in [[past-papers/ct1-2026-sta2020f-memo.pdf|the memo]]. Do not open it until you have finished and written down every answer.

**Round all answers to 2 decimal places, unless instructed otherwise.**
**Do not round intermediary calculations.**

Total: 39 marks. Suggested timing: Section 1 in 18 min, Section 2 in 22 min, Section 3 in 12 min.

# Section 1: Simple linear regression

## Question 1

The following simple linear regression model is fitted to a dataset with 50 observations:

$$\hat{y}_i = 5.7 - 0.4 x_i$$

Using the metrics below that relate to the above model and dataset, calculate the following:

$$r = -0.7 \qquad \sum_{i=1}^{n} e_i^2 = 602 \qquad se(\hat{\beta}_1) = 0.13$$

- **a)** Coefficient of determination **(1)**
- **b)** Predicted value of $y$ for an $x$ value of 5 **(1)**
- **c)** The residual standard error of the model **(1)**
- **d)** Lower bound of the 90% confidence interval for the slope **(2)**
- **e)** The value of the test statistic to test the significance of the slope coefficient **(1)**

## Question 2

Which of the following are assumptions of a simple linear regression model? (you may select more than one correct answer) **(2)**

- A. The relationship between $x$ and $y$ should be linear.
- B. $e_i \sim N(0, \sigma^2)$
- C. The errors have a non-constant variance.
- D. The errors are independent.
- E. $e_i \sim t_{n-2}$

## Question 3

What are model residuals in a linear regression analysis? Limit your answer to no more than one sentence. **(1)**

## Question 4

Calculate the correlation between two variables ($x$ and $y$) given the following information: **(1)**

$$SS_{xy} = 24 \qquad SS_x = 20.5 \qquad SS_y = 80.8$$

## Question 5

In the simple linear regression setting, prediction intervals for a prediction are: (you may select more than one correct answer) **(2)**

- A. Narrower than confidence intervals.
- B. Wider than confidence intervals.
- C. Used when we are predicting for the average.
- D. Always symmetrical around the estimate.
- E. Used when we are predicting for a specific individual.

## Question 6

In simple linear regression with one explanatory variable, testing whether the population correlation is zero is equivalent to testing whether the slope is zero. **(1)**

True or False?

## Question 7

A statistically significant slope implies that there is a large increase in $y$ for a unit increase in $x$. **(1)**

True or False?

# Section 2: Multiple linear regression

## Question 1

Use the dataset attached to fit a linear regression model. The dataset contains 5 variables recorded for 30 regional offices within a company. You should use `Quarterly_Profit` as the dependent variable and include the rest of the variables as independent variables in your model.

Dataset: [[past-papers/ct1-prep/regional_profit.csv|regional_profit.csv]]

The dataset includes 5 variables:

- `Quarterly_Profit`: the office's profit for the quarter (in thousands of rands)
- `Marketing_Budget`: the amount budgeted for marketing (in thousands of rands)
- `Operational_Cost`: the office's total costs for the quarter (in thousands of rands)
- `Employee_Engagement_Score`: a score measuring the engagement of employees with the company (0 to 100)
- `Region`: a categorical variable indicating which region the office is located in (North, South, West)

- **a)** What is the estimated coefficient for `Employee_Engagement_Score`? **(1)**
- **b)** What are the degrees of freedom for the test of significance of the `Operational_Cost` coefficient? Capture your answer as a whole number. **(1)**
- **c)** Interpret the `RegionSouth` estimate from the model (be as detailed as possible). **(2)**
- **d)** How many independent variables are included in the model? Capture your answer as a whole number. **(1)**
- **e)** What is the predicted profit for an office that has a marketing budget of R200 000, operational costs of R400 000, an employee engagement score of 75, and is located in the West region? Report your answer in thousands of rands (that is, if the rand amount is R500 000, report 500). **(1)**
- **f)** What is the upper bound of the 95% confidence interval for the prediction in 1e above? Report your answer in thousands of rands. **(2)**

## Question 2

Which of the following statements about the test of overall model significance in a multiple linear regression analysis are true? (you may select more than one correct answer) **(2)**

- A. Testing for overall model significance is equivalent to testing the significance of a coefficient in the model.
- B. The test statistic for this test is given by $F = \dfrac{MS_{reg}}{MS_{resid}}$
- C. The denominator degrees of freedom for this test statistic are given by $n - p - 1$.
- D. The null hypothesis for this test is $H_0: \beta_1 = \beta_2 = \cdots = \beta_p$
- E. The alternative hypothesis for this test is $H_a: \beta_1 \neq \beta_2 \neq \cdots \neq \beta_p$

## Question 3

We want high correlations between independent variables in multiple linear regression models. **(1)**

True or False?

## Question 4

A group of biologists study factors affecting plant biomass in a greenhouse experiment. They collect data on 25 plants and fit the following multiple regression model:

$$\widehat{Biomass} = 12 + 0.8(\text{Nitrogen}) + 0.5(\text{Sunlight}) - 1.2(\text{Competition})$$

Where:

- Biomass = final plant weight (grams)
- Nitrogen = nitrogen fertilizer applied (grams)
- Sunlight = hours of sunlight per day
- Competition = number of neighbouring plants within 10 cm

- **a)** If Nitrogen increases by 3 grams but all other variables remain the same, what is the change in biomass in grams? **(1)**
- **b)** State, in words (not symbols), the null and alternative hypotheses for the test of significance on the sunlight coefficient. **(1)**

## Question 5

Adding more independent variables to a model always increases the adjusted $R^2$. **(1)**

True or False?

## Question 6

Given the following information: **(1)**

$$SS_{residual} = 221.5 \qquad MS_{regression} = 40.17 \qquad n = 50 \qquad p = 3$$

What is the value of the regression sum of squares?

# Section 3: Logistic regression

## Question 1

Give the two reasons why we use the logit transformation in a logistic regression model. Limit your answer to no more than two sentences. **(2)**

## Question 2

In logistic regression, what does $logit(p_i)$ represent? **(2)**

- A. The probability of the outcome occurring.
- B. The odds of the outcome occurring.
- C. The log of the odds of the outcome occurring.
- D. The regression slope coefficient.
- E. The probability of the outcome not occurring.

## Question 3

Exponentiating a logistic regression model coefficient gives the probability. **(1)**

True or False?

## Question 4

If the predicted log-odds from a logistic regression model are 1.7:

- **a)** What is the predicted probability of the event occurring? **(1)**
- **b)** What are the odds of the event occurring? **(1)**

## Question 5

A medical researcher fits a logistic regression model to predict the probability that a patient has cardiovascular disease based on their total cholesterol levels. The slope coefficient is found to be 0.6. What is the interpretation of this coefficient in terms of the odds? Limit your answer to no more than one sentence. **(2)**

## Question 6

You generate a predicted probability of an event occurring from a logistic regression model of 0.67. Using a threshold of $\pi = 0.6$, we would say that this event did occur. **(1)**

True or False?
