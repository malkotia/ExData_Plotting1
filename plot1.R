##Plot1.R
## To be run on R command prompt as "source("plot1.R)
##Ensure that the file "household_power_consumption.txt" is present in the working directory
## read from file, The fields are converted by Read.Table from Character to default, so ensure "as.is" paramter 
## is set to TURE and Header is specified as true

PowerConsumptionData <- read.table("household_power_consumption.txt",sep = ";", as.is = TRUE,header=TRUE,na.strings="?")

## The Date and Time fields are read as characters so convert these to Date and Time respectively

PowerConsumptionData$Date <- as.Date(PowerConsumptionData$Date, format="%d/%m/%Y")
PowerConsumptionData$Time <- strptime(PowerConsumptionData$Time, format="%H/%M/%S")

##We need dat for only two days 01-Feb-2007 and 02-Feb-2007
PowerConsumptionData <- PowerConsumptionData[PowerConsumptionData$Date == as.Date("2007-02-01")|PowerConsumptionData$Date == as.Date("2007-02-02"),]
png(file="plot1.png")
hist(PowerConsumptionData$Global_active_power,main="Global Active Power",xlab="Global Active Power(Kilowatts)",ylab="Frequency",col="red")
dev.off()
