##  Exploratory Data Analysis Course Project 2
##  Plotting the National Emissions Inventory (NEI) Data
##  Requires ggplot2

## PLOT 3:  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases
## in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?

## Read data into R

require(ggplot2)

NEI <- readRDS("./data/summarySCC_PM25.rds")

## Aggregate Pollutant Sum by Year

NEISub <- subset(NEI, fips == '24510')

NEIAgg <- aggregate(Emissions ~ year + type, data = NEISub, FUN = sum)

## Plot Pollutant Sum by Year for All Sources

png('plot3.png', width=800, height=500, units='px')

ggplot(data = NEIAgg, aes(x = year, y = Emissions)) +
  geom_line(aes(color = type)) +
  labs(title = expression('Baltimore City, MD PM' [2.5] ~ 'Emissions by Source'), x = "Year",
   y = expression('PM ' [2.5] ~ '(tons)')) + theme(plot.title = element_text(size = 14, face="bold"))

dev.off()