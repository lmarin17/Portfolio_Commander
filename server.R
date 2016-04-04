library(jsonlite)
library(curl)
library(shiny)
library(googleVis)

shinyServer(function(input, output) {
  
  goget <- reactive({input$ticker})
  
 urlstring <- reactive({
   paste(c("http://finance.yahoo.com/webservice/v1/symbols/",input$ticker,"/quote?format=json&view=detail"), collapse = "")
 })
 
 output$name <- renderText({paste(fromJSON(urlstring())$list$resources$resource$fields$name," Results as of: ",
                             Sys.Date())})
 output$dayhigh <- renderText({paste("Today's high: ",round(as.numeric(fromJSON(urlstring())$list$resources$resource$fields$day_high),2))})

 output$daylow <- renderText({paste("Today's low: ",round(as.numeric(fromJSON(urlstring())$list$resources$resource$fields$day_low),2))})
 
 output$currentPrice <- renderText({paste("Current price: ",round(as.numeric(fromJSON(urlstring())$list$resources$resource$fields$price),2))})

 output$yearhigh <- renderText({paste("This year's high: ",round(as.numeric(fromJSON(urlstring())$list$resources$resource$fields$year_high),2))})

 output$yearlow <- renderText({paste("This year's low: ",round(as.numeric(fromJSON(urlstring())$list$resources$resource$fields$year_low),2))})

 hist <- reactive({
   paste(c("http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22",
           input$ticker,"%22%20and%20startDate%20%3D%20%222016-01-01%22%20and%20endDate%20%3D%20%222016-04-15",
           "%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="), collapse = "")
 })  
   tabprices <- reactive({fromJSON(hist())})
   
   output$thisYear <- renderGvis({
     gvisAnnotationChart(data.frame(Date = tabprices()$query$results$quote$Date,
                                    Close = as.numeric(tabprices()$query$results$quote$Close)), 
                         datevar = "Date", numvar = "Close")
       })

   output$closing <- renderTable({data.frame(Date = tabprices()$query$results$quote$Date,
                         Close = tabprices()$query$results$quote$Close)})
   
  
})