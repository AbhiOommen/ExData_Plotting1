wd <- getwd() # Saving current working directory
require(dplyr)
library(dplyr) 
if (!file.exists("PlotData")){dir.create("PlotData")} # Creating a seperate folder for the plots
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" # Data Source
dest <- "household_power_consumption.zip" # data destination file
setwd(paste0(wd, "/PlotData/")) # change working directory to newly created folder
# Since we use the same data set for mutiple plots I have included an if statement to check if the file or data frame exists first before creating it.
if(!file.exists("household_power_consumption.txt")) {download.file(fileUrl,dest);unzip(dest, overwrite = TRUE)} # download and unzip file if the text file does not exist, saves time
if (!exists ("dataset")) dataset <- read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE) # read data from the text file if the dataframe is not already created in the namespace, saves time
if (!exists ("plotdata")) plotdata <- subset(dataset, as.Date(Date,"%d/%m/%Y") >="2007-02-01" & as.Date(Date,"%d/%m/%Y") <="2007-02-02") # subset data frame for the two dates specified if it doesn't exist, saves time
plotTime <- paste(plotdata$Date,plotdata$Time, sep=" ") # Creating a date time column by concatinating the date and time columns together .
plotdata <- mutate(plotdata, PTime = as.POSIXct(strptime(plotTime, "%d/%m/%Y %H:%M:%S"))) # Using the dplyr package and mutate function to modify the data set by adding a column with the datetime value created above.
png("../plot1.png") # Opening the graphic device - png file, saving it in the original Working Directory. 
hist(plotdata$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)") # Creating the reference histogram
dev.off() # Closing the png file 
setwd(wd) # Setting the working directory back to the original one before exiting.