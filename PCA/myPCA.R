myPCA <- function(X) {
	xm <- matrix(colMeans(X), nrow=nrow(X), ncol=ncol(X), byrow=T)
	Xtrans <- X - xm
	S <- cov(Xtrans)
	eigenS <- eigen(S)
	u <- eigenS$vectors
	lambda <- eigenS$values
	return(list(u=u, lambda=lambda))
}
