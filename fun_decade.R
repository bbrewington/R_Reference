## decade.R: take a 4 digit number and calculate its decade
## defined as: [first 2 digits] [3rd digit] [0's]

decade <- function(year){
     if(!is.numeric(year) | !nchar(as.character(year)) == 4){
          stop("year must a 4 digit number")
     }
     paste0(substr(year,1,2),substr(year,3,3),"0's")
}
