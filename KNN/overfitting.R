source('./myKNN.r')
# Gera os dados sintéticos
media1 = 2
sigma1 = 1
xClasse1 = rnorm(n=50, media1, sigma1)
yClasse1 = rnorm(n=50, media1, sigma1)
classe1 = cbind(xClasse1, yClasse1)
rotulos1 = rep(-1, nrow(classe1))

media2 = 4
sigma2 = 1
xClasse2 = rnorm(n=50, media2, sigma2)
yClasse2 = rnorm(n=50, media2, sigma2)
classe2 = cbind(xClasse2, yClasse2)
rotulos2 = rep(1, nrow(classe2))

dados = rbind(classe1, classe2)
rotulos = c(rotulos1, rotulos2)

# Plotando os dados
xlim=c(-3,8)
ylim=c(-3,8)

plot(classe1[,1], classe1[,2], xlim=xlim, ylim=ylim, xlab='x1', ylab='x2')
par(new=T)
plot(classe2[,1], classe2[,2], xlim=xlim, ylim=ylim, col='red', xlab='x1', ylab='x2')

# Classificador

# Plotando a separacao
K = 2
intervalo = seq(from=-3,to=8,by=0.2)
grid = expand.grid(intervalo,intervalo)

results = apply(grid, 1, myKNN, dados, rotulos, K)
z = matrix(results, ncol=length(intervalo), nrow=length(intervalo))


par(new=T)
contour(intervalo, intervalo, z, xlim=xlim, ylim=ylim, drawlabels=F, nlevels=1)

