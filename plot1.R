# Download file, unzip and save it in folder "exdata1"
if (!file.exists("exdata1"))  { dir.create("exdata1")}
zipfile <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipfile)
unzip(zipfile, exdir = "exdata1")

# Read downloaded file into dataset "powerdata" and
# convert respective variables into Time and Date formats
powerdata <- read.table("~/exdata1/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
powerdata$timetemp <- paste(powerdata$Date, powerdata$Time) 
powerdata$Time <- strptime(powerdata$timetemp, format = "%d/%m/%Y %H:%M:%S")
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")

# Subset data into "plot1data" with only observations from the dates of 2007-02-01 and 2007-02-02
plot1data <- subset(powerdata, powerdata$Date =="2007-02-01" |powerdata$Date == "2007-02-02")


# Create Plot 1 and save it PNG file (plot1.png) 
png("~/exdata1/plot1.png", 480, 480)

#Set background of plot1 as transparent 
# to match the original samples from Professor Peng)
par(bg=NA)

# Create histogram for variable Global_active_power
hist(plot1data$Global_active_power, main="Global Active Power", col="Red", ylim=c(0, 1200), xlab="Global Active Power (kilowatts)")
dev.off()