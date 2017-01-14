setwd("C:/Users/xpf100/Box Sync")
library(dplyr)
library(magrittr)
library(RCurl)
library(RJSONIO)
library(lubridate)

getData <- function() {
  result <- postForm(
    uri='https://redcap.emory.edu/api/',
    #Token Here
    content='record',
    format='json',
    type='flat',
    rawOrLabel='label',
    rawOrLabelHeaders='label',
    exportCheckboxLabel='true',
    exportSurveyFields='true',
    exportDataAccessGroups='true',
    returnFormat='json'
  ) %>% fromJSON()
  result <- do.call("rbind",result) %>%
            as.data.frame.matrix() 
  result <- filter(result, result$redcap_data_access_group == 'DRSS')
  result <- result[,colSums(is.na(result))<nrow(result)]
  return(result)
}


#Clean Data frame

cleanData <- function(result) {
  
  dates <- names(result)
  dates <- dates[grepl("^dt.", dates)]
  result[,cols <- dates] <- lapply(result[,cols <- dates], ymd)
  
  
  vl <- names(result)
  vl <- vl[grepl("^hiv_rna.", vl)]
  vl <- vl[-9]
  result[,cols <- vl] <- lapply(result[,cols <- vl], as.numeric)
  
  cd4 <- names(result)
  cd4 <- cd4[grepl("^cd4.", cd4)]
  result[,cols <- cd4] <- lapply(result[,cols <- cd4], as.numeric)
  return(result)
}










