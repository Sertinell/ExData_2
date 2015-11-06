library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- as.factor(NEI$type)

sccveh <- SCC$SCC[grep("(?=.*[Vv]eh)", SCC$SCC.Level.Two, perl = TRUE)]
baltimore <- filter(NEI, fips == "24510")

NEIveh <- filter(baltimore, SCC %in% sccveh)
NEIveh <- group_by(NEIveh, year)

totals <- summarise(NEIveh, totalemissions = sum(Emissions))

png("plot5.png", width = 480, height = 480)
plot(totals$year, totals$totalemissions, 
     type= "l", 
     main = "Total motor vehicle emissions per year in Baltimore", 
     xlab = "Year", ylab = "Total Emissions (ton)")
points(totals$year, totals$totalemissions)
dev.off()
