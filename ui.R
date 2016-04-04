library(shiny)
library(googleVis)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Check My Stocks"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("ticker", "Choose a ticker:",
                  choices = c("AAPL","AMZN","DIS","FB","GOOG","LNKD","PYPL","SBUX","UA"),
                  selected = "AAPL")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3(textOutput("name")),
      h4(textOutput("currentPrice")),
      h4(textOutput("dayhigh")),
      h4(textOutput("daylow")),
      h4(textOutput("yearhigh")),
      h4(textOutput("yearlow")),
      h6(textOutput(" ")),
      htmlOutput("thisYear")
     # h6(tableOutput("closing"))
      
    )
  )
))