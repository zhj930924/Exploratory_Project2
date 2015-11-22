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

# Preliminary look at the data sets
head(neiData)
head(sccData)
dim(neiData) # 6497651   6
dim(sccData) # 11717    15

# Plotting for question 1 using base

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot/plot1.png", 
    width = 480, height = 480, 
    units = "px")
totalEmissions <- aggregate(neiData$Emissions, list(neiData$year), FUN = "sum")

plot(totalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions in the United States from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"),
     col="Purple")
dev.off()

