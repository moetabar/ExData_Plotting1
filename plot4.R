plot4 <- function()
{
  library(dplyr)
  
  # 4 plots, 2 rows: 2 columns
  par(mfrow=c(2,2))
  
  # name of the columns
  name = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  
  # here we read the data and assign the column names, skip is used so we do need to read column names two times
  data <- read.table("household_power_consumption.txt", sep = ";", skip =1, col.names = name)
  
  # here we set the date data to Date class format
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  # Here we subset the two days in February
  data <- filter(data, Date >= "2007-02-01")
  data <- filter(data, Date <= "2007-02-02")
  
  # Here a bew column with POSIXct format will be added to data which has both Date & Time
  data = mutate(data, Date.Time = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))
  
  # in the following 3 lines we convert the data to char and then from char to numeric
  data$Sub_metering_1 = as.numeric(as.character(data$Sub_metering_1))
  data$Sub_metering_2 = as.numeric(as.character(data$Sub_metering_2))
  data$Sub_metering_3 = as.numeric(as.character(data$Sub_metering_3))

  with(data,{   
      # plot1
      plot(data$Date.Time,as.numeric(as.character(data$Global_active_power)), type="l", xlab='', ylab="Global Active Power (killowats)") 
      # plot2
      plot(data$Date.Time,as.numeric(as.character(data$Voltage)), type="l", xlab='datetime', ylab="Voltage")
      # plot3
      with(data, {
              plot(data$Date.Time, data$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy Sub Metering")
              lines(data$Date.Time, data$Sub_metering_2, col="red", type="l")
              lines(data$Date.Time, data$Sub_metering_3, col="blue", type="l")
              legend("topright",pch=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
      })
      # plot4
      plot(data$Date.Time,as.numeric(as.character(data$Global_reactive_power)), type="l", xlab='datetime', ylab="Voltage")
      
      
  })
  dev.copy(png,  width = 680, height = 480, "plot4.png")
  dev.off()
}