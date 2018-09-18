wd <- getwd()
require(dplyr)
library(dplyr)
if (!file.exists("PlotData")){dir.create("PlotData")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "household_power_consumption.zip"
setwd(paste0(wd, "/PlotData/"))
if(!file.exists("household_power_consumption.txt")) {download.file(fileUrl,dest);unzip(dest, overwrite = TRUE)}
if (!exists ("dataset")) dataset <- read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
if (!exists ("plotdata")) plotdata <- subset(dataset, as.Date(Date,"%d/%m/%Y") >="2007-02-01" & as.Date(Date,"%d/%m/%Y") <="2007-02-02")
plotTime <- paste(plotdata$Date,plotdata$Time, sep=" ")
plotdata <- mutate(plotdata, PTime = as.POSIXct(strptime(plotTime, "%d/%m/%Y %H:%M:%S")))
png("../plot4.png")
par(mfcol = c(2,2))
plot(plotdata$PTime, plotdata$Global_active_power, type = "l", xlab = "", ylab="Global Active Power")
plot(plotdata$PTime, plotdata$Sub_metering_1, col= "black" ,type = "l", xlab="", ylab = "Energy sub metering")
lines(plotdata$PTime, plotdata$Sub_metering_2,  type = "l", col = "red")
lines(plotdata$PTime, plotdata$Sub_metering_3,  type = "l", col = "blue")
legend("topright", bty = "n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = "solid")
plot(plotdata$PTime, plotdata$Voltage, type = "l", xlab = "datetime", ylab="Voltage")
plot(plotdata$PTime, plotdata$Global_reactive_power, type = "l", xlab = "datetime", ylab="Global_reactive_power")
dev.off()
setwd(wd)