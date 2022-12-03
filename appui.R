# library(shiny)
# library(plotly)


#introduction_content <- sidebarPanel(
library(markdown)
library(shiny)

introduction_page <-tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  fluidPage(
    includeMarkdown("intro.rmd")
  )
)
report_page <- tabPanel(
  "Report",
  titlePanel("The Final Report"),
  fluidPage(
    includeMarkdown("index.rmd")
  )
)
#   
#   fluidPage(
#   includeMarkdown("index.rmd")
# )
# 
# scatter_panel <- tabPanel(
#   "Report",
#   titlePanel("The Final Report"),
#   sidebarLayout(
#     
    
    
    
    
#cindy map maybe with country?
#map_sidebar_content <- sidebarPanel(
#  selectInput(
#    "r",
#    label = "Which Country to Map",
#    choices = list(
#      "Bangledash" = "",
#      "India" = "",
#      "America" = ""
#    )
#  )
#)
ui <- navbarPage(
  "Group 4",
  introduction_page,
  report_page
)
# ui <- navbarPage(
#   "Introduction",
# #  bar_panel, 
# # line_panel,
# #  scatter_panel,
#   "Report"
# )
