TP MySQL avec Docker sur Windows
Lounas ALLOUTI  
INF1099
Ce TP est divisé en 12 étapes PowerShell :
📄 Étape 1-2 - Préparation de l'environnement
Vérification des prérequis système
Création du dossier de projet dans Downloads
Téléchargement et décompression de Sakila DB
📄 Étape 3-5 - Configuration Docker
Vérification de l'installation Docker
Démarrage et vérification de Docker Desktop
📄 Étape 6-8 - Conteneur MySQL et Base de données
Lancement du conteneur MySQL
Création de la base de données Sakila
Création et configuration de l'utilisateur etudiants
📄 Étape 9-10 - Import et Vérification
Importation du schéma Sakila
Importation des données Sakila
Vérification de l'importation des tables
---
🚀 Étapes du laboratoire
Étape 0 : Configuration des variables
```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
```
---
Étape 1 : Créer le dossier de projet
Créer le dossier INF1099 dans Downloads :
```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```
📋 Output
---
Étape 2 : Télécharger et décompresser Sakila DB
Décompresser Sakila dans le dossier projet :
```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir -Force
```
---
Étape 3 : Vérifier l'installation Docker
Docker est utilisé directement, vérifier qu'il est bien installé :
```powershell
docker --version
```
---
Étape 4 : Vérifier Docker Desktop
S'assurer que Docker Desktop est démarré et fonctionnel :
<img width="950" height="96" alt="image" src="https://github.com/user-attachments/assets/dfb7fe6b-2048-48b2-837c-f786f8ea051b" />

```powershell
docker info
```
📋 Output
---
Étape 5 : Vérifier le fonctionnement de Docker
```powershell
docker ps -a

```
<img width="942" height="279" alt="image" src="https://github.com/user-attachments/assets/2b84417f-f81a-49c9-b2f0-052a2890bef0" />

📋 Output
---
Étape 6 : Lancer le conteneur MySQL
```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```
Vérifier que le conteneur est démarré :
```powershell
docker ps
```
📋 Output
---
Étape 7 : Créer la base de données Sakila
Créer la base de données :
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
```
Vérifier la création :
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "SHOW DATABASES;"
```
📋 Output  
🖼️ Capture d'écran
<img width="937" height="651" alt="image" src="https://github.com/user-attachments/assets/ce59fe32-9ede-4ffb-914d-4448fe587437" />

---
Étape 8 : Créer l'utilisateur etudiants
Créer l'utilisateur :
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
```
<img width="937" height="651" alt="image" src="https://github.com/user-attachments/assets/c485baf6-e30d-4360-843f-113aa540a96b" />

Accorder les privilèges :
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```
Vérifier la création :
```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e "SELECT User, Host FROM mysql.user;"
```
<img width="937" height="651" alt="image" src="https://github.com/user-attachments/assets/9a02d5a2-ed20-4884-864e-18a1716ab229" />

📋 Output  
🖼️ Capture d'écran
---
Étape 9 : Importer le schéma Sakila
Charger le schéma :
```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```
---
Étape 10 : Importer les données Sakila
Charger les données :
```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```
<img width="955" height="671" alt="image" src="https://github.com/user-attachments/assets/5e4df096-b4d9-41c1-8445-b55d9763095c" />

---
Étape 11 : Vérifier l'importation
Afficher les tables :
```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```
📋 Output  
🖼️ Capture d'écran
<img width="955" height="671" alt="image" src="https://github.com/user-attachments/assets/a973c422-0b36-4897-8b0a-39960ced0718" />

---
Étape 12 : Tester quelques requêtes SQL
Se connecter de manière interactive :
```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```
Ou exécuter des requêtes directement :
```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SELECT COUNT(*) AS total_films FROM film;"
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SELECT first_name, last_name FROM actor LIMIT 5;"
```
📋 Output  
🖼️ Capture d'écran
---
📚 Commandes utiles
Commande	Description
`docker ps -a`	Lister tous les conteneurs
`docker stop INF1099-mysql`	Arrêter le conteneur MySQL
`docker start INF1099-mysql`	Démarrer le conteneur MySQL
`docker logs INF1099-mysql`	Voir les logs du serveur
`docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1`	Se connecter à MySQL
---
🔄 Script d'automatisation
`start-sakila-INF1099.ps1` :
```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# Lancer MySQL
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

# Attendre que MySQL soit prêt
Start-Sleep -Seconds 20

# Créer la base et l'utilisateur
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"

# Importer le schéma et les données
Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Write-Host "✅ Base de données Sakila importée avec succès!" -ForegroundColor Green
```
Exécuter le script :
```powershell
.\start-sakila-INF1099.ps1
```
---
✅ Résumé
Ce TP nous a permis de :
✅ Installer et configurer Docker Desktop sur Windows
✅ Vérifier le fonctionnement de Docker
✅ Lancer un conteneur MySQL 8.0
✅ Créer une base de données et un utilisateur MySQL
✅ Importer la base de données Sakila (schéma + données)
✅ Manipuler les tables avec des requêtes SQL
