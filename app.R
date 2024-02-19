
library(shiny)
library(mongolite)
library(ggplot2)

source("install_packages.R")
source("meteo.R")


#Interface utilisateur Shiny
ui <- fluidPage(
    titlePanel("Données météorologiques SYNOP de la semaine"),

    mainPanel(
        tabsetPanel(
            tabPanel("Analyse de la température", plotOutput("visu_data_temp")),
            tabPanel("Analyse de l'humidité", plotOutput("visu_data_humi")),
            tabPanel("Analyse de la pression", plotOutput("visu_data_pres"))
            #titlePanel("Analyse de la température sur la semaine",plotOutput("analyse_hebdo_meteo"))
        )
    )
)

#Serveur Shiny
server <- function(input, output, session){
    
    db_meteo <- mongo("Meteo","user")
    data_meteo <- obtenirData(db_meteo)
    
    observe({

        
        output$visu_data_temp <- renderPlot({
            obtenirGraphe(data_meteo, data_meteo$date, data_meteo$temperature)
        })

        output$visu_data_humi <- renderPlot({
            obtenirGraphe(data_meteo, data_meteo$date, data_meteo$humidite)
        })

        output$visu_data_pres <- renderPlot({
            obtenirGraphe(data_meteo, data_meteo$date, data_meteo$pression)
        })


    })

}

#Lancer l'app shiny
shinyApp(ui = ui, server = server)