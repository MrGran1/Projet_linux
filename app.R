source("install_packages.R")

library(shiny)
library(mongolite)
library(ggplot2)

source("visu.R")


#Interface utilisateur Shiny
ui <- fluidPage(
    titlePanel("Données météorologiques SYNOP de la semaine"),

    mainPanel(
        tabsetPanel(
            tabPanel("Météo",
                tabPanel("Température",
                    tabsetPanel(
                        tabPanel("Température", plotOutput("visu_data_temp")),
                        tabPanel("Moyenne", plotOutput("visu_data_moy_temp"))
                    )
                ),
                tabPanel("Humidité",
                    tabsetPanel(
                        tabPanel("Humidité", plotOutput("visu_data_humi")),
                        tabPanel("Moyenne", plotOutput("visu_data_moy_humi"))
                    )
                ),
                tabPanel("Pression",
                    tabsetPanel(
                        tabPanel("Pression", plotOutput("visu_data_pres")),
                        tabPanel("Moyenne", plotOutput("visu_data_moy_pres"))
                    )
                )
            ),

            tabPanel("Gaz", plotOutput("visu_data_gaz")),

            tabPanel("Electricité", plotOutput("visu_data_elec"))   
        )
    )

)

#Serveur Shiny
server <- function(input, output, session){
    
    db_meteo <- mongo("Meteo","user")
    db_elec <- mongo("conso_elect","user")
    db_gaz <- mongo("gaz","user")

    data_meteo <- obtenirData(db_meteo)
    data_elec <- obtenirData(db_elec)
    data_gaz <- obtenirData(db_gaz)
    
    moy_temp <- obtenirMoyenne(data_meteo,data_meteo$temperature)
    moy_humi <- obtenirMoyenne(data_meteo,data_meteo$humidite)
    moy_pres <- obtenirMoyenne(data_meteo,data_meteo$pression)
    

    observe({

        
        output$visu_data_temp <- renderPlot({
            obtenirGraphe(data_meteo, data_meteo$date, data_meteo$temperature, "°C")
        })

        output$visu_data_humi <- renderPlot({
            obtenirGraphe(data_meteo, data_meteo$date, data_meteo$humidite, "%")
        })

        output$visu_data_pres <- renderPlot({
            obtenirGraphe(data_meteo, data_meteo$date, data_meteo$pression, "Pa")
        })

        
        output$visu_data_moy_temp <- renderPlot({
            obtenirGraphe_moy(moy_temp, moy_temp$date, moy_temp$moyenne, "température", "°C")
        })

        output$visu_data_moy_humi <- renderPlot({
            obtenirGraphe_moy(moy_humi, moy_humi$date, moy_humi$moyenne, "humidité", "%")
        })

        output$visu_data_moy_pres <- renderPlot({
            obtenirGraphe_moy(moy_pres, moy_pres$date, moy_pres$moyenne, "variation de pression", "Pa")
        })

        
        output$visu_data_elec <- renderPlot({
            obtenirGraphe_elec(data_elec, data_elec$date, data_elec$consommation)
        })
        output$visu_data_gaz <- renderPlot({
            obtenirGraphe_gaz(data_gaz, data_gaz$date, data_gaz$consommation_gaz)
        })


    })

}

#Lancer l'app shiny
runApp(list(ui = ui, server = server), port=7177)
