## plot1.R by Paul Fornia 4/11/2015 creates plot1.png
##  for the Coursera Exploratory Data Course: Project 1 part 1

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

# Make plot1
# Initialize a PNG device
png(filename = "plot1.png")
hist(as.numeric(data2days$Global_active_power), 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
     )

dev.off()
