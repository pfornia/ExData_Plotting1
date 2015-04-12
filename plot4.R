## plot4.R by Paul Fornia 4/11/2015 creates plot4.png
##  for the Coursera Exploratory Data Course: Project 1 part 4

# Read in raw data.
rawData <- read.table(file = "household_power_consumption.txt", 
                      sep = ";",
                      header = TRUE,
                      stringsAsFactors = FALSE)

# Filter to only Feb 1st and 2nd 2007
dataDateTime <- transform(rawData, DateTime = strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"))

data2daysRaw <- dataDateTime[
    dataDateTime$DateTime >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S") &
        dataDateTime$DateTime <= strptime("02/02/2007 23:59:59", "%d/%m/%Y %H:%M:%S") &
        !is.na(dataDateTime$DateTime)
    ,]

# Remove "?" and NAs
data2daysTemp <- data2daysRaw
for(i in 1:(length(data2daysRaw) - 1)){
    data2daysTemp <- data2daysTemp[!is.na(data2daysTemp[[i]]) & data2daysTemp[[i]] != "?",]
}
data2days <- data2daysTemp

# Make plot4
# Initialize a PNG device
png(filename = "plot4.png")

# Initialize a 4-panel page
par(mfrow = c(2, 2))

##  Top Left
plot(x = data2days$DateTime, y = as.numeric(data2days$Global_active_power),  
     xlab = "",
     ylab = "Global Active Power",
     type = "l")

##  Top Right
plot(x = data2days$DateTime, y = as.numeric(data2days$Voltage),  
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")

##  Bottom Left (same as plot3.png)
plot(x = data2days$DateTime, y = as.numeric(data2days$Sub_metering_1),  
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")

###     Layer on Sub_metering_2 and 3
lines(x = data2days$DateTime, y = as.numeric(data2days$Sub_metering_2), col = "red")
lines(x = data2days$DateTime, y = as.numeric(data2days$Sub_metering_3), col = "blue")

###     Add in legend
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty = "n")

##  Bottom Right
plot(x = data2days$DateTime, y = as.numeric(data2days$Global_reactive_power),  
     xlab = "",
     ylab = "Global_reactive_power",
     type = "l")

dev.off()
