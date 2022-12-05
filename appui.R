library(plotly)
library(shinythemes)

library(markdown)
library(shiny)

introduction_page <-tabPanel(
  "Introduction",
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
  ),
  print("This chart is a line graph correlating the age of social media users 
        and their social media usage through different parts of the world. 
        First, in Bangladesh, the graph exhibits an average of approximately 
        three hours spent on social media across the age range. There is a spike in 
        36 years old and 53 years old with an average of 5 hours of social media usage. 
        The average social media usage of people under the age of 35 was fairly stable, 
        while the standard deviation of social media usage above that age was much greater. 
        This shows that older people’s social media behaviors vary drastically from person 
        to person, while young adults grew up with technology and exhibit the same patterns. 
        The graph representing India is much more fluid and follows a downward trend.")
  )

hui_main <- mainPanel(
  plotlyOutput("line")
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
      sidebarPanel(uiOutput("selectVariable"),
                   print("This chart is a behavioral analysis of young people within the age 
            range of 14 to 23 years old. All the behaviors displayed in this chart are 
            qualitative data collected from survey respondents. The variables are categorized by age 
            for same-age comparison or cross-chart analysis, in order to narrow the age range down 
            to the ones with the most social media usage for the results to be more significant. 
            Overall results show that youth 18-19 years old have the most social media usage, 
            the least exercise time, and the highest number of social media platforms. ")), 
      mainPanel(plotlyOutput("chosenPlot"))
      
    )
)

last_page <- tabPanel(
  "Negative Influence of Social Media", 
  titlePanel("Understanding the Negative Effects of Social Media on Mental Health and Physical Health"), 
  sidebarLayout(
    sidebarPanel(uiOutput("selectButton"), 
                 print("This chart is a stacked bar graph that analyses the negative effects of social media on mental health and physical health. All the variables in this graph are qualitative data collected from survey respondents, who would answer ther questions on a scale that determines frequency. Variables include analyzing emotional swings, overthinking, anxiety, depression, and sleep quality. The analysis of this chart provides valuable information which leads to the conclusion that the more time users spend on social media, the more mental health issues they experience.")), 
    mainPanel(plotlyOutput("buttonPlot"))
  )
)

summary_page <- tabPanel(
  "Summary",
  titlePanel("The Biggest Takeaways"),
  fluidPage(
    includeMarkdown("./docs/summary.Rmd")
  )
)  
ui <- navbarPage(
  theme = shinytheme("journal"), 
  "Group 4",
  introduction_page,
  hui_page,
  cindy_page, 
  last_page,
  summary_page,
  report_page
)
