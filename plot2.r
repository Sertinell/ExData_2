library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- filter(NEI, fips == "24510")
baltbyyear <- group_by(baltimore, year)
totals <- summarise(baltbyyear, totalemi = sum(Emissions))

png("plot2.png", width = 480, height = 480)
plot(totals$year, totals$totalemi, 
     type= "l", 
     main = "Total emissions per year", 
     xlab = "Year", ylab = "Total Emissions (ton)")
points(totals$year, totals$totalemi)
dev.off()
