time.profile <- function(iterations, expression = {}){
     df <- data.frame(elapsed = numeric())
     
     for(i in 1:iterations){
          df <- rbind(df, system.time({
               expression
          })[3])     
     }
     names(df) <- "elapsed"
     hist(df$elapsed)
     df$elapsed
}
