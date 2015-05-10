#Project 1 for Exploring Data Course
#setwd ("./Courses/Coursera/4. Exploratory Data Analysis/Project 1/")   #Set wd
fileurl <- "./household_power_consumption.txt"

#read in all the data
data <- read.table(fileurl, sep = ";",header = TRUE, nrows = -1)

#format dates from character to date format in a new variable called NewDate
data$NewDate <- as.Date(data$Date, format = "%d/%m/%Y")

#subset data to rows with NewDate = 2007-02-01 OR 2007-02-02
NeedData <- subset(data, NewDate == "2007-02-01" | NewDate == "2007-02-02")

#create new variable called datetime
NeedData$datetime <- strptime(paste(NeedData$NewDate,NeedData$Time), "%Y-%m-%d %H:%M:%S")

#create vector of dates with class = POSIXct
WD <- as.POSIXct(NeedData$datetime)
#create vector of global active power
GAP <- as.numeric(as.character(NeedData$Global_active_power))

#Use plot function to plot to png file
png("plot4.png")

#Plot 4
par(mfrow = c(2,2))

with (NeedData, {
        #plot GAP diagram with type = line and set y label 
        plot(WD, GAP, type = "l", ylab = "Global Active Power", xlab ="")
        
        #Plot Voltage line type diagram
        plot(WD,as.numeric(as.character(Voltage)), type = "l", xlab = "datetime", ylab = "Voltage" )
        
        #plot Energy sub metering diagram
        #NB. Sub_metering data are factor variables - need to be converted to numeric
        with(NeedData, plot(WD, as.numeric(as.character(Sub_metering_1)), type = "n", ylab = "Energy sub metering"), xlab = "")
        with(NeedData, points(WD, as.numeric(as.character(Sub_metering_1)), col = "black", type = "l"))
        with(NeedData, points(WD, as.numeric(as.character(Sub_metering_2)), col = "red", type = "l"))
        with(NeedData, points(WD, as.numeric(as.character(Sub_metering_3)), col = "blue", type = "l"))
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, border = "white")
        
        #plot Global Reactive Power vs datetime
        plot(WD, as.numeric(as.character(Global_reactive_power)),xlab ="datetime", ylab = "Global_reactive_power", type ="l")

})

dev.off() #Always close the PNG device!!!!!!