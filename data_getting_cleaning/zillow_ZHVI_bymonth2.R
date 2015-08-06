#Get csv file from www.zillow.com/research/data --> Zillow Value Per Square Foot Index
#file location: http://files.zillowstatic.com/research/public/Zip/Zip_MedianValuePerSqft_AllHomes.csv

# Data Structure -------------------------
#Columns 1-5: RegionName (Zip), City, State, Metro, CountyName
#Columns 6+: YYYY-MM (contains ZHVI score)

#Get Data, save into data frame "ZHVI_zip"
require(RCurl)

x <- getURL("http://files.zillowstatic.com/research/public/Zip/Zip_MedianValuePerSqft_AllHomes.csv")
y <- c("character",rep("factor",times=4),rep("integer",times=229))
ZHVI_zip <- read.csv(text = x, colClasses=y)

#Organize Data into 2 sections:
#  (1) Region (zipcode, city, state, metro, county)
#  (2) Scores (zipcode, month, score, year)

# Region ----------------------------------

#data frame of just the regions (column subset of 1st 5 cols of ZHVI_zip)
regions <- ZHVI_zip[,1:5]

# Scores ----------------------------------

#example: time series of scores of zip code 10025
#get 1 row of data to use as vector to convert to time series

#get time series-like subsection of ZHVI_zip (a particular row)
#x <- ZHVI_zip[1,6:length(ZHVI_zip)]
#convert to time series object

#scores <- list()
#zips <- c()
#start_year_month <- c(1996,4)
#end_year_month <- c(2015,4)
#for (i in 1:length(ZHVI_zip[,1])){
#  zips[i] <- ZHVI_zip$RegionName[i]
#  scores[[i]] <- ts(as.vector(t(ZHVI_zip[i,6:length(ZHVI_zip)])),start_year_month,end_year_month,frequency=12)
#}
#scores <- setNames(scores,zips)

#Grab all month columns
subset(ZHVI_zip,select=6:235)
t(subset(ZHVI_zip,select=6:235))

