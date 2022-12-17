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
library(bslib)

# Define UI for application that draws a histogram

ui <- fluidPage(
 theme = bs_theme(
    bg = "#f0f8ff", fg = "black", primary = "#9966cc",
    base_font = font_google("Dosis"),
    code_font = font_google("Dosis")
  ),
        mainPanel(
          fluidRow(includeMarkdown("Text_start.md")),
          fluidRow(includeMarkdown("formula.md"),
                   withMathJax()),
          fluidRow(includeMarkdown("Text_end.md"),
                   ),
          h2("First scenario: almost nobody lies"),
          fixedRow(
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
                   plotOutput("plot1")
                   )
            ),
          br(),
          "In settings where drug use is rare, trust in student
          responses is typically around 90%. However, when 
          the prevalence of drug use increases to 10%, 
          the trust in student responses increases to 99%",
          br(),
          h2("Second scenario: almost everybody lies"),
          fixedRow(
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
                   plotOutput("plot2")
                   )),
          fixedRow(
          "In a setting where lying is the norm, trust is very low. 
          However, if the use of drugs is also very common, trust may increase slightly."),
          br(),
          fixedRow(
          h4("What happens when 50%-50% of the students are deniers and braggers?")
          ),
          br(),
          fixedRow(
            "You can try changing the proportions of deniers and braggers 
            in the simulation and observe how it affects the trustworthiness
            of the data. This can be a helpful way to understand the impact of 
            these types of reporting biases and to identify strategies for 
            minimizing their influence."),
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
  
  output$plot1 <- renderPlot({
    
      gr <- ggplot(df(), aes(prevalence, trust, group=group)) +
      geom_line(size=1.2, color="#9966cc") +
      scale_y_continuous(breaks=seq(0,1,0.1), 
                         limits = c(0,1)) +
      scale_x_continuous(labels = scales::percent,
                         breaks = seq(0,1,0.15)) +
      labs(x="Drug prevalence (prevalence)",
           y="Trust") +
        theme_minimal() +
        theme(plot.background = element_rect(fill = '#f0f8ff',
                                             colour = "#f0f8ff"), 
              panel.background = element_rect(fill = '#f0f8ff',colour="#f0f8ff"),
              panel.grid.major = element_line(colour = "grey90")) 
      gr
  })
  
    output$plot2 <- renderPlot({
      
      gr <- ggplot(df2(), aes(prevalence, trust, group=group)) +
        geom_line(size=1.2, color="#9966cc") +
        scale_y_continuous(breaks=seq(0,1,0.1), 
                           limits = c(0,1)) +
        scale_x_continuous(labels = scales::percent,
                           breaks = seq(0,1,0.15)) +
        labs(x="Drug prevalence (prevalence)",
             y="Trust") +
        theme_minimal() +
        theme(plot.background = element_rect(fill = '#f0f8ff',
                                             colour = "#f0f8ff"), 
              panel.background = element_rect(fill = '#f0f8ff',colour="#f0f8ff"),
              panel.grid.major = element_line(colour = "grey90"))
      
      gr
  })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
