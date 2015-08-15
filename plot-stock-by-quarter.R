## Get stock quote from quantmod, and plot quarterly opening values using ggplot

splitindex <- function(x){
  #split index of CRI.quarterly (format: YYYY Q#)
  x.indexsplit <- strsplit(as.character(index(x)), split = " Q")
  
  quarter <- unlist(lapply(x.indexsplit, "[[", 2))
  year <- unlist(lapply(x.indexsplit, "[[", 1))
  data.frame(quarter = as.numeric(quarter), year = as.numeric(year), stringsAsFactors=FALSE)
}

factor2character <- function(df){
  if(!is.data.frame(df)) stop("df must be of class data.frame")
  for(i in which(sapply(df, class) == "factor")) df[[i]] = as.character(df[[i]])
  return(df)
}

# get stock quote and extract quarterly data
# reference on subsetting quantmod object: http://www.quantmod.com/examples/data/#subset
library(quantmod)
library(dplyr)
symbol <- "CRI"
# get stock quote if don't have it already
if(!(symbol %in% ls())){
  getSymbols(symbol)
}

# extract quarterly data
CRI.quarterly <- to.quarterly(CRI)
df.quarters <- splitindex(CRI.quarterly)
df <- cbind(df.quarters, open = as.numeric(CRI.quarterly[,1]))

# line ggplot (x axis: quarter, y axis: open, faceted by year)
ggplot(df, aes(quarter, open)) + geom_line() + facet_grid(.~year) + 
  ggtitle(paste(symbol,"Opening Price (by Quarter)"))
