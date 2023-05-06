library(shiny)
library(shinythemes)

# runExample(example = NA, port = NULL,
#            launch.browser = getOption("shiny.launch.browser", interactive()),
#            host = getOption("shiny.host", "127.0.0.1"), display.mode = c("auto",
#                                                                          "normal", "showcase"))
# runExample("08_html")



ui <- fluidPage(theme = shinytheme("superhero"),
          
  # Application title
  titlePanel(em ("샤이니로 워드 클라우드 만들기"), windowTitle = "Word Clouds"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a book:",
                  choices = books),
      actionButton("update", "Change", icon(name="fab fa-apple")),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100)
    ),
    
    # Show Word Cloud
    mainPanel(
      h2(textOutput(outputId = "out_caption")),
      plotOutput("plot")
    )
  )
)





