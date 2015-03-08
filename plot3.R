
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
,select=c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3")
)

##########
## plot 3
##########

## install package "lubridate" only if needed
ipc<-as.data.frame(installed.packages())
if(!("lubridate" %in% ipc$Package)){install.packages("lubridate")}
library("lubridate")

## combine Date and Time into a single datetime variable
d$dt<-as.POSIXct(paste(dmy(d$Date), d$Time))

## save original locale, to reset later
original_locale<-Sys.getlocale("LC_TIME")

## set locale to English
Sys.setlocale("LC_TIME", "English")

png(
  file="plot3.png"
  ,width = 480
  ,height = 480
  , units = "px"
)

## create plot
plot(
  d$dt
  ,d$Sub_metering_1
  ,main = ""
  ,xlab=""
  ,ylab="Energy sub metering"
  ,type="l"
  ,col="black"
  ,bty="o"
  )
with(d, lines(dt, Sub_metering_2, col = "red"))
with(d, lines(dt, Sub_metering_3, col = "blue"))
# box(col="grey")

## add legend
legend(
  "topright"
  ,lty=1
  ,pch = NA
  ,col = c("black", "red", "blue")
  ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.off()

## reset locale to original
Sys.setlocale("LC_TIME", original_locale)