
# Adding lubridate library to play with date
library(lubridate)

# To estimate the memory required by the dataset
format(object.size(read.table("./household_power_consumption.txt",sep=";",header=T)),units="Mb")

# Importing electrical power consumption

base_file_v1 <- read.table("./household_power_consumption.txt",sep=";",header=T)

base_file_v1$Date <- as.Date(as.character(base_file_v1$Date),format="%d/%m/%Y")
base_file_v1$Time <- hms(base_file_v1$Time)
base_file_v2 <- base_file_v1[base_file_v1$Date >= "2007-02-01" & base_file_v1$Date <= "2007-02-02",]


# Converting Factor into Numeric
base_file_v2$Sub_metering_1 <- as.numeric(as.character(base_file_v2$Sub_metering_1))
base_file_v2$Sub_metering_2 <- as.numeric(as.character(base_file_v2$Sub_metering_2))
base_file_v2$Sub_metering_3 <- as.numeric(as.character(base_file_v2$Sub_metering_3))
base_file_v2$Global_reactive_power <- as.numeric(as.character(base_file_v2$Global_reactive_power))
base_file_v2$Global_active_power <- as.numeric(as.character(base_file_v2$Global_active_power))

# Creating a new column DateTime
base_file_v2$DateTime <- paste (base_file_v2$Date, base_file_v2$Time)
base_file_v2$DateTime <- strptime(base_file_v2$DateTime, format = "%Y-%m-%d %H:%M:%S")

#creating the plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(base_file_v2$DateTime, base_file_v2$Global_active_power, type = "l", xlab= "", ylab= "Global Active Power")
base_file_v2$Voltage <- as.numeric(as.character(base_file_v2$Voltage))
plot(base_file_v2$DateTime, base_file_v2$Voltage, type = "l", xlab= "datetime", ylab= "Voltage")
plot(base_file_v2$DateTime, base_file_v2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(base_file_v2$DateTime, base_file_v2$Sub_metering_2, type = "l", col = "red")
points(base_file_v2$DateTime, base_file_v2$Sub_metering_3, type = "l", col = "blue")
legend("topright", cex= 0.9, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")
plot(base_file_v2$DateTime, base_file_v2$Global_reactive_power, type = "l", xlab= "datetime", ylab= "Global_reactive_power")
dev.off()