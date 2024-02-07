
import os
import json
from pymongo import MongoClient

# Chemin du répertoire contenant les fichiers JSON
input_dir = r"/home/u/Bureau/linux/"
dbname="user"
# Connexion à la base de données MongoDB
client = MongoClient('localhost', 27017)
db = client[dbname]
collection = db['gaz']

#collection.delete_many({})

def process_json_file(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
        for result in data['results']:
            summary_data = {'date': result['date'], 'consommation_gaz': result['consommation_journaliere_mwh_pcs']}
        collection.insert_one(summary_data)

# Liste tous les fichiers dans le répertoire d'entrée
files = os.listdir(input_dir)

# Parcours de tous les fichiers et traitement
for file in files:
    if file.endswith(".json"):
        file_path = os.path.join(input_dir, file)
        process_json_file(file_path)
        os.remove(file_path)

### Recup des data météo
collection="Meteo"
dossier_donnees = './meteo/'

col = db[collection]

#Fonction pour lire les données à partir des fichiers JSON
def lire_donnees(dossier_donnees):

    files = os.listdir(dossier_donnees)
    files.sort()

    #On parcourt les fichiers du repertoire
    for fichier in files:

        if fichier.endswith('.json'):

            chemin_fichier = os.path.join(dossier_donnees, fichier)

            with open(chemin_fichier, 'r') as file:
                #On charge les donnees JSON depuis le fichier
                fichier_json = json.load(file)

                print("\nLe fichier", fichier ,"contient", len(fichier_json['results']), "éléments.")

                for result in fichier_json['results']:
                    resultat = {"numero_station": result["numero_station"], "date": result["date"], "nom": result["nom"], "departement": result["departement"],"code_postale": result["code_postale"], "longitude": result["longitude"], "latitude": result["latitude"], "altitude": result["altitude"], "temperature_min": result["temperature_min"], "temperature_max": result["temperature_max"], "temperature": result["temperature"], "humidite": result["humidite"], "pression": result["pression"]}
                    col.insert_one(resultat)
                
                print("\nLe fichier", fichier, "a été traité.")

            os.remove(chemin_fichier)

lire_donnees(dossier_donnees)
client.close()
#col.delete_many({})
