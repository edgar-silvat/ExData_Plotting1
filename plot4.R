plot4<-function(){
    
    #Download data
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "./household_power_consumption.zip")
    #Unzip data
    unzip("./household_power_consumption.zip")
    
    #Read file into R
    energy<-read.table("./household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",stringsAsFactors = FALSE)
    energy$Date<-as.Date(energy$Date,"%d/%m/%Y") #Change "Date" column to Date class
    energy<-energy[energy$Date=="2007-02-01"|energy$Date=="2007-02-02",] #Extract data from 2007-02-01 to 2007-02-02
    energy$Time<-paste(energy$Date,energy$Time) #Add Date to the time column. Otherwise when change to Time class it will take todays date and repeat it in all times
    energy$Time<-strptime(energy$Time,"%Y-%m-%d %H:%M:%S") #Change Time column to POSIXlt (time format for R) class
    
    #Open png Device to ouput plot
    png(filename = "plot4.png",width = 480,height=480,units="px")
    #Plot setting for a plot matrix 2 x 2
    par(mfrow=c(2,2))
    #Plot 1 (Since mfrow is being used. This is the Top Left)
    plot(energy$Time,energy$Global_active_power,type="l",xlab = "",ylab="Global Active Power")
    #Plot 2 (Top Right)
    plot(energy$Time,energy$Voltage,type="l",xlab = "datetime",ylab="Voltage")
    #Plot 3 (Bottom Left)
    plot(energy$Time,energy$Sub_metering_1,type="l",xlab = "",ylab="Energy sub metering", col="black")
    lines(energy$Time,energy$Sub_metering_2,type = "l",col="red")
    lines(energy$Time,energy$Sub_metering_3,type = "l",col="blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col=c("black","red","blue"))
    #Plot 4 (Bottom Right)
    plot(energy$Time,energy$Global_reactive_power,type="l",xlab = "datetime",ylab="Global_reactive_power",lwd=0.5)
    
    dev.off() #Close png device so it can be view
    
    
}