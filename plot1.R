library(dplyr)
library(lubridate)

data <- read.csv("./household_power_consumption.txt", sep = ";", header = TRUE)
dim(data)
names(data)

data <- tbl_df(data)
data <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
data$Date <- dmy(data$Date)

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(as.numeric(data$Global_active_power), xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", 
     main = "Global Active Power")
dev.off()
