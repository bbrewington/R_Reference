# Function: setwd_windows()
# Set Working Directory with a windows filepath
# Author: Brent Brewington, https://github.com/bbrewington

# Thanks to Arun (http://stackoverflow.com/users/559784/arun) for his response at...
# http://stackoverflow.com/questions/17605563/efficiently-convert-backslash-to-forward-slash-in-r

setwd_windows <- function(){
    x <- readline(prompt = "windows filepath (use single backslashes and no quotes): ")
  setwd(gsub("\\\\","/",x))
}