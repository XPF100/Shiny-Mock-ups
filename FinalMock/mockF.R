#Final Mockup

require(shiny)
require(sjPlot)
library(ggplot2)
library(datasets)
library(dplyr)

#mock data setup
df <- as.data.frame(USArrests)
numeric <- sjt.df(df)
cate <- as.data.frame(UCBAdmissions)

categorical <- sjt.frq(cate)


# Define UI for application that draws a histogram
ui <- navbarPage("DRSS",
                 id = "nav",
                 tabPanel("Data Dictionary",
                          dataTableOutput("df2")
                          
                 ),
                 
                 tabPanel("Numeric",
                          id = "num",
                          tabsetPanel(type = "pills", 
                                      tabPanel("Data", dataTableOutput("df1")), 
                                      tabPanel("Summary", HTML(numeric$output.complete)), 
                                      tabPanel("Graph", 
                                               selectInput("select", label = h3("Variable"), 
                                                           choices = names(df)), 
                                               plotOutput("plot")
                                      )
                                      
                          )),
                 
                 tabPanel("Categorical",
                          id = "cat",
                          tabsetPanel(type = "pills",
                                      tabPanel("Data", dataTableOutput("datas")),
                                      tabPanel("Frequency Tables", HTML(categorical$output.complete))
                          )
                          
                 )
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$df1 <- renderDataTable(df)
  output$df2 <- renderDataTable(df)
  
  output$plot <- renderPlot(hist(df[, input$select],
                                 freq = FALSE,
                                 main = paste("Histogram of",input$select),
                                 xlab = paste("Variable:", input$select),
                                 ylab = "Density"
                                 
  ))
  output$datas <- renderDataTable(cate)
  
}

# Run the application 
shinyApp(ui = ui, server = server)

