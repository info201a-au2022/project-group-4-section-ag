# library(dplyr)
# source("../source/chart_hui.R")
# source("../source/chart_haipei.R")
# source("../source/chart_cindy.R")
# 
# 
# df <- read_excel("../data/Effects_of_social_media_d1.xlsx")
library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
source("./source/table.R")
ds2_3$age <- as.numeric(substr(ds2_3$age , 1, 2))

data <- ds2_3 %>% 
  group_by(age, location) %>% 
  select(age,time_on_sm, location) %>% 
  summarise(time_on_sm = mean(time_on_sm)) %>% 
  as.data.frame()

colNames <- final_table %>% 
  select(number_of_social_media_platforms, inappropriate_content_degree, time_on_social_media, time_on_exercise, how_much_more_hours_spend_on_social_media_compared_to_exercise) %>% 
  colnames()
  
server <- function(input, output) {
  # output$line <- renderPlot({
  #   ggplot(data = (cleaned_data %>% filter(location == input$location))) +
  #     geom_line(mapping = aes(x = cleaned_data$age, y = cleaned_data$time_on_sm)) + 
  #     labs(x = "Age", y = "Hours", title = "Effects of Age and Hours on Social Media")
  #     })
  output$line <- renderPlot(return ({
    ggplot(data %>% filter(location == input$location), 
           aes(age, time_on_sm)) + geom_line()
  })
  )
  
  output$selectVariable <- renderUI({
    selectInput("chosen", "Chose a variable you are interested", choices = colNames, selected = 1)
  })
  
  data <- reactive({
    if ( "number_of_social_media_platforms" %in% input$chosen) return(final_table$number_of_social_media_platforms)
    if ( "inappropriate_content_degree" %in% input$chosen) return(final_table$inappropriate_content_degree)
    if ( "time_on_exercise" %in% input$chosen) return(final_table$time_on_exercise)
    if ( "how_much_more_hours_spend_on_social_media_compared_to_exercise" %in% input$chosen) return(final_table$how_much_more_hours_spend_on_social_media_compared_to_exercise)
    if ( "time_on_social_media" %in% input$chosen) return(final_table$time_on_social_media)
  })
  

  output$chosenPlot <- renderPlotly({
    value <- data()
    p <- ggplot(data = final_table) + 
      geom_col(mapping = aes(x = age, y = value), fill = "lightgreen", color = "black") + 
      labs(x = "age", 
           y = "tbd", 
           title = "tbd")
    ggplotly(p)
  })
}


  

# scatter_panel <- tabPanel(
#   "Scatter",
#   titlePanel("Population v.s. Vote Power"),
#   sidebarLayout(
#     scatter_sidebar_content,
#     scatter_main_content
#   )
# )
# S
# server <- function(input, output) { 
#   output$bar <- renderPlotly({ 
#     return(build_map(joined_data, input$mapvar))
#   }) 
#   output$scatter <- renderPlotly({
#     return(build_scatter(joined_data, input$search))
#   })
#   output$line <- renderPlotly({ 
#     return(build_map(joined_data, input$mapvar))
#   }) 
# }
