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

png("plot3.png", width=480, height=480)

## plot 3

plot(epc[,dateTime],epc[,Sub_metering_1], type="l",xlab="",ylab="Energy submetering")
lines(epc[,dateTime],epc[,Sub_metering_2],col="red")
lines(epc[,dateTime],epc[,Sub_metering_3],col="blue")
legend("topright", col = c("black", "red", "blue"), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
dev.off()
