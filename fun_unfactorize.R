#  Function: factor2character(df)
#  Input: data frame
#  Output: data frame, with columns of class "factor" converted to class "Character"
#  Source: stackoverflow comment by user by0: http://stackoverflow.com/a/14268396/4718936

unfactorize <- function(df){
    if(!is.data.frame(df)) stop("df must be of class data.frame")
    for(i in which(sapply(df, class) == "factor")) df[[i]] = as.character(df[[i]])
    return(df)
  }
