#!/bin/bash

#PTH_DIR="/home/tigran/Documents/Cours/linux/Projet_linux/conso_electrique"

PTH_DIR="./conso_electrique"
DATE=$(date -d "yesterday" '+%Y-%m-%d')
HEURE=$(date '+%H') 
#heure_moins_une=$(date -d "$HEURE - 1 hour" '+%H')

mkdir -p $PTH_DIR

curl "https://odre.opendatasoft.com//api/explore/v2.1/catalog/datasets/eco2mix-national-tr/records?select=consommation%2Cdate%2Cheure&where=date%3D%22${DATE}%22%20and%20heure%3D%22${HEURE}%3A00%22&limit=1" >> "$PTH_DIR/conso_${DATE}_$HEURE:00.json"

curl "https://odre.opendatasoft.com//api/explore/v2.1/catalog/datasets/eco2mix-national-tr/records?select=consommation%2Cdate%2Cheure&where=date%3D%22${DATE}%22%20and%20heure%3D%22${HEURE}%3A30%22&limit=1" >> "$PTH_DIR/conso_${DATE}_$HEURE:30.json"
