rm(list=ls())
source('myPCA.R')
source('mySVM.R')
source('projectPCA.R')
library(mlbench)
library(plot3D)

data(BreastCancer)

dataset <- na.omit(BreastCancer)
X <- data.matrix(dataset[,2:10])
benignIndexes <- (dataset$Class == 'benign')
malignantIndexes <- (dataset$Class == 'malignant')

# Apply PCA
pca <- myPCA(X)
plot(seq(from=1, to=ncol(X), by=1), pca$lambda, type='b', xlab='Eixo PCA', ylab='Autovalor')

# Plot 2D PCA space
proj2D <- projectPCA(X, 2)

xlim <- c(-15,5)
ylim <- c(-8, 6)
plot(proj2D[benignIndexes,1], proj2D[benignIndexes,2], xlim=xlim, ylim=ylim, xlab='PCA1', ylab='PCA2', col='red')
par(new=T)
plot(proj2D[malignantIndexes,1], proj2D[malignantIndexes,2], xlim=xlim, ylim=ylim, xlab='PCA1', ylab='PCA2', col='blue')

# Plot 3D PCA space
proj3D <- projectPCA(X, 3)

colvar <- rep(1, nrow(X))
colvar[malignantIndexes] <- 4
points3D(proj3D[,1], proj3D[,2], proj3D[,3], colvar=colvar, colkey=FALSE, xlab='PCA1', ylab='PCA2', zlab='PCA3')


# Separating training, validation and test sets
swap <- sample(1:nrow(X))
attributes <- data.matrix(X[swap,])
classes <- dataset$Class[swap]

trainLim <- 0.5*nrow(attributes)
valLim <- 0.7*nrow(attributes)

# Calculating total SVM
training <- list(Attributes=attributes[1:trainLim,], Classes=classes[1:(trainLim)])
validation <- list(Attributes=attributes[(trainLim+1):valLim,], Classes=classes[(trainLim+1):valLim])
test <- list(Attributes=attributes[(valLim+1):nrow(attributes),], Classes=classes[(valLim+1):nrow(attributes)])

model <- mySVM(training, validation, c(0.1,2))
pred <- predict(model, test$Attributes)
err <- sum(pred != test$Classes)
acc <- 1 - err/length(pred)
print(acc)

# Calculating 2D SVM
attributes = proj2D[swap,]
training <- list(Attributes=attributes[1:trainLim,], Classes=classes[1:trainLim])
validation <- list(Attributes=attributes[(trainLim+1):valLim,], Classes=classes[(trainLim+1):valLim])
test <- list(Attributes=attributes[(valLim+1):nrow(attributes),], Classes=classes[(valLim+1):nrow(attributes)])

model2D <- mySVM(training, validation, c(0.1,2))
pred2D <- predict(model2D, test$Attributes)
err2D <- sum(pred2D != test$Classes)
acc2D <- 1 - err2D/length(pred2D)
print(acc2D)

# Calculating 3D SVM
attributes = proj3D[swap,]
training <- list(Attributes=attributes[1:trainLim,], Classes=classes[1:trainLim])
validation <- list(Attributes=attributes[(trainLim+1):valLim,], Classes=classes[(trainLim+1):valLim])
test <- list(Attributes=attributes[(valLim+1):nrow(attributes),], Classes=classes[(valLim+1):nrow(attributes)])

model3D <- mySVM(training, validation, c(0.1,2))
pred3D <- predict(model3D, test$Attributes)
err3D <- sum(pred3D != test$Classes)
acc3D <- 1 - err3D/length(pred3D)
print(acc3D)

