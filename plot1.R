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
         Date = as.Date(Date))

# Create plot with all required annotations and characteristics
hist(data$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col="red")

# Save plot to png
dev.copy(png,'plot1.png')
dev.off()

