##################################################
### PROG8430                                    ##
### Data Reduction Demonstration                ##
### Demonstration - SFS                         ##  
##################################################
#                                               ##
##################################################
# Written by Peiyuan Zhou
# ID: 123456789
##################################################
### Basic Set Up                                ##
##################################################
# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

##################################################
### Install Libraries                           ##
##################################################
#If the library is not already downloaded, download it
if(!require(pastecs)){install.packages("pastecs")}
library("pastecs")

if(!require(lattice)){install.packages("lattice")}
library("lattice")


##################################################
### Load Data.                                  ##
##################################################
head(mtcars)

#lm() is the function used to fit a linear regression model in R.
#1. Start from no feature - mpg is the target and only mpg is included. 
FitStart = lm(mpg ~ 1, data=mtcars) # lm developed using one feature
FitAll = lm(mpg ~., data=mtcars) #lm developed using all features
head(mtcars)
summary(FitAll) 
summary(FitStart) 


#2. Forward / Backward Feature Selection. 
result_backward <- step(FitAll,direction = "backward")
result_forward <- step(FitStart,direction = "forward", scope=formula(FitAll))

#Stepwise Regression using the forward/backward selection method based on the initial linear regression model
#AIC is a statistical criterion that quantifies the trade-off between model fit and complexity. 
#lower AIC values indicating better-fitting models

