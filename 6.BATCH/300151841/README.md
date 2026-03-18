# 🧪 Lab 6 — Automatisation PostgreSQL avec PowerShell & Docker

> **INF1099 — Bases de données** · Massinissa Mameri

---

## 📋 Table des matières

- [Objectif](#-objectif)
- [Technologies](#-technologies)
- [Structure du projet](#-structure-du-projet)
- [Mise en place](#-mise-en-place)
- [Script PowerShell](#️-script-powershell)
- [Vérification](#-vérification-des-données)
- [Résultats](#-résultats)

---

## 🎯 Objectif

Automatiser le déploiement complet d'une base de données **PostgreSQL** via un script **PowerShell**, en exécutant une série de scripts SQL dans un ordre précis :

| Étape | Fichier | Rôle |
|-------|---------|------|
| 1️⃣ | `DDL.sql` | Création du schéma et des tables |
| 2️⃣ | `DML.sql` | Insertion des données |
| 3️⃣ | `DCL.sql` | Gestion des utilisateurs et permissions |
| 4️⃣ | `DQL.sql` | Vérification et requêtes de contrôle |

---

## 🛠 Technologies

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=flat&logo=databricks&logoColor=white)

---

## 📁 Structure du projet

```
6.BATCH/
│
├── 📄 DDL.sql          # Création du schéma et des tables
├── 📄 DML.sql          # Insertion des données
├── 📄 DCL.sql          # Gestion des utilisateurs et permissions
├── 📄 DQL.sql          # Requêtes de vérification
├── ⚙️  load-db.ps1     # Script d'automatisation PowerShell
└── 🖼️  images/         # Captures d'écran du laboratoire
```

🖼️ Capture — Structure du projet dans PowerShell
![wait](https://github.com/user-attachments/assets/3c32a667-fd15-49ad-b6d9-6fdb248a83ac)

---

## 🐳 Mise en place

### 1. Vérifier que Podman est actif

Avant de lancer le conteneur, vérifier que le service Podman fonctionne :

```powershell
podman ps
```

🖼️ Capture — Podman actif avec le conteneur PostgreSQL
 
 ![wait](https://github.com/user-attachments/assets/58b696fe-d7fb-48da-8155-639487140f4a)


---

### 2. Lancer le conteneur PostgreSQL

```powershell
docker run -d `
  --name postgres-lab `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  postgres
```

### 3. Vérifier que le conteneur est actif

```powershell
docker ps
```

🖼️ Capture — Téléchargement de l'image et conteneur PostgreSQL en cours d'exécution

![wait](https://github.com/user-attachments/assets/06896e4b-4fdb-4627-b30a-219ff371ccd8)

> ✅ Le conteneur `postgres-lab` apparaît avec le statut **Up**.

---

## ⚙️ Script PowerShell

### Fonctionnement de `load-db.ps1`

Le script exécute automatiquement les fichiers SQL dans l'ordre suivant :

```
DDL ──► DML ──► DCL ──► DQL
```

**Étapes du script :**

1. ✔️ Vérifie que le conteneur Docker est actif
2. ✔️ Vérifie que tous les fichiers SQL sont présents
3. ✔️ Exécute les scripts SQL dans PostgreSQL
4. ✔️ Affiche les résultats des requêtes

### Exécution

```powershell
powershell -ExecutionPolicy Bypass -File .\load-db.ps1
```

🖼️ Capture — Exécution du script PowerShell

![wait](https://github.com/user-attachments/assets/82905562-90f1-4765-9839-2dabe15a3367)


---

## 📊 Vérification des données

### Connexion au conteneur

```bash
docker exec -it postgres-lab psql -U postgres -d ecole
```

### Requêtes de vérification

```sql
-- Vérifier les jeux enregistrés
SELECT * FROM esport.game;

-- Vérifier les équipes
SELECT * FROM esport.team;

-- Vérifier les joueurs
SELECT * FROM esport.player;
```

🖼️ Capture — Vérification des données dans PostgreSQL

![wait](https://github.com/user-attachments/assets/45be60ad-1f3a-4372-8cbd-86bcf625293e)


---

## ✅ Résultats

Le script PowerShell permet d'automatiser **complètement** le déploiement de la base de données PostgreSQL :

- 🏗️ Les tables sont créées via `DDL.sql`
- 📥 Les données sont insérées via `DML.sql`
- 🔐 Les permissions sont appliquées via `DCL.sql`
- 🔍 Les résultats sont vérifiés via `DQL.sql`

> Cette approche réduit les erreurs humaines et accélère le déploiement répétable d'environnements de base de données.

---

*Cours INF1099 — Bases de données · Massinissa Mameri*
