install.packages("plot3Drgl")
install.packages("gplots")
library("gplots")
library("plot3D")
library("plot3Drgl")

propostas_deputados = read.csv("legislatura_todas/propostas.csv")
gastos_deputados = read.csv("legislatura_todas/gastos.csv")
rowCondition <- apply(gastos_deputados[,-1],1,function(x) any(x[-length(x)] == 'Total'))
gastos <- gastos_deputados[rowCondition,]
status = c(colnames(propostas_deputados))[2:6]

print_plot <- function(year, stat) {
    single_year_gastos <- gastos$Ano == year
    single_year_propostas <- propostas_deputados$Ano == year
    
    party.cost <- aggregate(as.double(gastos[single_year_gastos,"Valor"]),gastos[single_year_gastos,]["Partido"],sum)
    party.propostas <- aggregate(as.double(propostas_deputados[single_year_propostas, stat]),
                                 propostas_deputados[single_year_propostas,]["Partido"],sum)
    
    party.propostas <- party.propostas[party.propostas["Partido"] != "", ]
    party.cost <- party.cost[party.cost["Partido"] != "", ]
    folder_name = paste("plot_party/", year, "/", sep="")

    pdf(paste(folder_name, "2dplot_", year, stat, ".pdf", sep=""))
    text2D(party.propostas$x, party.cost$x, party.cost$Partido,
    	   colvar=party.propostas$x,
    	   xlab=stat, ylab="Custo",
           cex=1, main=paste("Relação Custo - ", stat,  "p/ partido", as.character(year)), clab="Propostas")
    abline(lm(party.cost$x ~ party.propostas$x), col="green")
    abline(h=mean(party.cost$x), col="blue")
    abline(v=mean(party.propostas$x), col="red")
    legend("bottomright",legend=c("custo-proposta", "Média custo", "Média propostas"),
       col=c("green", "blue", "red"), lty=1, cex=1, bg="transparent")
    dev.off()
}
for (stat in status) {
    years <- seq(2007, 2019, 1)
    for (year in years) {
       print_plot(year, stat)
}
}
