# library(shiny)
# library(plotly)


#introduction_content <- sidebarPanel(
library(markdown)
library(shiny)

introduction_page <-tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  fluidPage(
    includeMarkdown("./docs/intro.Rmd")
  )
)
report_page <- tabPanel(
  "Report",
  titlePanel("The Final Report"),
  fluidPage(
    includeMarkdown("./docs/index.Rmd")
  )
)

hui_side <- sidebarPanel(
  selectInput(inputId = "location", 
               label = "Choose a Country", 
               choices = list("Bangladesh" ="bangladesh" ,
                              "India" = "India")
  )
  )

hui_main <- mainPanel(
  plotOutput("line")
)
  

hui_page <- tabPanel(
  "Time on Media",
  titlePanel("Age and Hours Used"),
  sidebarLayout(
    hui_side,
    hui_main
  )
)
cindy_page <- tabPanel(
    "Youth Analysis", 
    titlePanel("Understanding the Behavior of Youth on Social Media"), 
    sidebarLayout(
      sidebarPanel(uiOutput("selectVariable")), 
      mainPanel(plotlyOutput("chosenPlot"))
    )
)

last_page <- tabPanel(
  "Negative Influence of Social Media", 
  titlePanel("Understanding the Negative Effects of Social Media on Mental Health and Physical Health"), 
  sidebarLayout(
    sidebarPanel(uiOutput("selectButton")), 
    mainPanel(plotlyOutput("buttonPlot"))
  )
)

    
ui <- navbarPage(
  "Group 4",
  introduction_page,
  hui_page,
  cindy_page, 
  last_page,
  report_page
)
