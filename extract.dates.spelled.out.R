# Takes a character vector containing spelled out dates (e.g. "Due Date: November 4, 2014")
# and extracts only the date text (e.g. "November 4, 2014")

# TO DO: convert date text to Date type

extract.dates.spelled.out <- function(x){
  str_extract(x, "[:alpha:]+( )[:digit:]{1,2}, [:digit:]{4}")
}
