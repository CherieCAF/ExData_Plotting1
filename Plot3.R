#download the file to load
if (!file.exists("data")) {
        dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip")
dateDownloaded<- date()

data <- read.table(unz("./data/household_power_consumption.zip", 
                       "household_power_consumption.txt"), header = TRUE,
                       sep=";", na.strings="?", stringsAsFactors=FALSE)

library(dplyr)
dat <- tbl_df(data)

library(lubridate)
dat[,1] <- lapply(dat[,1], dmy)
dat2 <- filter(dat, Date=="2007-02-01" | Date=="2007-02-02")
dat2 <- mutate(dat2, Date_Time = paste(Date, Time))
dat2$Date_Time <- ymd_hms(dat2$Date_Time)
library(datasets)
png(filename = "Plot3.png", width = 480, height = 480, units = "px")
yrange <- range(c(dat2$Sub_metering_1, dat2$Sub_metering_2,dat2$Sub_metering_3))
plot(dat2$Date_Time, dat2$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering", ylim=yrange)
lines(dat2$Date_Time, dat2$Sub_metering_2, type="l", col="Red")
lines(dat2$Date_Time, dat2$Sub_metering_3, type="l", col="Blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2",
        "Sub_metering_3"),col=(c("Black", "Red", "Blue")), lty=(c(1,1,1)))
dev.off()
