Sys.setlocale("LC_TIME", "C") #this is to set the local language as english (otherwise on my machine it will
#displays the days in italian)

setwd("/home/yoda/Desktop/dataanalysiscourse/fourthunit/assignment1")
unzip("./exdata_data_household_power_consumption.zip")

Lines <- readLines("household_power_consumption.txt") #we read each data row as a simple string line
subL <- grep("^[12]/2/2007", Lines)# we look for the first 2 days of February 2007
#we read the subsetted table according to our requirements
householdpowercons<- read.table(text=Lines[subL], header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),sep=";",na.strings="?")

#plot1
#creation of the histogram of Globale active power along these 2 days
hist(householdpowercons$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power(kilowatts)")
#export of the histogram as a png file
dev.copy(png,file="plot1.png", width = 480, height = 480)
#close the connection
dev.off()