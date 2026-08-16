# Kruskal-Wallis

# Class example 1 (Shifts & speed) ---------------------------------------------

# importing data from csv file into R
kw1 <- read.csv("Data/Lecture4_Example1.csv", header = TRUE, sep = ",")

View(kw1)

# EDA = exploratory data analysis 

boxplot(kw1$num ~ kw1$name, main = "Boxplot of shifts and speed", 
        xlab = "Shifts", ylab = "Speed", col = c("red", "blue", "green"))

qqnorm(kw1$num[kw1$name=="mid.eight"])
qqline(kw1$num[kw1$name=="mid.eight"], col = "blue")

qqnorm(kw1$num[kw1$name=="four.mid"])
qqline(kw1$num[kw1$name=="four.mid"], col = "red")

qqnorm(kw1$num[kw1$name=="eight.four"])
qqline(kw1$num[kw1$name=="eight.four"], col = "green")

# carry out the test with a formula of the columns you wish to compare: response ~ group

kruskal.test(formula = num ~ name, data = kw1)


# Manually calculate the Kruskal-Wallis test statistic ------------------------

n1 <- nrow(kw1[kw1$name=="four.mid",])  
n2 <- nrow(kw1[kw1$name=="mid.eight",]) 
n3 <- nrow(kw1[kw1$name=="eight.four",])  

summary(kw1)
kw1$name <- as.factor(kw1$name)  # convert to factor
summary(kw1)

# Rank all values (average ranks for ties)
kw1$rank <- rank(kw1$num, ties.method = "average")

# Sum of ranks for each group
T1 <- sum(kw1$rank[kw1$name == "four.mid"])   
T2 <- sum(kw1$rank[kw1$name == "mid.eight"])   
T3 <- sum(kw1$rank[kw1$name == "eight.four"])   

T1;T2;T3

# Compute H statistic
n <- nrow(kw1)  # total number of observations
H <- (12 / (n * (n + 1))) * (T1^2/n1 + T2^2/n2 + T3^2/n3) - 3 * (n + 1)

# Compute p-value
1 - pchisq(H, df = 2)  # df = k - 1, where k is the number of groups

# same as 
pchisq(H, df = 2, lower.tail = FALSE)  # p-value for H statistic


# Class example 2 (Level of employee) ------------------------------------------

# importing data from csv file into R
kw2 <- read.csv("Data/Lecture4_Example2.csv", header = TRUE, sep = ",")

View(kw2)

# EDA
boxplot(kw2$num ~ kw2$name, main = "", 
        xlab = "", ylab = "", col = c("red", "blue", "green"))

qqnorm(kw2$num[kw2$name=="top"])
qqline(kw2$num[kw2$name=="top"], col = "blue")

qqnorm(kw2$num[kw2$name=="middle"])
qqline(kw2$num[kw2$name=="middle"], col = "red")

qqnorm(kw2$num[kw2$name=="worker"])
qqline(kw2$num[kw2$name=="worker"], col = "green")


# carry out the test with a formula of the columns you wish to compare: response ~ group

kruskal.test(formula = num ~ name, data = kw2)

# NB: the chi-squared test statistic (in both examples) uses a different formula to perform 
# this calculation and it is not the same as what we calculated it to be by hand. We will focus 
# on the p-value and the interpretation of this test;
# the conclusions for R's test and our hand calculated tests will be the same and the p-values
# are not expected to differ by much.

      
             
