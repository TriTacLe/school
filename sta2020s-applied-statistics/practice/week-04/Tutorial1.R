# -------------------------------
# TUTORIAL 1: One-Way ANOVA Analysis
# -------------------------------

# Question 1 ------------------------------------------------------------
# Load Data -------------------------------------------------------------
data <- read.csv("Data/test_anxiety.csv")  # Read dataset


# Compute Overall Mean --------------------------------------------------
overall_mean <- mean(data$Score)  # Grand mean across all groups

# Compute Group Means ---------------------------------------------------
mean1 <- mean(data$Score[data$Group == "Group 1"])
mean2 <- mean(data$Score[data$Group == "Group 2"])
mean3 <- mean(data$Score[data$Group == "Group 3"])

# Store treatment means in a vector
treatment_means <- c(mean1, mean2, mean3)

# Compute Treatment Effects ---------------------------------------------
treatment_effects <- treatment_means - overall_mean  # Deviations from overall mean

# Compute Error Variance (estimate or sigma^2) ------------------------------------------

# Sum of squares for each group
group1_scores <- data$Score[data$Group == "Group 1"]
group1_sum_squares <- sum((group1_scores - mean1)^2)  

group2_scores <- data$Score[data$Group == "Group 2"]
group2_sum_squares <- sum((group2_scores - mean2)^2)  

group3_scores <- data$Score[data$Group == "Group 3"]
group3_sum_squares <- sum((group3_scores - mean3)^2)  

# Total sum of squares (within-group variability)
sum_squares <- sum(group1_sum_squares, group2_sum_squares, group3_sum_squares)

N <- nrow(data)  # Total number of observations
a <- 3  # Number of treatment groups

MSE <- sum_squares / (N - a)  # Mean squared error (within-group variance)
MSE  # Print MSE

# Visualizing Assumptions -----------------------------------------------

# Boxplot with jittered points to check spread of scores across groups
boxplot(Score ~ Group, data = data, 
        ylab = "Score", main = "Score Distribution by Group", las = 1, outline = FALSE)
stripchart(Score ~ Group, data = data, vertical = TRUE, add = TRUE, method = "jitter")

# Compare standard deviations for homogeneity of variance assumption
sort(tapply(data$Score, data$Group, sd))

# Normality check using Q-Q plots
cond1 <- data$Score[data$Group == "Group 1"]
cond2 <- data$Score[data$Group == "Group 2"]
cond3 <- data$Score[data$Group == "Group 3"]

par(mfrow = c(2, 2))  # Set plotting layout

qqnorm(cond1, main = "Q-Q Plot: Group 1", col = "blue")
qqline(cond1, col = "red")

qqnorm(cond2, main = "Q-Q Plot: Group 2", col = "blue")
qqline(cond2, col = "red")

qqnorm(cond3, main = "Q-Q Plot: Group 3", col = "blue")
qqline(cond3, col = "red")

# Dot chart to visualize distribution of scores
dotchart(data$Score, ylab = "Order of Observation", xlab = "Post Treatment Data Score",
         main = "Dot Plot of Scores")

# Perform One-Way ANOVA -------------------------------------------------
mod1 <- aov(Score ~ Group, data = data)

# Display ANOVA Summary Tables -------------------------------------------
m <- model.tables(mod1, type = "means", se = TRUE)   # Group means with standard errors
model.tables(mod1, type = "effects", se = TRUE)  # Treatment effects with standard errors

summary(mod1)

# Question 2 ------------------------------------------------------------

# Simulate data using code given in tutorial 

set.seed(123) # this is very important, it ensure you get the same data every time

# Factor: baking temperature
temp <- factor(rep(c("180", "190", "200", "210"), each = 12))

# Simulated rise heights (cm)
rise <- c(
  rnorm(12, mean = 6.0, sd = 0.5),
  rnorm(12, mean = 6.4, sd = 0.5),
  rnorm(12, mean = 6.3, sd = 0.5),
  rnorm(12, mean = 5.8, sd = 0.5)
)

bread <- data.frame(temp, rise)

# Boxplot with jittered points to check spread of scores across groups
boxplot(rise ~ temp, data = bread, 
        ylab = "Rise height", main = "Rise height by tempearture", las = 1, outline = FALSE)
stripchart(rise ~ temp, data = bread, vertical = TRUE, add = TRUE, method = "jitter")

# Compare standard deviations for homogeneity of variance assumption
sort(tapply(bread$rise, bread$temp, sd))

# Normality check using Q-Q plots
temp1 <- bread$rise[bread$temp == "180"]
temp2 <- bread$rise[bread$temp == "190"]
temp3 <- bread$rise[bread$temp == "200"]
temp4 <- bread$rise[bread$temp == "210"]

par(mfrow = c(2, 2))  # Set plotting layout

qqnorm(temp1, main = "Q-Q Plot: Group 1", col = "blue")
qqline(temp1, col = "red")

qqnorm(temp2, main = "Q-Q Plot: Group 2", col = "blue")
qqline(temp2, col = "red")

qqnorm(temp3, main = "Q-Q Plot: Group 3", col = "blue")
qqline(temp3, col = "red")

qqnorm(temp4, main = "Q-Q Plot: Group 3", col = "blue")
qqline(temp4, col = "red")

# Dot chart to visualize distribution of scores
dotchart(bread$rise, ylab = "Order of Observation", xlab = "Post Treatment Data Score",
         main = "Dot Plot of Scores")

