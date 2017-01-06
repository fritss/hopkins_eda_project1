# the days of the weeks have to be printed in English, not in my own language.
# I suspect that this works only under Windows
Sys.setlocale("LC_TIME", "English")

# set the data file
DataFile <- "household_power_consumption.txt"

#set the plotfile
plot3 <- "plot3.png"

# read the file "household_power_consumption.txt"
df <- read.csv(DataFile, sep=";", header = TRUE, na.strings = "?" )

# convert the dates and take the two-days subset
df$DateC <- as.Date(df$Date, format="%d/%m/%Y")
df_feb <- df[df$DateC=="2007-02-01" | df$DateC=="2007-02-02",]

# convert the date/time of this subset
df_feb$DateTime <- strptime(paste(df_feb$Date, df_feb$Time), format= "%d/%m/%Y %H:%M:%S")

# the dataframe may contain NA's. Remove them
df_feb <- df_feb[ !is.na(df_feb$DateTime)
                & !is.na(df_feb$Sub_metering_1)
                & !is.na(df_feb$Sub_metering_2)
                & !is.na(df_feb$Sub_metering_3)
                ,]

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
