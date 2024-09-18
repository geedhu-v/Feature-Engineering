##################################################
### PROG8430                                    ##
### Data Reduction Demonstration                ##
### Demonstration                               ##  
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

##############################
## Read in Data             ##
##############################
options(digits=5)
Master <- read.csv("Data/Dimension_Reduction.csv", header = TRUE, sep = ",")
head(Master)

##############################
## Filter Feature Selection ##
##############################
# 1. Missing Values Ratio
# Find missing values
summary(Master)
#Look like X02 is likely!
ratio = sum(is.na(Master[3]))/nrow(Master[3])
ratio
Master <- Master[-c(3)]
head(Master,10)


# 2. Identify Low Variance
stat.desc(Master)  #Consider coef of var
#Based on the above X04 seem likely. Let's check!
table(Master$X04)
Master <- Master[-c(4)]
head(Master,10)


# 3.Identify High Correlation
cor(Master,method="pearson")
cor(Master,method="spearman")
#X05 and X06 seem highly correlated
#Don't need to keep both, I'll drop the second one.
Master <- Master[-c(5)]
head(Master,10)



