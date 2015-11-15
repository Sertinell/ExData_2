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
#filter Baltimore and Los Angeles data
batlang <- filter(NEI, fips == "24510" | fips == "06037")

batlang$city <- as.factor(batlang$fips)
levels(batlang$city) <- c("Los Angeles", "Baltimore")

#Filter out not vehicle data
NEIveh <- filter(batlang, SCC %in% sccveh)
#Group by year
NEIveh <- group_by(NEIveh, year, city)
#summarise
totals <- summarise(NEIveh, totalemissions = sum(Emissions))

#plot
png("plot6.png", width = 480, height = 480)
ggplot(totals, aes(x = year, y = totalemissions, colour = city)) + 
  geom_line() + geom_point() +
  ggtitle("Motor vehicles emissions in Baltimore and Los Angeles")
dev.off()
