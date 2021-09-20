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
with(data, plot(Datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

# Save plot to png
dev.copy(png,'plot2.png')
dev.off()

