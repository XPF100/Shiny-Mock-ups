
library(dplyr)

shinyServer(function(input, output) {

  options(shiny.maxRequestSize = 30 * 1024 ^ 2)
  # df_subset <- reactive({
  #   x <- df[, colSums(is.na(df)) < nrow(df)]
  #   x <- df[[input$var]]
  #   
  #   return(x)
  # })
  
  output$ddict <- renderTable(dd)
  
  

  
  
  # output$main_plot <- renderPlot({
  #   y = df_subset()
  #   hist(y, breaks = 5)
  # })
})