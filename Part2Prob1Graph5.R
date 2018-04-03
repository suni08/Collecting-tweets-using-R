# Plot the 5th graph. : HeatMap
hm<- read.csv("./StateDatabyWeekforMap_2017-18week3-4.csv", header= TRUE)

hm$region <- tolower(hm$STATENAME)

library(ggplot2)
library(maps)
state<-map_data("state")

hm$coln<- paste(hm$ACTIVITY.LEVEL.LABEL,hm$ACTIVITY.LEVEL, sep=" ")

library(stringr)
b<-str_split_fixed(hm$ACTIVITY.LEVEL, " ", 2)
hm$count<-as.numeric(b[,2])
sim_data_geo <- merge(state, hm, by="region",all.x=T)

my_palette <- colorRampPalette(c("green", "yellow", "red"))(n = 299)


print(ggplot(sim_data_geo, aes(x=long,y=lat,group=group))+
          geom_polygon(aes(fill=sim_data_geo$count))+
          geom_path()+ 
          ggtitle("2017-18 Influenza Season Week 4 ending Jan 27, 2018") +
          scale_fill_gradientn(colours=my_palette,na.value="transparent",name="ILI Activity Level"))

        

