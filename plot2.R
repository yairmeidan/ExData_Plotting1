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
,select=c("Date","Time","Global_active_power")
)

##########
## plot 2
##########

## combine Date and Time into a single datetime variable
d$dt<-as.POSIXct(paste(dmy(d$Date), d$Time))

## save original locale, to reset later
original_locale<-Sys.getlocale("LC_TIME")

## set locale to English
Sys.setlocale("LC_TIME", "English")

png(
  file="plot2.png"
  ,width = 480
  ,height = 480
  , units = "px"
)

## create plot
plot(
  x=d$dt
  ,y=d$Global_active_power
  ,type="l"
  ,main=""
  ,xlab=""
  ,ylab="Global Active Power (kiloWatts)"
  ,bty="o"
)

dev.off()

## reset locale to original
Sys.setlocale("LC_TIME", original_locale)