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
powerhouse$Global_reactive_power <- as.numeric(powerhouse$Global_reactive_power)
powerhouse$Voltage <- as.numeric(powerhouse$Voltage)
powerhouse$Sub_metering_1 <- as.numeric(powerhouse$Sub_metering_1)
powerhouse$Sub_metering_2 <- as.numeric(powerhouse$Sub_metering_2)
powerhouse$Sub_metering_3 <- as.numeric(powerhouse$Sub_metering_3)

#plot #4
par(mfrow=c(2,2))
with(powerhouse, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
with(powerhouse, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="dateTime"))
with(powerhouse, plot(DateTime, Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab=""))
with(powerhouse, lines(DateTime, Sub_metering_1, type="l",  col="black"))
with(powerhouse, lines(DateTime, Sub_metering_2, type="l",  col="red"))
with(powerhouse, lines(DateTime, Sub_metering_3, type="l",  col="blue"))
legend("topright", pch="____", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), border="white")
with(powerhouse, plot(DateTime, Global_reactive_power, type="l", ylab="Global Rective Power (kilowatts)", xlab="dateTime"))
dev.copy(png, file="plot4.png")
dev.off()
