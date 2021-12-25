#EXPLORATORY DATA ANALYSIS PROJECT 1 


#Clear objects
rm(list=ls())

#Set wd
old.dir <- getwd()
setwd('~/Desktop/R Projects/Coursera/Exploratory Data Analysis/Week 1/Project 1')

#load libraries
library(tidyverse)
library(lubridate)

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
y <- grep('^[1,2]/2/2007', substr(x, 1,10))

colnames <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 							 	    'Global_intensity', 'Sub_metering_1',  'Sub_metering_2', 																'Sub_metering_3')

data <- read.table(text=x[y], 
		sep = ';', 
		header=TRUE,
		col.names= colnames
		)

#view data
head(data)
nrow(data)

#Convert Date and Time columns into correct format w/ lubridate
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

#Construct plot and save to png
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')

hist(data$Global_active_power, 
		main='Global Active Power', 
		xlab= 'Global Active Power (kilowatts)',
		col = 'red')

dev.off()

