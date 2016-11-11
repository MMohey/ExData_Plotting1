## plot1.R plots a histogram of "Global Active Power" from the "House Power
## Consumption" Dataset for a specified dates

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

png("plot2.png", # creating a png file
    width = 480,
    height = 480,
    units = "px")

hist(
  # drawing the histogram
  as.numeric(as.character(selected_data$Global_active_power)),
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)

dev.off()
