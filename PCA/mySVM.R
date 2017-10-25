mySVM <- function(training, validation, paramLimits) {
	
	if (!require(e1071)) {
		stop('the package e1071 is required')
	}
	
	interval <- seq(from=paramLimits[1], to=paramLimits[2], by=0.1)
	grid <- expand.grid(interval,interval)
	
	accuracies <- rep(0, nrow(grid))
	for(i in 1:nrow(grid)) {
		
		svm.model <- svm(x=training$Attributes, y=training$Classes, cost=grid[i,1], gamma=grid[i,2])
		
		svm.pred = predict(svm.model, validation$Attributes)
	    
		errors = sum(svm.pred != validation$Classes)
		accuracies[i] = 1 - (errors/length(validation$Classes))
	}
	bestParams <- grid[which.max(accuracies),]
	svm.model <- svm(x=training$Attributes, y=training$Classes, cost=bestParams[1], gamma=bestParams[2])

	return(svm.model)
}
