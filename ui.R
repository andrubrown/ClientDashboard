require(ggplot2)
source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClaimsGraph2.R")

fluidPage(

titlePanel(img(src  = "Arrow2a.jpg", width = "100%")),
  

  sidebarPanel (
# wellPanel1----
           wellPanel(
             
            # uiOutput("select")
             selectInput("select", 
                         label = "Select: ",
                         choices = list("Investo", "Multiply", "Myriad", "Client Information"),
                         selected = "Myriad")
             
             
             
             
             ),
# end of wellPanel1====
# wellPanel2----
   wellPanel(
     conditionalPanel(condition = "input.select == 'Myriad'",
                      selectInput("Mselect",
                                  label = "Myriad",
                                  choices = list("Policy statistics", "Claims", "VoC"),
                                  selected = "Policy statistics")),
     

     
     
     conditionalPanel(condition = "input.select == 'Investo'",
                      selectInput("Iselect",
                                  label = "Investo",
                                  choices = list("Policy statistics", "VoC"),
                                  selected = "Policy statistics")),
     
     conditionalPanel(condition = "input.select == 'Multiply'",
                      selectInput("MPselect",
                                  label = "Multiply",
                                  choices = list("Policy statistics", "Member Status"),
                                  selected = "Policy statistics")),
     
#VoC
     conditionalPanel(condition = "(input.select == 'Investo' & input.Iselect == 'VoC') | (input.select == 'Myriad' & input.Mselect == 'VoC')" ,
                      selectInput("VoCMetric", 
                                  label = "Metric",
                                  choices = list('Ability to meet needs'
                                                 ,'Agent Ability'
                                                 ,'Ease of doing business'
                                                 ,'Kept in the loop'
                                                 ,'Number of Responses'
                                                 ,'Professionalism'
                                                 ,'Turnaround time'
                                                 ,'Overall Experience'),
                                  selected = "Ability to meet needs")),
     
     
#Claims 
     conditionalPanel(condition = "(input.select == 'Myriad' & input.Mselect == 'Claims')",
                      selectInput("ClaimsInput",
                                  label = "Claim Information",
                                  choices = list("Causes",
                                                 #"Cause Trends",
                                                 "Claim Amount"),
                                  selected = "Causes"),
                      # Causes 
                      conditionalPanel(condition = "(input.select == 'Myriad' & input.Mselect == 'Claims' & input.ClaimsInput == 'Causes')",
                                       dateInput("CDR",
                                                 label = "Month",
                                                 min = min(Claims$Date),
                                                 max = max(Claims$Date),
                                                 value = max(Claims$Date),
                                                 format = "yyyy-mm-dd",
                                                 startview = "month"))),

uiOutput("daterange"),

conditionalPanel(condition = "(input.select == 'Myriad' & input.Mselect == 'Policy statistics') 
                 | (input.select == 'Investo' & input.Iselect == 'Policy statistics')",
                 sliderInput("slider",
                             label = "Forecast Range",
                             min = 0,
                             max = 24,
                             value = 12)),


#clients
conditionalPanel(condition = "input.select == 'Client Information'",
                 selectInput("ClientInfo",
                             label = "Client Info",
                             choices = list("New Clients"
                                            #"Total Number of Clients",
                                            #"Cross Sell Ratios"
                                            ),
                             selected = "New Clients")),


conditionalPanel(condition = "(input.select == 'Client Information' & input.ClientInfo == 'New Clients')",
                 selectInput("PHSelect",
                             label = "Product Houses",
                             choices = list("Myriad",
                                            "Investo",
                                            "Multiply"),
                             selected = list("Myriad",
                                             "Investo",
                                             "Multiply"),
                             multiple = T 
                             )),




uiOutput("clientdaterange")
  
     
   )
# end of wellPanel2====
),# end of sidePanel
  
  
  
  

         mainPanel(
           wellPanel(
             plotOutput("Plot")
           )
         )
)
 
  






