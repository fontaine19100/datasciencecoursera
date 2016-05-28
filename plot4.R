Sys.setlocale("LC_TIME", "C")#this is to set the local language as english (otherwise on my machine it will
#displays the days in italian)

setwd("/home/yoda/Desktop/dataanalysiscourse/fourthunit/assignment1")
unzip("./exdata_data_household_power_consumption.zip")

Lines <- readLines("household_power_consumption.txt")#we read each data row as a simple string line
subL <- grep("^[12]/2/2007", Lines)# we look for the first 2 days of February 2007
householdpowercons <- read.table(text=Lines[subL], header = TRUE, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),sep=";",na.strings="?")

x<-as.Date(inSub$Date,format="%d/%m/%Y")
y<-weekdays(x,abbreviate=T)


par(mar=c(4,4,2,2)) #we enlarge the outer margins at bottom and left
par(mfrow=c(2,2)) # we create an array of plots 2x2 by rows
#upper left plot
plot(householdpowercons$Global_active_power, type="l", xlab="",ylab="Global Active Power", xaxt="n") 
axis(1, at=c("0","1440", "2880"), labels=c("Thu", "Fri", "Sat"))

#upper right plot
plot(householdpowercons$Voltage, type="l", xlab="",ylab="Voltage", xaxt="n") 
axis(1, at=c("0","1440", "2880"), labels=c("Thu", "Fri", "Sat"))
mtext("datetime", side = 1,line=2.5, at=1440)

#lower left plot
plot(householdpowercons$Sub_metering_1, type="l", xlab="",ylab="Energy sub metering", xaxt="n")
lines(householdpowercons$Sub_metering_2,col="red")
lines(householdpowercons$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),lty = 1, col = c("black","red","blue"))
axis(1, at=c("0","1440", "2880"), labels=c("Thu", "Fri", "Sat"))

#loer right plot
plot(householdpowercons$Global_reactive_power, type="l", xlab="",ylab="Global Reactive Power", xaxt="n") 
axis(1, at=c("0","1440", "2880"), labels=c("Thu", "Fri", "Sat"))
mtext("datetime", side = 1,line=2.5, at=1440)

dev.copy(png,file="plot4.png", width = 480, height = 480) #export of the histogram as a png file
dev.off() #close the connection