#BI 3051 Evolutionary Analysis - C. Pelabon - Update September 2026#
#PART 1: Getting started with R#

# 1) WORKING DIRECTORY ---------

# Set working directory!
setwd("/Volumes/pelabon/Teaching/BI 3051/2026")# This is an example, you have to set your own working directory

#Example of script - building a simple data set----

ind<-1:10
cat<-rep(1:2, each=5)
mass<-c(2, 2.3, 2.4, 1.4, 1.5, 2, 2.3, 4, 2.1, 3)
data1<-cbind(ind,cat,mass)
data1<-data.frame(data1)

with(data1, mean(mass[cat=="2"]))


mean(data1$mass[data1$cat==2])



#Exploring data, data set management, descriptive statistics - Data: seedling----

seedling<-read.table("C:\\Rdatafile\\BI3051\\seedling.txt", header=T)#read the data file seedling in the C drive
names(seedling)#list the name of the column in seedling data file. 

mean(seedling$sdwght)#calculate the mean for the variable sdwght in the data seddling
var(seedling$sdwght)
sd(seedling$sdwght)

#Understanding the structure of the data set#
with(seedling, length(seedset))#this will give the total number of observation
length(seedling$seedset)#note that this command is the same as the previous one

with(seedling, table(hybrid, seedcat )) # there are 4 type of cross per category of seeds, 2 hybrids and 2 non-hybrids#

#distribution of the variables#

par(mfrow=c(2,2))#divide the graph window into 2 columns and 2 rows
hist(seedling$seedset)
hist(seedling$sdwght,20)
hist(seedling$lobe)
hist(seedling$biomass)

#explore graphically the possible correlations between response variables#

dataset<-with(seedling, cbind(seedset, sdwght, lobe, biomass)) #combined the different response variables we are interested in#
pairs(dataset)  #represent the scatterplot for each pair#

#Represent the relationship between the seed mass and the plant biomass at one month for the two seed category on a single graph#
par(mfrow=c(1,1)) #restore the single graph in the graph window
plot(seedling$sdwght,seedling$biomass, col=as.numeric(seedling$seedcat), pch=as.numeric(seedling$seedcat), xlab="seed mass (g)", ylab="biomass (g)")

# Calculate the mean and standard deviation of the seed mass for hybrids and non hybrids crosses for the two seed categories
with(seedling, tapply(sdwght,list(seedcat, hybrid), mean, na.rm=T))
variance<-with(seedling, tapply(sdwght,list(seedcat, hybrid), var, na.rm=T))
samplesize<-with(seedling, tapply(sdwght,list(seedcat, hybrid), length))
SE<-sqrt(variance/samplesize)
SE


#represent the change in mean according to these two variables

with(seedling, interaction.plot(factor(hybrid), factor(seedcat), sdwght))
#############################


# PART 2 -  Data manipulation and packages (dplyr)

#' author: Laura Bartra Cabre
#' date: 2021-09-22
#' edited by: Agnes Holstad
#' date: 31.01.2024
#' ----



# 1) WORKING DIRECTORY -------------------------------------------------

# Always set working directory!
setwd("~/Library/CloudStorage/OneDrive-NTNU/01_PhD/Teaching/R_course-master_students/latest_versions/Session3_DataManipulation")



# 2) MORE DATA FRAME MANIPULATION -------------------------------------------------

example1 <- data.frame(
  id = 1:5,
  a = c(1, 5, 2, 3, 2),
  b = c(8, 10, 9, 8, 7),
  c = c(3, 7, 4, 6, 4))

example2 <- data.frame(
  id = 1:5,
  group = c("yes", "no", "yes", "no", "no"),
  e = c(25, 22, 24, 19, 23))

# cbind() "column bind" vs merge()  
combined <- cbind(example1, example2[ ,-1])
combined2 <- merge(example1, example2, by = "id")
?merge 
# The cbind() is used to combine vectors, matrices, or data frames by adding their columns side by side. 
# The merge() function is used to combine data frames by matching rows based on common columns (key columns). 
# The function identifies common columns between the data frames and creates a new data frame with rows 
# from both data frames where the values in the specified column match. 


# Useful if the rows don't match (different order):
example3 <- data.frame(
  id = 5:1,
  group = c("yes", "no", "yes", "no", "no"),
  e = c(25, 22, 24, 19, 23))

comb <- merge(example1, example3, by = "id")

# Even if the number of rows differ:
example4 <- data.frame(
  id = 4:1,
  group = c("yes", "no", "yes", "no"),
  e = c(25, 22, 24, 19))

comb2 <- merge(example1, example4, by = "id")
?merge 
comb2 <- merge(example1, example4, by = "id", all = TRUE)


# calculate mean of a for each group (yes and no)
aggregate(a ~ group, 
          data = combined, 
          FUN = mean)
?aggregate
# The aggregate() function is used for aggregating data within a data frame. 
# It helps you summarize data by applying a specified function to subsets of the data based on one or more grouping factors. 
# This is particularly useful when you want to calculate summary statistics or perform other computations on subsets of your data.



# YOU TRY: calculate the total sum of b for each group (yes and no) 
# and only for e > 20 in the data frame combined.
?aggregate()

aggregate(b ~ group, 
          data = combined, 
          FUN = sum,
          subset = e > 20)





# 3) LOAD, SUBSET AND SORT THE DATA -------------------------------------------------

# Load the data
moose_full <- read.csv("data/MooseData.csv")   

# Subset the data
moose <- moose_full[ ,c(1:3,6:10,11,22)]              
head(moose)


# Sort by Calf weight
?order
moose <- moose[order(moose$CalfWeight), ]
head(moose)




# YOU TRY: Sort Calf weight by Season in decreasing order (Winter first):
?order
moose[order(moose$Season, moose$CalfWeight, decreasing = c(T,F), method = "radix"), ]







# 4) PACKAGES -------------------------------------------------

# A package is a set of pre-written functions. 
# Once you have installed and imported a package, you can benefit from all of its functions.
# There are packages for everything, from importing Google Maps to converting imperial to metric to monitoring animal movement.
.libPaths() # get library location
library()   # see all packages installed
search()    # see packages currently loaded



# 5) dplyr -------------------------------------------------

# dplyr was created to make editing and manipulating data more intuitive. 
# Whilst everything you're about to see CAN be done without dplyr, 
# the language and format of dplyr makes it easier.

#install.packages("dplyr")
library(dplyr)                             
# require(dplyr) # Same


#detach("package:dplyr", unload=TRUE)       # to detach a package

# 6) Base R vs dplyr -------------------------------------------------

# Bind data frames with dplyr use *_join
combined2 <- left_join(example1, example2, by = "id")
?left_join


# Selecting coloumns
moose[ ,c("OwnSex","CalfWeight")]
moose[ ,c(6,3)]

# Let's use dplyr to select certain columns. This format is simple; the first 
# argument is the data frame you want to use, any arguments following that are 
# the columns you want.
select(moose, OwnSex, CalfWeight)
select(moose, 6, 3)                            # We can also use numbers
select(moose, OwnSex, 8)

select(moose, BYrId)
# Here you CAN mix numbers and names
?select
# NOTE: Unfortunately, there are multiple 'select' functions floating around in 
# R, and sometimes you MAY get an error popping up because of this. If it 
# happens, you can simply write 'dplyr::select' to tell R where to look for the 
# function. Think of it as the $, but for functions instead of data.

dplyr::select(moose, CalfWeight:OwnSex)
?dplyr

# Here's a good time to elaborate on the use of ':'. These essentially string 
# anything into a sequence vector. Try 1:8. It works with OwnSex:CalfWeight 
# because it can see that they're part of a larger pattern and includes 
# everything between them.

# The '-' also works here to exclude anything you don't need. With select(), you 
# can use it in front of words.
select(moose, -(3:6))
select(moose, -(CalfWeight:OwnSex))

# The slice function works the same way, except with rows instead of columns.
slice(moose, 1:3)

# Now let's try applying some filters to the data we have
filter(moose, CalfWeight <= 68)
# Remeber filtering in base R:
moose[moose$CalfWeight <= 68, ]


# YOU TRY: filter by calfweight > than 90 or smaller than 60, and only in the Summer 
df <- filter(moose, CalfWeight > 90 | CalfWeight < 60, Season == "Summer", WeightType == "Slaughter")
df




# The function 'arrange' is an easy way to rearrange your data frames. It takes 
# whatever variable you choose and arranges your data frame according to that 
# variable.
arrange(moose, CalfWeight)

# YOU TRY: If you choose multiple variables to arrange by, R will arrange them in the 
# order you list. Arrange by Season first, and then my calfweight
?arrange # look at the examples!

arrange(moose, Season, CalfWeight)


# Alternative standard R code to this is as follows
moose[order(moose$WeightType, moose$CalfWeight),]

# YOU TRY: The default is low to high. To change the order they are listed in, simply 
# use the desc() function. desc stands for descending. Arrange by age in descending order, 
# and by weightype in ascending order
arrange(moose, desc(Age), WeightType)





# The distinct function allows you to observe all distinct data points.
distinct(moose, Age)
distinct(moose, Season, WeightType, Age)

# The rename function renames your variables. 
# NB: You give the existing name of the variable second.
rename(moose, Sex = OwnSex, MotherAge = Age)
# DO YOU remember how to do this with base R? 
names(moose)[c(6,7)] <- c("Sex","MotherAge")





# We can produce new columns using the 'mutate' function
moose2 <- mutate(moose, Weight_log = log(CalfWeight))
# DO YOU remember how to do this in base R?
moose2$weight_log <- log(moose$CalfWeight)




# And if you only want new variables, use transmute
moose3 <- transmute(moose, BYrId,
                    Age_plus = Age + 1,
                    Age_log = log(Age_plus))


# Lastly, the summarise function is very useful for determining mean, maximum
# and minimum values (among others) from data frames.
summarise(moose, meanWeight = mean(CalfWeight))

summarise(moose,
          meanWeight = mean(CalfWeight),
          n_obs = n(),
          sum = sum(CalfWeight))

# YOU TRY: summarise the minimum and maximum values of age in moose (and also the number of observations)
summarise(moose,
          min = min(Age),
          max = max(Age),
          n = n())



################## END ######################




