#!/bin/bash

output_dir="/home/u/Bureau/linux"

current_datetime=$(date +"%Y%m%d")
output_filename="consommation_gaz_${current_datetime}.json"

api_url="https://odre.opendatasoft.com/api/explore/v2.1/catalog/datasets/consommation-nationale-horaire-de-gaz-donnees-provisoires-grtgaz-terega-v2/records?select=date%2C%20consommation_journaliere_mwh_pcs&where=date%20%3E%202023&order_by=date%20DESC&limit=1&offset=1&exclude=statut%3AProvisoire"

curl --http1.1 -o "${output_dir}/${output_filename}" "${api_url}"

echo "Données téléchargées avec succès dans ${output_dir}/${output_filename}"
