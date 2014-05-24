##  Exploratory Data Analysis Course Project 2
##  Plotting the National Emissions Inventory (NEI) Data

## PLOT 1:  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##          Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
##          for each of the years 1999, 2002, 2005, and 2008.

## Read data into R

NEI <- readRDS("./data/summarySCC_PM25.rds")

## Aggregate Pollutant Sum by Year

NEIAgg <- aggregate(Emissions ~ year, NEI, sum)
NEIAgg$Emissions <- round(NEIAgg$Emissions/1000,2)

## Plot Pollutant Sum by Year for All Sources

png("plot1.png")
barplot(NEIAgg$Emissions, main = expression('Total US PM' [2.5] ~ ' Emissions by Year'), names.arg = NEIAgg$year, col = "red", xlab="Year",
        ylab= expression('PM ' [2.5] ~ '(kilotons)'))
dev.off()