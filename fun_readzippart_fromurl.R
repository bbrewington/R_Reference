# Function: readzippart_fromurl
# What it does: Without saving the zip file itself, download & unzip a single file from it
## Source: http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data

readzippart_fromurl <- function(zipurl, filetoget, filetype = "table"){
  # Set up temp file connection & download zip file to that temp connection
  temp <- tempfile()
  download.file(zipurl, temp)
  
  # Read contents of file specified by "filetoget", method given by "filetype"
  if(filetype == "table"){
    data <- read.table(unz(temp, filetoget))
  } else if(filetype == "csv"){
    data <- read.csv(unz(temp, filetoget))
  }
  
  # Close temp file connection
  unlink(temp)
  
  # Return data as data frame
  data
}

# Example: read a1.dat from a1.zip
a1 <- readzippart_fromurl("http://www.newcl.org/data/zipfiles/a1.zip", "a1.dat")