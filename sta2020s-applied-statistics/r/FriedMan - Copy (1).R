# Set the working directory (if not already set)
setwd("")

# Class example 1 

# Read in the data set
fr.1 <- read.csv("Lecture5_Example1.csv", header = TRUE, sep = ",")

# View the data set to ensure it imported correctly
View(fr.1)

# Friedman test carried out in two different ways:
# Method 1: Specify y (numeric/observation column), groups, and blocks
friedman.test(y = fr.1$rating, groups = fr.1$manager, blocks = fr.1$applicant)

# Method 2: Use the formula a~b|c where a = observations, b = groups/treatment, and c = blocks
friedman.test(formula = rating~manager|applicant, data = fr.1)

# Class example 2

# Read in the data set
fr.2 <- read.csv("Lecture5_Example2.csv", header = TRUE, sep = ",")

# View the data set to ensure it imported correctly
View(fr.2)

# Friedman test carried out in two different ways:
# Method 1: Specify y (numeric/observation column), groups/treatment, and blocks
friedman.test(y = fr.2$bid, groups = fr.2$company, blocks = fr.2$plot)

# Method 2: Use the formula a~b|c where a = observations, b = groups/treatment, and c = blocks
friedman.test(formula = bid~company|plot, data = fr.2)


# Manually ---------------------------------------------------------------------

# Step 1: Transform data to wide format (plots as rows, companies as columns)

# Split data by company
manager1 <- fr.1[fr.1$manager == "1", ]
manager2 <- fr.1[fr.1$manager == "2", ]
manager3 <- fr.1[fr.1$manager == "3", ]
manager4 <- fr.1[fr.1$manager == "4", ]

# Construct wide-format data frame
wide_rating <- data.frame(
  manager1 = manager1$rating,
  manager2 = manager2$rating,
  manager3 = manager3$rating,
  manager4 = manager4$rating
)

# Alternative: Use tidyr::pivot_wider() to do this automatically
# Or input the data manually 

# Step 2: Rank the rating within each plot (i.e., across each row)
# Apply 'rank' row-wise; transpose result so rows = plots
ranked_rating <- t(apply(wide_rating, 1, rank, ties.method = "average"))

# Step 3: Compute treatment rank sums (sum of ranks for each company)
rank_sums <- colSums(ranked_rating)

# Step 4: Compute Friedman test statistic
n <- nrow(wide_rating)  # number of plots (blocks)
k <- ncol(wide_rating)  # number of companies (treatments)

Fr <- (12 / (n * k * (k + 1))) * sum(rank_sums^2) - 3 * n * (k + 1)

# Step 5: Calculate p-value from chi-squared distribution
p_value <- pchisq(Fr, df = k - 1, lower.tail = FALSE)

