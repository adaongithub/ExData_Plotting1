
# Exploratory Data Analysis Project #1
# Program plot1.R 
# Writes a plot of a histogram of "Global Active Power" to file plot1.png
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

# We also have looked inside file "household_power_consumption.txt" and
# have noted that the dates that we are interested in (1/2/2007 and 2/2/2007,
# day/month/year) appear in the first 69518 rows of the file.
#
## ep_df <- read.csv( file=file1_unzip_path, sep=";", na.strings=c("?"), nrows=69518 )
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

# Create our plot (a histogram) in the file "plot1.png" in, you guessed it,
# PNG graphics format.  Size, color, etc. as specified in problem statement.
png( filename="plot1.png", width=480, height=480 )
hist( ep_Feb_01_02_df$Global_active_power, col="red", freq=TRUE,
      main="Global Active Power", xlab="Global Active Power (kilowatts)"
    )
dev.off()  # end the plot session to our PNG file

