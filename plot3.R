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

# Check and set up required R packages
if (!require("plyr")) {
        install.packages("plyr")
}
if (!require("ggplot2")) {
        install.packages("ggplot2")
}
library(ggplot2)
library(plyr)

# Subset to Baltimore City, MD
Baltimore <- neiData[neiData$fips == "24510", ]
Baltimore.type <- ddply(Baltimore, .(type, year), summarize, Emissions = sum(Emissions))
Baltimore.type$Pollutant_Type <- Baltimore.type$type

# Plotting for question 3 using ggplot2 package

png(filename = "./plot/plot3.png", 
    width = 480, height = 480, 
    units = "px")

qplot(year, Emissions, data = Baltimore.type, group = Pollutant_Type, color = Pollutant_Type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
        
dev.off()
