## load data and libraries

## set locale to print weekdays in English
## Sys.setlocale("LC_TIME", "English") 

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

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = epc[, dateTime]
     , y = epc[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
