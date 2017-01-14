
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


getDataDictionary <- function(){
  dd <- read.csv("C:/Users/xpf100/Box Sync/DataDictionary/DataDictionaryJoined.csv")
  dd$Variable <- as.character(dd$Variable)
  return(dd)
}

dd <- getDataDictionary()


  list <- table(dd$Form)
  list <- names(list)
  ddat <- as.list(rep("", 25))
  for(i in 1:25){
    ddat[[i]]<-filter(dd,grepl(list[i], dd$Form))
  }
  aidsCond<-as.data.frame(ddat[1])
  altTreat <-as.data.frame(ddat[2])
  arvs <- as.data.frame(ddat[3])
  arvs <- filter(arvs, arvs$Form != "follow_up_antiretrovirals")
  concomMeds <-as.data.frame(ddat[4])
  demograph <-as.data.frame(ddat[5])
  dispo <-as.data.frame(ddat[6])
  follAidsCond <-as.data.frame(ddat[7])
  follARV <-as.data.frame(ddat[8])
  follLabRes <-as.data.frame(ddat[9])
  follNonAidsCond <-as.data.frame(ddat[10])
  follRX <-as.data.frame(ddat[11])
  fxScores<-as.data.frame(ddat[12])
  grtLog<-as.data.frame(ddat[13])
  labRe<-as.data.frame(ddat[14])
  labRe <- filter(labRe, labRe$Form != "follow_up_laboratory_results")
  medAdhe<-as.data.frame(ddat[15])
  nonAidsCond<-as.data.frame(ddat[16])
  nonAidsCond <- filter(nonAidsCond, nonAidsCond$Form != "follow_up_nonaids_conditions_feef")
  patFlow<-as.data.frame(ddat[17])
  rX<-as.data.frame(ddat[18])
  rX <- filter(rX, rX$Form != "follow_up_pharmacy_refills")
  psycSocFact<-as.data.frame(ddat[19])
  resist1<-as.data.frame(ddat[20])
  resist2<-as.data.frame(ddat[21])
  sesAccess<-as.data.frame(ddat[22])
  specTrack<-as.data.frame(ddat[23])
  symptoms<-as.data.frame(ddat[24])
  waterSaft<-as.data.frame(ddat[25])


  




