require(shiny)
require(sjPlot)
numeric <- sjt.df(mtcars)
server <- function(input, output) {
  output$df <- renderDataTable(mtcars)
  
  output$plot <- renderPlot(hist(mtcars[, input$select],
                                 freq = FALSE,
                                 main = paste("Histogram of",input$select),
                                   xlab = paste("Variable:", input$select),
                                   ylab = "Density"
                                   # breaks = input$slider1
                                 
                                 ))
                            
}







ui <- navbarPage("DRSS",
                 id = "nav",
                tabPanel("Data Dictionary"
                         
                         ),
                
                tabPanel("Numeric",
                         id = "num",
                         tabsetPanel(type = "pills", 
                                     tabPanel("Data", dataTableOutput("df")), 
                                     tabPanel("Summary", HTML(numeric$output.complete)), 
                                     tabPanel("Graph", 
                                              selectInput("select", label = h3("Variable"), 
                                                          choices = names(mtcars), 
                                              
                                     
                                              
                                              plotOutput("plot"))
                         ))
                         
                         ),
                
                tabPanel("Categorical",
                         id = "cat",
                         tabsetPanel(type = "pills",
                                      tabPanel("Data"),
                                      tabPanel("Frequency Tables")
                          )
                          
                         )
)


shinyApp(ui = ui, server = server)
