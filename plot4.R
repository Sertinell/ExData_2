library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI$type <- as.factor(NEI$type)
#get all the SCC codes related to coal combustion
scccoal <- SCC$SCC[grep("(?=.*[Cc]omb)(?=.*[Cc]oal)", SCC$Short.Name, perl = TRUE)]

#fileter out all the SCC not included in scccoal
NEIcoal <- filter(NEI, SCC %in% scccoal)
#group by year
NEIcoalbyyear <- group_by(NEIcoal, year)
#summarise
NEIcoalbyyear <- summarise(NEIcoalbyyear, totalemision = sum(Emissions))

png("plot4.png", width = 480, height = 480)
plot(NEIcoalbyyear$year, NEIcoalbyyear$totalemision, 
     type= "l", 
     main = "Total carbon combustion emissions per year across the States", 
     xlab = "Year", ylab = "Total Emissions (ton)")
points(totals$year, totals$totalemi)
dev.off()
