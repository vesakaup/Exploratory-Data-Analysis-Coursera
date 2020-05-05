## load data and libraries

library(data.table)

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName = "epcdata.zip"

if(!file.exists(fileName)){
        download.file(fileUrl, fileName, mode = "wb")    
}
unzip(fileName)
epc <- data.table::fread(input = "household_power_consumption.txt"
                         , na.strings="?")


epc[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


epc[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


epc <- epc[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

##plots 1-4/4

par(mfrow=c(2,2))
par(mar=c(3.8,3.8,3.8,3.8))

## plot 1/4

plot(epc[,dateTime], epc[,Global_active_power], type="l",xlab="",ylab="Global Active Power")

# plot 2/4
plot(epc[,dateTime],epc[,Voltage], type="l", xlab = "datetime", ylab="Voltage")

# plot 3/4 

plot(epc[,dateTime],epc[,Sub_metering_1], type="l",xlab="",ylab="Energy submetering")
lines(epc[,dateTime],epc[,Sub_metering_2],col="red")
lines(epc[,dateTime],epc[,Sub_metering_3],col="blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = colnames(epc)[7:9], lwd = 1, cex=0.5)

# plot 4/4
plot(epc[,dateTime], epc[,Global_reactive_power], type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()

