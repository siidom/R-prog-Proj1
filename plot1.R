##Install all the required packages
##code written in R 4.2.2

if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

source("household_power_consumption.txt")

plot1 <- function(file) {
        
        power <- read.table(file, header=T, sep=";")
        power$Date <- as.Date(power$Date, format="%d/%m/%Y")
        
        df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
        
        df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
        
        hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")

}

plot1("household_power_consumption.txt")