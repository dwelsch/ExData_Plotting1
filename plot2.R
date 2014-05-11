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
powerdata$datetime <- strptime(powerdata$datetime, format="%Y-%m-%d %H:%M:%S")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
par("mar"=c(2,4,2,2))
plot(x=powerdata$datetime, y=powerdata$Global_active_power, main="", 
     ylab="Global Active Power (kilowatts)", pch=NA_integer_,
     xlab=as.character(powerdata$datetime, format="%a", type="n"))
lines(x=powerdata$datetime, y=powerdata$Global_active_power)
dev.copy(png, file="plot2.png")
dev.off()