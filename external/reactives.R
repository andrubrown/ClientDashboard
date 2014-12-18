# plotg <- reactive({
#   if(!is.null(input$select)){
#     if (input$select == "Investo"){
#       if(input$Iselect == "Policy statistics") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MyriadInvestoGraph.R")$value
#       #if(input$Iselect == "VoC") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MyriadInvestoGraph.R")$value
#     }
#     if (input$select == "Myriad"){
#       if(input$Iselect == "Policy statistics") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MyriadInvestoGraph.R")$value
#       if(input$Iselect == "Claims") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClaimsGraph.R")$value
#       #if(input$Iselect == "VoC") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MyriadInvestoGraph.R")$value
#     } 
#     plotg
#     
#   }
# })

plotg <- reactive({
    if (input$select == "Investo") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/MyriadInvestoGraph.R")$value
    if (input$select == "Myriad") plotg <- source("//mizazaycensql01/SCMBIR/Client Dashboard/Shiny/graphs/ClaimsGraph.R")$value

})