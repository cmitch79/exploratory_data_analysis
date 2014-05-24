##  Exploratory Data Analysis Course Project 2
##  Plotting the National Emissions Inventory (NEI) Data

## PLOT 5:  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Read data into R

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
message("read complete")

## Subset NEI to Baltimore City and SCC to Onroad and aggregate emissions by year

SCCOnroad <- SCC[SCC$Data.Category == "Onroad", ]
NEIBalt <- NEI[NEI$fips == "24510", ]
NEIBaltOnroad <- join(x = SCCOnroad, y = NEIBalt, by = "SCC")
NEIAgg <- aggregate(Emissions ~ year, data = NEIBaltOnroad, FUN = sum)

## Plot Onroad Emissions in Baltimore City by Year

png("plot5.png")
barplot(NEIAgg$Emissions, main = expression('Baltimore City, MD PM' [2.5] ~ ' Onroad Emissions by Year'), names.arg = NEIAgg$year, col = "red", xlab="Year",
        ylab= expression('PM ' [2.5] ~ '(tons)'))
dev.off()