##Install all the required packages
##code written in R 4.2.2

if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

source("household_power_consumption.txt")

plot4 <- function(file) {
        power <- read.table(file, header=T, sep=";")
        power$Date <- as.Date(power$Date, format="%d/%m/%Y")
        df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
        
        df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
        df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
        df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
        df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
        df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
        df$Voltage <- as.numeric(as.character(df$Voltage))
        
        df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
        
        par(mfrow=c(2,2))
        
        
        plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        
        
        plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        
        plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(df$timestamp,df$Sub_metering_2,col="red")
        lines(df$timestamp,df$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        

        plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
}

plot4("household_power_consumption.txt")