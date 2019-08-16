install.packages("plot3Drgl")
install.packages("gplots")
library("gplots")
library("plot3D")
library("plot3Drgl")

propostas = read.csv("legislatura_todas/propostas.csv")
gastos = read.csv("legislatura_todas/gastos.csv")
partys <- aggregate(as.double(gastos$Valor),gastos["Partido"],sum)
status = "Total"

plot_party <- function(party) {
    party.propostas <- propostas[propostas["Partido"] == as.character(party), ]
    party.gastos <- gastos[gastos["Partido"] == as.character(party), ]

    party.propostas <- aggregate(party.propostas[status], party.propostas["Ano"], sum)
    party.gastos <- aggregate(party.gastos["Valor"], party.gastos["Ano"], sum)
    file_path = paste("plot_party/", party, "/", sep="")
    dir.create(file_path)
    png(paste(file_path, "2dplot_", as.character(party), status, ".png", sep=""), width = 1980, height = 1080)
    text2D(party.propostas$Total, party.gastos$Valor, party.gastos$Ano,
    	 colvar=party.propostas$Ano,
    	 xlab=status, ylab="Custo",
         cex=1, main=paste("Relação Custo - ", status, " ", as.character(party), sep=""), clab="Propostas")
    abline(h=mean(party.gastos$Valor), col="blue")
    abline(v=mean(party.propostas$Total), col="red")
    legend("bottomleft",legend=c("Média custo", "Média propostas"),
       col=c("blue", "red"), lty=1, cex=1, bg="transparent")
    dev.off()
}

for (party in partys$Partido) {
    plot_party(party)
}