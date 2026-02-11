&nbsp;# 📄 README.md — TP INF1099

\## Manipulation de données avec MySQL et Podman sur Windows



---



\## 👤 Étudiant

\- \*\*Nom :\*\* Massi  

\- \*\*Cours :\*\* INF1099  

\- \*\*Environnement :\*\* Windows 10/11 – PowerShell – Podman – MySQL 8.0  



---



\## 🎯 Objectif du TP

L’objectif de ce TP est de :

\- Installer et configurer Podman avec WSL2 sur Windows

\- Lancer un conteneur MySQL

\- Créer une base de données Sakila

\- Créer un utilisateur MySQL

\- Importer les données Sakila

\- Vérifier la manipulation des tables SQL



---



\## 🛠️ Environnement utilisé

\- Windows 10/11 (64 bits)

\- PowerShell (Administrateur)

\- Podman 5.7.1

\- WSL2

\- MySQL 8.0 (conteneur Docker/Podman)

\- Base de données Sakila (officielle MySQL)



---



\## 📦 Étapes réalisées



\### 1️⃣ Installation et configuration de Podman

\- Installation de Podman pour Windows

\- Choix du backend WSL2

\- Activation de WSL

\- Initialisation et démarrage de la machine Podman  



\*\*Commandes utilisées :\*\*

```powershell

podman --version

podman machine init

podman machine start

podman machine list

2️⃣ Création du dossier de travail

Création du dossier INF1099 dans Downloads :



$projectDir = "$env:USERPROFILE\\Downloads\\INF1099"

New-Item -ItemType Directory -Path $projectDir -Force

3️⃣ Téléchargement et préparation de Sakila

Téléchargement de la base Sakila officielle (format SQL), puis décompression :



Expand-Archive -Path "$projectDir\\sakila-db.zip" -DestinationPath $projectDir -Force

Fichiers obtenus :



sakila-schema.sql



sakila-data.sql



4️⃣ Alias Docker vers Podman

Afin d’utiliser les commandes Docker avec Podman :



Set-Alias docker podman

5️⃣ Lancement du conteneur MySQL

Création et démarrage du conteneur MySQL :



docker run -d --name INF1099-mysql `

&nbsp; -e MYSQL\_ROOT\_PASSWORD=rootpass `

&nbsp; -p 3306:3306 `

&nbsp; mysql:8.0

Vérification :



docker ps

6️⃣ Création de la base de données Sakila

docker exec -it INF1099-mysql mysql -h 127.0.0.1 -u root -prootpass -e "CREATE DATABASE sakila;"

Vérification :



docker exec -it INF1099-mysql mysql -h 127.0.0.1 -u root -prootpass -e "SHOW DATABASES;"

7️⃣ Création de l’utilisateur MySQL

Création de l’utilisateur etudiants :



docker exec -it INF1099-mysql mysql -h 127.0.0.1 -u root -prootpass -e `

"CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants\_1';"

Attribution des droits :



docker exec -it INF1099-mysql mysql -h 127.0.0.1 -u root -prootpass -e `

"GRANT ALL PRIVILEGES ON sakila.\* TO 'etudiants'@'%'; FLUSH PRIVILEGES;"

8️⃣ Importation de la base Sakila

Import du schéma :



Get-Content "$projectDir\\sakila-db\\sakila-schema.sql" |

docker exec -i INF1099-mysql mysql -u etudiants -petudiants\_1 sakila

Import des données :



Get-Content "$projectDir\\sakila-db\\sakila-data.sql" |

docker exec -i INF1099-mysql mysql -u etudiants -petudiants\_1 sakila

9️⃣ Vérification finale

Connexion à MySQL et affichage des tables :



docker exec -it INF1099-mysql mysql -u etudiants -petudiants\_1 -e "USE sakila; SHOW TABLES;"

Résultat :



Les tables actor, film, customer, category, etc. sont présentes.



✅ Conclusion

Le conteneur MySQL fonctionne correctement avec Podman.

La base de données Sakila a été importée avec succès et est prête pour les exercices SQL du cours INF1099.



📸 CAPTURES D’ÉCRAN À METTRE DANS LE README

👉 Très important pour la note



Capture 1 — Podman fonctionnel



Capture 2 — Machine Podman en cours d’exécution





Capture 3 — Conteneur MySQL actif





Capture 4 — Bases de données MySQL





Capture 5 — Tables Sakila (preuve finale)





Capture 6 — connexion sur workbench



