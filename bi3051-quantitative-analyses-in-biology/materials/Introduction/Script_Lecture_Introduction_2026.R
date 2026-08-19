#Script Lecture 1 BI3051 Introduction - Pelabon NTNU
####################################################
#1 - Basic principle of statistical test####


#1.1 Calculating a T-test----
#Two samples with equal mean variance and sample size#

ss1<-rnorm(50, 0,1)#random sampling of 50 individuals in a population with mean=0, SD=1
ss2<-rnorm(50, 1,1)#random sampling of 50 individuals in a population with mean=1, SD=1



?rnorm
?t.test
ss3<-rnorm(50, 2,1)
t.test(ss3, mu=3)

#distribution of the two samples
par(mfrow=c(1,2))
hist(ss1, xlim=c(-4,4),8)
hist(ss2, xlim=c(-4,4),8)

#Calculation of the T statistics
tvalue<-(mean(ss1)-mean(ss2))/sqrt((var(ss1)/length(ss1))+(var(ss2)/length(ss2)))
tvalue
#What is the proportion of the T sampling distribution that is lower than the observed T value
pnorm(tvalue)#proportion of value lower than the tvalue

#Lets check with a t.test
t.test(ss1,ss2)

#1.2. Representing a T distribution----
#Simulating 1000 replicate of this sampling and calculating the T value for each replicate

tvalues<-numeric(1000)
for(i in 1:1000){
  ss1<-rnorm(30, 1,1)#first sample from a normal distribution with n = 30 mean = 1 SD = 1
  ss2<-rnorm(30, 1,1)#second sample
  tvalues[i]<-(mean(ss1)-mean(ss2))/sqrt((var(ss1)/length(ss1))+(var(ss2)/length(ss2)))[1]
}#generate a vector with 1000 simulated t value

#distribution of the T value
par(mfrow=c(1,1))
hist(tvalues) #distribution of the t values
quantile(tvalues,c(0.025, 0.975)) #95% confidence interval of the t values 

#T.test for the initial data
t.test(ss1,ss2)

#END

#One sample t-test 