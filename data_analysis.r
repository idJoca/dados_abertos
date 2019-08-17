install.packages("plot3Drgl")
install.packages("gplots")
install.packages("abjutils")

library(abjutils)
library("gplots")
library("plot3D")
library("plot3Drgl")
getwd()
propostas_deputados = read.csv("../../../dados_abertos-master/legislatura_todas/propostas.csv")

gastos_deputados = read.csv("../../../dados_abertos-master/legislatura_todas/gastos.csv")
rowCondition <- apply(gastos_deputados[,-1],1,function(x) any(x[-length(x)] == 'Total'))
single_year <- apply(gastos_deputados,1,function(x) x["Ano"] == 2009)
gastos <- gastos_deputados[rowCondition,]
sums.year <- aggregate(as.double(gastos$Valor),gastos["Ano"],sum)
party.cost <- aggregate(as.double(gastos[single_year,]$Valor),gastos[single_year,]["Partido"],sum)
party.propostas <- aggregate(as.double(propostas_deputados[single_year,]$Tramitando),propostas_deputados[single_year,]["Partido"],sum)
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
          theta = 90, phi = -60, pch = 18, type='p', bty='b2',
	    colvar=z, xlab="Nr. Propostas", ylab="Gastos", zlab="Anos")
scatter2D(x, y, type='h')
scatter2D(party.cost$x, party.propostas$x)
text2D(party.propostas$x, party.cost$x, party.cost$Partido,
	 colvar=party.propostas$x,
	 xlab="Nr. Propostas", ylab="Gastos Partido",
     cex=0.7)
text3D(x, y, z, rm_accent(propostas_deputados$Nome), cex=0.5,
	          theta = 90, phi = -60, pch = 18, type='p', bty='b2',
	    colvar=z, xlab="Nr. Propostas", ylab="Gastos", zlab="Anos")
 plotdev(xlim = c(0, 10), ylim = c(40, 150), 
         zlim = c(7, 25))
abline(lm(party.cost$x ~ party.propostas$x), col="green")
abline(h=mean(party.cost$x), col="blue")
abline(v=mean(party.propostas$x), col="red")
hist3D(z = table(party.propostas$x, party.cost$x))
hist(party.cost$x)
hist3D(z = table(propostas_deputados$Total, as.numeric(propostas_deputados$Ano)),
	 theta = 90, phi = 60)
heatmap(table(propostas_deputados$Ano, propostas_deputados$Total), scale = "column")
plotrgl()