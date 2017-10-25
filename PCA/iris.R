rm(list=ls())
source('myPCA.R')
source('projectPCA.R')
data(iris)
X <- as.matrix(iris[,1:4])

# Apply PCA
pca <- myPCA(X)
plot(c(1,2,3,4), pca$lambda, type='b', xlab='Eixo PCA', ylab='Autovalor')

# 2D plot
proj2D <- projectPCA(X, 2)
plot(proj2D[,1], proj2D[,2], xlim=c(-4,4), ylim=c(-2,2), xlab='PCA1', ylab='PCA2')
