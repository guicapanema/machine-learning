rm(list=ls())
source('myPCA.R')
source('mySVM.R')
source('projectPCA.R')
library(mlbench)
library(plot3D)

data(USArrests)

X <- data.matrix(USArrests)

# Apply PCA
pca <- myPCA(X)
plot(seq(from=1, to=ncol(X), by=1), pca$lambda, type='b', xlab='Eixo PCA', ylab='Autovalor')

# Plot 2D PCA space
proj2D <- projectPCA(X, 2)

xlim <- c(-15,5)
ylim <- c(-8, 6)
plot(proj2D[,1], proj2D[,2], xlab='PCA1', ylab='PCA2', col='red')

# Plot 3D PCA space
proj3D <- projectPCA(X, 3)

points3D(proj3D[,1], proj3D[,2], proj3D[,3], colvar=NULL, colkey=FALSE, xlab='PCA1', ylab='PCA2', zlab='PCA3')
