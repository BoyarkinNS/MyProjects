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
setwd("C:/Users/kotko/Downloads/titanic")
df <- read.csv('Titanic.csv')

ui <- fluidPage(

    titlePanel("Titanic"),
        fluidRow(
            column(4,
                   selectInput('bar', 'Barplot', choices = c('Survived' = 'Survived',
                                                             'Pclass' = 'Pclass',
                                                             'Sex' = 'Sex'))
                    ),
            column(4,
                   selectInput('hist', 'Histogramm', choices = c('Age' = 'Age', 'Fare' = 'Fare'))
                    ),
            ),
        fluidRow(
            column(4,
                   selectInput('colorbar1', 'Choose a color:', choices = c('Red' = 'red',
                                        'Green' = 'green', 'Blue' = 'blue', 'Yellow' = 'yellow'))
                    ),
            column(4,
                   selectInput('colorbar2', 'Choose a color:', choices = c('Red' = 'red',
                                        'Green' = 'green', 'Blue' = 'blue', 'Yellow' = 'yellow'))
                    ),
            ),

        mainPanel(
           fluidRow(
               splitLayout(cellWidths = c("50%", "50%"), plotOutput("distPlot1"), plotOutput("distPlot2"))
           )
        )
)

server <- function(input, output){
    df <- read.csv('Titanic.csv')
    dataInput1 <- reactive({
        
        cols1 <- input$bar
        
    })
    colorInput1 <- reactive({
        
        color1 <- input$colorbar1
        
    })
    dataInput2 <- reactive({
        
        cols2 <- input$hist
        
    })
    colorInput2 <- reactive({
        
        color2 <- input$colorbar2
        
    })
    output$distPlot1 <- renderPlot({
        
        cols1 <- dataInput1()
        color1 <- colorInput1()
        
        barplot(table(df[, cols1]), col=color1, main = paste("Barplot of" , cols1)) 
    })
    output$distPlot2 <- renderPlot({
        
        cols2 <- dataInput2()
        color2 <- colorInput2()
        
        hist(table(df[, cols2]), col=color2, xlab=as.character(cols2), main = paste("Histogram of" , cols2)) 
    })
}
    
 
shinyApp(ui = ui, server = server)
    
