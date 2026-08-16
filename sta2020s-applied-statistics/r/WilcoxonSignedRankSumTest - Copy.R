
# Wilcoxon Signed Rank Sum Test in R --------------------------------------------

flexi_data<-read.csv('Data/Lecture2_Example.csv', header = TRUE, sep =",")

## Manual --------------------------------------------

# Calculate the differences
flexi_data$Difference <- flexi_data$Normal - flexi_data$Flexi

# Remove zero differences  
flexi_data <- flexi_data[flexi_data$Difference != 0, ]

# Number of non-zero differences
n <- nrow(flexi_data) 

# Calculate the absolute differences
flexi_data$Abs_Difference <- abs(flexi_data$Difference)

# Rank the absolute differences
flexi_data$Rank <- rank(flexi_data$Abs_Difference, ties.method = "average")

# Assign signs to the ranks
flexi_data$Signed_Rank <- flexi_data$Rank * sign(flexi_data$Difference)

# test statistic 
W <- sum(flexi_data$Signed_Rank)

# z-score 
mean_W <- 0
sd_W <- sqrt((n*(n+1)*(2*n+1))/6)
z <- (W - mean_W)/sd_W

# p-value 
pnorm(z,lower.tail = F)



## With function wilcox.test -------------------------------------------

# in R 


# wilcox.test() will perform your required test. 
# specify whether the data is paired (TRUE) or not (FALSE)
# specify exact = TRUE ONLY if you have NO TIES; 
# in the presence of ties: exact = FALSE will give you an approximated p-value (which you want in this case)
# alternative = c("two.sided", "less", "greater")---choose one based on the problem and alternative hypothesis 
# that you specified
# search in the help function for more info on wilcox.test()
# NB: the value V in the output is the sum of the POSITIVE signed ranks. 


wilcox.test(x=flexi_data$Normal, # first sample
            y=flexi_data$Flexi,  # second sample 
            exact=FALSE,         # normal approx or not?
            paired = TRUE,       # paired or not?
            alternative = "greater") # alternative hypothesis 

                   
                   
# Set up the data manually -----------------------------------------------------

worker <- 1:32
before <- c(34, 35, 43, 46, 16, 26, 68, 38, 61, 52, 68, 13, 69, 18, 53, 18,
            41, 25, 17, 26, 44, 30, 19, 48, 29, 24, 51, 40, 26, 20, 19, 42)
after <- c(31, 31, 44, 44, 15, 28, 63, 39, 63, 54, 65, 12, 71, 13, 55, 19,
           38, 23, 14, 21, 40, 33, 18, 51, 33, 21, 50, 38, 22, 19, 21, 38)

# Combine into a data frame
data <- data.frame(worker, Before = before, After = after)


                   
                                      