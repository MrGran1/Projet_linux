#!/bin/bash


path="./meteo"
fichier="meteo_data"
fichier_save="param.txt"
date_par_defaut="2023-01-01T00"

#Création du repertoire
if [ ! -d "$path" ]; then
    mkdir "$path"
fi

if [ ! -f "$path/$fichier_save" ]; then
    #Créer le fichier s'il n'existe pas
    touch "$path/$fichier_save"
    #Et on donne une date par défaut (ici janvier 2023)
    echo $date_par_defaut >> $path/$fichier_save
fi



#On récupère la date de derniere recuperation des données
derniere_save=$(<"$path/$fichier_save")


url="https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/donnees-synop-essentielles-omm/records?select=numer_sta%20AS%20numero_station%2C%20date%2C%20nom%2C%20nom_dept%20AS%20departement%2C%20longitude%2C%20latitude%2C%20altitude%2C%20tn12c%20AS%20temperature_min%2C%20tx12c%20AS%20temperature_max%2C%20tc%20AS%20temperature%2C%20u%20AS%20humidite%2C%20tend%20AS%20pression&where=code_dep%20!%3D%20%27971%27%20AND%20code_dep%20!%3D%20%27972%27%20AND%20code_dep%20!%3D%20%27973%27%20AND%20code_dep%20!%3D%20%27974%27%20AND%20code_dep%20!%3D%20%27976%27%20AND%20code_dep%20!%3D%20%272a%27%20AND%20code_dep%20!%3D%20%272b%27%20AND%20date%20%3E%3D%20%27$derniere_save%3A00%3A00%2B00%3A00'&order_by=date&limit=20"

#Heure du téléchargement
heure=$(date +"%Y_%m_%d_%H_%M")

reponse=$(curl -s -w "%{http_code}" -o "$path/$fichier"_"$heure.json" "$url")

#Vérifier le code de retour
if [ $reponse -eq 404 ]; then
    echo "Echec de récupération des données."
    exit 0 #Sortie du programme
else
    echo "Données récupérées avec succès!"
fi

#Récupérer la date de sauvegarde au format '2023-01-01T00'
derniere_save=$(echo "${heure}" | awk -F '_' '{printf "%s-%s-%sT%s", $1, $2, $3, $4}')

#Et on met à jour la date de dernière sauvegarde
echo $derniere_save > $path/$fichier_save
