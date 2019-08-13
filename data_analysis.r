install.packages("plot3Drgl")
library("plot3D")
person_status = read.csv("legislatura_2019/person_status_qntd_2019.csv")
person_status2 = read.csv("legislatura_2018/person_status_qntd_2018.csv")
person_status3 = read.csv("legislatura_2017/person_status_qntd_2017.csv")
person_status4 = read.csv("legislatura_2016/person_status_qntd_2016.csv")
person_status5 = read.csv("legislatura_2015/person_status_qntd_2015.csv")
person_status6 = read.csv("legislatura_2014/person_status_qntd_2014.csv")
person_status7 = read.csv("legislatura_2013/person_status_qntd_2013.csv")
person_status8 = read.csv("legislatura_2012/person_status_qntd_2012.csv")
person_status9 = read.csv("legislatura_2011/person_status_qntd_2011.csv")
person_status10 = read.csv("legislatura_2010/person_status_qntd_2010.csv")
person_status11 = read.csv("legislatura_2009/person_status_qntd_2009.csv")
person_status12= read.csv("legislatura_2008/person_status_qntd_2008.csv")
person_status13 = read.csv("legislatura_2007/person_status_qntd_2007.csv")
gastos_deputados = read.csv("legislatura_2019/gastos_deputados_2019.csv")
gastos_deputados2 = read.csv("legislatura_2018/gastos_deputados_2018.csv")
gastos_deputados3 = read.csv("legislatura_2017/gastos_deputados_2017.csv")
gastos_deputados4 = read.csv("legislatura_2016/gastos_deputados_2016.csv")
gastos_deputados5 = read.csv("legislatura_2015/gastos_deputados_2015.csv")
gastos_deputados6 = read.csv("legislatura_2014/gastos_deputados_2014.csv")
gastos_deputados7 = read.csv("legislatura_2013/gastos_deputados_2013.csv")
gastos_deputados8 = read.csv("legislatura_2012/gastos_deputados_2012.csv")
gastos_deputados9 = read.csv("legislatura_2011/gastos_deputados_2011.csv")
gastos_deputados10 = read.csv("legislatura_2010/gastos_deputados_2010.csv")
gastos_deputados11 = read.csv("legislatura_2009/gastos_deputados_2009.csv")
gastos_deputados12= read.csv("legislatura_2008/gastos_deputados_2008.csv")
gastos_deputados13 = read.csv("legislatura_2007/gastos_deputados_2007.csv")
data(iris)
data(iris)
print(gastos_deputados$Valor)
rowCondition <- apply(gastos_deputados[,-1],1,function(x) any(x[-length(x)] == 'Total'))

library("plot3Drgl")
x <- rbind(person_status$Total, person_status2$Total,
           person_status3$Total, person_status4$Total,
           person_status5$Total, person_status6$Total,
           person_status7$Total, person_status8$Total,
           person_status9$Total, person_status10$Total,
           person_status11$Total, person_status12$Total,
           person_status13$Total)
y <- rbind(gastos_deputados$Arquivados, gastos_deputados2$Arquivados,
           gastos_deputados3$Arquivados, gastos_deputados4$Arquivados,
           gastos_deputados5$Arquivados, gastos_deputados6$Arquivados,
           gastos_deputados7$Arquivados, gastos_deputados8$Arquivados,
           gastos_deputados9$Arquivados, gastos_deputados10$Arquivados,
           gastos_deputados11$Arquivados, gastos_deputados12$Arquivados,
           gastos_deputados13$Arquivados)
z <- rep(c(2007:2019), times = c(nrow(person_status), nrow(person_status2),
                                         nrow(person_status3), nrow(person_status4),
                                         nrow(person_status5), nrow(person_status6),
                                         nrow(person_status7), nrow(person_status8),
                                         nrow(person_status9), nrow(person_status10),
                                         nrow(person_status11), nrow(person_status12),
                                         nrow(person_status13)))
grid.lines = 26
fit <- lm(z ~ x + y)
x.pred <- seq(min(x), max(x), length.out = grid.lines)
y.pred <- seq(min(y), max(y), length.out = grid.lines)
xy <- expand.grid( x = x.pred, y = y.pred)
z.pred <- matrix(predict(fit, newdata = xy), 
                 nrow = grid.lines, ncol = grid.lines)
# fitted points for droplines to surface
fitpoints <- predict(fit)
print(Labels)
scatter3D(x, y, z, theta = 0, phi = -70, pch = 18, type='p', bty='b2', labels=Labels)
plotrgl()
head(person_status)
print(person_status$Arquivados[1])
frequencies <- table(person_status$Arquivados, person_status$Retirados, person_status$Arquivados, person_status$Total)
plot(person_status[, -1])