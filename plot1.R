#Esnure that you set the working directory to be the same as the one into which the zip file has been extracted to
fileurl <- "./household_power_consumption.txt"

#read in all the data
data <- read.table(fileurl, sep = ";",header = TRUE, nrows = -1)

#format dates from character to date format in a new variable called NewDate
data$NewDate <- as.Date(data$Date, format = "%d/%m/%Y")

#subset data to rows with NewDate = 2007-02-01 OR 2007-02-02
NeedData <- subset(data, NewDate == "2007-02-01" | NewDate == "2007-02-02")

#create new variable called datetime
NeedData$datetime <- strptime(paste(NeedData$NewDate,NeedData$Time), "%Y-%m-%d %H:%M:%S")

#Plot 1
#Calls the hist function but also needs to convert the Global_active_power
#variable from a factor to numeric. Hist requires numeric. In order to fo
#from factor to numeric it first needs to be converted to a character so as not
#to return the factor levels as the value
hist(as.numeric(as.character(NeedData$Global_active_power)), col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png") #copies plot to a png file
dev.off() #Always close the PNG device!!!!!!
