#! /usr/bin/env Rscript

#Bibliothèque MongoDB
#install.packages("mongolite")

library(mongolite)
library(ggplot2)


#Obtenir date actuelle avec l'heure
obtenirData <- function(ma_db){
    
    Sys.setenv(TZ = "UTC") #Les données d'origine prennent en compte le fuseau horaire UTC
    

    #Nous allons récupérer les données

    #D'il y a une semaine (date de départ)
    date_sys_semaine <- Sys.time() - 7 * 24 * 60 * 60
    #Date formatée
    date_semaine <- format(date_sys_semaine, "%Y-%m-%dT00:00:00Z")

    #Jusqu'à la date du jour
    date_sys_ojd <- Sys.time()
    #Date formatée
    date_ojd <- format(date_sys_ojd, "%Y-%m-%dT00:00:00Z")


    requete <- paste0('{"date": {"$gte": {"$date": "',date_semaine,'"}, "$lte": {"$date": "',date_ojd,'"}}}')

    data_meteo <- ma_db$find(requete, sort = '{"date": 1, "nom": 1}')
    
    return(data_meteo)

}


#Temperature hebdomadaire
obtenirGraphe <- function(donnees, abscisse, ordonnee){

    ggplot(donnees) +
        aes(x = abscisse, y = ordonnee, colour = donnees$nom) +
        geom_line() +
        geom_point()

}

#db_meteo <- mongo("Meteo","user")
#data_meteo <- obtenirData(db_meteo)

#obtenirTemperature(data_meteo)