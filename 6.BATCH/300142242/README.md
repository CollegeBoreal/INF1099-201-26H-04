# Laboratoire : Automatisation PostgreSQL avec PowerShell et Docker

Ce projet automatise la configuration d'une base de données PostgreSQL dans un conteneur Docker à l'aide d'un script PowerShell.

## Structure du projet
- `DDL.sql` : Création des tables.
- `DML.sql` : Insertion des données.
- `DCL.sql` : Gestion des permissions.
- `DQL.sql` : Requêtes de vérification.
- `load-db.ps1` : Script d'automatisation.

## Prérequis
- Docker Desktop installé et fonctionnel.
- PowerShell.

## Utilisation
1. Lancer le conteneur :
   `docker container run -d --name postgres-lab -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres`
2. Exécuter le script :
   `./load-db.ps1`
