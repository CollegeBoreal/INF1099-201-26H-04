# TP Batch — PowerShell & PostgreSQL

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat&logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=flat&logo=windows&logoColor=white)

> Automatisation complète du chargement d'une base de données PostgreSQL via un script PowerShell et un conteneur Docker.

**Auteure :** Rabia BOUHALI | **Matricule :** 300151469 | **Domaine :** Rendez-vous TCF Canada

---

## Table des matières

- [🎯 Objectifs](#-objectifs)
- [📁 Structure du projet](#-structure-du-projet)
- [🗂️ Types de scripts SQL](#-types-de-scripts-sql)
- [🐳 Démarrer avec Docker](#-démarrer-avec-docker)
- [⚡ Exécution rapide](#-exécution-rapide)
- [📝 Scripts SQL](#-scripts-sql)
- [🔧 Script PowerShell](#-script-powershell)
- [📊 Résultat](#-résultat)
- [🏆 Fonctionnalités bonus](#-fonctionnalités-bonus)
- [✅ Vérification](#-vérification)

---

## 🎯 Objectifs

| # | Objectif | Statut |
|---|----------|--------|
| 1 | Comprendre les types de scripts SQL (DDL, DML, DCL, DQL) | ✅ |
| 2 | Utiliser Docker pour exécuter PostgreSQL | ✅ |
| 3 | Écrire un script PowerShell d'automatisation | ✅ |
| 4 | Charger plusieurs scripts SQL automatiquement | ✅ |
| 5 | Bonus : paramètre, log, chronomètre | ✅ |

---

## 📁 Structure du projet

```
📦 300151469/
 ┣ 📄 DDL.sql              ← Création des tables
 ┣ 📄 DML.sql              ← Insertion des données
 ┣ 📄 DCL.sql              ← Permissions et rôles
 ┣ 📄 DQL.sql              ← Requêtes SELECT
 ┣ 📄 load-db.ps1          ← Script d'automatisation
 ┣ 📄 execution.log        ← Log généré automatiquement
 ┗ 📄 README.md
```

> Ordre d'exécution obligatoire : **DDL → DML → DCL → DQL**

---

## 🗂️ Types de scripts SQL

```
┌─────────────────────────────────────────────────────────┐
│  DDL → DML → DCL → DQL                                  │
│                                                         │
│  CREATE TABLE    INSERT    GRANT    SELECT               │
└─────────────────────────────────────────────────────────┘
```

| Type | Signification | Commandes | Fichier |
|------|---------------|-----------|---------|
| 🏗️ DDL | Data Definition Language | `CREATE`, `DROP`, `ALTER` | `DDL.sql` |
| 📥 DML | Data Manipulation Language | `INSERT`, `UPDATE`, `DELETE` | `DML.sql` |
| 🔐 DCL | Data Control Language | `GRANT`, `REVOKE` | `DCL.sql` |
| 🔍 DQL | Data Query Language | `SELECT` | `DQL.sql` |

---

## 🐳 Démarrer avec Docker

### 1. Lancer le conteneur PostgreSQL

```powershell
docker container run -d `
  --name postgres-lab `
  -e POSTGRES_PASSWORD=postgres `
  -p 5432:5432 `
  postgres
```

### 2. Créer la base de données

```powershell
docker exec -it postgres-lab psql -U postgres -c "CREATE DATABASE tcf_canada_300151469;"
```

### 3. Vérifier que le conteneur tourne

```powershell
docker container ls
```

```
CONTAINER ID   IMAGE      STATUS       PORTS                    NAMES
a1b2c3d4e5f6   postgres   Up 5 secs    0.0.0.0:5432->5432/tcp   postgres-lab
```

---

## ⚡ Exécution rapide

```powershell
# Étape 1 — Autoriser les scripts
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# Étape 2 — Lancer le script
.\load-db.ps1

# Ou avec le nom du conteneur en paramètre (bonus)
.\load-db.ps1 postgres-lab
```

---

## 📝 Scripts SQL

### 🏗️ DDL.sql — Création des tables

Crée les 5 tables de la base : `candidat`, `lieu`, `session`, `rendezvous`, `paiement` avec leurs clés primaires et étrangères.

### 📥 DML.sql — Insertion des données

Insère les données de test : 3 candidats, 3 lieux (Toronto, Ottawa, Montréal), 3 sessions, 3 rendez-vous et 3 paiements.

### 🔐 DCL.sql — Permissions

Crée l'utilisateur `etudiant300151469` et lui accorde les droits `SELECT`, `INSERT`, `UPDATE` sur toutes les tables.

### 🔍 DQL.sql — Requêtes

6 requêtes de consultation dont des `JOIN` entre candidats, sessions, lieux, rendez-vous et paiements.

---

## 🔧 Script PowerShell

```powershell
# ============================================================
# load-db.ps1 — Chargement automatique de PostgreSQL
# Auteure : Rabia BOUHALI | Matricule : 300151469
# Usage   : .\load-db.ps1 [nom-du-conteneur]
# ============================================================

param([string]$Container = "postgres-lab")

$Database = "tcf_canada_300151469"
$User     = "postgres"
$LogFile  = "execution.log"
$Files    = @("DDL.sql", "DML.sql", "DCL.sql", "DQL.sql")

function Write-Log {
    param([string]$Message)
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $Message"
    Write-Output $line
    Add-Content -Path $LogFile -Value $line
}

$start = Get-Date
Write-Log "Demarrage du chargement..."

# Vérification du conteneur
$running = docker ps --format "{{.Names}}" | Select-String $Container
if (-not $running) {
    Write-Log "ERREUR : conteneur '$Container' non actif!"
    exit 1
}

# Exécution de chaque fichier SQL
foreach ($file in $Files) {
    if (-not (Test-Path $file)) {
        Write-Log "ERREUR : fichier manquant : $file"
        exit 1
    }
    Write-Log "Execution de $file"
    Get-Content $file | docker exec -i $Container psql -U $User -d $Database
}

$duree = ((Get-Date) - $start).TotalSeconds
Write-Log "Termine en $([math]::Round($duree, 2)) secondes!"
```

### Explication des commandes clés

| Commande | Rôle |
|----------|------|
| `param(...)` | Accepte le nom du conteneur en argument |
| `Test-Path` | Vérifie qu'un fichier existe |
| `Get-Content` | Lit le contenu d'un fichier SQL |
| `docker exec -i` | Exécute une commande dans le conteneur |
| `psql` | Client PostgreSQL qui reçoit le SQL |
| `Add-Content` | Écrit dans le fichier log |

---

## 📊 Résultat

```
[09:15:01] Demarrage du chargement...
[09:15:01] Execution de DDL.sql
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
[09:15:02] Execution de DML.sql
INSERT 0 3
INSERT 0 3
INSERT 0 3
INSERT 0 3
INSERT 0 3
[09:15:02] Execution de DCL.sql
GRANT
[09:15:02] Execution de DQL.sql

 id_candidat |   nom   | prenom |           email            | telephone
-------------+---------+--------+----------------------------+------------
           1 | Bouhali | Rabia  | rabia.bouhali@email.com    | 6471111111
           2 | Ali     | Sami   | sami.ali@email.com         | 6472222222
           3 | Ben     | Nora   | nora.ben@email.com         | 6473333333

   nom     | prenom | date_session | heure_session |  statut
-----------+--------+--------------+---------------+-----------
 Bouhali   | Rabia  | 2026-04-15   | 09:00:00      | Confirme
 Ali       | Sami   | 2026-04-18   | 13:30:00      | En attente
 Ben       | Nora   | 2026-04-22   | 10:15:00      | Confirme

[09:15:03] Termine en 2.14 secondes!
```

---

## 🏆 Fonctionnalités bonus

### 1. Conteneur en paramètre

```powershell
.\load-db.ps1 mon-conteneur
```

### 2. Fichier log horodaté — `execution.log`

```
[09:15:01] Demarrage du chargement...
[09:15:01] Execution de DDL.sql
[09:15:02] Execution de DML.sql
[09:15:02] Execution de DCL.sql
[09:15:02] Execution de DQL.sql
[09:15:03] Termine en 2.14 secondes!
```

### 3. Temps d'exécution

Le script affiche automatiquement le temps total d'exécution en secondes.

---

## ✅ Vérification

Se connecter dans le conteneur :

```powershell
docker exec -it postgres-lab psql -U postgres -d tcf_canada_300151469
```

Puis tester dans psql :

```sql
SELECT * FROM candidat;
SELECT * FROM rendezvous;
\q
```

---

## Conclusion

Ce laboratoire démontre comment automatiser le chargement d'une base de données PostgreSQL avec PowerShell et Docker, appliqué au domaine **Rendez-vous TCF Canada**. Les quatre types de scripts SQL ont été exécutés avec succès en moins de 3 secondes, avec journalisation complète dans `execution.log`.
