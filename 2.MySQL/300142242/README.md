# Projet de Gestion Scolaire (Moodle Duplicate) - INF1099

## Description
Ce projet consiste en la mise en place d'une infrastructure de base de données pour une plateforme de gestion scolaire. Il utilise des conteneurs Podman pour isoler le serveur MySQL et des scripts PowerShell pour automatiser le déploiement.

## Structure du Projet
* `schema.sql` : Définition des tables (3FN).
* `data.sql` : Données de test pour peupler la base.
* `start-sakila-INF1099.ps1` : Script d'automatisation complet.

## Preuve de fonctionnement
Voici le résultat de l'exécution du script d'automatisation, montrant la création des tables et l'insertion des données :

<img width="1410" height="921" alt="image" src="https://github.com/user-attachments/assets/aefe6dc3-fe6f-4289-be0b-4aba7324ce24" />


## Instructions
Pour lancer le projet, ouvrez PowerShell dans ce dossier et exécutez :
`.\start-sakila-INF1099.ps1`
