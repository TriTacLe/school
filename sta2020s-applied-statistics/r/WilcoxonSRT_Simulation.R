
library(ggplot2)

## Exact distribution of signed rank sum n = 3 ---------------------------------

w <- c(6, 4, 3, 0, 0, -2, -4, -6)

# Convert to data frame
df <- data.frame(diff = w)

# Plot histogram showing proportion
ggplot(df, aes(x = factor(diff))) +
  geom_bar(aes(y = after_stat(prop), group = 1), fill = "skyblue", color = "black") +
  labs(title = "Proportion of Signed Differences",
       x = "W",
       y = "Proportion") +
  theme_minimal()

# Using base plot R 

barplot(table(w) / length(w),
        main = "Proportion of Signed Differences",
        xlab = "W", ylab = "Proportion",
        col = "lightblue", border = "black")


# Simulation showing normal approx to samp distribution of W -------------------

simulate_wilcoxon <- function(n, reps = 10000) {
  stats <- numeric(reps)
  
  for (i in 1:reps) {
    # Simulate n differences from a symmetric distribution (under H0)
    diffs <- rnorm(n, mean = 0, sd = 1)
    
    # Drop zeros (rare for continuous data like normal)
    diffs <- diffs[diffs != 0]
    
    # Get ranks of absolute values
    ranks <- rank(abs(diffs))
    
    # Signed ranks
    signed_ranks <- ranks * sign(diffs)
    
    # Compute the sum of positive signed ranks
    stats[i] <- sum(signed_ranks)
  }
  
  return(stats)
}

# Simulate for different sample sizes
set.seed(123)
sizes <- c(9, 12, 14, 16, 18, 20, 50, 100)
par(mfrow = c(4, 2))

for (n in sizes) {
  sim_stats <- simulate_wilcoxon(n)
  hist(sim_stats, breaks = 30, probability = TRUE,
       main = paste("n =", n),
       xlab = "Signed Rank Sum",
       col = "lightblue", border = "white")
  
  # Add normal curve for comparison
  mu <- 0
  sigma <- sqrt(n * (n + 1) * (2 * n + 1) / 6)
  curve(dnorm(x, mean = mu, sd = sigma),
        col = "red", lwd = 2, add = TRUE)
}

## Generalised code for getting exact distribution --------------------------------

max_rank <- 5
ranks <- 1:max_rank
sign_combos <- expand.grid(rep(list(c(-1, 1)), max_rank))

w <- apply(sign_combos, 1, function(signs) sum(signs * ranks))

df <- data.frame(W = factor(w))

ggplot(df, aes(x = W)) +
  geom_bar(aes(y = after_stat(prop), group = 1), fill = "skyblue", color = "black") +
  labs(title = "Exact Distribution of Signed Rank Sum (n = 3)",
       x = "W (Signed Rank Sum)",
       y = "Proportion") +
  theme_minimal()


## Mann-Whitney U test simulation ---------------------------------------------

simulate_mannwhitney <- function(n1,n2, reps = 10000) {
  stats <- numeric(reps)
  n_total <- n1 + n2
  
  for (i in 1:reps) {
    # Step 1: Simulate a combined sample under H0 (same distribution)
    combined <- rnorm(n_total)  # or runif(n_total) if you want a non-normal dist
    
    # Step 2: Randomly assign group labels
    group_labels <- sample(c(rep(1, n1), rep(2, n2)))
    
    group1 <- combined[group_labels == 1]
    group2 <- combined[group_labels == 2]
    
    # Step 3: Compute the U statistic
    ranks <- rank(c(group1, group2))
    R1 <- sum(ranks[1:n1])  # sum of ranks for group 1
    
    stats[i] <- R1
  }
  
  return(stats)
}

# Simulate for different sample sizes
set.seed(123)
n1 <- c(3, 5, 10, 10, 16, 18)
n2 <- c(3, 5, 3, 10, 5, 18)

par(mfrow = c(3, 2))

for (i in 1:length(n1)) {
  sim_stats <- simulate_mannwhitney(n1[i], n2[i])
  hist(sim_stats, breaks = 30, probability = TRUE,
       main =paste("n1 =", n1[i], "n2 =", n2[i]),
       xlab = "T1",
       col = "lightblue", border = "white")
  
  # Add normal curve for comparison
  mu <- (n1[i]*(n1[i] + n2[i] +1))/2
  sigma <- sqrt((n1[i] * n2[i] * (n1[i] + n2[i] +1))/12)
  curve(dnorm(x, mean = mu, sd = sigma),
        col = "red", lwd = 2, add = TRUE)
}

