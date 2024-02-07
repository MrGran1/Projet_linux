from pymongo import MongoClient
from datetime import datetime
import os
import json

dbname="user"
collection="Meteo"
dossier_donnees = './meteo/'
fichier_log = 'log.txt'


client = MongoClient('localhost', 27017)
db = client[dbname]
col = db[collection]

#Fonction pour lire les données à partir des fichiers JSON
def lire_donnees(dossier_donnees):

    files = os.listdir(dossier_donnees)

    #On parcourt les fichiers du repertoire
    for fichier in files:

        if fichier.endswith('.json'):

            chemin_fichier = os.path.join(dossier_donnees, fichier)

            with open(chemin_fichier, 'r') as file:
                #On charger les donnees JSON depuis le fichier
                fichier_json = json.load(file)

                #Ouvre le fichier log en mode écriture (historique)
                chemin_log= os.path.join(dossier_donnees, fichier_log)
                with open(chemin_log, 'w') as file:
                    # Utilise la fonction print pour écrire dans le fichier
                    print("Date:", datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "- Le fichier", fichier ,"contient", len(fichier_json['results']), "éléments.\n", file=file)
                    print("\nLe fichier", fichier ,"contient", len(fichier_json['results']), "éléments.")

                for result in fichier_json['results']:
                    resultat = {"numero_station": result["numero_station"], "date": result["date"], "nom": result["nom"], "departement": result["departement"],"code_postale": result["code_postale"], "longitude": result["longitude"], "latitude": result["latitude"], "altitude": result["altitude"], "temperature_min": result["temperature_min"], "temperature_max": result["temperature_max"], "temperature": result["temperature"], "humidite": result["humidite"], "pression": result["pression"]}
                    col.insert_one(resultat)

            os.remove(chemin_fichier)

    client.close()

lire_donnees(dossier_donnees)

#col.delete_many({})