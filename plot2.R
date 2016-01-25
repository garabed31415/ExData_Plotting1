## Assignment1
## Plot2.R
                       
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
## Start building "plot 2" of the Assignment1

with(red_table.3,
     plot(DateTime, Global_active_power,
          type="l",
          ylab = "Global Active Power (kilowatts)"))

legend("topleft", pch=1, col="black", legend="Plot 2")

dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!



