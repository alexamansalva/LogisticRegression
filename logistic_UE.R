
############################################################
####        TEST                                        ####
############################################################
# Set directory
setwd("D:/Alex/Concurso unidad editorial/code")

# To clean up the memory
rm(list=ls(all=TRUE))

## Instalamos el paquete 'sqldf' 
install.packages("sqldf")
library(sqldf)

## Carga de los datos
load("D:/Alex/Concurso unidad editorial/data/tmp_thecontest_train_dataframe_tramos.RData")
# ahora tenemos un objecto 'data' disponible
load("D:/Alex/Concurso unidad editorial/data/tmp_thecontest_train_dataframe.RData")
load("D:/Alex/Concurso unidad editorial/data/tmp_thecontest_test_dataframe.RData")


# Analizamos la tabla
names(data) 
str(data)
head(data, n=10)
View(data)
summary(data)

# Analizamos el target
table(data$target) # frequencias
table(data$target)/nrow(data) # %
hist(data$target) # histogram

## Esta seria la forma de aplicar la tramificacion 
# data.model.tram <- ApplyTramification(data, tramification.results)
# data.model.tram solo contiene aquellas variables para las que hay regas de tramificacion


cor(data) # correlaciones

logreg = glm(target ~ ., family=binomial(logit), data=data) # Estimate the drivers of attrition

hist(logreg$fitted.values) # See the proportion of employee attrition according to the model
cor(logreg$fitted.values,data$target) # Assess the correlation between estimated attrition and actual


cutoff=.3 # Cutoff to determine when P[leaving] should be considered as a leaver or not. Note you can play with it...
sum((logreg$fitted.values<=cutoff)&(datatot$target==0))/sum(datatot$left==0) # Compute the percentage of correctly classified employees who stayed
sum((logreg$fitted.values>cutoff)&(datatot$left==1))/sum(datatot$left==1) # Compute the percentage of correctly classified employees who left
mean((logreg$fitted.values>cutoff)==(datatot$left==1)) # Compute the overall percentage of correctly classified employees

summary(logreg) # Report the results of the logistic regression

# Let's use a more visual way to see the effect of one of the most important driver: TIC

plot(datatot$TIC,data$target,main= "Time and Employee Attrition", ylab="Attrition", xlab= "Time spent")

# An aggregated plot
tempdata=data
aggbTimeRank=aggregate(target~ TIC, data=tempdata, FUN=mean) # We compute the average attrition rate for each value of TIC
plot(aggbTimeRank$TIC,aggbTimeRank$target,main= "Time and Employee Attrition", ylab="Average Attrition Rate", xlab= "Time spent")

# An even better one!
cntbTimeRank=aggregate(target~ TIC, data=tempdata, FUN=length) # We compute the number of employees for each value of TIC
symbols(aggbTimeRank$TIC,aggbTimeRank$left,circles=cntbTimeRank$left, inches=.75, fg="white", bg="red",main= "Time and Employee Attrition", ylab="Average Attrition Rate", xlab= "Time spent") # we 

# Let's use a more visual way to see the effect of the most important driver: Satisfaction
tempdata=datatot
tempdata$rankSatis = round(rank(-tempdata$S)/600) # We create categories of employee satisfaction ranking. We create 20 groups (because it will work well later...)
aggbSatisRank = aggregate(left~ rankSatis, data=tempdata, FUN=mean) # We compute the average attrition rate for each category
cntbSatisRank = aggregate(left~ rankSatis, data=tempdata, FUN=length) # We compute the number of employees for each value of TIC
symbols(aggbSatisRank$rankSatis,aggbSatisRank$left,circles=cntbSatisRank$left, inches=.2, fg="white", bg="red",main= "Satisfaction and Employee Attrition", ylab="Average Attrition Rate", xlab= "Rank of Satisfaction")

