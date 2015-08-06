#grab the data
library(RJSONIO)
scores <- fromJSON("https://brigades.opendatanetwork.com/api/views/jzeg-w743/rows.json")
names(scores)

#Extract the data from the JSON file
scores_data <- scores[['data']]
scores_meta <- scores[['meta']]

# method copied from http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/
library(gdata) # for the trim function
grabInfo <- function(var){
  print(paste("Variable", var, sep=" "))  
  sapply(scores_data, function(x) returnData(x, var)) 
}

returnData<-function(x, var){
  if(!is.null( x[[var]])){
    return( trim(x[[var]]))
  }else{
    return(NA)
  }
}

# do the extraction and assembly
scoredatadf<-data.frame(sapply(1:12, grabInfo), stringsAsFactors=FALSE)

grabGeoInfo<-function(val){
  
  l<- length(scores_data[[1]][[val]])
  tmp<-lapply(1:l, function(y) 
    
    sapply(scores_data, function(x){
      
      if(!is.null(x[[val]][[y]])){
        return(x[[val]][[y]])
      }else{
        return(NA)
      }
      
    })     
  )
}


fmDataGeo<-grabGeoInfo(13)
fmDataGeo<-data.frame(do.call("cbind", fmDataGeo), stringsAsFactors=FALSE)

scoredatadf<-cbind(scoredatadf, fmDataGeo)

columns<-scores[['meta']][['view']][['columns']]

getNames<-function(x){
  if(is.null(columns[[x]]$subColumnTypes)){
    return(columns[[x]]$name)
  }else{
    return(columns[[x]]$subColumnTypes)
  }
}

scoreNames <- unlist(sapply(1:length(columns), getNames))
names(scoredatadf)<- scoreNames

# Data Cleaning
scoredatadf$latitude<-as.numeric(scoredatadf$latitude)
scoredatadf$longitude<-as.numeric(scoredatadf$longitude)
scoredatadf$date <- as.Date(sapply(strsplit(scoredatadf$date, "T"), "[[", 1))

# Write data frame to csv
write.csv(scoredatadf, file = "inspections_fromJSON_2014_2015.csv", row.names=FALSE)