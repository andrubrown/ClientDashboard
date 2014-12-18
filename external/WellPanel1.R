output$select <- renderUI({
  selectInput("select", 
              label = "Product House",
              choices = list("Investo", "Multiply", "Myriad"),
              selected = "Myriad")
  })


