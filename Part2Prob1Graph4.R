# Plot the 3rd graph. : Mortality
df <- read.csv("./NCHSData08.csv")
df<- df[df$Year>2013|(df$Year==2013 & df$Week>=40)|(df$Year==2018 & df$Week<5),]
df$Week1<-ifelse((df$Week<10), paste("0",df$Week,sep=""), df$Week)

df$Week1<- paste(df$Year, df$Week1,sep = "")

#Extract columns that is required
df <- subset(df, select = c('Year','Week','Week1','Percent.of.Deaths.Due.to.Pneumonia.and.Influenza','Expected','Threshold'))
#load package plotly
plot(df$Week1, df$Expected,type='n',axes=FALSE,ylim=range(1:30))
lines(x=df$Week1, y=df$Expected)
library(plotly)
p <- plot_ly(df, showlegend = FALSE, width = 625, height = 350) %>%
  add_trace(x = ~ Week1, y = ~ Percent.of.Deaths.Due.to.Pneumonia.and.Influenza, 
            type = 'scatter', mode = 'lines', line = list(color = 'red'))  %>%
  add_trace(x = ~ Week1, y = ~ Expected, type = 'scatter', mode = 'lines', line = list(color = 'black'))  %>%
  add_trace(x = ~ Week1, 
            y = ~ Threshold, type = 'scatter', mode = 'lines', line = list(color = 'black')) %>%
  layout(
    title="Pneumonia and Influenza Mortality from
      the National Center for Health Statistics Mortality Survelliance System",
    xaxis = list(title = "MMWR Week",showline = TRUE,gridwidth = 0, showgrid = FALSE, tickangle = 45,labels=df$Week),
    yaxis=list(title="% of All Deaths due to P&I",showline = TRUE,showgrid = FALSE)
  )
print(p)