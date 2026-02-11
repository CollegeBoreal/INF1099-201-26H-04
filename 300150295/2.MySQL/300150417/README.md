# 📘 TP INF1099 – Automatisation de la base Sakila avec Docker / Podman

## 👤 Étudiant
- **Nom :** Abdelatif Nemous  
- **Cours :** INF1099  
- **Sujet :** Automatisation du déploiement de la base Sakila avec Docker (Podman) et MySQL 8  

---

## 🎯 Objectif du TP

L’objectif de ce travail est de mettre en place un environnement MySQL conteneurisé permettant :

- le lancement d’un serveur MySQL avec Docker (via Podman),
- la création de la base de données **Sakila**,
- la création d’un utilisateur applicatif (`etudiants`),
- l’importation automatique du schéma et des données Sakila,
- la vérification du bon fonctionnement à l’aide de requêtes SQL.

L’ensemble du processus est automatisable et reproductible.

---

## 🧰 Environnement utilisé

- **Système d’exploitation :** Windows  
- **Shell :** PowerShell  
- **Moteur de conteneurs :** Podman (alias Docker)  
- **Image Docker :** `mysql:8.0`  
- **Base de données :** MySQL 8  
- **Jeu de données :** Sakila  

🟢 Étape 1 – Création du dossier du projet

Création du dossier INF1099 dans le répertoire Downloads afin de centraliser les fichiers du TP.

![creation_de_chemin](./images/1.PNG) 

🟢 Étape 2 – Initialisation de Podman

Initialisation et démarrage de la machine virtuelle Podman pour permettre l’exécution des conteneurs Docker.

![podman](./images/intilitation_podman_3.PNG) 

🟢 Étape 3 – Lancement du conteneur MySQL

Lancement du conteneur MySQL avec un mot de passe root et l’exposition du port MySQL.

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

![my_sql](./images/lancage_conteneur_my_sql_4.PNG) 

🟢 Étape 4 – Création de la base de données Sakila

Création de la base de données sakila à l’intérieur du conteneur MySQL.
```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
```

Vérification :
```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "SHOW DATABASES;"
```
![sakila_creation](./images/creeation_base_sakila_5.PNG) 

🟢 Étape 5 – Création de l’utilisateur etudiants

Création de l’utilisateur etudiants afin de permettre un accès applicatif à la base de données Sakila.


![etudiant](./images/utilsaateur_etudiant.PNG) 

🟢 Étape 6 – Importation du schéma Sakila

Importation du schéma de la base Sakila à partir du fichier sakila-schema.sql.

```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```


🟢 Étape 7 – Importation des données Sakila

Importation des données Sakila à partir du fichier sakila-data.sql.

```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

🟢 Étape 8 – Vérification de l’importation

Vérification de la présence des tables dans la base Sakila.
```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

Les tables principales (actor, film, customer, rental, inventory, etc.) sont bien présentes.

![imprtage](./images/importage_sakila_7.PNG) 
