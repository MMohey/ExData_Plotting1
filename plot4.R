## plot4.R plots four different plots on one figure

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


png("plot4.png", # creating a png file
    width = 480,
    height = 480,
    units = "px")

par( # setting out the graph margins and dividing the area into 4 plotting regions
  mfrow = c(2, 2),
  mar = c(4, 4, 2, 1),
  oma = c(0, 0, 2, 0)
)


with(selected_data, { # plotting the four graphs
  plot( # plot for the first graph
    Global_active_power ~ Date_Time,
    type = "l",
    ylab = "Global Active Power (kilowatts)",
    xlab = ""
  )
  plot(Voltage ~ Date_Time, # plot for the second graph
       type = "l",
       ylab = "Voltage (volt)",
       xlab = "")
  plot( # plot for the third graph
    Sub_metering_1 ~ Date_Time,
    type = "l",
    ylab = "Global Active Power (kilowatts)",
    xlab = ""
  )
  lines(Sub_metering_2 ~ Date_Time, col = 'Red')
  lines(Sub_metering_3 ~ Date_Time, col = 'Blue')
  legend(
    "topright",
    col = c("black", "red", "blue"),
    lty = 1,
    lwd = 2,
    bty = "n",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  )
  plot( # plot for the fourth graph
    Global_reactive_power ~ Date_Time,
    type = "l",
    ylab = "Global Rective Power (kilowatts)",
    xlab = ""
  )
})

dev.off()
