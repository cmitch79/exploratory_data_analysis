##  Exploratory Data Analysis Course Project 2
##  Plotting the National Emissions Inventory (NEI) Data

## PLOT 6:  Compare emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle
## sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

## Read data into R

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
message("read complete")

## Subset NEI to Baltimore City and SCC to Onroad and aggregate emissions by year

SCCOnroad <- SCC[SCC$Data.Category == "Onroad", ]
NEIfipsbalt <- NEI[NEI$fips == "24510", ]
NEIfipsLA <- NEI[NEI$fips == "06037", ]
NEIbaltonroad <- join(x = SCCOnroad, y = NEIfipsbalt, by = "SCC")
NEILAonroad <- join(x = SCCOnroad, y = NEIfipsLA, by = "SCC")
AggNEIbalt <- aggregate(Emissions ~ year, data = NEIbaltonroad, FUN = sum)
AggNEILA <- aggregate(Emissions ~ year, data = NEILAonroad, FUN = sum)

## Plot Onroad Emissions in Baltimore City by Year

png(filename="plot6.png", width = 1000, height = 480)

par(mfrow=c(1,2))
barplot(AggNEIbalt$Emissions, main = expression('Total Baltimore PM' [2.5] ~ ' Onroad Emissions by Year'), names.arg = AggNEIbalt$year,
     col = "red", ylab= expression('PM ' [2.5] ~ '(tons)'), 
     xlab="Year")
barplot(AggNEILA$Emissions, main = expression('Total LA County PM' [2.5] ~ ' Onroad Emissions by Year'), names.arg = AggNEILA$year,
     ylab= expression('PM ' [2.5] ~ '(tons)'), 
     col = "blue", xlab="Year")
dev.off()