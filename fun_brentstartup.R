## This file contains packages and custom functions to load (ones that I use a lot)
## To run, source this script in R

# Commonly used packages
library(ggplot2)
library(dplyr)
library(lubridate)

#  Function: factor2character(df)
#  Go through a data frame and converts all factor fields to class "Character"
#  Source: stackoverflow comment: http://stackoverflow.com/a/14268396/4718936
  factor2character <- function(df){
    if(!is.data.frame(df)) stop("df must be of class data.frame")
    for(i in which(sapply(df, class) == "factor")) df[[i]] = as.character(df[[i]])
    return(df)
  }

# Function: setwd_windows()
# Set Working Directory with a windows filepath (with user input to the terminal)
# Source: http://stackoverflow.com/questions/17605563/efficiently-convert-backslash-to-forward-slash-in-r
  setwd_windows <- function(){
    x <- readline(prompt = "windows filepath (use single backslashes and no quotes): ")
    setwd(gsub("\\\\","/",x))
  }