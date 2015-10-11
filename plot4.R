# Downloading file, unzipping and saving it in folder "exdata1"
if (!file.exists("exdata1"))  { dir.create("exdata1")}
zipfile <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipfile)
unzip(zipfile, exdir = "exdata1")

# Reading downloaded file into dataset "powerdata" and
# converting respective variables into Time and Date formats
powerdata <- read.table("~/exdata1/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
powerdata$timetemp <- paste(powerdata$Date, powerdata$Time) 
powerdata$Time <- strptime(powerdata$timetemp, format = "%d/%m/%Y %H:%M:%S")
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")

# Subsetting data into "plot4data" with only observations from the dates of 2007-02-01 and 2007-02-02
plot4data <- subset(powerdata, powerdata$Date =="2007-02-01" |powerdata$Date == "2007-02-02")

# Creating Plot 4 and save it PNG file (plot4.png) 
# with a width of 480 pixels and a height of 480 pixel
png("~/exdata1/plot4.png", 480, 480)

# Putting all four plots on the same page
par(mfrow=c(2,2))

#Setting background of plot4 as transparent 
# to match the original samples from Professor Peng)
par(bg=NA)

# Creating the four plots as shown in the examples from Professor Peng
plot(plot4data$Time, plot4data$Global_active_power, typ="l", ylim=c(0, 7.5), ylab="Global Active Power", xlab="")
plot(plot4data$Time, plot4data$Voltage, typ="l", ylab="Voltage", ylim=c(233, 247), xlab="datetime")
plot(plot4data$Time, plot4data$Sub_metering_1, type = "l", ylim = c(0,38),
     ylab = "Energy Sub Metering", xlab="")
lines(plot4data$Time, plot4data$Sub_metering_2, col = "red")
lines(plot4data$Time, plot4data$Sub_metering_3, col = "blue")
legend("topright", bty="n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(plot4data$Time, plot4data$Global_reactive_power, typ="l", ylim=c(0, 0.5), ylab="Global_reactive_power", xlab="datetime")

dev.off()