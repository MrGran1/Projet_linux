#!/bin/bash

#output_dir="/home/tigran/Documents/Cours/linux/Projet_linux/conso_gaz"

output_dir="./conso_gaz"

mkdir -p $output_dir

current_datetime=$(date +"%Y%m%d")
output_filename="consommation_gaz_${current_datetime}.json"

api_url="https://odre.opendatasoft.com/api/explore/v2.1/catalog/datasets/consommation-nationale-horaire-de-gaz-donnees-provisoires-grtgaz-terega-v2/records?where=date%3E2023&order_by=date%20DESC&limit=1&offset=1&exclude=statut%3AProvisoire"

curl -o "${output_dir}/${output_filename}" "${api_url}"

echo "Données téléchargées avec succès dans ${output_dir}/${output_filename}"
