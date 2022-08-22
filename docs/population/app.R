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
library(plotly)
library(rsconnect)

data("population")
population <- population

# Define UI for application that draws a histogram
ui <- fluidPage(
  selectInput(inputId = "countries",
              label = "Select a country:",
              choices = c(population %>% 
                            select(country) %>%
                            distinct(country)
              )
              
  )
  ,
  plotlyOutput(outputId ="line_plot") 
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  country_df <- reactive({
    population %>%
      filter(country == input$countries)
  })
  
  output$line_plot <- renderPlotly({
    country_df() %>%
      ggplot()+
      geom_line(aes(x=year, y=population))+
      ggtitle("Number of population per year")+
      xlab("YEAR")+
      ylab("POPULATION")
  })
  
}







# Run the application 
shinyApp(ui, server)
