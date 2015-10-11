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
png(filename = "plot3.png")
plot(powerconsumptionsub$Datetime,powerconsumptionsub$Sub_metering_1,xlab = "", ylab = "Energy sub metering",type = "l")
points(powerconsumptionsub$Datetime,powerconsumptionsub$Sub_metering_2,type = "l", col = "red")
points(powerconsumptionsub$Datetime,powerconsumptionsub$Sub_metering_3,type = "l", col = "blue")
legend("topright",lwd = 1, col = c("black","red", "blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()