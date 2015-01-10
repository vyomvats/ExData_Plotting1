
# Adding lubridate library to play with date
library(lubridate)

# To estimate the memory required by the dataset
format(object.size(read.table("./household_power_consumption.txt",sep=";",header=T)),units="Mb")

# Importing electrical power consumption

base_file_v1 <- read.table("./household_power_consumption.txt",sep=";",header=T)

base_file_v1$Date <- as.Date(as.character(base_file_v1$Date),format="%d/%m/%Y")
base_file_v1$Time <- hms(base_file_v1$Time)
base_file_v2 <- base_file_v1[base_file_v1$Date >= "2007-02-01" & base_file_v1$Date <= "2007-02-02",]

#Constructing the required plot
par(bg="transparent")
hist(as.numeric(as.character(base_file_v2$Global_active_power)),col="red",xlab = "Global Active Power (kilowatts)",main="Global Active Power")
dev.copy(png,file="plot1.png",height=480,width=480)
dev.off()
