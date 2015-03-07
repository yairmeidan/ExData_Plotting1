## download zip file
fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl,destfile="household_power_consumption.zip")

## read required lines only, from specific dates
d<-subset(read.table(
  unz("household_power_consumption.zip", "household_power_consumption.txt")
  ,header=TRUE
  ,sep=";"
  ,na.strings="?"
  ,stringsAsFactors=FALSE
)
,Date %in% c("1/2/2007","2/2/2007")
)

##########
## plot 4
##########

## combine Date and Time into a single datetime variable
d$dt<-as.POSIXct(paste(dmy(d$Date), d$Time))

## save original locale, to reset later
original_locale<-Sys.getlocale("LC_TIME")

## set locale to English
Sys.setlocale("LC_TIME", "English")

## set device
png(
  file="plot4.png"
  ,width = 480
  ,height = 480
  , units = "px"
)

## set parameter for creating 4 plots (2X2) on the same device
par(mfrow = c(2, 2),bty="o")


## create plot 4.1
plot(
  x=d$dt
  ,y=d$Global_active_power
  ,type="l"
  ,main=""
  ,xlab=""
  ,ylab="Global Active Power"
)

## create plot 4.2
plot(
  x=d$dt
  ,y=d$Voltage
  ,type="l"
  ,main=""
  ,xlab="datetime"
  ,ylab="Voltage"
)

## create plot 4.3
plot(
  d$dt
  ,d$Sub_metering_1
  ,main = ""
  ,xlab=""
  ,ylab="Energy sub metering"
  ,type="l"
  ,col="black"
)
with(d, lines(dt, Sub_metering_2, col = "red"))
with(d, lines(dt, Sub_metering_3, col = "blue"))
# box(col="grey")

## add legend to plot 4.3
legend(
  "topright"
  ,lty=1
  ,pch = NA
  ,col = c("black", "red", "blue")
  ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  ,bty = "n"
)


## create plot 4.4
plot(
  x=d$dt
  ,y=d$Global_reactive_power
  ,type="l"
  ,main=""
  ,xlab="datetime"
  ,ylab="Global_reactive_power"
)

dev.off()

## reset locale to original
Sys.setlocale("LC_TIME", original_locale)