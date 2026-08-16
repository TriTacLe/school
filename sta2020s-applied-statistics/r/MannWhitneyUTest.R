# Mann Whitney U Test in R --------------------------------------------

## Small Samples --------------------------------------------

datproc <- c(70,52,46,65,60,40)
typing <- c(59,70,75,85,50,82,64)

# looks quite normal! 
qqnorm(datproc)
qqline(datproc)                                     

# run the wilcox.test() for the two variables
# in this case, the data is NOT paired; let paired = FALSE
# the alternative hypothesis is "two.sided"
# if we have ties, set exact = FALSE or if we want to use the normal approx 

wilcox.test(x = datproc, 
            y = typing, 
            exact = FALSE, 
            paired = FALSE, 
            alternative = "two.sided")                                       


# R uses the U statistic 
# U1 = n1*n2+(n1*(n1+1))/2 - T1
# U2 = n1*n2+(n2*(n2+1))/2 - T2
# min(U1,U2) 


# Sample sizes
n1 <- length(datproc)
n2 <- length(typing)

# Combine all data and group labels
values <- c(datproc, typing) # combined_sample
group <- c(rep("datproc", n1), rep("typing", n2))

# Rank all values (average ranks for ties)
ranks <- rank(values)

# Check ranking
data.frame(values, group, ranks)

# Sum of ranks for each group
T1 <- sum(ranks[group == "datproc"])  # datproc
(T2 <- sum(ranks[group == "typing"]))


# standardise T1
# use pnorm 


# Compute U statistics
U1 <- n1 * n2 + (n1 * (n1 + 1)) / 2 - T1
U2 <- n1 * n2 - U1  # since U1 + U2 = n1 * n2

# Smaller of the two U's is the test statistic
min(U1, U2)

# conclusion should be the same, p-values might only differ very slightly 

## Large sample -------------------------------------------------------

# Class example 2 (large sample approach)

# read in the data set 
aspdata <- read.csv('Data/Lectur3_Example.csv', header = TRUE, sep =",")
View(aspdata)

# run the wilcox.test() for the two variables
# in this case, the data is NOT paired; let paired = FALSE
# change the alternative hypothesis to "greater"

wilcox.test(x=aspdata$New,
            y=aspdata$Aspirin,
            exact=FALSE,
            paired = FALSE, 
            alternative = "greater")


# In this case, R uses a different formula to perform this calculation and it is not the same as 
# what we calculated it to be by hand. We will focus on the p-value and the interpretation of this test;
# the conclusions for R's test and our hand calculated tests will be the same and the p-values 
# are not expected to differ by much
