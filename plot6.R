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

# Subset to Baltimore and LA
Baltimore_motor <- subset(neiData, fips == "24510" & type=="ON-ROAD")
Baltimore_motor_source <- aggregate(Baltimore_motor[c("Emissions")], 
                                    list(type = Baltimore_motor$type, 
                                         year = Baltimore_motor$year, 
                                         zip = Baltimore_motor$fips), sum)
LA_motor <- subset(neiData, fips == "06037" & type=="ON-ROAD")
LA_motor_source <- aggregate(LA_motor[c("Emissions")], list(type = LA_motor$type, 
                                               year = LA_motor$year, 
                                               zip = LA_motor$fips), sum)
Two_Regions <- rbind(Baltimore_motor_source, LA_motor_source)

# Plotting for question 6 using ggplot2 package

# Check and set up required R packages
if (!require("plyr")) {
        install.packages("plyr")
}
if (!require("ggplot2")) {
        install.packages("ggplot2")
}
library(ggplot2)
library(plyr)

# Plot

png(filename = "./plot/plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

qplot(year, Emissions, data = Two_Regions, color = zip, geom= "line", ylim = c(-100, 5500)) + 
        ggtitle("Motor Vehicle Emissions in Baltimore (24510) \nvs. Los Angeles (06037) Counties") + 
        xlab("Year") + ylab("Emission Levels")

dev.off()