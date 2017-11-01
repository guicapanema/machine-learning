library(mlbench)
source('./myKNN.r')
# Gera os dados sintéticos

data <- mlbench.spirals(300,1,0.05)

classe1 <- data$x[data$classes==1,]
classe2 <- data$x[data$classes==2,]
dados <- data$x
dados[dados==2] <- -1
rotulos <- data$classes

# Plotando os dados
xlim <- c(-2,2)
ylim <- xlim

plot(classe1[,1], classe1[,2], xlim=xlim, ylim=ylim, xlab='x1', ylab='x2')
par(new=T)
plot(classe2[,1], classe2[,2], xlim=xlim, ylim=ylim, col='red', xlab='x1', ylab='x2')

# Classificador

# Plotando a separacao
K = 20
intervalo = seq(from=xlim[1],to=xlim[2],by=0.05)
grid = expand.grid(intervalo,intervalo)

results = apply(grid, 1, myKNN, dados, rotulos, K)
z = matrix(results, ncol=length(intervalo), nrow=length(intervalo))


par(new=T)
contour(intervalo, intervalo, z, xlim=xlim, ylim=ylim, drawlabels=F, nlevels=1)

