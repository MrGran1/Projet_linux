import os
import json
from pymongo import MongoClient

# Chemin du répertoire contenant les fichiers JSON
input_dir = r"C:\Users\iland\OneDrive\Bureau\M1 2023\Administration Linux\TD\TP"

# Connexion à la base de données MongoDB
client = MongoClient('localhost', 27017)
db = client['bdd']
collection = db['collection']

def process_json_file(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
        summary_data = {'date': data['date'], 'consommation_gaz': data['consommation_journaliere_mwh_pcs']}
        collection.insert_one(summary_data)

# Liste tous les fichiers dans le répertoire d'entrée
files = os.listdir(input_dir)

# Parcours de tous les fichiers et traitement
for file in files:
    if file.endswith(".json"):
        file_path = os.path.join(input_dir, file)
        process_json_file(file_path)
        os.remove(file_path)

docs = collection.find()
for doc in docs:
    print(doc)

client.close()
