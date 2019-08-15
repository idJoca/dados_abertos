install.packages("plot3Drgl")
install.packages("gplots")
library("gplots")
library("plot3D")
library("plot3Drgl")
propostas_deputados = read.csv("legislatura_todas/propostas.csv")
gastos_deputados = read.csv("legislatura_todas/gastos.csv")
rowCondition <- apply(gastos_deputados[,-1],1,function(x) any(x[-length(x)] == 'Total'))
gastos <- gastos_deputados[rowCondition,]
sums.year <- aggregate(as.double(gastos$Valor),gastos["Ano"],sum)
party.cost <- aggregate(as.double(gastos$Valor),gastos["Partido"],sum)
party.propostas <- aggregate(as.double(propostas_deputados$Tramitando),propostas_deputados["Partido"],sum)
print(party.propostas)
print(party.cost)
x <- propostas_deputados$Total
y <- as.double(gastos$Valor)[0:6851]
z <- as.numeric(propostas_deputados$Ano)
fit <- lm(z ~ x + y)
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
y.pred <- seq(min(y), max(y), length.out = grid.lines)
xy <- expand.grid( x = x.pred, y = y.pred)
z.pred <- matrix(predict(fit, newdata = xy), 
                 nrow = grid.lines, ncol = grid.lines)
fitpoints <- predict(fit)
scatter3D(x, y, z, surf = list(x = x.pred, y = y.pred, z = z.pred,  
    facets = NA, fit = fitpoints))
scatter3D(x, y, z,
          theta = 180, phi = -70, pch = 18, type='p', bty='b2', colvar=z)
scatter2D(x, y, type='h')
scatter2D(party.cost$x, party.propostas$x)
text2D(party.propostas$x, party.cost$x, party.cost$Partido)
abline(lm(party.cost$x ~ party.propostas$x))
hist3D(z = table(party.propostas$x, party.cost$x))
hist(party.cost$x)
hist3D(z = table(propostas_deputados$Total, as.numeric(propostas_deputados$Ano)))
heatmap(table(propostas_deputados$Ano, propostas_deputados$Total), scale = "column")
plotrgl()