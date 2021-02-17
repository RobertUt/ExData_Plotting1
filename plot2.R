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

thurs_gap <- data$Global_active_power[thurs]
fri_gap <- data$Global_active_power[fri]

png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(c(thurs_gap, fri_gap), type = "n", xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = "", cex.lab = 0.8)
lines(c(thurs_gap, fri_gap))
labels = c("Thu", "Fri", "Sat")
axis(1, at = c(0, 1440, 2880), labels = labels, cex.axis = 0.8) ### 1440 is the length of the vector
dev.off()

