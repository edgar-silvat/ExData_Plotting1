
plot1<-function(){
    
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
    
    png(filename = "plot1.png",width = 480,height=480,units="px") #Open png Device to ouput plot
    hist(energy$Global_active_power,main="Global Active Power",col="red",xlab = "Global Active Power (kilowatts)") #Make Plot
    dev.off() #Close png device so it can be view
    
}
