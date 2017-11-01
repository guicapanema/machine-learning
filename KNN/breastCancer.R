rm(list=ls())
source('./myKMN.r')
library(mlbench)

data(BreastCancer)

dataset <- na.omit(BreastCancer)
X <- data.matrix(dataset[,2:10])
benignIndexes <- (dataset$Class == 'benign')
malignantIndexes <- (dataset$Class == 'malignant')

# Separating training, validation and test sets
swap <- sample(1:nrow(X))
attributes <- data.matrix(X[swap,])
classes <- dataset$Class[swap]

trainLim <- 0.5*nrow(attributes)
valLim <- 0.7*nrow(attributes)

training <- list(Attributes=attributes[1:trainLim,], Classes=classes[1:(trainLim)])
validation <- list(Attributes=attributes[(trainLim+1):valLim,], Classes=classes[(trainLim+1):valLim])
test <- list(Attributes=attributes[(valLim+1):nrow(attributes),], Classes=classes[(valLim+1):nrow(attributes)])

# Keyfold Crossvalidation
nTrain <- nrow(training$Attributes)

myKeyfold <- function(data) {
  attributes <- data$Attributes
  classes <- data$Classes
  
  nSamples <- nrow(attributes)
  groupSize <- nSamples / 10
    
  groups <- list()
  
  for (i in 1:10) {  
    groups[[i]] <- list(Attributes <- attributes[(groupSize*(i-1)+1):(groupSize*i),], 
                        Classes <- classes[(groupSize*(i-1)+1):(groupSize*i)])
  }
  return(groups)
}

groups <- list(g1=training)