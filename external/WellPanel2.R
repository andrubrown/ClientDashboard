output$Mselect <- renderUI({

                   selectInput("Mselect",
                               label = "Myriad",
                               choices = list("Policy statistics", "Claims", "dasd"),
                               selected = "Policy statistics")
})



