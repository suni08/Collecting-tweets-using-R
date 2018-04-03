# Plot the 2nd graph. : Positive tested
data1 <- read.csv("./WHO_NREVSS_Public_Health_Labs.csv",skip=1)
data1<-data1[data1$YEAR<2018|(data1$YEAR==2018 & data1$WEEK<5),]
data1$WEEK1<-ifelse((data1$WEEK<10), paste("0",data1$WEEK,sep=""), data1$WEEK)

data1$WEEK1<- paste(data1$YEAR, data1$WEEK1,sep = "")

#Load package ggplot2
library(ggplot2)

#Extract columns that is required
data1 <- subset(data1, select = c('WEEK1','A..Subtyping.not.Performed.', 'A..2009.H1N1.', 'A..H3.','H3N2v','B','BVic','BYam'))

#Find transpose for stacked bar chart 
library(reshape)
d <- melt(data1, id=c("WEEK1"))

p  <-   ggplot(d)+
  geom_bar(data=d,aes(x=WEEK1,y = value, fill=variable),stat = "identity") + 
  scale_fill_manual(values = c("A..Subtyping.not.Performed." = "yellow", "A..2009.H1N1." = "orange", "A..H3." ="red", "H3N2v" ="violet", "B" ="dark green", "BVic" ="green", "BYam" ="light green")) +
  scale_y_continuous(limits = c(0,5000), expand = c(0, 0)) + 
  scale_x_discrete(limits=c("201740","201741","201742","201743","201744","201745","201746","201747","201748","201749","201750","201751","201752","201801","201802","201803","201804","201805","201806","20807","201808","201809","201810","201811","201812","201813","201814","201815","201816","201817","201818","201819","201820"),breaks=c("201740","201742","201744","201746","201748","201750","201752","201802","201804","201806","201808","201810","201812","201814","201816","201818","201820"))+
  theme_classic() + 
  theme(axis.text.x = element_text(angle=45,hjust=1)) +
  ggtitle("Influenza Positive Tests Reported to CDC by Public Health Laboratories, National Summary,\n2017-18 Season, week ending Jan 27, 2018") +
  labs(y="Number of positive specimens", x = "Week") 
print(p)

