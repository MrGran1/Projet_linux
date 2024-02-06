import pymongo
import os
import json
PATH_CURRENCY = "/home/tigran/Documents/Cours/linux/Projet_linux/conso_electrique"


# DB_NAME = "test"
# COLUMN = "customers"
# myclient = pymongo.MongoClient("mongodb://localhost:27017/")

# mydb = myclient[DB_NAME]

# mycol = mydb[COLUMN]

# mydict = { "name": "John", "address": "Highway 37" }

# #x = mycol.insert_one(mydict)
# x = mycol.find_one()

# print(x) 
# --------------------------- Brouillon -----------------------


documents = os.listdir(PATH_CURRENCY)
# Ouverture de tout les fichiers
for path_doc in documents:
    fichier = open(PATH_CURRENCY+"/"+path_doc)
    fichier = json.load(fichier)

    print(fichier["results"][0]['consommation'])