# Tutorial 2
library(tidyverse)

# Part 1
# Q1 Tutorial 1
data <- read.csv("Data/test_anxiety.csv")
mod1 <- aov(Score ~ Group , data = data)
model.tables(mod1,type = "effects", se=TRUE)
model.tables(mod1,type = "means", se=TRUE)
summary(mod1)

# Q2 Tutorial 1 
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
mod2 <- aov(rise ~ temp, data = bread)
summary(mod2)


# Ignore 
# study <- read.csv("Data/anova_data.csv")
# study_data <- study %>%
#   select(2:4) %>%
#   pivot_longer(cols = everything(), names_to = "StudyEnvironment", values_to = "Score")
# 
# write.csv(study_data, "Data/study_environment.csv", row.names = FALSE)

# Part 2 ---------------------------------------------------------------------
study_data <- read.csv("Data/study_environment.csv")

summary(study_data)
study_data$StudyEnvironment <- as.factor(study_data$StudyEnvironment)


aov_model <- aov(Score ~ StudyEnvironment, data = study_data)
model.tables(aov_model, type = "effects", se = TRUE)
model.tables(aov_model, type = "means", se = TRUE)

summary(model)

## RCBD - Coffee --------------------------------------------------------------

data <- data.frame(
  Experts = c("E.B.", "N.B.", "M.D.", "M.H.", "B.J.", "R.J.", "B.K.", "B.M.", "J.S."),
  A = c(24, 27, 19, 24, 22, 26, 27, 25, 22),
  B = c(26, 27, 22, 27, 25, 27, 26, 27, 23),
  C = c(25, 26, 20, 25, 22, 24, 22, 24, 20),
  D = c(22, 24, 16, 23, 21, 24, 23, 21, 19)
)

data_long <- data %>%
  pivot_longer(cols = -Experts, names_to = "Category", values_to = "Score")

data_long$Experts <- as.factor(data_long$Experts)
data_lonf$Category <- as.factor(data_long$Category)

interaction.plot(data_long$Category, data_long$Experts, data_long$Score)

model <- aov(Score ~ Experts + Category, data = data_long)
effect<- model.tables(model, type = "effects", se = TRUE)
model.tables(model, type = "means", se = TRUE)

ao <- anova(model)
sq_sum <- function(x) {sum(x^2)}

s <- tapply(data_long$Score, data_long$Category, sq_sum)
sum(s) + (sum(data_long$Score)^2)/nrow(data_long)





