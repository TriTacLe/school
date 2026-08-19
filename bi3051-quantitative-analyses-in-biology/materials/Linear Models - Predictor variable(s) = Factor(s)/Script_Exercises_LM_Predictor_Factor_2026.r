#BI 3051 Evolutionary Analysis - C. Pelabon#
#Exercise session - LINEAR MODEL - predictor = factor
#Update 2026


setwd("M:/Teaching/BI 3051/2024/Part_2_Linear_models/predictor_as_factor/Exercises")

###########################################################################
#Exercise 1. - One-way ANOVA----
#Data set about the yield in field with different fertilization treatments#

fert<-read.table("fertilizer.txt", header=T)
names(fert)


table(fert$fertil)
plot(factor(fert$fertil), fert$yield)

#fitting an ANOVA model----
model.1<-lm(yield~factor(fertil), data =fert)# linear model where the yield is 
                                              #the response variable and the fertilizer the predictor
anova(model.1)#anova table of the model testing the different effects
summary(model.1)# table of the parameter estimates

model.1b<-lm(yield~-1+factor(fertil), data=fert)# This way of writing the script allows 
                                                # estimating directly the means. It is referred to as model without intercept
summary(model.1b)

with(fert, tapply(yield, factor(fertil), mean))
plot(factor(fert$fertil), fert$yield)

par(mfrow=c(2,2))
plot(model.1)
hist(residuals(model.1))

#Calculation of r-square and adjusted r-square
10.823/(10.823+25.622)#Calculation of the multiple r-square
(var(fert$yield)-0.949)/var(fert$yield)#Adjusted r-square

#Reanalyse the model after removing the data having the strongest leverage----
#notice the script to remove specific data - 6, 19, 29 are the number of the row# 
model.2<-update(model.1, subset=-c(6, 19,29))
anova(model.2)
summary(model.2)
with(fert, plot(factor(fertil[subset=-c(6,19,29)]), yield[subset=-c(6,19,29)]))
hist(residuals(model.2))


#Graph-----
plot(model.2)
library(sciplot)
lineplot.CI(fert$fertil, fert$yield)
with(fert, lineplot.CI(factor(fertil[subset=-c(6,19,29)]), yield[subset=-c(6,19,29)], 
            xlab="Fertilization level", ylab="Yield (Tons)"))

####################################################################
#Exercise 2. Daphnia - Data from the R book Crawley ----

library(sciplot)

daph<-read.table("daphnia.txt", header=T)
names(daph)

#Structure of the data set-----
with(daph, table(Water, Detergent, Daphnia))

model1<-lm(Growth.rate~Water*Detergent*Daphnia, data = daph)
anova(model1)
summary(model1)

(1.985+2.212+39.178+0.175+13.732+20.601+5.848)/(1.985+2.212+39.178+0.175+13.732+20.601+5.848+33.428)#Multiple R2 square
(var(daph$Growth.rate)-.6964)/var(daph$Growth.rate)#ajusted r2 

model1a<-lm(Growth.rate~-1+Water:Detergent:Daphnia, data = daph) #by removing the intercept we can get 
                                                                # an estimates for each level.
summary(model1a)


#Simplest model----
model2<-lm(Growth.rate~Water+Detergent+Daphnia+ Water:Daphnia+Daphnia:Detergent + Water:Detergent, data=daph)
anova(model2)
summary(model2)

model3<-lm(Growth.rate~Water+Detergent+Daphnia+ Water:Daphnia+Daphnia:Detergent, data=daph)
anova(model3)
summary(model3)


#Making graphs----
par(mfrow=c(1,2))
with(daph, lineplot.CI(Water, Growth.rate, Daphnia))
with(daph, lineplot.CI(Detergent, Growth.rate, Daphnia))


#END
#############################################################

