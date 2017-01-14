library(shiny)
# shinyUI(fluidPage(
#   titlePanel("DRSS"),
#
#   sidebarLayout(
#     sidebarPanel("Variable Selection",
#
#
#                  selectInput("var",
#                              label = "Choose a variable to display",
#                              choices = names(df),
#                              selected = "hiv_rna1")
#
#                  ),
#     mainPanel(
#               plotOutput("main_plot")
#               )
# )))


navbarPage(
  "DRSS",
  id = "nav",
  tabPanel("Data Dictionary",
           tableOutput("ddict")),
  
  tabPanel(" Numerical Data Summary",
            HTML(numeric$output.complete)
           ),
  
  tabPanel(" Graph Numerical Data"
           
  ),
  
  tabPanel("Categorical Data Summary",
           HTML(cate$output.complete)
           ),
  
  tabPanel("Categorical")
  
  
)