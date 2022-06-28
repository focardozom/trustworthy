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
library(markdown)
library(plotly)
library(scales)

# Define UI for application that draws a histogram
ui <- fluidPage(
        mainPanel(
          fluidRow(includeMarkdown("Text.md"),
                   withMathJax()
                   ),
          fluidRow(
            h2("First scenario: almost nobody lies"),
            column(4,
                   sliderInput("deniers",
                      "Deniers: say not, but yes",
                      min = 0.001,
                      max = 0.999,
                      value = 0.001),
                   sliderInput("braggers",
                      "Braggers: say yes, but no",
                      min = 0.001,
                      max = 0.999,
                      value = 0.001)
                   ),
            column(8,
                   plotlyOutput("plot1")
                   )
            ),
          br(),
          fluidRow(
          " In settings where drug use is rare, the trust is around 90%. However, after 10% of prevalence, the trust is 99%. ",
          ),
          br(),
          fluidRow(
            h2("Second scenario: almost everybody lies"),
            column(4,
                   sliderInput("deniers2",
                               "Deniers: say not, but yes",
                                 min = 0.001,
                                 max = 0.999,
                                 value = 0.999),
                   sliderInput("braggers2",
                               "Braggers: say yes, but no",
                               min = 0.001,
                               max = 0.999,
                               value = 0.999)),
            column(8,
                   plotlyOutput("plot2")
                   )),
          fluidRow(
          "In this setting, the trust is very close to 0%. In settings where the prevalence of drug is 99%, 
          trust increase slightly to 0.09."),
          br(),
          fluidRow(
          "What happen when the denniers and braggers are 50%?"
          ),
          br(),
          fluidRow(
          "Play with the parameters and see how the propotion of liers
          in your survey afect your trustwhorty"),
          br(),
          includeMarkdown("Conclusions.md"),
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {


  conf <- function(prevalence, deniers, braggers){ 
    
    #VPP = P(A) * P (B|A) / (P(A) * P (B|A)) + (1- P(A))* (1 - (P(¬B|¬A))
    
    x <- tibble(trust = (prevalence*(1-deniers)) / 
                  ((prevalence*(1-deniers)) + (braggers*(1-prevalence))),
                prevalence=prevalence,
                braggers=braggers, 
                deniers=deniers,
                group=c(1)) }
   
  df <- reactive({
    
      l <- list(prevalence=seq(0.01,0.99,0.01),
                deniers=rep(input$deniers,99),
                braggers=rep((input$braggers),99)
               )
   
    dataset <- pmap_dfr(l,conf)
    
    return(dataset)
    })
  
  df2 <- reactive({
    
    l <- list(prevalence=seq(0.01,0.99,0.01),
              deniers=rep(input$deniers2,99),
              braggers=rep((input$braggers2),99)
    )
    
    dataset <- pmap_dfr(l,conf)
    
    return(dataset)
  })
  
  output$tab <- renderTable(df())
  
  output$plot1 <- renderPlotly({
    
      gr <- ggplot(df(), aes(prevalence, trust, group=group)) +
      geom_line() +
      scale_y_continuous(breaks=seq(0,1,0.1), 
                         limits = c(0,1)) +
      scale_x_continuous(labels = scales::percent,
                         breaks = seq(0,1,0.15)) +
      labs(x="Drug prevalence (prevalence)",
           y="Trust")
        
      ggplotly(gr)
  })
  
    output$plot2 <- renderPlotly({
      
      gr <- ggplot(df2(), aes(prevalence, trust, group=group)) +
        geom_line() +
        scale_y_continuous(breaks=seq(0,1,0.1), 
                           limits = c(0,1)) +
        scale_x_continuous(labels = scales::percent,
                           breaks = seq(0,1,0.15)) +
        labs(x="Drug prevalence (prevalence)",
             y="Trust")
      
      ggplotly(gr)
  })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
