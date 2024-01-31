#!/bin/bash

output_dir="C:\Users\iland\OneDrive\Bureau\M1 2023\Administration Linux\TD\TP"

current_datetime=$(date +"%Y%m%d")
output_filename="consommation_gaz_${current_datetime}.json"

api_url="https://odre.opendatasoft.com/api/explore/v2.1/catalog/datasets/consommation-nationale-horaire-de-gaz-donnees-provisoires-grtgaz-terega-v2/records?select=date%2C%20consommation_journaliere_mwh_pcs&where=date%3E2023&order_by=date&limit=100&exclude=statut%3AProvisoire"

curl -o "${output_dir}/${output_filename}" "${api_url}"

echo "Données téléchargées avec succès dans ${output_dir}/${output_filename}"
