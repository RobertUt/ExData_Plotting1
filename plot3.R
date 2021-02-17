library(dplyr)
library(lubridate)

data <- read.csv("./household_power_consumption.txt", sep = ";", header = TRUE)
dim(data)
names(data)

data <- tbl_df(data)
data <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
data$Date <- dmy(data$Date)

days <- wday(data$Date) 
table(days)
thurs <- days == 5
fri <- days == 6

thurs_sm_1 <- data$Sub_metering_1[thurs]
thurs_sm_2 <- data$Sub_metering_2[thurs]
thurs_sm_3 <- data$Sub_metering_3[thurs]
fri_sm_1 <- data$Sub_metering_1[fri]
fri_sm_2 <- data$Sub_metering_2[fri]
fri_sm_3 <- data$Sub_metering_3[fri]

png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(c(thurs_sm_1, fri_sm_1), type = "n", xaxt = "n", ylab = "Energy sub metering", xlab = "", cex.lab = 0.8)
lines(c(thurs_sm_1, fri_sm_1))
lines(c(thurs_sm_2, fri_sm_2), col = "red")
lines(c(thurs_sm_3, fri_sm_3), col = "blue")
labels = c("Thu", "Fri", "Sat")
axis(1, at = c(0, 1440, 2880), labels = labels, cex.axis = 0.8)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8, 
       lty = 1, col = c("black", "red", "blue"))
dev.off()

