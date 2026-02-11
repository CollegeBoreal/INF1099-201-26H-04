📄 TP INF1099 – MySQL avec Podman
👤 Informations

Nom : Massinissa Mameri
Cours : INF1099
Session : Hiver 2026
Environnement : Windows 10/11 – PowerShell – Podman – MySQL 8.0

🎯 Objectif du TP

Ce TP consiste à :

Installer et configurer Podman avec WSL2

Lancer un conteneur MySQL

Créer la base de données Sakila

Créer un utilisateur MySQL

Importer les données Sakila

Vérifier la présence des tables

🛠️ Environnement utilisé

Windows 10/11 (64 bits)

PowerShell (Administrateur)

Podman 5.7.1

WSL2

MySQL 8.0 (conteneur)

Base de données Sakila (officielle MySQL)

📦 Étapes réalisées
1️⃣ Installation et configuration de Podman
Commandes utilisées
podman --version
podman machine init
podman machine start
podman machine list

2️⃣ Création du dossier de travail
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force

3️⃣ Préparation de la base Sakila
Expand-Archive -Path "$projectDir\sakila-db.zip" -DestinationPath $projectDir -Force


Fichiers obtenus :

sakila-schema.sql

sakila-data.sql

4️⃣ Alias Docker vers Podman
Set-Alias docker podman

5️⃣ Lancement du conteneur MySQL
docker run -d --name INF1099-mysql `
 -e MYSQL_ROOT_PASSWORD=rootpass `
 -p 3306:3306 `
 mysql:8.0


Vérification :

docker ps

6️⃣ Création de la base sakila
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"


Vérification :

docker exec -it INF1099-mysql mysql -u root -prootpass -e "SHOW DATABASES;"

7️⃣ Création de l'utilisateur
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"

docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON sakila.* TO 'etudiants'@'%'; FLUSH PRIVILEGES;"

8️⃣ Importation de Sakila

Import du schéma :

Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila


Import des données :

Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

9️⃣ Vérification finale
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"


Les tables actor, film, customer, category, etc. sont présentes.

✅ Conclusion

✔ Le conteneur MySQL fonctionne correctement avec Podman
✔ La base Sakila a été importée avec succès
✔ L’environnement est prêt pour les exercices SQL

📸 Captures d’écran

(Les images doivent être dans le dossier images du même dossier que ce README)

Capture 1 —  
![wait](https://github.com/user-attachments/assets/fc263246-769a-4789-9b6c-d008eea9fac5)


Capture 2 — Machine Podman active
<img width="938" height="178" alt="Machine Podman en cours d’exécution" src="https://github.com/user-attachments/assets/8c71d200-5d06-45ef-a583-27013c5e6c2d" />


Capture 3 — Conteneur MySQL actif
<img width="941" height="171" alt="Conteneur MySQL actif" src="https://github.com/user-attachments/assets/c3cedcf5-6ca1-4d6f-b1d0-ba17cd4cd873" />

Capture 4 — Bases de données MySQL
<img width="940" height="663" alt="Bases de données MySQL" src="https://github.com/user-attachments/assets/bbba65d9-8128-414e-8220-9c0524821760" />

Capture 5 — Tables Sakila
<img width="929" height="456" alt="Tables Sakila (preuve finale)" src="https://github.com/user-attachments/assets/63dc9525-a725-419b-81a3-7ae91b27ab8c" />

Capture 6 — Connexion Workbench
<img width="1207" height="1020" alt="connexion sur worbench" src="https://github.com/user-attachments/assets/e21cce2a-4482-454c-ab6f-79d995f8f911" />
