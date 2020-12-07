#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)

options(shiny.maxRequestSize = 30*1024^2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Uploading files"),
   
   # Sidebar layout with input and output definitions 
   sidebarLayout(
     #sidebar panel for inputs 
     sidebarPanel(
       #input: select a file  
       fileInput("file1", "Choose xlsx file",
                     multiple = TRUE,#true multiple parameter lets user select multiple files
                 accept = c(".xlsx")) 
      
             ),
     
     #main panel for displaying outputs
     mainPanel(
       
       #output: data file
       tableOutput("contents")
     )
   )
)

# Define server logic to read selected file
server <- function(input, output) {
   
   output$contents <- renderTable({
     
     #input$file1 will be NULL initially. After the user selects and uploads a file,
     #head of that data file by default, or all rows if selected, will be shown
     
     req(input$file1)
     
     inFile <- input$file1
     read_excel(inFile$datapath, 1)
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

