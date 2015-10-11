## Download the data file from the website

dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataUrl,"power_consumption_data.zip",method = "libcurl")

##Unzip the data file
unzip("power_consumption_data.zip")

## Read the data file into R
powerconsumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character","character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## Add a column with Date/Time Class
powerconsumption <- within(powerconsumption, Datetime <- as.POSIXlt(paste(powerconsumption$Date, powerconsumption$Time), format = "%d/%m/%Y %H:%M:%S", tz = "GMT"))

## Subset the data to Feb 01, 2007 till Feb 02, 2007
powerconsumptionsub <- subset(powerconsumption,powerconsumption$Datetime >= as.POSIXlt("2007-02-01 00:00:00", tz = "GMT") & powerconsumption$Datetime <= as.POSIXlt("2007-02-02 24:00:00",tz = "GMT") )

#Plot PNG file
png(filename = "plot2.png")
plot(powerconsumptionsub$Datetime,powerconsumptionsub$Global_active_power,xlab = "", ylab = "Global Active Power (kilowatts)",type = "l")
dev.off()