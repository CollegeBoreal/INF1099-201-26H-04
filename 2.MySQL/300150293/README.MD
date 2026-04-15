🚀 INF1099 – MySQL 8 avec Podman sur Windows
🎯 Objectif du projet

Ce TP a pour objectif de :

🖥 Installer et configurer Podman sur Windows
🔄 Utiliser un alias Docker avec Podman
🐳 Déployer un conteneur MySQL 8.0
🗄 Créer et importer la base de données Sakila
⚡ Automatiser le déploiement avec PowerShell
📊 Exécuter des requêtes SQL (GROUP BY, JOIN)
🔗 Se connecter avec MySQL Workbench
🛠 1️⃣ Installation de Podman
📥 Installation
choco install podman-desktop -y
✅ Vérification
podman --version
podman info
📁 2️⃣ Création du dossier de travail
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
📦 3️⃣ Extraction de Sakila
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir
🔄 4️⃣ Configuration de l’alias Docker
Set-Alias docker podman
Permanent :
notepad $PROFILE

Ajouter :

Set-Alias docker podman
⚙️ 5️⃣ Initialisation de Podman
podman machine init
podman machine start
🐳 6️⃣ Déploiement du conteneur MySQL
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
Vérification :
docker ps
🗄 7️⃣ Création de la base de données
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
👤 8️⃣ Création de l’utilisateur
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"

docker exec INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
📥 9️⃣ Importation de Sakila
🔹 Schéma
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
🔹 Données
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
✅ 🔟 Vérification
docker exec INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"

✔ Résultat : tables comme film, customer, actor, etc.

⚡ 1️⃣1️⃣ Script d’automatisation

📄 Fichier : start-sakila-INF1099.ps1

$projectDir = "$env:USERPROFILE\Downloads\INF1099"

docker rm -f -v INF1099-mysql 2>$null

docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

Start-Sleep -Seconds 40

docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
docker exec INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"

Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

docker exec INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
▶ Exécution :
.\start-sakila-INF1099.ps1
📊 1️⃣2️⃣ Requêtes SQL réalisées
🔹 Requête 1
SELECT rating, COUNT(*) AS total
FROM film
GROUP BY rating;

✔ Affiche le nombre de films par catégorie

🔹 Requête 2
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;

✔ Affiche les clients avec leur ville

🖥 1️⃣3️⃣ Connexion MySQL Workbench
Host : 127.0.0.1
Port : 3306
User : etudiants
Password : etudiants_1
Database : sakila

✔ Connexion réussie

👤 Auteur
Nom : Salim Amir
🎓 Programme : INF1099
🏫 Collège Boréal
📅 Année : 2026
🎉 Résultat final
✅ Podman configuré
✅ MySQL fonctionnel
✅ Base Sakila importée
✅ Script automatisé
✅ Requêtes SQL exécutées
✅ Connexion Workbench validée
