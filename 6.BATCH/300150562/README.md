\# 🚀 INF1099 - Projet PostgreSQL avec Docker \& PowerShell



\## 📌 Description du projet



Ce projet consiste à automatiser le déploiement et le chargement d’une base de données PostgreSQL à l’aide de \*\*Docker\*\* et d’un script \*\*PowerShell\*\*.



La base de données simule une boutique de maillots de sport avec gestion des clients, commandes, livraisons et paiements.



\---



\## 🧱 Architecture du projet



Le projet est structuré en plusieurs scripts SQL :



\- `DDL.sql` → Création des tables

\- `DML.sql` → Insertion des données

\- `DCL.sql` → Gestion des droits (sécurité)

\- `DQL.sql` → Requêtes de consultation



\---



\## 🐳 Conteneur Docker
\---

<img width="941" height="157" alt="image" src="https://github.com/user-attachments/assets/89b4b1bc-fe82-4e38-9986-c319a0b383b7" />
\---


Un conteneur PostgreSQL est utilisé :



\- Image : `postgres`

\- Nom du conteneur : `postgres-maillot`

\- Base de données : `boutique\_maillots`

\- Utilisateur : `postgres`

\- Port : `5432`



\---



\## ⚙️ Script d’automatisation (PowerShell)



Le script `load-db.ps1` automatise :
\---
<img width="939" height="684" alt="image" src="https://github.com/user-attachments/assets/67c7ed52-50eb-44dc-b640-6f5dacd71724" />
\--



1\. Vérification du conteneur Docker

2\. Copie des fichiers SQL dans le conteneur

3\. Exécution des scripts SQL dans PostgreSQL
\---

<img width="464" height="362" alt="image" src="https://github.com/user-attachments/assets/268bffb7-8ef6-4b58-b29e-6799ab96ad5e" />

---
4\. Génération d’un fichier de log `execution.log`



\---



\## 📜 Contenu du script PowerShell



```powershell

$docker = "C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe"



$container = "postgres-maillot"

$db = "boutique\_maillots"

$user = "postgres"

$log = "execution.log"



Write-Host "🚀 Début du chargement..."



\# Vérification du conteneur

$running = \& $docker ps --format "{{.Names}}"

if ($running -notcontains $container) {

&#x20;   Write-Host "❌ Conteneur non actif"

&#x20;   exit

}



\# Copie des fichiers SQL dans le conteneur

\& $docker cp DDL.sql ${container}:/DDL.sql

\& $docker cp DML.sql ${container}:/DML.sql

\& $docker cp DCL.sql ${container}:/DCL.sql

\& $docker cp DQL.sql ${container}:/DQL.sql



\# Exécution des scripts SQL

\& $docker exec -i $container psql -U $user -d $db -f /DDL.sql >> $log 2>\&1

\& $docker exec -i $container psql -U $user -d $db -f /DML.sql >> $log 2>\&1

\& $docker exec -i $container psql -U $user -d $db -f /DCL.sql >> $log 2>\&1

\& $docker exec -i $container psql -U $user -d $db -f /DQL.sql >> $log 2>\&1



Write-Host "✅ Terminé ! Vérifie execution.log"



▶️ Exécution du projet

1\. Démarrer Docker

docker start postgres-maillot
\---
---
<img width="929" height="600" alt="image" src="https://github.com/user-attachments/assets/3b201862-5967-47b2-9ef0-4047a834e897" />

---


2\. Lancer le script PowerShell



powershell -ExecutionPolicy Bypass -File .\\load-db.ps1

<img width="967" height="814" alt="image" src="https://github.com/user-attachments/assets/a9162cbb-bc67-45f6-b587-3e8cafade907" />

---


🧪 Vérification de la base

docker exec -it postgres-maillot psql -U postgres -d boutique\_maillots

Afficher les tables :



\\dt





