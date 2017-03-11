##Plot4.R
## To be run as source(Plot4.R) on R command

## read from file, The fields are converted by Read.Table from Character to default, so ensure "as.is" paramter 
## is set to TURE and Header is specified as true

PowerConsumptionData <- read.table("household_power_consumption.txt",sep = ";", as.is = TRUE,header=TRUE,na.strings="?")

## The Date field is read as characters, need to be coverted to Date

PowerConsumptionData$Date <- as.Date(PowerConsumptionData$Date, format="%d/%m/%Y")

##We need data for only two days 01-Feb-2007 and 02-Feb-2007
PowerConsumptionData <- PowerConsumptionData[PowerConsumptionData$Date == as.Date("2007-02-01")|PowerConsumptionData$Date == as.Date("2007-02-02"),]

PowerConsumptionData <- transform(PowerConsumptionData, Time=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

png(file="plot4.png")

##We want to combine four plots into one graph so that the subsequent plot doesnt overwrite previous plot on png file
par(mfrow=c(2,2))

##Firt Graph
plot(PowerConsumptionData$Time,PowerConsumptionData$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##Second Graph

plot(PowerConsumptionData$Time,PowerConsumptionData$Voltage, type="l", xlab="datetime", ylab="Voltage")

##Third Graph
plot(PowerConsumptionData$Time,PowerConsumptionData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(PowerConsumptionData$Time,PowerConsumptionData$Sub_metering_2,col="red")
lines(PowerConsumptionData$Time,PowerConsumptionData$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

#Fourth graph
plot(PowerConsumptionData$Time,PowerConsumptionData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##Close png device
dev.off()