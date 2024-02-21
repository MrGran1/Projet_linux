
import os
import json
from pymongo import MongoClient
from datetime import datetime

# Chemin du répertoire contenant les fichiers JSON
input_dir = "./conso_gaz"
dbname="user"
# Connexion à la base de données MongoDB
client = MongoClient('localhost', 27017)
db = client[dbname]
collection = db['gaz']


### Recup des data de gaz -----------------------------------------------------------------
# collection="gaz"
# Fonction pour convertir les noms d'heures en objets datetime
def convertir_heure(clef):
    if len(clef) != 5:
        return None
    if not clef[2] == '_':
        return None
    try:
        heure, minute = int(clef[:2]), int(clef[3:])
        if 0 <= heure <= 23 and 0 <= minute <= 59:
            return datetime.strptime(f'{heure:02d}:{minute:02d}', '%H:%M')
    except ValueError:
        pass
    return None

# Fonction pour lire les données du fichier JSON
def lire_donnees(fichier_json):
    # Ouvrir le fichier JSON
    with open(fichier_json, 'r') as file:
        donnees = json.load(file)

    # Extraire la date
    donnees = donnees['results'][0]

    # Parcourir les clés du dictionnaire
    for clef in donnees:
        # Convertir la clé en objet datetime
        heure = convertir_heure(clef)
        # Si la conversion a réussi
        if heure:
            # Extraire la date et l'heure
            date_str = donnees['date']

            # Convertir la date et l'heure en objet datetime
            date_obj = datetime.strptime(date_str, "%Y-%m-%d")
            heure_obj = datetime.strptime(heure, "%H:%M")

            # Fusionner date et heure en un seul objet datetime
            datetime_obj = datetime(date_obj.year, date_obj.month, date_obj.day, heure_obj.hour, heure_obj.minute)

            # Convertir en format ISO 8601
            iso8601_str = datetime_obj.isoformat()
            date_obj = datetime.fromisoformat(iso8601_str)

            # Extraire la consommation de gaz
            consommation_gaz = donnees['results'][0]['consommation_journaliere_mwh_pcs']

            # Créer le document à insérer
            document = {
                'date': date_heure_formattee,
                'consommation_gaz': consommation_gaz
            }

            # Insérer le document dans la collection
            collection.insert_one(document)

# Liste tous les fichiers dans le répertoire d'entrée
files = os.listdir(input_dir)

# Parcours de tous les fichiers et traitement
for file in files:
    if file.endswith(".json"):
        file_path = os.path.join(input_dir, file)
        lire_donnees(file_path)
        os.remove(file_path)

docs = collection.find()


### Recup des data météo -----------------------------------------------------------------
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

                    #Convertir la chaîne en objet datetime
                    date_obj = datetime.fromisoformat(result["date"])

                    resultat = {"numero_station": result["numero_station"], "date": date_obj, "nom": result["nom"], "departement": result["departement"],"code_postale": result["code_postale"], "longitude": result["longitude"], "latitude": result["latitude"], "altitude": result["altitude"], "temperature_min": result["temperature_min"], "temperature_max": result["temperature_max"], "temperature": result["temperature"], "humidite": result["humidite"], "pression": result["pression"]}
                    col.insert_one(resultat)
                
                print("\nLe fichier", fichier, "a été traité.")

            os.remove(chemin_fichier)

lire_donnees(dossier_donnees)
#col.delete_many({})

## Data consommation éléctrique -----------------------------------------------------------------------
PATH_ELECT = "./conso_electrique"

COLUMN = "conso_elect"
mydb = client[dbname]
mycol = mydb[COLUMN]
#Ajout des infos dans la DB
documents = os.listdir(PATH_ELECT)
# Ouverture de tout les fichiers et ajout dans la DB

for path_doc in documents:
    fichier = open(PATH_ELECT+"/"+path_doc)
    fichier_json = json.load(fichier)
    date_str = fichier_json["results"][0]['date']
    heure_str = fichier_json["results"][0]['heure']

    # Convertir en objet datetime
    date_obj = datetime.strptime(date_str, "%Y-%m-%d")
    heure_obj = datetime.strptime(heure_str, "%H:%M")

    # Fusionner date et heure en un seul objet datetime
    datetime_obj = datetime(date_obj.year, date_obj.month, date_obj.day, heure_obj.hour, heure_obj.minute)

    # Convertir en format ISO8601
    iso8601_str = datetime_obj.isoformat()
    date_obj = datetime.fromisoformat(iso8601_str)


    data ={"consommation" : fichier_json["results"][0]["consommation"], "date": date_obj}
    x = mycol.insert_one(data)
    #os.remove(PATH_ELECT+"/"+path_doc)

client.close()
