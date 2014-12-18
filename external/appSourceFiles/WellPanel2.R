output$Mselect <- renderUI({

                   selectInput("Mselect",
                               label = "Myriad",
                               choices = list("Policy statistics", "Claims", "VoC"),
                               selected = "Policy statistics")
})