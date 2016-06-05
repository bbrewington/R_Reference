# Code source: http://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r

readUrl <- function(url) {
     out <- tryCatch(
          {
               # Just to highlight: if you want to use more than one 
               # R expression in the "try" part then you'll have to 
               # use curly brackets.
               # 'tryCatch()' will return the last evaluated expression 
               # in case the "try" part was completed successfully
               
               message("This is the 'try' part")
               
          },
          error=function(cond) {
               message("___ caused an error")
               message("Here's the original error message:")
               message(cond)
               # Choose a return value in case of error
               return(NA)
          },
          warning=function(cond) {
               message("___ caused a warning")
               message("Here's the original warning message:")
               message(cond)
               # Choose a return value in case of warning
               return(NULL)
          },
          finally={
               # NOTE:
               # Here goes everything that should be executed at the end,
               # regardless of success or error.
               # If you want more than one expression to be executed, then you 
               # need to wrap them in curly brackets ({...}); otherwise you could
               # just have written 'finally=<expression>' 
               message("[Insert action taken]")
               message("Some other message at the end")
          }
     )    
     return(out)
}
