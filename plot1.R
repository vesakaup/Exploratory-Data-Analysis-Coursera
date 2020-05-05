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

epc[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

epc <- epc[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

### plot1
options(scipen=5)
png("plot1.png", width=480, height=480)

hist(epc[,Global_active_power], main = "Global Active Power", 
     xlab= "Global Active Power (kilowatts)",
     col = "red", breaks=12,ylim=c(0,1200),yaxt="n")
axis(side = 2,cex.axis=0.8)
dev.off()
