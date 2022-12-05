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

# for hui page
hdata <- ds2_3 %>% 
  group_by(age, location) %>% 
  select(age,time_on_sm, location) %>% 
  summarise(time_on_sm = mean(time_on_sm)) %>% 
  as.data.frame()

# for cindy page
colNames <- final_table %>% 
  select(number_of_social_media_platforms, inappropriate_content_degree, time_on_social_media, time_on_exercise, how_much_more_hours_spend_on_social_media_compared_to_exercise) %>% 
  colnames()

# for last paage
test1 <- bangla_data$friends_on_social_media %>% unique()
test2 <- bangla_data$personal_friends_on_sm %>% unique()
test3 <- bangla_data$if_sm_is_good_thing %>% unique()
test4 <- bangla_data$emotion_influence_by_other_post %>% unique()
test5 <- bangla_data$if_no_sm_better_mental_health %>% unique()
test6 <- bangla_data$p30_feeling_down_depress_hopeless %>% unique()
test7 <- bangla_data$p30_poor_appetite_over_eating %>% unique()
test8 <- bangla_data$p30_worry_too_much %>% unique()
test9 <- bangla_data$p30_sleep_quality_rate %>% unique()

        #bangla_data <- bangla_data %>%
           # mutate(bmi = body_weight/(height*height))

# server
server <- function(input, output) {
  # hui page
  # output$line <- renderPlot({
  #   ggplot(data = (cleaned_data %>% filter(location == input$location))) +
  #     geom_line(mapping = aes(x = cleaned_data$age, y = cleaned_data$time_on_sm)) + 
  #     labs(x = "Age", y = "Hours", title = "Effects of Age and Hours on Social Media")
  #     })
  output$line <- renderPlot(return ({
    ggplot(hdata %>% filter(location == input$location), 
           aes(age, time_on_sm)) + geom_line() + 
      labs(x = "Age (Years)", 
           y = "Hours on Social Media", 
           title = "Different Ages and their Usage of Social Media")
  })
  )
  
  
  # cindy page
  output$selectVariable <- renderUI({
    selectInput("chosen", 
                "Chose a question you are interested", 
                choices = list("How many social media platforms young people have per person?" = colNames[1], 
                               "How much do young people feel that they are exposed to inappropriate content(out of 10)?" = colNames[2], 
                               "How much time do young people spend on social media on average per day?" = colNames[3], 
                               "How much time do young people spend on exercise on average per day?" = colNames[4], 
                               "How much more hours do young people spend on social media compared to exercise on average per day?" = colNames[5]), 
                selected = 1)
  })
  
  data <- reactive({
    if ( "number_of_social_media_platforms" %in% input$chosen) return(final_table$number_of_social_media_platforms)
    if ( "inappropriate_content_degree" %in% input$chosen) return(final_table$inappropriate_content_degree)
    if ( "time_on_exercise" %in% input$chosen) return(final_table$time_on_exercise)
    if ( "how_much_more_hours_spend_on_social_media_compared_to_exercise" %in% input$chosen) return(final_table$how_much_more_hours_spend_on_social_media_compared_to_exercise)
    if ( "time_on_social_media" %in% input$chosen) return(final_table$time_on_social_media)
  })
  
  unit <- reactive({
    if ( "number_of_social_media_platforms" %in% input$chosen) return("number of platforms")
    if ( "inappropriate_content_degree" %in% input$chosen) return("inappropriate degree")
    if ( "time_on_exercise" %in% input$chosen) return("hour(s)")
    if ( "how_much_more_hours_spend_on_social_media_compared_to_exercise" %in% input$chosen) return("hour(s)")
    if ( "time_on_social_media" %in% input$chosen) return("hour(s)")
  })

  output$chosenPlot <- renderPlotly({
    value <- data()
    p <- ggplot(data = final_table) + 
      geom_col(mapping = aes(x = age, y = value), fill = "lightgreen", color = "black") + 
      labs(x = "age", 
           y = unit(), 
           title = paste0(input$chosen, " Versus Age for Young People (14-23)"))+
      theme(plot.title = element_text(hjust = 0.5))
    ggplotly(p)
  })
  
  # last page
  output$selectButton <- renderUI({
    selectInput("button", 
                label = h3("Select a Variable to See its Relationship With Time on Social Media"),
                choices = list("Getting Emotionally Influenced by Other's Posts?" = "emotion", 
                                "Feeling Down, Depressed or Hopeless." = "feeling", 
                                "Poor Appetite or Aver-eating" = "appe",
                                "Worrying Too Much About Different Things" = "worry",
                                "Sleep Quality" = "sleep"), 
                 selected = 1)
  })
  
  data2 <- reactive({
    if ("emotion" %in% input$button) return(bangla_data %>% select(time_on_sm, emotion_influence_by_other_post))
    if ("feeling" %in% input$button) return(bangla_data %>% select(time_on_sm, p30_feeling_down_depress_hopeless))
    if ("appe" %in% input$button) return(bangla_data %>% select(time_on_sm, p30_poor_appetite_over_eating))
    if ("worry" %in% input$button) return(bangla_data %>% select(time_on_sm, p30_worry_too_much))
    if ("sleep" %in% input$button) return(bangla_data %>% select(time_on_sm, p30_sleep_quality_rate))
  })
  
  output$buttonPlot <- renderPlotly({
    se_data <- data2()
    v <- se_data %>% select(2) %>% unique() %>% pull()
    len <- se_data %>% select(2) %>% unique() %>% nrow()
    if (len == 3) {
      Order <- c("Always", "Sometimes", "Not at all")
    } else if ("Not at all" %in% v) {
      Order <- c("Not at all", "Several days", "Half of days", "Nearly everyday")
    } else {
      Order <- c("Very bad", "Farely bad", "Farely good", "Very good")
    }
    Extent <- factor(se_data %>% select(2) %>% pull(), Order)
    Duration <- factor(se_data$time_on_sm, levels = c("Less than 1 hour", "1-3 hours", "3-5 hours", "More than 5 hours"))

    plot1 <- ggplot(se_data, aes(fill = Extent, y = 1, x = Duration)) +
      geom_bar(position = "fill", stat = "identity") +
      labs(x = "Hour(s)", 
           y = "Proportion", 
           title = paste0(se_data %>% select(2) %>% colnames(), " versus Time on Social Meida for People in Bangladesh in 30 Days"))
    plot1
    ggplotly(plot1)
  })
  
}



  
