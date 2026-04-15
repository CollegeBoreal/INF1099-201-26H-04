# ✈️ Projet PostgreSQL – Automatisation complète avec PowerShell, Docker & Podman

## 📌 Description générale

Ce projet consiste à créer et automatiser une base de données PostgreSQL représentant un système aéroportuaire complet.
L’automatisation est réalisée à l’aide d’un script PowerShell capable d’exécuter les fichiers SQL, gérer les erreurs, et générer un journal (log) détaillé.

---

## 🧰 Technologies utilisées

* PostgreSQL
* Docker (via Podman)
* PowerShell
* SQL (DDL, DML, DCL, DQL)

---

## ⚙️ Étape 1 : Initialisation de Podman

```powershell
podman machine init
podman machine start
podman info
```
---------------------
<img width="1366" height="728" alt="1" src="https://github.com/user-attachments/assets/1c1d1b71-9cf9-4f34-b411-6edaffca9cd1" />

-------------------------

✔ Machine démarrée en mode rootless
✔ API Docker compatible

---

## 🐳 Étape 2 : Lancement du conteneur PostgreSQL

```powershell
docker container run -d --name postgres-lab -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres
```
-------------------------
<img width="1366" height="459" alt="2" src="https://github.com/user-attachments/assets/74bd954f-454b-41ec-a7de-72acf03d70dd" />

----------------------------

Vérification :

```powershell
docker container ls
```
-------------------------
<img width="1366" height="119" alt="3" src="https://github.com/user-attachments/assets/e5410125-ad3e-4199-8215-6c140c676257" />

----------------------------

✔ Conteneur actif
✔ Port exposé

---

## 📁 Étape 3 : Création des fichiers

```powershell
New-Item DDL.sql
New-Item DML.sql
New-Item DCL.sql
New-Item DQL.sql
New-Item load-db.ps1
```
------------------------
<img width="1366" height="726" alt="4" src="https://github.com/user-attachments/assets/9de6d152-bd1e-4e85-9682-587acd37b5f8" />

---------------------------
<img width="700" height="212" alt="5" src="https://github.com/user-attachments/assets/23323423-786d-4d97-8957-534502d39468" />

--------------------------

## 🏗️ Étape 4 : DDL (Structure)

<img width="1366" height="728" alt="5 1" src="https://github.com/user-attachments/assets/8ff0188a-50d4-436e-8da8-9594f6657aeb" />


✔ Clés primaires et étrangères définies
✔ Relations entre les tables

---

## 📥 Étape 5 : DML (Insertion des données)

Insertion de données réalistes :

------------------
<img width="1365" height="724" alt="5 2" src="https://github.com/user-attachments/assets/8a7a92de-1cfa-443f-b054-da8a3781fda9" />

--------------

## 🔐 Étape 6 : DCL (Gestion des accès)

<img width="1366" height="725" alt="5 3" src="https://github.com/user-attachments/assets/31653a49-0bbb-4a7c-9297-fd4ce4fa6696" />


✔ Gestion correcte des erreurs

---

## 🔎 Étape 7 : DQL (Requêtes)

-----------------------
<img width="1366" height="729" alt="5 4" src="https://github.com/user-attachments/assets/6618e774-44f9-4fc6-8892-9e859df197a7" />

---------
✔ Jointures fonctionnelles
✔ Résultats corrects

---

## Étape 8 : Automatisation avec PowerShell et exécution des scripts SQL

## 📌 Description

Dans cette étape, nous avons automatisé l’exécution de la base de données PostgreSQL à l’aide d’un script PowerShell (`load-db.ps1`).
Ce script permet d’exécuter automatiquement les fichiers SQL (DDL, DML, DCL, DQL) dans un conteneur Docker.

---

## 📁 Création du script PowerShell

```powershell id="w8z2jr"
New-Item load-db.ps1
```

Ouverture :

```powershell id="y2kns0"
notepad load-db.ps1
```

--------------------------
<img width="717" height="227" alt="6" src="https://github.com/user-attachments/assets/c71f1ee6-85e6-4bc9-8f36-f72e96cff5f5" />

---

## ⚙️ Fonctionnement du script

Le script réalise les actions suivantes :

* Vérifie que le conteneur Docker est actif
* Exécute les fichiers SQL dans cet ordre :

  * DDL.sql → création des tables
  * DML.sql → insertion des données
  * DCL.sql → gestion des droits
  * DQL.sql → exécution des requêtes

---

## ▶️ Exécution du script

```powershell id="w1y8bq"
.\load-db.ps1
```

-----------------------
<img width="1366" height="726" alt="7" src="https://github.com/user-attachments/assets/e4ec5973-7488-4719-86e2-f1bcc12d37c9" />

---

## 🏗️ Exécution du DDL

Résultat observé :

```text id="9o3l4s"
NOTICE: table "..." does not exist, skipping
DROP TABLE
CREATE TABLE
```

✔ Les anciennes tables sont supprimées
✔ Les nouvelles tables sont créées correctement

---

## 📥 Exécution du DML

```text id="6j0t8h"
INSERT 0 5
```

✔ Les données sont insérées avec succès

---

## 🔐 Exécution du DCL

```text id="9c3f7d"
CREATE ROLE
GRANT
```

✔ Création du rôle `agent_consultation`
✔ Attribution des permissions

---

## 🔎 Exécution du DQL

Résultats affichés :

### 🔹 Compagnies aériennes

```text id="5r2n9w"
Air Canada
Air France
Lufthansa
Emirates
Qatar Airways
```

---

### 🔹 Avions et capacités

```text id="7z1m4k"
Boeing 737
Airbus A320
Airbus A380
Boeing 787
```

---

### 🔹 Vols

```text id="b4x8pq"
AC101 → Toronto → Montreal
AF202 → Paris → Rome
LH303 → Berlin → Madrid
EK404 → Dubai → Doha
QR505 → Doha → London
```

---

### 🔹 Passagers

```text id="l2v9js"
Ali Ahmed
Sara Ben
John Doe
Anna Smith
Omar Khan
```

---

### 🔹 Nombre de passagers

```text id="p8d1fm"
COUNT = 5
```

---

### 🔹 Tri des vols

```text id="u6k3la"
ORDER BY date_depart DESC
```

✔ Tri correct des résultats

---

### 🔹 Incidents

```text id="y0f5dz"
Delay
Technical issue
Weather
Late boarding
Fuel issue
```

---

### 🔹 Services au sol

```text id="h1n8tx"
Nettoyage
Carburant
Bagages
Catering
Maintenance
```

---

## ✅ Résultat final

```text id="e9r4qs"
Chargement terminé.
```

✔ Toutes les étapes ont été exécutées avec succès
✔ Base de données opérationnelle
✔ Données visibles et cohérentes
 ------------------------
 <img width="1366" height="726" alt="8" src="https://github.com/user-attachments/assets/993a9744-9324-40ae-a6a6-b8c0db980bca" />

 ------------------------
 <img width="1366" height="727" alt="9" src="https://github.com/user-attachments/assets/d85b5ae3-b098-4b9c-80cd-bbf183470d10" />

---------------------------
<img width="774" height="77" alt="10" src="https://github.com/user-attachments/assets/1d5d8628-4e47-4a7a-bf6c-1b4ab5f92244" />

----------------------
<img width="1366" height="728" alt="11" src="https://github.com/user-attachments/assets/b65fd01a-2d23-44a0-a89e-d97848732ec0" />

-----------------------
<img width="1366" height="729" alt="12" src="https://github.com/user-attachments/assets/07d0d947-f8a9-4393-a85e-ddc048ca4d5d" />

-----------------------

## 🎯 Objectif de cette étape

* Automatiser l’exécution des scripts SQL
* Tester la création et l’insertion des données
* Vérifier les résultats des requêtes
* Valider le bon fonctionnement global

---

## ⚙️ Étape 9 — Script PowerShell (Automatisation)

### 🔹 Script complet

```powershell
param(
    [string]$Container = "postgres-lab"
)

$Database = "ecole"
$User = "postgres"

$Files = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

$LogFile = "execution.log"

$StartTime = Get-Date

"--- Début de l'exécution ---" | Out-File $LogFile

$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {
    "ERREUR : le conteneur $Container n'est pas actif !" | Tee-Object -FilePath $LogFile
    exit
}

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {
        "ERREUR : fichier manquant : $file" | Tee-Object -FilePath $LogFile -Append
        exit
    }

    "Execution de $file" | Tee-Object -FilePath $LogFile -Append

    Get-Content $file |
    docker exec -i $Container psql -U $User -d $Database |
    Tee-Object -FilePath $LogFile -Append
}

$EndTime = Get-Date
$Duration = $EndTime - $StartTime

"Temps d'exécution : $Duration" | Tee-Object -FilePath $LogFile -Append
"--- Fin de l'exécution ---" | Tee-Object -FilePath $LogFile -Append
```

-------------------------
<img width="1366" height="731" alt="16" src="https://github.com/user-attachments/assets/6f40449f-9069-4f85-8062-6d177d4a8f83" />

---

## ▶️ Exécution

```powershell
.\load-db.ps1
```

ou

```powershell
.\load-db.ps1 postgres-lab
```
---------------------
<img width="1366" height="729" alt="17" src="https://github.com/user-attachments/assets/32449def-c71f-4bdb-bbac-60d8215a5c36" />

-------------
<img width="1366" height="727" alt="18" src="https://github.com/user-attachments/assets/401f4bee-4b28-4ece-a163-a5597a7d212b" />

----------------
<img width="1366" height="729" alt="19" src="https://github.com/user-attachments/assets/11b6d56e-87a4-4973-9bbc-1750d2e7b44f" />

----------------

## ⚠️ Gestion des erreurs

### 🔹 Conteneur arrêté

```text
ERREUR : le conteneur postgres-lab n'est pas actif !
```

Solution :

```powershell
docker start postgres-lab
```

---

### 🔹 Fichier manquant

```text
ERREUR : fichier manquant : DDL.sql
```

✔ Vérification automatique

---------------------
<img width="1366" height="720" alt="13" src="https://github.com/user-attachments/assets/1f424777-5c37-4d39-afaa-e73437e7ae3a" />

-----------------
<img width="1366" height="199" alt="14" src="https://github.com/user-attachments/assets/3d2f78f9-af74-428f-9417-e726ea7f0d92" />

-------------------
<img width="1366" height="726" alt="15" src="https://github.com/user-attachments/assets/bed6339f-d124-4403-b63d-b47d789917c9" />


### 🔹 Rôle existant

```text
ERROR: role "agent_consultation" already exists
```

✔ Non bloquant

---

## 🧾 Fichier LOG

```powershell
notepad execution.log
```
-------------
<img width="1366" height="728" alt="20" src="https://github.com/user-attachments/assets/b923499d-235d-4eeb-9613-28054367d2b1" />

--------------

## 🎯 Objectifs atteints

✔ Automatisation complète
✔ Docker + PostgreSQL
✔ Scripts SQL complets
✔ Sécurité (DCL)
✔ Requêtes avancées
✔ Script PowerShell robuste
✔ Gestion des erreurs
✔ Journalisation (LOG)
✔ Mesure de performance

---

## 🏁 Conclusion

Ce projet démontre la mise en place d’un système automatisé professionnel pour la gestion d’une base de données PostgreSQL avec Docker.

La solution est :

* fiable
* réutilisable
* automatisée
* prête pour un usage réel

Elle représente une base solide pour des projets plus avancés en DevOps et gestion de bases de données.

