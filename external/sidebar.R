
column(4,p("Input Range"),
       wellPanel(selectInput("select", 
                             label = "Product House",
                             choices = list("Investo", "Multiply", "Myriad", "PDS"),
                             selected = "Investo")),
       wellPanel(textOutput("text1"))
       )



