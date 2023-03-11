##Install all the required packages
##code written in R 4.2.2

if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
source("household_power_consumption.txt")

plot2 <- function(file) {
        power <- read.table(file, header=T, sep=";")
        power$Date <- as.Date(power$Date, format="%d/%m/%Y")
        df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
        
        df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
        df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
        
        plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
}


plot2("household_power_consumption.txt")