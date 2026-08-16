# Read in the data
sp <- read.csv("Lecture6_Example.csv")

# Check to ensure the data imported correctly
View(sp)

# Spearman's Rank Correlation Test using cor.test()
# Specify the two paired samples: x = time, y = mark
# There are ties, so include exact = FALSE to obtain the approximate p-value
cor.test(x = sp$time, y = sp$mark, method = 'spearman', exact = FALSE)


# Do the test manually
# Rank the sp
sp$markRank <- rank(sp$mark, ties.method = "average")
sp$timeRank <- rank(sp$time, ties.method = "average")

# Compute the Spearman correlation coefficient
n <- nrow(sp)
d <- sum((sp$markRank - sp$timeRank)^2)
rho <- 1 - (6 * d) / (n * (n^2 - 1))
rho

# Compute the p-value
z <- rho*sqrt(n-1)
pnorm(z, lower.tail = FALSE) # one-tailed test

# R uses a t-approx instaed of a normal approximation for small sample sizes

