## plot3.R plots "Sub_metering_1", "Sub_metering_2" and "Sub_metering_3 from 
##the "House Power Consumption" Dataset for a specified dates

original_data <-  # importing the data set
  read.table(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ';',
    stringsAsFactors = F
  )

original_data$Date <- ## converting to 'Date' class
  as.Date((original_data$Date), format = "%d/%m/%Y")

selected_data <- ## selecting the specified dates
  subset(original_data,
         subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# merging Date and Time column into new column of 'POSIXct' class
selected_data$Date_Time <-
  as.POSIXct(paste(as.Date(selected_data$Date), selected_data$Time))


png("plot3.png",
    width = 480,
    height = 480,
    units = "px")

with(selected_data, {
  plot(
    Sub_metering_1 ~ Date_Time,
    typ  = "l",
    ylab = "Global Active Power (kilowatts)",
    xlab = ""
  )
  lines(Sub_metering_2 ~ Date_Time, col = 'Red')
  lines(Sub_metering_3 ~ Date_Time, col = 'Blue')
})

legend(
  "topright",
  col = c("black", "red", "blue"),
  lty = 1,
  lwd = 2,
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.off()
