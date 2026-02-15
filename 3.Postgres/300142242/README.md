Rapport de TP : PostgreSQL et pgAdmin 4 avec Docker/Podman
Étudiant : Abderrafia Yahia

Matricule : 300142242

1. Objectifs atteints
Ce travail consistait à déployer un environnement PostgreSQL complet en utilisant la conteneurisation pour isoler la base de données et un outil graphique pour sa gestion.

2. Déploiement du serveur PostgreSQL
J'ai utilisé Podman pour lancer une instance PostgreSQL 16 avec une persistance des données via un volume:
docker container run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16

3. Chargement de la base de données Sakila
Le processus d'intégration des données s'est déroulé en trois phases :

Téléchargement des scripts SQL officiels (Schéma et Données) via PowerShell.

Transfert des fichiers vers le système de fichiers interne du conteneur.


Exécution des fichiers via l'utilitaire psql:
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql

4. Gestion Graphique avec pgAdmin 4
Pour faciliter l'exploration des données, j'ai installé pgAdmin 4 en utilisant le gestionnaire de paquets Chocolatey. J'ai ensuite configuré une connexion au serveur local sur le port 5432 pour accéder visuellement aux tables comme actor et film.

5. Personnalisation et Validation
Pour authentifier mon travail, j'ai inséré mes informations personnelles dans la table des acteurs :
INSERT INTO actor (first_name, last_name) VALUES ('ABDERRAFIA YAHIA', '300142242');


La commande \dt confirme la présence de l'ensemble des tables Sakila dans le schéma public de la base appdb.
