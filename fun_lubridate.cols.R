## Function: lubridate.cols
## Inputs:
##    df: data frame
##    date.col.name: character (must be name of a column in df)
##    date.col.format: see package "Lubridate", help file for function parse_date_time ("orders" argument)

## Action performed: take user-indicated date column of data frame df, and add extra columns...
##    week    weekday    month   day(of month)    quarter   year
##    day(of year)    year-week    year-month   year-quarter

## Output: data frame with above columns, prefaced with the name of the input date variable

lubridate.cols <- function(df, date.col.name, date.col.format = "mdy"){
  require(lubridate)
  if(!is.data.frame(df) | !is.character(date.col.name) | !is.character(date.col.format)){
    stop("df must be data frame, & date.col.name, date.col.format must be character")
  }
  if(is.na(match(date.col.name, names(df)))){
    stop("data frame df must contain column date.col.name")
  }

  twochar <- function(x){
    if(nchar(x) == 1){
      paste("0",x,sep="")
    } else {
      x
    }
  }
  
  date.col.pos <- match(date.col.name, names(df))
  new.date.col <- parse_date_time(df[,date.col.pos], date.col.format)
  
  week <- week(new.date.col)
  weekday <- wday(new.date.col)
  month <- month(new.date.col)
  day.of.month <- mday(new.date.col)
  quarter <- quarter(new.date.col)
  year <- year(new.date.col)
  day.of.year <- yday(new.date.col)
  year.week <- paste(year, sapply(week, twochar), sep="-w")
  year.month <- paste(year, sapply(month, twochar), sep="-m")
  year.quarter <- paste(year, sapply(quarter, twochar), sep="-q")
  
  df.extracols <- data.frame(week = week, weekday = weekday, month = month,
                             day.of.month = day.of.month, quarter = quarter, year = year,
                             day.of.year = day.of.year, year.week = year.week,
                             year.month = year.month, year.quarter = year.quarter)
  
  names(df.extracols) <- paste(date.col.name, names(df.extracols), sep=".")
  cbind(df, df.extracols)
}
