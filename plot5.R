library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- as.factor(NEI$type)

#Looking for motor vehicles, filtering by "Veh" in the SCC.Level.Two 
# column seems to be a good option
unique(SCC$SCC.Level.Two[
  grep("(?=.*[Vv]eh)", SCC$SCC.Level.Two, perl = TRUE)])
#Get all the codes whose 
sccveh <- SCC$SCC[grep("(?=.*[Vv]eh)", SCC$SCC.Level.Two, perl = TRUE)]
#filter baltimore data
baltimore <- filter(NEI, fips == "24510")

#Filter out not vehicle data
NEIveh <- filter(baltimore, SCC %in% sccveh)
#Group by year
NEIveh <- group_by(NEIveh, year)
#summarise
totals <- summarise(NEIveh, totalemissions = sum(Emissions))

#plot
png("plot5.png", width = 480, height = 480)
plot(totals$year, totals$totalemissions, 
     type= "l", 
     main = "Total motor vehicle emissions per year in Baltimore", 
     xlab = "Year", ylab = "Total Emissions (ton)")
points(totals$year, totals$totalemissions)
dev.off()
