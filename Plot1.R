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

library(datasets)
png(filename = "Plot1.png",
    width = 480, height = 480, units = "px")
hist(dat2$Global_active_power, col="Red", main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()