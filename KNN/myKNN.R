euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))

myKNN <- function(amostra, dados, rotulos, K) {

	distancias = apply(dados, 1, euc.dist, amostra)
	vizinhos = order(distancias)[1:K]

	if (sum(rotulos[vizinhos]==1) > sum(rotulos[vizinhos]==-1)) {
		classe = 1
	} else {
		classe = -1
	}
	return(classe)
}

