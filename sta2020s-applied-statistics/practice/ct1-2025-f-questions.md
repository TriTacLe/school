---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course, test-prep]
summary: Answer-free question paper reconstructed from the STA2020S 2025 Class Test 1 memo (12 March 2025).
---
Questions only. Answers live in [[past-papers/ct1-2025-sta2020f-memo.pdf|the memo]]. Do not open it until you have finished.

**Open the memo PDF alongside this file for the R output.** Questions 2, 3 and 4 depend on `summary()` tables and plots that are images in the PDF and cannot be transcribed here. Read the output from the PDF, write your answers here, and only scroll to the marking text at the end.

Time: 90 minutes. Max marks: 50.

**Round all answers to 2 decimal places unless otherwise specified.**
**Do not round intermediary calculations.**

# Section A: MCQ [12]

## Question 1 **(2)**

Which one of the following goals can we **not** achieve when conducting correlation analysis with two variables?

- A. Quantifying the strength of a linear relationship between 2 variables.
- B. Finding the direction of the linear relationship between 2 variables.
- C. Performing statistical inference to determine whether there is a relationship between 2 variables.
- D. Predicting one variable's value from the other variable's value.
- E. Calculating the proportion of variability in one variable that is explained by the other.

## Question 2 **(2)**

Which of the following statements about the Akaike Information Criterion (AIC) is correct?

- A. AIC is used to compare models fitted to different data.
- B. A higher AIC value indicates a better model fit.
- C. The AIC of a model measures the same thing as the coefficient of determination ($R^2$).
- D. The AIC is a trade-off between model complexity and goodness-of-fit.
- E. The AIC always increases when additional independent variables are added to the model.

## Question 3 **(2)**

Which of the following gives the distribution of the test statistic for a test of significance of the model coefficients in a multiple linear regression model?

- A. $t_{n-p-1}$
- B. $N(0,1)$
- C. $t_{n-2}$
- D. $N(0, \sigma^2)$
- E. $F_{p,\,n-p-1}$

## Question 4 **(2)**

The following regression model is fitted to data with 30 observations:

$$\hat{y} = \beta_0 + \beta_1 x$$

Using the model, the predicted value of $y$ when $x = 0.9$ is 2.23. The mean of $x$ is 1.1, and the sum of squares for $x$ is 7.71. The residual standard error of the model is 0.96. What is the 95% confidence interval for this prediction?

- A. $[0.31, 4.15]$
- B. $[0.57, 3.89]$
- C. $[1.91, 2.55]$
- D. $[0.23, 4.23]$
- E. $[1.84, 2.62]$

## Question 5 **(2)**

We use a multiple linear regression model when:

- A. There is a single continuous dependent variable and a single continuous independent variable.
- B. There is a single binary dependent variable and multiple continuous/categorical independent variables.
- C. There is a single continuous dependent variable and multiple continuous/categorical independent variables.
- D. There are multiple continuous/categorical dependent variables and a single continuous independent variable.
- E. There are multiple continuous dependent variables and a single continuous independent variable.

## Question 6 **(2)**

Increasing the probability threshold for a classification from 0.5 to 0.7 would result in:

- A. An increase in the sensitivity of the classification.
- B. An increase in the specificity of the classification.
- C. A decrease in the number of true negatives.
- D. An increase in the number of false positives.
- E. An increase in the number of true positives.

# Section B: Regression questions [38]

## Question 1 [10]

- **a)** In a linear regression analysis, why do we conduct a hypothesis test to test the significance of the model coefficients? Refer to the concept of a population versus a sample in your answer. **(2)**
- **b)** Examine the model checking plots in the PDF. What assumption are these plots checking? Is this assumption met? Justify your answer with evidence from the plots. **(4)**
- **c)** Use the following results from a simple linear regression analysis to calculate the 95% confidence interval for the slope coefficient. The analysis was done for 40 observations. **(2)**

$$CI = \hat{\beta}_1 \pm t_{\frac{\alpha}{2},\, n-2} \times se(\hat{\beta}_1)$$

  (Read $\hat{\beta}_1$ and $se(\hat{\beta}_1)$ off the R output in the PDF.)

- **d)** Using a 5% significance level, what conclusion would you make about the significance of the coefficient for $x$ from the model in question 1c? Justify your conclusion using a p-value. **(2)**

## Question 2 [12]

An airport wants to avoid flight delays, so to better understand associations with flights being delayed, they collect the following data on 100 flights from the airport:

- `delay`: flight delay time (in minutes).
- `congestion`: the number of planes arriving or departing the airport within an hour of the flight time.
- `age`: the age of the plane (in years).
- `weather`: weather conditions at take-off time (either "clear" or "not clear").

A multiple linear regression model is fitted using `delay` as the dependent variable and all other variables as independent variables. **The results of this analysis are the R output in the PDF.**

- **a)** Give the regression equation for this model. Provide the actual estimated values for the model coefficients from the given RStudio output. **(1)**
- **b)** What is the interpretation of the `weathernot clear` coefficient? Be as specific as possible. **(2)**
- **c)** What is the predicted delay time (in minutes) when the congestion is 10 planes, the plane age is 4 years, and the weather condition is clear? **(1)**
- **d)** Conduct the F-test to test the significance of the overall model. State both hypotheses, report the p-value of the test, and make a conclusion. You should use a significance level of 5%. **(3)**
- **e)** Before the analysis was conducted, a correlation matrix was produced. Why would the correlation matrix need to be assessed before conducting the analysis? **(1)**
- **f)** Given that the correlation between `age` and `congestion` was found to be 0.06, would you conclude that the results of the fitted model are problematic? Justify your answer. **(1)**
- **g)** The plot in the PDF shows the relationship between `delay` and `age` of the plane. The lines are the fitted regression lines for when the weather is clear (solid line) and for when the weather is not clear (dashed line). By examining this plot, would you conclude that an interaction between `age` and `weather` is likely? Justify your answer. **(2)**
- **h)** When do we use a confidence interval versus a prediction interval for a prediction in a regression analysis? **(1)**

## Question 3 [6]

The airport scheduling staff now want to be able to predict flight delays, but they don't know which variables to include in their model. They conduct a model building procedure to help them decide. **The results of this procedure are the R output in the PDF.**

- **a)** Which model selection procedure has been implemented here? Justify your answer. **(1)**
- **b)** Why can it be dangerous to just rely on the results of model building procedures like the one implemented above? (Give 2 reasons) **(2)**
- **c)** Explain the algorithm behind the forward selection model building procedure. **(3)**

## Question 4 [10]

A pharmaceutical company wants to determine whether a patient's age will affect whether they respond positively to a new medication the company is developing. They collected data on 100 patients who were prescribed the medication. The dependent variable is binary and takes on a value of 1 if the patient responds positively to the medication and 0 if they do not. Age is recorded in years. **The result of fitting a logistic regression model to this data is the R output in the PDF.**

- **a)** What is the interpretation of the `age` coefficient in terms of odds? **(2)**
- **b)** What is the predicted probability of a patient who is 30 years old responding positively to the medication? **(2)**
- **c)** You use the resulting model from this analysis to classify the observations in the dataset. A probability threshold of 0.6 is used for the classification. The classification resulted in 43 patients predicted not having a positive response and 57 predicted having a positive response to the medication. Complete the classification matrix shown in the PDF by finding the missing values. **(2)**
- **d)** Using the classification matrix above, calculate the sensitivity and specificity of the classification. If you cannot answer question c, choose any two values to use for the missing values in the matrix to answer this question. **(2)**
- **e)** The predicted probability of a patient reacting positively to the medication is found to be 0.5. Would you classify this patient as reacting positively to the medication or not? Justify your response. **(1)**
- **f)** Why was logistic regression used for this analysis and not simple linear regression? **(1)**
