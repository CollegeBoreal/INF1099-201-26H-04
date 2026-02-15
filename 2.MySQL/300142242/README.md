# Rapport de TP : Mise en place de MySQL avec Podman

**Par :** Abderrafia Yahia

**Matricule :** 300142242

## 1. Objectif du projet

L'objectif de ce TP était de configurer un environnement de base de données conteneurisé sur Windows en utilisant **Podman** avec un alias **Docker**. Le projet inclut le déploiement d'un serveur MySQL 8.0 et l'importation de la base de données exemple **Sakila**.

## 2. Configuration de l'environnement

J'ai d'abord configuré Podman et préparé les fichiers nécessaires sur mon système :

* **Initialisation de Podman :** Création et démarrage de la machine virtuelle Linux.
```powershell
podman machine init
podman machine start

```


* **Alias Docker :** Configuration de l'alias pour utiliser les commandes `docker` standards.
```powershell
Set-Alias docker podman

```


* **Préparation des fichiers :** Extraction de la base Sakila dans le dossier `$projectDir` (`C:\Users\Laptop\Downloads\INF1099`).

## 3. Déploiement du conteneur MySQL

J'ai lancé l'instance MySQL avec les paramètres de sécurité demandés :

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

```

## 4. Configuration et Importation des données

Une fois le conteneur prêt, j'ai créé la structure de la base de données et l'utilisateur dédié :

* **Création de la base et de l'utilisateur :**
```powershell
docker exec -i INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec -i INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"
docker exec -i INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'%' WITH GRANT OPTION;"

```


* **Importation du schéma et des données :**
```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

```



## 5. Personnalisation et Preuves de travail

Pour démontrer ma maîtrise de la base de données, j'ai ajouté mes informations personnelles directement dans la table des acteurs :

* **Ajout de mon identité :**
```powershell
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila -e "INSERT INTO actor (first_name, last_name) VALUES ('ABDERRAFIA YAHIA', '300142242');"

```


* **Modification d'un enregistrement :** J'ai également personnalisé la description du premier film pour y inclure mes détails de TP.
```powershell
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila -e "UPDATE film SET description = 'Modifié par Abderrafia Yahia (300142242)' WHERE film_id = 1;"

```



## 6. Vérification finale

La commande suivante confirme que toutes les tables (actor, film, customer, etc.) sont bien présentes et que les données ont été injectées avec succès :

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
