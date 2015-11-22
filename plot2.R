# Set up and download the data
setwd("D:/Selflearn/R/ExploratoryDataAnalysis/Project2")
if(!file.exists("./plot")){dir.create("./plot")}
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data/PM25.zip")

#Unzip the file
if (!file.exists("Source_Classification_Code.rds")){
        unzip(zipfile = "./data/PM25.zip")
}

# Check if both data exist. If not, load the data.
if (!"neiData" %in% ls()) {
        neiData <- readRDS("./summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
        sccData <- readRDS("./Source_Classification_Code.rds")
}

# Subset to Baltimore City, MD
subset <- neiData[neiData$fips == "24510", ] 

# Plotting question 2 with base

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot/plot2.png", 
    width = 480, height = 480, 
    units = "px")
totalEmissions <- aggregate(subset$Emissions, list(subset$year), FUN = "sum")
# options(scipen=0)
# options(scipen=999)
plot(totalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions in Baltimore City from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"),
     col="Purple")

dev.off()