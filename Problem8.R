TTM <- read.delim("/Users/sunitapattanayak/Documents/DIC/Lab1EDA/TTM.txt",header = TRUE,sep = "\t")
print(TTM)

#Load package ggplot2
library(ggplot2)

# Plot the basic frame of the stacked bar chart.
print(ggplot(data=TTM,aes(x=Type.of.Behavior,y = Sample.Size,fill=Stage.of.Change))+geom_bar(stat = "identity"))
print(ggplot(data = TTM, aes(x = Type.of.Behavior, y = Sample.Size, fill = Stage.of.Change)) + 
  geom_bar(stat="identity") + coord_flip())

# Reorder the chunks so that they represent the logical order of stage
# progression.
TTM$Stage.of.Change <- factor(TTM$Stage.of.Change, levels = c("Precontemplation", 
                                                              "Contemplation", "Preparation", "Action", "Maintenance"))

# Re-plot the chart under the newly assigned order by changing the 'fill'
# command.
print(ggplot(data = TTM, aes(x = Type.of.Behavior, y = Sample.Size, fill = factor(Stage.of.Change))) + 
  geom_bar(stat="identity") + coord_flip())

# Change the color palette so that it is easier to read.
print(ggplot(data = TTM, aes(x = Type.of.Behavior, y = Sample.Size, fill = factor(Stage.of.Change))) + 
  geom_bar(stat="identity") + coord_flip() + scale_fill_brewer(palette = 12))

# Change the labels of the plot. Done!
print(ggplot(data = TTM, aes(x = Type.of.Behavior, y = Sample.Size, fill = factor(Stage.of.Change))) + 
  geom_bar(stat="identity") + coord_flip() + scale_fill_brewer(palette = 12) + labs(title = "Figure 1  Total Sample Size and Subsamples for Each Stage for Each of the 12 Problem Behaviors", 
                                                                     y = "Sample Size", x = "Type of Behavior", fill = "Stage of Change"))