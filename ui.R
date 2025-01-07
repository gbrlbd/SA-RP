library(shiny)

# Define UI for the application
shinyUI(fluidPage(
  titlePanel("EuStockMarkets Interactive App"),
  
  tabsetPanel(
    tabPanel("Application",
             sidebarLayout(
               sidebarPanel(
                 sliderInput("yearRange", 
                             "Select Year Range:", 
                             min = 1991, 
                             max = 1998, 
                             value = c(1991, 1998),
                             step = 1,
                             sep = ""),
                 actionButton("calcMean", "Calculate Mean")
               ),
               mainPanel(
                 plotOutput("stockPlot"),
                 verbatimTextOutput("meanOutput")
               )
             )
    ),
    tabPanel("Documentation",
             fluidPage(
               h3("Documentation"),
               p("This application explores four european stock markets"),
               h4("Features:"),
               tags$ul(
                 tags$li("Select a year range using the slider."),
                 tags$li("The plot the trend."),
                 tags$li("Calculate the mean value of each stock in the selected window.")
               )
             )
    )
  )
))
