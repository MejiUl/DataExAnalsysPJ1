#We read all the rows in the file
powerhouse <- read.table("../household_power_consumption.txt", sep=";",  header=TRUE, as.is=TRUE)

#We match the strings that are between 1-2 of february to subset
flag <- grepl("^[1-2]/2/2007", powerhouse$Date)
powerhouse <- powerhouse[flag,]

#We could also subset like this but it's more slow as we have to cast more strings into dates
#powerhouse <- subset(powerhouse, powerhouse$Date >='2007/02/1' & powerhouse$Date <='2007/02/2')

#We merge the Date and Time into a single vector "DateTime" and cast it to a date format
DateTime <- paste(powerhouse$Date, powerhouse$Time, sep=" ")
DateTime <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")

#We cast the Global_active_power feature to numeric so we can plot it correctly
powerhouse$Global_active_power <- as.numeric(powerhouse$Global_active_power)

#plot #2
with(powerhouse, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.copy(png, file="plot2.png")
dev.off()

