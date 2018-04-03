pied<-read.csv("./Genetic08.csv", header= TRUE)
pie_uni<-unique(pied$X.Sub.type)
#get( getOption( "device" ) )()
par(mar = c(2,2,2,26))
Pie_main <- read.csv("./Pie_chart_data.csv", header=TRUE)
pie(Pie_main$Number,labels = Pie_main$Number,radius= 1, col=c("orange", "yellow", "light green", "green", "dark green","red"), clockwise=TRUE,
    init.angle=-180, cex=0.75)
legend("bottom",legend= Pie_main$X.Sub.type,bty="n", cex=0.7, fill=c("orange", "yellow", "light green", "green", "dark green","red"))
par(mar = c(10,2,4,26))
title(main="Influenza Positive Specimens Reported by
    U.S. Public Health Laboratories,
    Cumulative, 2017-2018 Session",cex.main=0.75 )
par(new=T)
par(mar = c(12,8,3,6))
pied1<-pied[pied$X.Sub.type=="H3" & pied$X..of..Sub.type.Total>0,]
lbls= paste(pied1$X..of..Sub.type.Total,"%")
lbls = paste(pied1$Genetic_Group, pied1$Number, lbls, sep="\n") 
pie(pied1$X..of..Sub.type.Total,labels = lbls,radius= 1, col=heat.colors(length(lbls)), clockwise=TRUE,
    init.angle=90, main="Influenza A(H3N2)", cex=0.7, cex.main=0.75)
par(new=T)
par(mar = c(12,20,3,0))
pied2<-pied[pied$X.Sub.type=="H1pdm09" & pied$X..of..Sub.type.Total>0,]
lbls= paste(pied2$X..of..Sub.type.Total,"%")
lbls = paste(pied2$Genetic_Group, pied2$Number, lbls, sep="\n") 
pie(pied2$X..of..Sub.type.Total,labels = lbls, col=c("Orange"), clockwise=TRUE,
    init.angle=90, main="Influenza A(H1N1)pdm09", cex = 0.7, cex.main = 0.75)
par(new=T)
par(mar = c(2,8,13,6))
pied3<-pied[pied$X.Sub.type=="B/Victoria",]
lbls= paste(pied3$X..of..Sub.type.Total,"%")
lbls = paste(pied3$Genetic_Group, pied3$Number, lbls, sep="\n") 
pie(pied3$X..of..Sub.type.Total,labels = lbls, col=terrain.colors(length(lbls)), clockwise=TRUE,
        init.angle=90,cex = 0.7)
par(mar = c(5,8,23,6))
title( main="Influenza B Victoria",cex.main = 0.75)
par(new=T)
par(mar = c(2,20,13,0))
pied4<-pied[pied$X.Sub.type=="B/Yamagata",]
lbls= paste(pied4$X..of..Sub.type.Total,"%")
lbls = paste(pied4$Genetic_Group, pied4$Number, lbls, sep="\n") 
pie(pied4$X..of..Sub.type.Total,labels = lbls, col=terrain.colors(length(lbls)), clockwise=TRUE,
        init.angle=90, cex = 0.7)
par(mar = c(5,20,23,0))
title( main="Influenza B Yamagata",cex.main = 0.75)

