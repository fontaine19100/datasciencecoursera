Sys.setlocale("LC_TIME", "C")#this is to set the local language as english (otherwise on my machine it will
#displays the days in italian)

setwd("/home/yoda/Desktop/dataanalysiscourse/fourthunit/assignment1")
unzip("./exdata_data_household_power_consumption.zip")

Lines <- readLines("household_power_consumption.txt")#we read each data row as a simple string line
subL <- grep("^[12]/2/2007", Lines)# we look for the first 2 days of February 2007
householdpowercons<- read.table(text=Lines[subL], header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),sep=";",na.strings="?")


dates<-as.Date(householdpowercons$Date,format="%d/%m/%Y")#we convert the Dates variable in the dataframe into
# Dates class in R
weeks<-weekdays(x,abbreviate=T)# we take out the days corresponding to the first 2 days of February 2007
print(weeks)

#we plot the Globale active power versus the days starting from thursday and ending on saturday at midnight
plot(householdpowercons$Global_active_power, type="l", xlab="",ylab="Global Active Power(Kilowatts)", xaxt="n") 
axis(1, at=c("0","1440", "2880"), labels=c("Thu", "Fri", "Sat")) 
#1440 : position for which Friday starts
#2880 end of the subsetted dataset, beginning of Saturday

dev.copy(png,file="plot2.png", width = 480, height = 480) #export of the histogram as a png file
dev.off() #close the connection