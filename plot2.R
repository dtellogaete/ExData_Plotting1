# Import library
library(pryr)
library(lubridate)

# Import Data
data <- read.table("data/household_power_consumption.txt", 
                   sep = ";", 
                   header = TRUE,
                   stringsAsFactors = FALSE)

data$Datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

str(data)
head(data)

# Read size
object_size(data)

# Cast Data
data$Date <- dmy(data$Date)
data$Global_active_power <- as.double(data$Global_active_power)

# Subset data
data2 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

# Plot 2
dev.print(png, file = "plot2.png", width = 504, height = 504)
png(file = "plot2.png", bg = "transparent")
with(data2, plot(Datetime,
                 Global_active_power,
                 type = "l",
                 xlab = "",
                 ylab = "Global Active Power (kilowatts)"))
dev.off()
