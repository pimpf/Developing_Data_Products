library(shiny)

shinyUI(
    pageWithSidebar(
        headerPanel("Data Science FTW!"),
        sidebarPanel(h3("Sidebar panel")),
        mainPanel(h3("Main panel text"))
    )
)