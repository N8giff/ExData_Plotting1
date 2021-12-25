#EXPLORATORY DATA ANALYSIS PROJECT 1 (plot 4)


#Clear objects
rm(list=ls())

#Set wd
old.dir <- getwd()
setwd('~/Desktop/R Projects/Coursera/Exploratory Data Analysis/Week 1/Project 1')

#load libraries
library(tidyverse)
library(tibble)

#Download data to wd
zipfile <- 'electric_power_consumption.zip'
filename <- 'household_power_consumption.txt'

if(!file.exists(zipfile)) {
  URL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  
  download.file(URL, destfile= './electric_power_consumption.zip', method='curl')
}

if(!file.exists(filename)) {
  unzip(zipfile)
}


#Load data into R for 1/2/2007 and 2/2/2007 (dd/mm/yyyy)
x <- readLines('./household_power_consumption.txt')
y <- grep('^[1,2,]/2/2007', substr(x, 1,10))

colnames <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 							 	    'Global_intensity', 'Sub_metering_1',  'Sub_metering_2', 																'Sub_metering_3')

data <- read.table(text=x[y], 
		sep = ';', 
		header=TRUE,
		col.names= colnames
		)

as_tibble(data)

#view data
head(data, 2)
nrow(data)
ncol(data)

#Add new column, datetime
data$datetime <-  as.POSIXct(paste(data$Date, data$Time), 
				 format = "%d/%m/%Y %H:%M:%S"
)

#View new column
colnames(data)
data$datetime[1:5] #first 5 elements


#Construct plot and save to png
png(filename = 'plot4.png', width = 480, height = 480, units = 'px') #open device

#set device structure 
par(mfrow = c(2,2))

#plot 1
plot(data$datetime, data$Global_active_power,
				type = 'l',
				main = ' ',
				xlab = ' ',
				ylab = 'Global Active Power'
		)

#plot 2
plot(data$datetime, data$Voltage,
				type = 'l',
				main = ' ',
				xlab = 'datetime',
				ylab = 'Voltage'
		)

#plot 3
plot(data$datetime, data$Sub_metering_1,
				type = 'l',
				main = ' ',
				xlab = ' ',
				ylab = 'Energy sub metering'
		)
lines(data$datetime, data$Sub_metering_2,
				col = 'red'
		)
lines(data$datetime, data$Sub_metering_3,
				col = 'blue'
		)	
legend('topright',
			col = c('black', 'red', 'blue'),
			c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
			lty=c(1,1),
			lwd=c(1,1)
		)

#plot 4
plot(data$datetime, data$Global_reactive_power,
				type = 'l',
				main = ' ',
				xlab = 'datetime',
				ylab = 'Global_reactive_power'
		)

dev.off()

