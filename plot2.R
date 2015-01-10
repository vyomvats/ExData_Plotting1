
# Adding lubridate library to play with date
library(lubridate)

# To estimate the memory required by the dataset
format(object.size(read.table("./household_power_consumption.txt",sep=";",header=T)),units="Mb")

# Importing electrical power consumption

base_file_v1 <- read.table("./household_power_consumption.txt",sep=";",header=T)

base_file_v1$Date <- as.Date(as.character(base_file_v1$Date),format="%d/%m/%Y")
base_file_v1$Time <- hms(base_file_v1$Time)
base_file_v2 <- base_file_v1[base_file_v1$Date >= "2007-02-01" & base_file_v1$Date <= "2007-02-02",]

# Changing Factor to Numeric
base_file_v2$Global_active_power <- as.numeric(as.character(base_file_v2$Global_active_power))

# Creating a new column DateTime
base_file_v2$DateTime <- paste (base_file_v2$Date, base_file_v2$Time)
base_file_v2$DateTime <- strptime(base_file_v2$DateTime, format = "%Y-%m-%d %H:%M:%S")

#Constructing the required plot
plot(base_file_v2$DateTime, base_file_v2$Global_active_power, xlab = "", ylab = "Global Active Power (Kilowatts)", type = "l")

# Creating PNG file
dev.copy (png, file = "plot2.png", width = 480, height = 480)

dev.off()


