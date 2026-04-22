# Laboratoire : Automatisation de Base de Données Moodle avec PowerShell et Podman

## Description du projet
Ce projet automatise la création, le peuplement et la gestion des droits d'une base de données PostgreSQL (nommée `moodle_db`) s'exécutant dans un conteneur. Il utilise un script PowerShell (`load-db.ps1`) pour orchestrer l'exécution de plusieurs scripts SQL dans un ordre logique strict.

## Structure des fichiers SQL
L'ordre d'exécution est crucial pour respecter les contraintes d'intégrité (clés étrangères) :
1.  **DDL.sql** : Suppression des anciennes tables et création des nouvelles tables (`ETUDIANT`, `COURS`, `INSCRIPTION`).
2.  **DML.sql** : Insertion des données initiales (étudiants, cours et inscriptions).
3.  **DCL.sql** : Création du rôle `prof_moodle` et configuration des permissions de sécurité.
4.  **DQL.sql** : Requête de vérification effectuant une jointure entre les trois tables.

## Prérequis
* **Podman** (ou Docker) installé et fonctionnel.
* **PowerShell** (pwsh) pour l'exécution du script d'automatisation.

## Guide d'utilisation

### 1. Démarrer le conteneur
Avant de lancer le script, assurez-vous que votre conteneur PostgreSQL est actif :
```powershell
podman run -d --name postgres-moodle -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=moodle_db -p 5432:5432 postgres
