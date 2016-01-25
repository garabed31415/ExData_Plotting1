## Assignment1
## Plot4.R

orig_df1 <- read.table("household_power_consumption.txt", 
                       header = TRUE,
                       sep=";",
                       na.strings = "?",
                       stringsAsFactors=FALSE)
### str(orig_df1)
## 'data.frame':  2075259 obs. of  9 variables:
## Date and Time are "character" variable; all the rest are "numeric"

## remove rows with missing data:

clean_df <- na.omit(orig_df1) ## remove incomplete rows
rm(orig_df1)  ## no longer needed

## use dplyr() function to transform original data frame into table data frame 

install.packages("dplyr")
library("dplyr")

clean_table <- tbl_df(clean_df)   ## preparing for "dplyr"package 

rm(clean_df)   ## no longer needed

## Choose only rows with required dates - use the filter function

red_table <- filter(clean_table, Date == "1/2/2007" | Date == "2/2/2007")

rm(clean_table)  ## no longer needed

## nrow(red_table)  #### [1] 2880

## Data and Time  variables

## Concatenate Date and Tinme into one POSIXct DateTime Variable

install.packages("lubridate")
library("lubridate")

red_table.2 <- mutate(red_table, DateTime = ymd_hms(paste(dmy(Date), Time, sep= " ")))
## str(red_table.2)  ## The new variable DateTime POSIXct
## Now drop variables "Date" and "Time"

red_table.3 <- select(red_table.2, DateTime,
                      Global_active_power:Sub_metering_3)
rm(red_table.2)
## Start building "plot 3" of the Assignment1

par(mfrow = c(2,2))
par(mar=c(1, 4, 1,1))

with(red_table.3,
     plot(DateTime, Global_active_power,
          type="l",
          ylab = "Global Active Power"))


with(red_table.3,
     plot(DateTime, Voltage,
          type="l",
          ylab = "Voltage"))

x <-   red_table.3$DateTime
y1 <-  red_table.3$Sub_metering_1
y2 <-  red_table.3$Sub_metering_2
y3  <- red_table.3$Sub_metering_3

with(red_table.3,
     plot(DateTime, y1, type="l", col="black",
          ylab = "Energy sub metering)"))

lines(x, y2, col="red")
lines(x, y3, col="blue")

legend("topright", pch=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## legend("topleft", pch=1, col="black", legend="Plot 3")

with(red_table.3,
     plot(DateTime, Global_reactive_power,
          type="l",
          ylab = "Global_reactive_Power",
          xlab = "datetime"))


dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!


