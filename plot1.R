# the days of the weeks have to be printed in English, not in my own language.
# I suspect that this works only under Windows
Sys.setlocale("LC_TIME", "English")

# set the data file
DataFile <- "household_power_consumption.txt"

#set the plotfile
plot1 <- "plot1.png"

# read the file "household_power_consumption.txt"
df <- read.csv(DataFile, sep=";", header = TRUE, na.strings = "?" )

# convert the dates and take the two-days subset
df$DateC <- as.Date(df$Date, format="%d/%m/%Y")
df_feb <- df[df$DateC=="2007-02-01" | df$DateC=="2007-02-02",]

# convert the date/time of this subset
df_feb$DateTime <- strptime(paste(df_feb$Date, df_feb$Time), format= "%d/%m/%Y %H:%M:%S")

# the dataframe may contain NA's. Remove them
df_feb <- df_feb[ !is.na(df_feb$DateTime) &!is.na(df_feb$Global_active_power),]

# compose plot 1
png(file=plot1, width = 480, height = 480)
hist(df_feb$Global_active_power, col="red", main="Global Active Power", xlab="Global ActivePower (kilowatts)")
dev.off()
