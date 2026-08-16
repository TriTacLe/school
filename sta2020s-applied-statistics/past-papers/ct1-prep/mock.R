# Load and inspect
d <- read.csv("regional_profit.csv")
str(d)

# fit full model
m <- lm(Quarterly_Profit ~ ., data=d)
summary(m)
