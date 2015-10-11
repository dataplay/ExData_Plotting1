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

# Subsetting data into "plot3data" with only observations from the dates of 2007-02-01 and 2007-02-02
plot3data <- subset(powerdata, powerdata$Date =="2007-02-01" |powerdata$Date == "2007-02-02")

# Creating Plot 3 and save it PNG file (plot3.png) 
# with a width of 480 pixels and a height of 480 pixel
png("~/exdata1/plot3.png", 480, 480)

#Setting background of plot3 as transparent 
# to match the original samples from Professor Peng)
par(bg=NA)  

# Plotting the data from variables 
# Sub_metering_1, Sub_metering_2, and Sub_metering_3 on the same plot
plot(plot3data$Time, plot3data$Sub_metering_1, type = "l", ylim = c(0,38),
     ylab = "Energy Sub Metering", xlab="")  
lines(plot3data$Time, plot3data$Sub_metering_2, col = "red")
lines(plot3data$Time, plot3data$Sub_metering_3, col = "blue")
# Creating the legend as shown in the original Plot 3
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()