library(ggplot2)
data(mpg)
attach(mpg)
head(mpg)
summary(mpg)
#after analysis remove the data from the memory
detach(mpg)

library (help=datasets)
library(datasets)
head(uspop)
plot(uspop)