library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIbyyear <- group_by(NEI, year)
totals <- summarise(NEIbyyear, totalemi = sum(Emissions))

png("plot1.png", width = 480, height = 480)
plot(totals$year, totals$totalemi, 
     type= "l", 
     main = "Total emissions per year", 
     xlab = "Year", ylab = "Total Emissions (ton)")
points(totals$year, totals$totalemi)
dev.off()

