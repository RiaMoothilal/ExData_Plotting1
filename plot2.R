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

#plot 2
#create vector of dates with class = POSIXct
WD <- as.POSIXct(NeedData$datetime)

#create vector of global active power
GAP <- as.numeric(as.character(NeedData$Global_active_power))

#plot diagram with type = line and set y label 
plot(WD, GAP, type = "l", ylab = "Global Active Power (kilowatts)")

#copy to png file
dev.copy(png, file = "plot2.png") #copies plot to a png file
dev.off() #Always close the PNG device!!!!!!