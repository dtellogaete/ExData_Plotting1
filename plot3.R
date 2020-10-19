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

# Subset data
data2 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

# Plot 3
dev.print(png, file = "plot3.png", width = 504, height = 504)
png(file = "plot3.png", bg = "transparent")
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
dev.off()
