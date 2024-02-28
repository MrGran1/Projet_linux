#! /usr/bin/env Rscript

library(mongolite)
library(ggplot2)
library(dplyr)


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
    date_ojd <- format(date_sys_ojd, "%Y-%m-%dT23:59:00Z")


    requete <- paste0('{"date": {"$gte": {"$date": "',date_semaine,'"}, "$lte": {"$date": "',date_ojd,'"}}}')

    data_meteo <- ma_db$find(requete, sort = '{"date": 1}')
    
    return(data_meteo)

}

#Moyenne valeur d'une donnée spécifique c((date,val))
obtenirMoyenne <- function(donnees, valeur){

    data_interet <- data.frame(
        date = c(donnees$date),
        valeur = c(valeur)
    )

    #Calculer les moyennes par date
    df_resultat <- data_interet %>%
        group_by(date) %>%
        summarise(moyenne = mean(valeur, na.rm = TRUE))

    return(df_resultat)
}


#Temperature hebdomadaire
obtenirGraphe <- function(donnees, abscisse, ordonnee, y_unite){

    ggplot(donnees) +
        aes(x = abscisse, y = ordonnee, colour = donnees$nom) +
        geom_line() +
        geom_point() +
    labs(
            x = "date",
            y = y_unite
        )

}

obtenirGraphe_moy <- function(donnees, abscisse, ordonnee, nom, y_unite){

    ggplot(donnees) +
        aes(x = abscisse, y = ordonnee) +
        geom_line(colour = "red") +
        geom_point(colour = "red") +
        labs(
            x = "date",
            y = y_unite,
            title = nom
        )

}

obtenirGraphe_elec <- function(donnees, abscisse, ordonnee){

    ggplot(donnees) +
        aes(x = abscisse, y = ordonnee) +
        labs(
            x = "date",
            y = "MW",
            title = "consommation d'électricité"
        ) +
        geom_line(colour = "blue") +
        geom_point(colour = "blue")

}

obtenirGraphe_gaz <- function(donnees, abscisse, ordonnee){

    ggplot(donnees) +
        aes(x = abscisse, y = ordonnee) +
        labs(
            x = "date",
            y = "MWh",
            title = "consommation de gaz"
        ) +
        geom_line(colour = "red") +
        geom_point(colour = "red")

}

library(ggplot2)


obtenirGraphe_Multiples <- function(df_list, titre) {
    
    palette_couleurs <- c("#000000", "#333333", "#4B3621", "#004d00", "#000080", "#800020", "#8B0000", "#4B0082", "#191970", "#8B4513")

    p <- ggplot()
    
    for (i in 1:length(df_list)) {
        p <- p + geom_line(aes(x = date, y = valeur, color = nom), data=df_list[[i]])
    }
    
    
    p <- p + labs(x = "date", y = "résultat", color = "Courbes") +
        ggtitle(titre) +
        scale_color_manual(values = sample(palette_couleurs))
    
    return(p)
}
