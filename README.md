RENDU :[https://cloud.parisdescartes.fr/index.php/s/K8Hkn5wqLqQyCHN]

    Fichier compressé (zip ou tar.gz) avec les noms des étudiants dans le nom de fichier
    Bien mettre les noms des étudiants dans le rapport

# Demande à réaliser
## Sujet

Vous êtes missionné pour réfléchir à la création un tableau de bord temps réel, représentant l’activité journalière de ce que vous voulez (activités humaines, activités géologiques, activités climatiques..) sur une zone de votre choix (terre, continent, pays, ville…).

L’idée du projet est principalement de mettre en place la partie extraction des données et stockage, pas forcément la partie analyse et visualisation.

A partir de sources de données temps réel, vous devez récupérer les données en 3 étapes :

    Créer un script téléchargeant les données de l’API toutes les minutes (ou heures selon la source)
        Script bash
        Dans un fichier JSON (ou XML)
        Stocké dans un répertoire dédié, avec un nom de fichier explicite sur la date et l’horaire de téléchargement (format au choix)
        Définir la tâche chron à associé pour la programmation automatique de ce script
    Créer un script résumant les données stockées dans les fichiers toutes les heures (ou tous les jours selon la source)
        Script Python ou R
        Stockage du résultat dans Mongo
        Suppression des fichiers résumés
        Définir la tâche chron à associé pour la programmation automatique de ce script
    Créer un script d’analyse des données tous les jours (ou semaines voire mois selon la source)
        Script Python ou R
        Génération d’un fichier PDF ou d’une appli web (shiny ou streamlit)
        Définir la tâche chron à associé pour la programmation automatique de ce script

## Contraintes

    Groupes de 3 ou 4
    Au moins 3 ou 4 sources de données différentes (Une par étudiant du groupe), comme par exemple
        Météo
        Bourse
        Réseaux sociaux
        Tremblements de terre
        Tempête, ouragan, cyclone…
        Partages de vidéos
        Musique
        Transports
        Electricité, gaz…
        Commerce en ligne
        …
    Pour chaque source, on veut connaître au moins les informations suivantes :
        Contenu des données
        Périodicité
        Moyen d’accès aux données (API, téléchargement, autre… - token nécessaire ou non, libre ou non)
        Droit de ré-utilisation des données

## Livrables à rendre

    Rapport
        Problématique choisie
            Quel sujet ? Avec quelle approche ? Quelles analyses à prévoir ?
        Sources de données (ainsi que leur modèle)
            Comment sont structurées les sources ? Qu’est-ce qu’il y a dedans comme informations ?
            Comment y a t’on accès ?
            Quelle périodicité faut-il prévoir pour les récupérer ?
            Qu’ont-elles en commun éventuellement ? (hormis les aspects date et zone géographique)
            Est-il possible de les ré-utiliser librement ou non ?
        Tableau de bord et/ou analyse envisagé.e
            Aspect visuel (schématiquement)
            Graphiques et/ou tableaux prévus
            Un seul ou plusieurs onglets ?
            Méthodes
            …
    Codes d’importation des données et de transformation (pour chaque étape et pour chaque source), ainsi que le fichier chron pour l’automatisation

