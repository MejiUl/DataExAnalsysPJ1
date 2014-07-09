#We read all the rows in the file
powerhouse <- read.table("household_power_consumption.txt", sep=";",  header=TRUE, as.is=TRUE)

#We match the strings that are between 1-2 of february to subset
flag <- grepl("^[1-2]/2/2007", powerhouse$Date)
powerhouse <- powerhouse[flag,]

DateTime <- paste(powerhouse$Date, powerhouse$Time, sep=" ")
DateTime <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")
#powerhouse$Date <- as.Date(powerhouse$Date, format="%d/%m/%Y")
#powerhouse$Time <- strptime(powerhouse$Time, "%H:%M:%S")

#We could also subset like this but it's more slow as we have 
#powerhouse <- subset(powerhouse, powerhouse$Date >='2007/02/1' & powerhouse$Date <='2007/02/2')

#We cast the Global_active_power feature to numeric so we can plot it correctly
powerhouse$Global_active_power <- as.numeric(powerhouse$Global_active_power)

#plot #2
with(powerhouse, plot(DateTime, Global_active_power, type="n"))

