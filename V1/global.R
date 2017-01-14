# load required libraries
library(shiny)
library(plyr)
library(ggplot2)
library(googleVis)
library(reshape2)
require(sjPlot)
library(tidyr)

#Get and clean data
source("FullDataSet.R")




if (!is.data.frame(df)) {
  df <- getData()
  df <- cleanData(df)
  class(categories$race)
  df <- df[, colSums(is.na(df)) < nrow(df)]
  nums <- sapply(df, is.numeric)
  numbers <- df[, nums]
  cats <- sapply(df, is.list)
  categories <- df[, cats]
  cats <- names(categories)
  categories[, cols <-
               cats] <- lapply(categories[, cols <- cats], unlist)
  categories[, cols <-
               cats] <- lapply(categories[, cols <- cats], as.factor)
  class(df$dt_rna1)
  dat <- sapply(df, is.Date)
  dates <- df[, dat]
  cate <- sjt.frq(categories)
  numeric <- sjt.df(numbers)
}

if (!is.data.frame(dd)) {
  dd <- read.csv("dictionary.csv")
  dd <- dd[, colSums(is.na(dd)) < nrow(dd)]
  names(dd)
  dd <-
    select(dd, one_of(
      c(
        "Variable...Field.Name",
        "Form.Name",
        "Field.Type",
        "Field.Label",
        "Choices..Calculations..OR.Slider.Labels"
      )
    ))
}