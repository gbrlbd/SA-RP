library(shiny)
library(datasets)

shinyServer(function(input, output) {
  calculatedMean <- reactiveVal(NULL)

  observeEvent(input$calcMean, {
    stockData <- EuStockMarkets
    years <- 1991 + (time(stockData) - start(time(stockData)))

    selectedIndices <- which(years >= input$yearRange[1] & years <= input$yearRange[2])
    filteredData <- stockData[selectedIndices, ]

    meanValues <- colMeans(filteredData, na.rm = TRUE)
    calculatedMean(meanValues)
  })

  output$stockPlot <- renderPlot({
    stockData <- EuStockMarkets
    years <- 1991 + (time(stockData) - start(time(stockData)))

    selectedIndices <- which(years >= input$yearRange[1] & years <= input$yearRange[2])
    filteredData <- stockData[selectedIndices, ]
    filteredYears <- years[selectedIndices]

    matplot(filteredYears, filteredData, type = "l", lty = 1, col = 1:4,
            xlab = "Year", ylab = "Stock Index",
            main = paste("EuStockMarkets - Years:", input$yearRange[1], "-", input$yearRange[2]))
    legend("topleft", legend = colnames(stockData), col = 1:4, lty = 1)
  })

  output$meanOutput <- renderText({
    meanValues <- calculatedMean()
    meanValues
  })
})
