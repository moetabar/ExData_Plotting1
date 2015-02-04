plot1 <- function()
{
  library(dplyr)
  
  # only one plot
  par(mfrow=c(1,1))

  # name of the columns
  name = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

  # here we read the data and assign the column names, skip is used so we do need to read column names two times
  data <- read.table("household_power_consumption.txt", sep = ";", skip =1, col.names = name)

  # here we set the date data to Date class format
  data$Date <- as.Date(data$Date, "%d/%m/%Y")

  # Here we subset the two days in February
  data <- filter(data, Date >= "2007-02-01")
  data <- filter(data, Date <= "2007-02-02")

  # Drawing plot#1
  hist(as.numeric(as.character(data$Global_active_power)), col='red', xlab = "Global Active Power(kilowatts)", main = "Global Active Power")
  dev.copy(png,  width = 480, height = 480, "plot1.png")
  dev.off()
  
}
