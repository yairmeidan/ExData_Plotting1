
## download zip file only if needed
if (!file.exists("household_power_consumption.zip")) {
  fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(fileUrl,destfile="household_power_consumption.zip") 
}

## read required lines only, from specific dates
d<-subset(read.table(
  unz("household_power_consumption.zip", "household_power_consumption.txt")
  ,header=TRUE
  ,sep=";"
  ,na.strings="?"
  ,stringsAsFactors=FALSE
)
,Date %in% c("1/2/2007","2/2/2007")
,select="Global_active_power"
)

##########
## plot 1
##########

png(
  file="plot1.png"
  ,width = 480
  ,height = 480
  , units = "px"
)

hist(
  d$Global_active_power
  ,col="red"
  ,main="Global Active Power"
  ,xlab="Global Active Power (kiloWatts)"
  ,ylab="Frequency"
  ,border=TRUE
  ,bty="l"
)

dev.off()