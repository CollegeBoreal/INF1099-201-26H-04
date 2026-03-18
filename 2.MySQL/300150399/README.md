# TP INF1099 – Automatisation de la base Sakila avec Docker / Podman

**Nom :** Rahmani Chakib  
**Numéro étudiant :** 300150399  


## Étudiant

Nom : Chakib Rahmani  

Numéro étudiant : 300150399  

Cours : INF1099  

Sujet : Automatisation du déploiement de la base Sakila avec Docker (Podman) et MySQL 8
---

# Objectif

Ce TP consiste à automatiser le déploiement de la base de données **Sakila** en utilisant **Docker (Podman)** et **MySQL 8**.

Les étapes incluent :
## Objectif du TP

- lancement d’un conteneur MySQL
- création de la base Sakila
- création d’un utilisateur applicatif
- importation du schéma et des données
- vérification avec des requêtes SQL

---

# Environnement utilisé
- Windows  
- PowerShell  
- Podman (alias Docker)  
- MySQL 8  
- Base Sakila  

---

# Étape 1 – Vérification de Podman

## Environnement utilisé

\- Système d’exploitation : Windows  

\- Shell : PowerShell  

\- Moteur de conteneurs : Podman (alias Docker)  

\- Image Docker : mysql:8.0  

\- Base de données : MySQL 8  

\- Jeu de données : Sakila

---



## Étape 1 – Création du dossier du projet

Création du dossier INF1099 dans le répertoire Downloads afin de centraliser les fichiers du TP.



!\[Création du dossier](images/creation\_de\_chemin.png)

---



## Étape 2 – Initialisation de Podman

Initialisation et démarrage de la machine virtuelle Podman pour permettre l’exécution des conteneurs Docker.



!\[Podman](images/podman.png)

---



---



## Étape 3 – Lancement du conteneur MySQL



Lancement du conteneur MySQL avec un mot de passe root et l’exposition du port MySQL.


Commande utilisée :


podman --version
Set-Alias docker podman


![Screenshot 1](images/1.png)

---

# Étape 2 – Création du dossier du projet

Commandes utilisées :


$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Force -Path $projectDir
Set-Location $projectDir
pwd
=======
## Étape 4 – Création de la base de données Sakila


![Screenshot 2](images/2.png)

---

# Étape 3 – Initialisation de Podman

Commandes utilisées :


podman machine init
podman machine start


![Screenshot 3](images/3.png)

---

# Étape 4 – Lancement du conteneur MySQL

Commande utilisée :


docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0


Vérification :


docker ps


![Screenshot 4](images/4.png)

---

# Étape 5 – Création de la base de données Sakila

Commande :

docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
=======
## Étape 5 – Création de l’utilisateur etudiants


Vérification :


SHOW DATABASES;


![Screenshot 5](images/5.png)

---

# Étape 6 – Création de l’utilisateur etudiants

Commandes :


CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';
GRANT ALL PRIVILEGES ON sakila.* TO 'etudiants'@'%';
FLUSH PRIVILEGES;
=======
## Étape 6 – Importation du schéma Sakila


![Screenshot 6](images/6.png)

---

# Étape 7 – Vérification des fichiers Sakila
=======


## Étape 7 – Importation des données Sakila



Importation des données Sakila à partir du fichier sakila-data.sql.



Commande utilisée :


Get-ChildItem "$projectDir" -Recurse -Filter "*.sql"


Les fichiers trouvés :

- sakila-schema.sql  
- sakila-data.sql  

![Screenshot 7](images/7.png)

---

# Étape 8 – Importation du schéma Sakila

Commande :


Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
=======
## Étape 8 – Vérification de l’importation


![Screenshot 8](images/8.png)

---

# Étape 9 – Importation des données Sakila

Commande :


Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila


![Screenshot 9](images/9.png)

---

# Étape 10 – Vérification de la base

Commande utilisée :


docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"


Exemples de requêtes SQL :


SELECT COUNT() FROM actor;
SELECT title, release_year FROM film LIMIT 10;
SELECT rating, COUNT() FROM film GROUP BY rating;
SELECT first_name, last_name, email FROM customer LIMIT 10;


![Screenshot 10](images/10.png)

---

# Conclusion

La base de données Sakila a été déployée avec succès dans un conteneur MySQL à l’aide de Podman.  
Les tables ont été créées et les données importées correctement, comme confirmé par les requêtes SQL exécutées.

Cette méthode permet de déployer rapidement une base de données dans un environnement conteneurisé et reproductible.