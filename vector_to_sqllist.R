# Takes a vector of values and returns string of comma & single quote separated values
# (suitable as object in SQL "IN" statement)

# Example (not run)
# example.vec <- c("dog", "cat", "cats are evil demon creatures")
# vector_to_sqllist(example.vec)
# 'dog', 'cat', 'cats are evil demon creatures'

vector_to_sqllist <- function(x){
  temp.list <- vector(mode = "list", length = length(x))
  for(i in seq_along(temp.list)){
    if (i == max(seq_along(temp.list))){
      temp.list[[i]] <- paste0("\'", x[i], "\'")
    } else{
      temp.list[[i]] <- paste0("\'", x[i], "\', ")
    }
  }
  return(paste(unlist(temp.list), collapse = ""))
}
