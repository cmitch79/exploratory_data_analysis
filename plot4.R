##  Exploratory Data Analysis Course Project 2
##  Plotting the National Emissions Inventory (NEI) Data
##  Requires ggplot2, plyr

## PLOT 4:  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## Read data into R

require(ggplot2)
require(plyr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
message("read complete")

## Subset to coal combustion and aggregate emissions by year

SCCCoalComb <- SCC[grepl("Coal", SCC$Short.Name) & grepl("Comb", SCC$Short.Name), ]
NEICoalComb <- join(x = SCCCoalComb, y = NEI, by = "SCC")
AggNEICoalComb <- aggregate(Emissions ~ year, data = NEICoalComb, FUN = sum)

## GG Plot Plot US Coal-Related Emissions by Year

png('plot4.png', width=500, height=500, units='px')

ggplot(AggNEICoalComb, aes(x = year, y = Emissions)) +
geom_line(color = "red") +
labs(title = expression('Total US PM' [2.5] ~ 'Coal Related Emissions by Year'), x = "Year",
y = expression('PM ' [2.5] ~ '(tons)')) + theme(plot.title = element_text(size = 14, face="bold"))

dev.off()