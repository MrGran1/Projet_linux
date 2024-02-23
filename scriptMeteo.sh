#!/bin/bash

#path="/home/tigran/Documents/Cours/linux/Projet_linux/meteo"

path="./meteo"
fichier="meteo_data"

#Date de départ au format YYYY-MM-DDTHH:00:00
date_depart=$(date -d "yesterday" +"%Y-%m-%dT00:00:00")

#Nombre d'itérations 8x3 = 24heures
nombre_iterations=8


#Création du repertoire
if [ ! -d "$path" ]; then
    mkdir -p $path
fi



for ((i=0; i<$nombre_iterations; i++)); do

    heure=$(date -d "$date_depart" +"%Y-%m-%dT%H$heure_depart")

    url="https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records?select=numer_sta%20AS%20numero_station%2C%20date%2C%20nom%2C%20nom_dept%20AS%20departement%2C%20code_dep%20AS%20code_postale%2C%20longitude%2C%20latitude%2C%20altitude%2C%20tn12c%20AS%20temperature_min%2C%20tx12c%20AS%20temperature_max%2C%20tc%20AS%20temperature%2C%20u%20AS%20humidite%2C%20tend%20AS%20pression&where=code_dep%20!%3D%20%27971%27%20AND%20code_dep%20!%3D%20%27972%27%20AND%20code_dep%20!%3D%20%27973%27%20AND%20code_dep%20!%3D%20%27974%27%20AND%20code_dep%20!%3D%20%27975%27%20AND%20code_dep%20!%3D%20%27976%27%20AND%20code_dep%20!%3D%20%27977%27%20AND%20code_dep%20!%3D%20%27978%27%20AND%20code_dep%20!%3D%20%27984%27%20AND%20code_dep%20!%3D%20%27986%27%20AND%20code_dep%20!%3D%20%27987%27%20AND%20code_dep%20!%3D%20%27988%27%20AND%20code_dep%20!%3D%20%27989%27%20AND%20code_dep%20!%3D%20%272A%27%20AND%20code_dep%20!%3D%20%272B%27%20AND%20code_dep%20!%3D%20%272a%27%20AND%20code_dep%20!%3D%20%272b%27%20AND%20date%3Ddate%27$heure%27%20&order_by=date%2C%20code_dep&limit=100"

    heure_tel=$(date -d "$date_depart" +"%Y_%m_%d_%H_%M")

    reponse=$(curl -s -w "%{http_code}" -o "$path/$fichier"_"$heure_tel.json" "$url")

    #Vérifier le code de retour
    if [ $reponse -eq 404 ]; then
        echo "Echec de récupération des données."
    else
        echo "Données récupérées avec succès!"
    fi

    #Incrémenter la date de 3 heures
    date_depart=$(date -d "$date_depart 3 hours" +"%Y-%m-%dT%H:00:00")

    #Pour eviter des erreurs de traitement
    sleep 1s

done
