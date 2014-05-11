# Course Project 1
# Exploratory Data Analysis
# Roger Peng, Johns Hopkins University
# May 11, 2014

# Reproduce plot 1 from electric power consumption dataset
setwd("C:/Users/Dave/Documents/Coursera/Exploratory Data Analysis - Roger Peng - Johns Hopkins")

library(data.table)

# Have a look at the top of the data file, see what format we're dealing with
read.table("exdata_data_household_power_consumption/household_power_consumption.txt", nrows = 3)

# This should do it
# Specify approximate nrows to reduce processing time
powerdata <- read.csv2("exdata_data_household_power_consumption/household_power_consumption.txt",
                       nrows=2076000, dec=".", 
                       as.is=seq(1:9))
# Sanity check
head(powerdata)

# No magic here--had to look at the data to determine the correct data formula of
# single-digit days and months
powerdata <- powerdata[powerdata$Date %in% c("1/2/2007", "2/2/2007"),]
powerdata$datetime <- paste(powerdata$Date, powerdata$Time, sep=" ")
powerdata$datetime <- strptime(powerdata$datetime, "%d/%m/%Y %H:%M:%S")
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)
par("mar"=c(2,4,2,2))
plot(x=powerdata$datetime, y=powerdata$Sub_metering_1, main="", 
     ylab="Global Active Power (kilowatts)", pch=NA_integer_,
     xlab=as.character(powerdata$datetime, format="%a", type="n"))
lines(x=powerdata$datetime, y=powerdata$Sub_metering_1, col="black")
lines(x=powerdata$datetime, y=powerdata$Sub_metering_2, col="red")
lines(x=powerdata$datetime, y=powerdata$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot2.png")
dev.off()