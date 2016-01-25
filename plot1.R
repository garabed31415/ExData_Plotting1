## Assignment1
## Plot1.R
## read the origina table into data frame orig_df1

orig_df1 <- read.table("household_power_consumption.txt", 
                       header = TRUE,
                       sep=";",
                       na.strings = "?",
                       stringsAsFactors=FALSE)
## str(orig)_df1
## looks like "Time" and "Date" are defined as Factor variables!

## remove rows with missing date

clean_df <- na.omit(orig_df1) ## remove incomplete rows

rm(orig_df1) ## no longer needed

## use dplyr() package to transform original data frame
## into tbl_df

install.packages("dplyr")
library("dplyr")

clean_table <- tbl_df(clean_df)

rm(clean_df)

## Choose only rows with required dates - use the filter()

red_table <- filter(clean_table, Date == "1/2/2007" | Date == "2/2/2007")
rm(clean_table)## no longer needed

## red_table represents only two require dates

## nrow(red_table)  ## there are now 2880 rows here

## png(file="plot1.png")

hist(red_table$Global_active_power,
     main = "Glaobal Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

legend("topright", col="black", legend="Plot 1")


### PLEASE NOTE:Putting the legend on "topleft" blocks part of
### tip of the first colunmn.  INthe spirit of "EXPLORATORY ANALYSIS"
### I moved it to th "topright"

dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

### PLEASE NOTE:  I tried to directly create a PNG file, While the file
### was created, the file would not open , indicating lack of permission
### was was never resolved.  So I took an alternate route,which worked.

