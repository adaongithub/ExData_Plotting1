
# Exploratory Data Analysis Project #1
# Program plot4.R 
# Writes a four-plot panel to file plot4.png
#
# See the project's problem statement for details.


# Download and read in the electric power data set for this program:

dirname              <- "../data"
file1_local_zip_name <- "electric_power.zip"

file1_path <- paste( dirname, file1_local_zip_name, sep="/" )

# Only take the time to download the .zip file if it's not already downloaded
if ( ! file.exists( file1_path ) )
{  # .zip file not here so download it and unzip() it
   dir.create( dirname )
   file1_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   # for Mac use method="curl"; for Windows don't
   # download.file( file1_URL, destfile=file1_path, method="curl" )
   download.file( file1_URL, destfile=file1_path )
   unzip( file1_path, exdir=dirname )
}

# We already manually took a look inside the .zip and know the name of the
# single .txt data file that it contains.

file1_local_unzip_name <- "household_power_consumption.txt"
file1_unzip_path       <- paste( dirname, file1_local_unzip_name, sep="/" )

ep_df <- read.csv( file=file1_unzip_path, sep=";", na.strings=c("?") )

# Now only keep, in ep_Feb_01_02_df, the rows for those two dates just above.
rows_1 <- grepl( "^1/2/2007", x=as.character(ep_df$Date) )
rows_2 <- grepl( "^2/2/2007", x=as.character(ep_df$Date) )
ep_Feb_01_02_df <- ep_df[ rows_1 | rows_2 , ]

# Add a new column with an R POSIXct Date-Time for each row.
# (Note, we don't use this column in this program but will in later programs.)
fmt <- "%d/%m/%Y %H:%M:%S"
ep_Feb_01_02_df$DateTime <- 
	as.POSIXct( paste( ep_Feb_01_02_df$Date, ep_Feb_01_02_df$Time ),
		    format=fmt
		  )

# Create our plot (four plots in panels) in the file "plot4.png" in
# PNG graphics format.  Size, color, etc. as specified in problem statement.
png( filename="plot4.png", width=480, height=480 )

par( mfcol=c(2,2) )

# Upper-Left Panel: Plot "Global Active Power" versus Time
#   (From plot2.R which writes the file plot2.png)
plot( x=ep_Feb_01_02_df$DateTime, y=ep_Feb_01_02_df$Global_active_power, 
      type="l",
      xlab="",
      ylab="Global Active Power"
    )


# Lower-Left Panel: Plot "Energy sub metering" (3 variables) versus Time
#   (From plot3.R which writes the file plot3.png)

plot( x=ep_Feb_01_02_df$DateTime,
      y=ep_Feb_01_02_df$Sub_metering_1, 
      type="l", col="black",
      xlab="",
      ylab="Energy sub metering"
    )
lines( x=ep_Feb_01_02_df$DateTime,
       y=ep_Feb_01_02_df$Sub_metering_2, 
       type="l", col="red"
    )
lines( x=ep_Feb_01_02_df$DateTime,
       y=ep_Feb_01_02_df$Sub_metering_3, 
       type="l", col="blue"
    )
# Instructors seem to be trying to be tricky by not having a border for
# the legend box for this composite plot; hence, the bty="n" option below.
legend( "topright",
        legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ),
        col    = c(          "black",            "red",           "blue" ),
        lty    = c(                1,                1,                1 ),
        bty    = "n"
      )

# Upper-Right Panel: Plot "Voltage" versus Time
plot( x=ep_Feb_01_02_df$DateTime, y=ep_Feb_01_02_df$Voltage, 
      type="l",
      xlab="datetime",
      ylab="Voltage"
    )

# Lower-Right Panel: Plot "Global_reactive_power" versus Time
plot( x=ep_Feb_01_02_df$DateTime, y=ep_Feb_01_02_df$Global_reactive_power, 
      type="l",
      xlab="datetime",
      ylab="Global_reactive_power"
    )

dev.off()  # end the plot session to our PNG file

