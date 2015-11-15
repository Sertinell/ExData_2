library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Convert the type column to a factor
NEI$type <- as.factor(NEI$type)

#filter baltimore data
baltimore <- filter(NEI, fips == "24510")
#group by year and type
baltbyyt <- group_by(baltimore, year, type)

#summarise
totals <- summarise(baltbyyt, totals = sum(Emissions))

#plot the results with facets based on type
png("plot3.png", width = 960, height = 480)
ggplot(totals, aes(x=year, y=totals))+
  geom_line()+
  geom_point()+
  facet_grid(.~type)+
  ggtitle("Baltimore emissions by type")
dev.off()

