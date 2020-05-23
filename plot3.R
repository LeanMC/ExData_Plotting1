library(dplyr)

#Get the data
download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile = 'data.zip')
unzip('data.zip')

#Load the data
x <- read.table('household_power_consumption.txt', sep = ';', header = TRUE, 
                colClasses = c(rep('character', 2), rep('numeric', 7)), na.strings = '?') %>% 
    filter(grepl("^[1-2]{1}/2/2007$", Date)) %>%
    mutate(Datetime = as.POSIXct(paste(Date, Time), format = '%d/%m/%Y %H:%M:%S'))  %>% 
    select(-Date, -Time) 

#Make the plot
png('plot3.png', width = 480, height = 480)

plot(x = x$Datetime, y = x$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(x = x$Datetime, y = x$Sub_metering_2, col = 'red')
lines(x = x$Datetime, y = x$Sub_metering_3, col = 'blue')
legend("topright", legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), lty = 1)

dev.off()