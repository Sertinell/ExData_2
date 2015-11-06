library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- as.factor(NEI$type)

baltimore <- filter(NEI, fips == "24510")
baltbyyt <- group_by(baltimore, year, type)

totals <- summarise(baltbyyt, totals = sum(Emissions))

png("plot3.png", width = 960, height = 480)
ggplot(totals, aes(x=year, y=totals))+
  geom_line()+
  geom_point()+
  facet_grid(.~type)
dev.off()

