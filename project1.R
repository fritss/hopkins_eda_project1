# the days of the weeks have to be printed in English, not in my own language.
# I suspect that this works only under Windows
Sys.setlocale("LC_TIME", "English")

# set the data file
DataFile <- "household_power_consumption.txt"

#set the plotfiles
plot1 <- "plot1.png"
plot2 <- "plot2.png"
plot3 <- "plot3.png"
plot4 <- "plot4.png"

# read the file "household_power_consumption.txt"
df <- read.csv(DataFile, sep=";", header = TRUE, na.strings = "?" )

# convert the dates and take the two-days subset
df$DateC <- as.Date(df$Date, format="%d/%m/%Y")
df_feb <- df[df$DateC=="2007-02-01" | df$DateC=="2007-02-02",]

# convert the date/time of this subset
df_feb$DateTime <- strptime(paste(df_feb$Date, df_feb$Time), format= "%d/%m/%Y %H:%M:%S")

# the dataframe may contain NA's. Remove them
df_feb <- df_feb[ !is.na(df_feb$DateTime)
                  & !is.na(df_feb$Global_active_power)
                  & !is.na(df_feb$Global_reactive_power)
                  & !is.na(df_feb$Sub_metering_1)
                  & !is.na(df_feb$Sub_metering_2)
                  & !is.na(df_feb$Sub_metering_3)
                  & !is.na(df_feb$Voltage)
                  ,]

# compose plot 1
png(file=plot1, width = 480, height = 480)
hist(df_feb$Global_active_power, col="red", main="Global Active Power", xlab="Global ActivePower (kilowatts)")
dev.off()

# compose plot 2
png(file=plot2, width = 480, height = 480)
with(df_feb, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()

# compose plot 3
png(file=plot3, width = 480, height = 480)
with(df_feb, {
     plot(DateTime, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
     lines(DateTime, Sub_metering_2, col="red")
     lines(DateTime, Sub_metering_3, col="blue") }
    )
lcolors <- c("black", "red", "blue")
lnames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", col=lcolors, lty=1, legend=lnames)
dev.off()

# compose plot 4, this plot contains 4 subplots
png(file=plot4, width = 480, height = 480)
par(mfrow = c(2,2), mar = c(5,4,3,2))

# subplot1
with(df_feb, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))

# subplot2
with(df_feb, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))

# subplot3
with(df_feb, {
  plot(DateTime, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue") }
)
legend("topright", cex=.9, bty="n", col=lcolors, lty=1, legend=lnames)

# subplot4
with(df_feb, plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))
dev.off()


