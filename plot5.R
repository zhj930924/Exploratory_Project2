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

# Subset to motor related in Baltimore City, MD

Baltimore_motor <- subset(neiData, fips == "24510" & type=="ON-ROAD")
Baltimore_motor_source <- aggregate(Baltimore_motor[c("Emissions")], 
                                    list(type = Baltimore_motor$type, 
                                         year = Baltimore_motor$year, 
                                         zip = Baltimore_motor$fips), sum)

# Plotting for question 5 using ggplot2

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

png(filename = "./plot/plot5.png", 
    width = 480, height = 480, 
    units = "px")

qplot(year, Emissions, data = Baltimore_motor_source, geom= "line") + 
        theme_gray() + 
        ggtitle("Motor Vehicle-Related Emissions in Baltimore County") + 
        xlab("Year") + ylab("Emission Levels")

dev.off()

