library("data.table")
library("readr")
library("dplyr")

## Given the estimated total size will be:
## Cell_size*number_of_columns*number_of_rows 8 bytes/cell * 9 columns * 2,075,259 rows
## Total size ~ 142Mb
# Extract a sample of data to look at before proceeding with full download
datasample <- read.csv(file="household_power_consumption.txt",sep = ';',nrows = 10)

# Extracting using fread for efficiency
data <- fread("household_power_consumption.txt",na.strings="?")

# Filter down on only required dates for exercise + fix data types
data <- data %>% filter(grepl("^[12]/2/2007$",Date)) %>%
  mutate(Global_active_power = as.numeric(Global_active_power),
         Datetime = as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))

# Create plot with all required annotations and characteristics
par(mfrow=c(2,2))
with(data, {plot(Datetime,Global_active_power,type="l",ylab="Global Active Power",xlab="")
  plot(Datetime,Voltage,type="l",ylab="Voltage",xlab="datetime")
  {plot(Datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  lines(Datetime,Sub_metering_2,ylab="",xlab="",col="red")
  lines(Datetime,Sub_metering_3,ylab="",xlab="",col="blue")
  legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))}
  plot(Datetime,Global_reactive_power,type="l",xlab="datetime")})

# Save plot to png
dev.copy(png,'plot4.png')
dev.off()

