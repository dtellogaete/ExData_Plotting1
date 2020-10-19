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
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

# Subset data
data2 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

# Plot 4
dev.print(png, file = "plot4.png", width = 504, height = 504)
png(file = "plot4.png", bg = "transparent")
par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data2,plot(Datetime,
                Global_active_power,
                type = "l",
                xlab = "",
                ylab = "Global Active Power (kilowatts)"))
with(data2, plot(Datetime,
                 Voltage,
                 type = "l",
                 xlab = "datetime",
                 ylab = "Voltage"))
with(data2, plot(Datetime,
                 Sub_metering_1,
                 type = "l",
                 xlab = "",
                 ylab = "Energy sub metering",
                 col = "gray"))
with(data2, lines(Datetime,
                  Sub_metering_2,
                  type = "l", 
                  col = "red"))
with(data2, lines(Datetime,
                  Sub_metering_3,
                  type = "l", 
                  col = "blue"))
legend("topright", pch = 19, col = c("gray", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3"))
with(data2, plot(Datetime,
                 Global_reactive_power,
                 type = "l",
                 xlab = "datetime",
                 ylab = "Global_reactive_power"))
dev.off()

