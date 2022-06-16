#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
  
    # Sidebar with a slider input for number of bins 
    fluidPage(

        # Show a plot of the generated distribution
        mainPanel(
          fluidRow(includeMarkdown("Text.md"),
                   withMathJax()) ,
          "Ahead two different smulated scenarios to understand the problem",
          "Then you can play with the number of liers in 
          your case to understand
          the presence of liers affect your confidence in the 
          students responses",
          fluidRow(
            h1("First scenario: nobody lies"),
            column(4,sliderInput("nliers",
                      "Deniers: say not, but yes",
                      min = 0.001,
                      max = 0.999,
                      value = 0.001),
          sliderInput("pliers",
                      "Braggers: say yes, but no",
                      min = 0.001,
                      max = 0.999,
                      value = 0.001)),
          column(8,
          plotOutput("plot1"))
          ),
          "In this scenario we can trust 100% in the student responses",
          br(),
          fluidRow(
            h1("Second scenario: everybody lies"),
            column(4,sliderInput("nliers2",
                                 "Deniers: say not, but yes",
                                 min = 0.001,
                                 max = 0.999,
                                 value = 0.999),
                   sliderInput("pliers2",
                               "Braggers: say yes, but no",
                               min = 0.001,
                               max = 0.999,
                               value = 0.999)),
            column(8,
                   plotOutput("plot2")),
            "In this scenario we can trust 0% in the student responses"),
          "Now, play with the parameters and find how the propotion of liers
          in your survey afect your trustwhorty",
          includeMarkdown("Conclusions.md"),
          
          #
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {


  conf <- function(context, nliers, pliers){ 
    
    x <- tibble(trust = ((1-nliers)*context) / 
                  (((1-nliers)*context) + ((1-context)*pliers) 
                   ),
                context=context,
                pliers=pliers, 
                nliers=nliers,
                group=c(1)) }
   
  df <- reactive({
    
      l <- list(context=seq(0.01,1,0.01),
                nliers=rep(input$nliers,100),
                pliers=rep((input$pliers),100)
               )
   
    dataset <- pmap_dfr(l,conf)
    
    return(dataset)
    })
  
  df2 <- reactive({
    
    l <- list(context=seq(0.01,0.99,0.01),
              nliers=rep(input$nliers2,99),
              pliers=rep((input$pliers2),99)
    )
    
    dataset <- pmap_dfr(l,conf)
    
    return(dataset)
  })
  
  output$tab <- renderTable(df())
  
  output$plot1 <- renderPlot({
    ggplot(df(), aes(context, trust, group=group)) +
      geom_line() +
      scale_y_continuous(breaks=seq(0,1,0.1), limits = c(0,1)) +
      labs(x="Drug prevalence (Context)",
           y="Trust")
  })
  
    output$plot2 <- renderPlot({
      ggplot(df2(), aes(context, trust, group=group)) +
        geom_line() +
        scale_y_continuous(breaks=seq(0,1,0.1), limits = c(0,1)) +
        labs(x="Drug prevalence (Context)",
             y="Trust")
  })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
