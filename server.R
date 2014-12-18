require(ggplot2)
require(forecast)
require(scales)

source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MyriadInvestoGraph.R") 
source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/VoCGraph.R") 
source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClaimsGraph2.R")
source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClientsGraph.R")



funggcast<-function(dn,fcast){ 
  
  require(zoo) #needed for the 'as.yearmon()' function
  
  en<-max(time(fcast$mean)) #extract the max date used in the forecast
  
  #Extract Source and Training Data
  ds<-as.data.frame(window(dn,end=en, extend = TRUE))
  names(ds)<-'observed'
  ds$date<-as.Date(time(window(dn,end=en, extend = TRUE)))
  
  #Extract the Fitted Values (need to figure out how to grab confidence intervals)
  dfit<-as.data.frame(fcast$fitted)
  dfit$date<-as.Date(time(fcast$fitted))
  names(dfit)[1]<-'fitted'
  
  ds<-merge(ds,dfit,all.x=T) #Merge fitted values with source and training data
  
  #Exract the Forecast values and confidence intervals
  dfcastn<-as.data.frame(fcast)
  dfcastn$date<-as.Date(as.yearmon(row.names(dfcastn)))
  names(dfcastn)<-c('forecast','lo80','hi80','lo95','hi95','date')
  
  pd<-merge(ds,dfcastn,all.x=T) #final data.frame for use in ggplot
  return(pd) 
}



shinyServer(function(input, output) {
  

  output$Plot <- renderPlot({
    
    ## Investo Graphs
    if (input$select == "Investo")  {
      if(input$Iselect == "Policy statistics") PHG(input$select, input$daterange[1], input$daterange[2], input$slider)
      else if(input$Iselect == "VoC") FUNVOC(input$select, input$VoCMetric)
    }
    
    
    ## Myriad Graphs
    else if (input$select == "Myriad"){  
      
      if(input$Mselect == "Policy statistics") PHG(input$select, input$daterange[1], input$daterange[2], input$slider)
      else if(input$Mselect == "VoC") FUNVOC(input$select, input$VoCMetric) 
      else if(input$Mselect == "Claims") {
        if(input$ClaimsInput == "Claim Amount") source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClaimsGraph.R")$value
        else  if(input$ClaimsInput == "Causes") if(!is.null(input$CDR)) CLAIMSFUNCTION(input$CDR)
          
        
      }
    }
    
    ## Multiply Graphs
    else if (input$select == "Multiply"){
      if(input$MPselect == "Policy statistics") PHG(input$select, input$daterange[1], input$daterange[2], input$slider)
      else if (input$MPselect == "Member Status") source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MultiplyStatusGraph.R")$value
      
    }
    
    ##Client Graphs
    else if (input$select == "Client Information"){
      if(input$ClientInfo == "New Clients") ClientInfo(input$PHSelect, input$clientdaterange[1], input$clientdaterange[2])
    }
    
    
  })

  output$daterange <- renderUI({
    
    conditionalPanel(condition = "(input.select == 'Myriad' & input.Mselect == 'Policy statistics') 
                     | (input.select == 'Investo' & input.Iselect == 'Policy statistics')
                     | (input.select == 'Multiply' & input.MPselect == 'Policy statistics')",
                     dateRangeInput("daterange",
                                    label = "Date Range",
                                    min = min(as.Date(NLC[which(NLC$ProductHouse == input$select),"Date"])),
                                    max = max(as.Date(NLC[which(NLC$ProductHouse == input$select),"Date"]))+1,
                                    start = min(as.Date(NLC[which(NLC$ProductHouse == input$select),"Date"])),
                                    end = max(as.Date(NLC[which(NLC$ProductHouse == input$select),"Date"]))+1,
                                    separator = " to ",
                                    startview = "month"))
  })
  
  
  output$clientdaterange <- renderUI({
    
    conditionalPanel(condition = "(input.select == 'Client Information' & input.ClientInfo == 'New Clients')",
                     dateRangeInput("clientdaterange",
                                    label = "Date Range",
                                    min = min(as.Date(Clients$Date)),
                                    max = max(as.Date(Clients$Date)),
                                    start = min(as.Date(Clients$Date)),
                                    end = max(as.Date(Clients$Date)),
                                    separator = " to ",
                                    ))
    
  })
  
})

