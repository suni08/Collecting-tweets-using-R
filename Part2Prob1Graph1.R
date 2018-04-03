# Plot the 1st graph. : Influenza
data1<-read.csv("./WHO_NREVSS_Clinical_Labs.csv", header= TRUE, skip = 1)
data1<-data1[data1$YEAR<2018|(data1$YEAR==2018 & data1$WEEK<5),]
data1$WEEK1<-ifelse((data1$WEEK<10), paste("0",data1$WEEK,sep=""), data1$WEEK)

data1$WEEK1<- paste(data1$YEAR, data1$WEEK1,sep = "")
library(reshape)
data2<- subset(data1, select=c('WEEK1','TOTAL.A','TOTAL.B','PERCENT.A','PERCENT.B','PERCENT.POSITIVE','TOTAL.SPECIMENS'))
data2<- melt(data2, id=c("WEEK1","PERCENT.A","PERCENT.B","PERCENT.POSITIVE",'TOTAL.SPECIMENS'))


library(ggplot2)
p1<-ggplot(data2) +
  geom_bar(aes(x = WEEK1, y =value,fill = variable),stat = "identity")+
  scale_fill_manual(values = c("TOTAL.A" = "yellow", "TOTAL.B" = "green"))+
  geom_point(aes(x=WEEK1, y=PERCENT.POSITIVE*22000/32,group=1), stat = "identity")+
  geom_line(aes(x=WEEK1, y=PERCENT.POSITIVE*22000/32,group=1,linetype="Percent positive",color="Percent positive"),stat = "identity")+
  scale_y_continuous(position="left",sec.axis = sec_axis(~./22000*32,name="Percent Positive"),limits = c(0,22000), expand = c(0, 0))+
  geom_point(aes(x=WEEK1, y=PERCENT.A*22000/32,group=1), stat = "identity")+
  geom_line(aes(x=WEEK1, y=PERCENT.A*22000/32,group=1,linetype="Percent A",color="Percent A"), stat = "identity")+
  geom_point(aes(x=WEEK1, y=PERCENT.B*22000/32,group=1), stat = "identity")+
  geom_line(aes(x=WEEK1, y=PERCENT.B*22000/32,group=1,linetype="Percent B",color="Percent B"), stat = "identity")+
  scale_x_discrete(limits=c("201740","201741","201742","201743","201744","201745","201746","201747","201748","201749","201750","201751","201752","201801","201802","201803","201804","201805","201806","20807","201808","201809","201810","201811","201812","201813","201814","201815","201816","201817","201818","201819","201820"),breaks=c("201740","201742","201744","201746","201748","201750","201752","201802","201804","201806","201808","201810","201812","201814","201816","201818"))+
  theme_classic() + theme(axis.text.x = element_text(angle=45,hjust=1)) +
  ggtitle("Influenza Positive Tests Reported to CDC by Clinical Laboratories, National Summary,\n2017-18 Season, week ending Jan 27, 2018") +
  labs(y="Number of positive specimens", x = "Week") +
  scale_linetype_manual(name="Point plot",values= c('solid', 'twodash', 'dotdash'))+
  scale_colour_manual(name="Line plot",values = c("blue", "green","red"))
print(p1)