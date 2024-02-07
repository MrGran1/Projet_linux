import pymongo
import os
import json
PATH_ELECT = "/home/tigran/Documents/Cours/linux/Projet_linux/conso_electrique"

# Définition de la DB
DB_NAME = "projet_linux"
COLUMN = "conso_elect"
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient[DB_NAME]
mycol = mydb[COLUMN]
#Ajout des infos dans la DB
documents = os.listdir(PATH_ELECT)
# Ouverture de tout les fichiers et ajout dans la DB

for path_doc in documents:
    fichier = open(PATH_ELECT+"/"+path_doc)
    fichier_json = json.load(fichier)
    x = mycol.insert_one(fichier_json["results"][0])
    os.remove(PATH_ELECT+"/"+path_doc)