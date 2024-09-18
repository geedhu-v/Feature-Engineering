##################################################
### RStudio - Test Run                          ## 
##################################################
# Written by Peiyuan Zhou
# ID: 1234567

##################################################
### Basic Set Up                                ##
##################################################
# Clear all plots
if(!is.null(dev.list())) dev.off()
# Clear entire console
cat("\014") 
# Clean and clear the workspace
rm(list=ls())
options(scipen=9)

################################
# Original image
################################
mnist <- read.csv("C:/Users/Geedhu/Documents/Maths _ Data Analysys/Week 5_Feature Engineering/mnist.csv")
head(mnist)
#extra the pixel values fort he first image
image_pixels <-mnist[3,-1]#first row excepting the first column
image_pixels <- as.numeric(ifelse(is.na(image_pixels),0,image_pixels)) 
#reshape the pixel values into a matrix
image_matrix <- matrix(image_pixels, nrow = 28, ncol=28)
image_matrix <- as.matrix(image_matrix)
image_matrix
image_matrix <- aperm(image_matrix,c(2,1))
image_matrix
image(image_matrix, axes=FALSE, rotate=90,col=gray((0:255)/255))

#Apply PCA
library(datasets)
library(ggplot2)

########################################################
##  Implement PCA without using built-in functions    ##
########################################################
#Step 1: Standardize the data
data <- mnist[,-1]
mean_vals <- colMeans(data)
data_sdn <- data - mean_vals

#Step 2: Compute the covariance matrix 
cov_matrix <- cov(data_sdn)

#Step 3: Perform eigenvalue decomposition
eigen_result <- eigen(cov_matrix)
eigenvalues  <- eigen_result$values
eigenvectors <- eigen_result$vectors
#Eigenvectors are actually the loadings which are the correlation 
#between the principal components and the regional variables. 

#Step 4: Sort eigenvectors by eigenvalues
#Select desired number of principal components
components <- 50 # Number of principal components to retain
selected_eigenvectors <- eigenvectors[, 1:components]

#Step 5: reconstruct the image
#Transform the data
scores <- as.matrix(data_sdn) %*% as.matrix(selected_eigenvectors)
#Reconstruction
reconstructed_image <- scores %*% t(selected_eigenvectors)+mean_vals
recon_image <- reconstructed_image[1,]
recon_image<- matrix(recon_image, ncol = 28)
recon_image <- aperm(recon_image,c(2,1))
image(as.matrix(recon_image), axes=FALSE, col=gray((0:255)/255))


########################################################
##                 Use prcomp() function              ##
########################################################
#use prcomp function to get the result of pca.
dim(data)
pca_result <- prcomp(data)
dim(pca_result$x)
principal_components <- pca_result$x  # Principal components (transformed data)
standard_deviations <- pca_result$sdev  # Standard deviations of the principal components
rotation_matrix <- pca_result$rotation  # Rotation matrix (eigenvectors)
length(pca_result$sdev)
#get the score of pca
scores <- predict(pca_result)
components <- 50
selected_components <- pca_result$rotation[,1:components]
selected_components

#reconstruct the image
#Transform the data
scores <- as.matrix(data) %*% as.matrix(selected_components)
#Reconstruction
mean_vals <- colMeans(data)
reconstructed_image <- scores %*% t(selected_components)
#reconstructed_image <- scores %*% t(selected_components)+mean_vals
recon_image <- reconstructed_image[1,]
recon_image<- matrix(recon_image, ncol = 28)
recon_image <- aperm(recon_image,c(2,1))
image(as.matrix(recon_image), axes=FALSE, col=gray((0:255)/255))

