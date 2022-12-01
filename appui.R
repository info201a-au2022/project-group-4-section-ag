library(shiny)
library(plotly)


introduction_content <- sidebarPanel(
)

ui <- navbarPage(
  "Introduction",
  bar_panel, 
  line_panel,
  scatter_panel,
  "Report"
)
