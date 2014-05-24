##  Exploratory Data Analysis Course Project 2
##  Plotting the National Emissions Inventory (NEI) Data

## PLOT 2:  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

## Read data into R

NEI <- readRDS("./data/summarySCC_PM25.rds")

## Aggregate Pollutant Sum by Year

NEISub <- subset(NEI, fips == '24510')

NEIAgg <- aggregate(Emissions ~ year, NEISub, sum)

## Plot Pollutant Sum by Year for All Sources

png("plot2.png")
barplot(NEIAgg$Emissions, main = expression('Total Baltimore City, MD PM' [2.5] ~ ' Emissions by Year'), names.arg = NEIAgg$year, col = "red", xlab="Year",
        ylab= expression('PM ' [2.5] ~ '(tons)'))
dev.off()