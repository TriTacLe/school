#Script lecture linear model with a factor as predictor variable 

#1 - ANOVA by hand----
x1<-c(2,3,3,2,3)
x2<-c(3,4,3,4,3)
x3<-c(5,6,5,6,5)
cat<-c(1,1,1,1,1,2,2,2,2,2,3,3,3,3,3)
yy<-c(x1,x2,x3)
data<-data.frame(yy,factor(cat))
data
model<-lm(yy~factor(cat))
anova(model)
summary(model)

with(data, tapply(yy, cat, mean))

#2 - Analysis Simulated data----
  # 2.1. Simulation----
  #Data where the growth of plants is measured under three different treatment (Control, Fertiliser A, Fertiliser B)
  #with 50 plants per treatment.
      cat<-rep(c("Cont", "Fert_A", "Fert_B"),each = 50)

      xx1.1<-rnorm(50, 10,0.3)
      xx1.2<-rnorm(50, 12,0.3)
      xx1.3<-rnorm(50, 8,0.3)
      xx1<-c(xx1.1,xx1.2,xx1.3)
      
      xx2.1<-rnorm(50, 10,1.5)
      xx2.2<-rnorm(50, 12,1.5)
      xx2.3<-rnorm(50, 8,1.5)
      xx2<-c(xx2.1,xx2.2,xx2.3)

      Data<-data.frame(cat,xx1, xx2)
      head(Data)#shows the column name and the first raws of the data set. 

  # 2.2. plot of the data----

  library(ggplot2)

    #simple plot for the first set of data
  ggplot(Data, aes(x = cat, y = xx1)) +
  geom_boxplot(fill = "burlywood", 
               outlier.alpha = 0) + 
  geom_jitter(width = 0.20, size = 0.1) +
  labs(x = "Treatment",y = "Growth (mm/d)", cex=2)+
  ylim(6.5,12.5)+
  theme(axis.title.y = element_text(size = rel(1.8), angle = 90))+
  theme(axis.title.x = element_text(size = rel(1.8), angle = 00))+
  theme(axis.text.x = element_text(size= 20))+
  theme(axis.text.y = element_text(size= 20))

    #plot of the two data sets side by side
  if(!require(devtools)) install.packages("devtools")
  devtools::install_github("kassambara/ggpubr")
  library(ggpubr)
  
  plot1<-ggplot(Data, aes(x = cat, y = xx1)) +
  geom_boxplot(fill = "burlywood", 
               outlier.alpha = 0) + 
  geom_jitter(width = 0.20, size = 0.1) +
  labs(x = "Treatment",y = "Growth (mm/d)", cex=2)+
  ylim(5,14)+ 
  theme(axis.title.y = element_text(size = rel(1.8), angle = 90))+
  theme(axis.title.x = element_text(size = rel(1.8), angle = 00))+
  theme(axis.text.x = element_text(size= 15))+
  theme(axis.text.y = element_text(size= 15))

  plot2<-ggplot(Data, aes(x = cat, y = xx2)) +
  geom_boxplot(fill = "burlywood", 
               outlier.alpha = 0) + 
  geom_jitter(width = 0.20, size = 0.1) +
  labs(x = "Treatment",y = "Growth (mm/d)", cex=2)+
  ylim(5,14)+ 
  theme(axis.title.y = element_text(size = rel(1.8), angle = 90))+
  theme(axis.title.x = element_text(size = rel(1.8), angle = 00))+
  theme(axis.text.x = element_text(size= 15))+
  theme(axis.text.y = element_text(size= 15))

  ggarrange(plot1,plot2 ,  
          labels = c("A", "B"),
          ncol = 2, nrow = 1)

  # 2.3. Analysis---- 
    model1<-lm(xx1~cat, data = Data)
    anova(model1)#anova table
    summary(model1)#summary table with effect size

    with(Data, tapply(xx1, cat , mean))#calculating the mean using the mean function.
    summary(lm(xx1~cat-1, data = Data))#estimating the mean of the different treatment using a model without intercept

  #testing the fit of the model
    par(mfrow=c(2,2))
    plot(model1)#diagnostic plots 

  #Comparing the distribution of the data with the distribution of the residuals
    par(mfrow=c(1,2))
    hist(Data$xx1)
    hist(residuals(model1))

  #Post-hoc multiple comparison----
    TukeyHSD(aov(xx1~cat, data=Data))
  
  # 2.4. Final figure----
  library(sciplot)
  with (Data, lineplot.CI(x.factor = cat, response = xx1, type="p",
            xlab="Treatment", ylab="growth (mm/d)"))


# 3 Exercise in class - Analysis of th roe deer antler length----

    RD<-read.table("C:\\Rdatafile\\BI3051\\roedeer.txt", header=T)
    names(RD)
    summary(RD$antsizer)     #Note that there is no missing values in the antler size neither for the left nor for the right#
    table(RD$dens, RD$agecat)#Unbalance number of animals in the different age class

    #Calculating an average antler size
    AS<-(RD$antsizel+RD$antsizer)/2

  # 3.1. Does the density affect antler length----

    model1<-lm(AS~factor(dens), data =RD)

    anova(model1)
    summary(model1)
    tapply(AS, RD$dens,mean)

    lineplot.CI(RD$dens, AS,xlab="Density", ylab="Antler length cm")

  # 3.2. - Linear model two factors: Does the effect of density on antler length depends on the age?----

    model2<-lm(AS~factor(dens)*factor(agecat), data =RD)

    anova(model2)

    model3<-lm(AS~factor(dens)+factor(agecat), data =RD)
    anova(model3)
    summary(model3)
    tapply(AS, list(RD$dens, RD$agecat) ,mean)

    with(RD, lineplot.CI(agecat, AS, dens, xlab = "age category", ylab="Antler size cm"))
    with(RD, lineplot.CI(dens, AS, agecat, xlab="Density", ylab="Antler size cm"))

#####################################

