projectPCA <- function(X, ndim) {
	xm <- matrix(colMeans(X), nrow=nrow(X), ncol=ncol(X), byrow=T)
	Xtrans <- X - xm
	S <- cov(Xtrans)
	eigenS <- eigen(S)
	u <- eigenS$vectors
	maxdim <- ncol(u)
	if(ndim <= maxdim) {
		projection <- Xtrans %*% u
	}
	return(projection)
}
