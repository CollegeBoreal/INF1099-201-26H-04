<div align="center">

# 🗄️ TP Batch — PowerShell & PostgreSQL

<img src="https://readme-typing-svg.herokuapp.com?font=JetBrains+Mono&size=22&pause=1000&color=00F7FF&center=true&vCenter=true&width=750&lines=Chargement+automatique+de+PostgreSQL;Scripts+SQL+%3A+DDL+%7C+DML+%7C+DCL+%7C+DQL;PowerShell+%2B+Docker+%2B+PostgreSQL+%F0%9F%90%B3" />

<br/>

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Conteneur-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-Script-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-Compatible-0078D6?style=for-the-badge&logo=windows&logoColor=white)

<br/>

> **Automatisation complète du chargement d'une base de données PostgreSQL**
> via un script PowerShell et un conteneur Docker.

</div>

---

## 📚 Table des matières

- [🎯 Objectifs](#-objectifs)
- [📁 Structure du projet](#-structure-du-projet)
- [🗂️ Types de scripts SQL](#️-types-de-scripts-sql)
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
📦 lab-batch/
 ┣ 📄 DDL.sql              ← Création des tables
 ┣ 📄 DML.sql              ← Insertion des données
 ┣ 📄 DCL.sql              ← Permissions et rôles
 ┣ 📄 DQL.sql              ← Requêtes SELECT
 ┣ 📄 load-db.ps1          ← Script d'automatisation
 ┣ 📄 execution.log        ← Log généré automatiquement
 ┗ 📄 README.md
```

> ⚠️ **Ordre d'exécution obligatoire :** `DDL` → `DML` → `DCL` → `DQL`

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
|------|--------------|-----------|---------|
| 🏗️ **DDL** | Data Definition Language | `CREATE`, `DROP`, `ALTER` | `DDL.sql` |
| 📥 **DML** | Data Manipulation Language | `INSERT`, `UPDATE`, `DELETE` | `DML.sql` |
| 🔐 **DCL** | Data Control Language | `GRANT`, `REVOKE` | `DCL.sql` |
| 🔍 **DQL** | Data Query Language | `SELECT` | `DQL.sql` |

---

## 🐳 Démarrer avec Docker

### 1. Lancer le conteneur PostgreSQL

```powershell
docker container run -d `
  --name postgres-lab `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  postgres
```

### 2. Créer la base de données

```powershell
docker exec -it postgres-lab psql -U postgres -c "CREATE DATABASE ecole;"
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

<details>
<summary><b>🏗️ DDL.sql — Création des tables</b></summary>

```sql
CREATE TABLE IF NOT EXISTS etudiants (
    id      SERIAL PRIMARY KEY,
    nom     VARCHAR(100) NOT NULL,
    prenom  VARCHAR(100) NOT NULL,
    email   VARCHAR(150) UNIQUE,
    age     INT
);

CREATE TABLE IF NOT EXISTS cours (
    id      SERIAL PRIMARY KEY,
    titre   VARCHAR(200) NOT NULL,
    credits INT DEFAULT 3
);

CREATE TABLE IF NOT EXISTS inscriptions (
    id          SERIAL PRIMARY KEY,
    etudiant_id INT REFERENCES etudiants(id),
    cours_id    INT REFERENCES cours(id)
);
```

</details>

<details>
<summary><b>📥 DML.sql — Insertion des données</b></summary>

```sql
INSERT INTO etudiants (nom, prenom, email, age) VALUES
    ('Tremblay', 'Alice',   'alice@ecole.ca',  20),
    ('Gagnon',   'Bob',     'bob@ecole.ca',    22),
    ('Roy',      'Claire',  'claire@ecole.ca', 21),
    ('Cote',     'David',   'david@ecole.ca',  23),
    ('Bouchard', 'Emma',    'emma@ecole.ca',   19);

INSERT INTO cours (titre, credits) VALUES
    ('Bases de donnees',  3),
    ('Reseaux',           3),
    ('Programmation Web', 3);

INSERT INTO inscriptions (etudiant_id, cours_id) VALUES
    (1,1),(2,1),(3,2),(4,3),(5,1);
```

</details>

<details>
<summary><b>🔐 DCL.sql — Permissions</b></summary>

```sql
CREATE ROLE lecteur LOGIN PASSWORD 'lecteur123';
GRANT CONNECT ON DATABASE ecole TO lecteur;
GRANT USAGE ON SCHEMA public TO lecteur;
GRANT SELECT ON etudiants, cours, inscriptions TO lecteur;
```

</details>

<details>
<summary><b>🔍 DQL.sql — Requêtes</b></summary>

```sql
SELECT * FROM etudiants;
SELECT * FROM cours;

SELECT e.nom, e.prenom, c.titre AS cours
FROM inscriptions i
JOIN etudiants e ON e.id = i.etudiant_id
JOIN cours     c ON c.id = i.cours_id
ORDER BY e.nom;
```

</details>

---

## 🔧 Script PowerShell

```powershell
# ============================================================
# load-db.ps1 — Chargement automatique de PostgreSQL
# Usage : .\load-db.ps1 [nom-du-conteneur]
# ============================================================

param([string]$Container = "postgres-lab")

$Database = "ecole"
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
[14:19:11] Demarrage du chargement...
[14:19:11] Execution de DDL.sql
CREATE TABLE
CREATE TABLE
CREATE TABLE
[14:19:11] Execution de DML.sql
INSERT 0 5
INSERT 0 3
INSERT 0 5
[14:19:12] Execution de DCL.sql
GRANT
[14:19:12] Execution de DQL.sql

 id |   nom    | prenom |      email      | age
----+----------+--------+-----------------+-----
  1 | Tremblay | Alice  | alice@ecole.ca  |  20
  2 | Gagnon   | Bob    | bob@ecole.ca    |  22
  3 | Roy      | Claire | claire@ecole.ca |  21
  4 | Cote     | David  | david@ecole.ca  |  23
  5 | Bouchard | Emma   | emma@ecole.ca   |  19

   nom    | prenom |       cours
----------+--------+-------------------
 Bouchard | Emma   | Bases de donnees
 Cote     | David  | Programmation Web
 Gagnon   | Bob    | Bases de donnees
 Roy      | Claire | Reseaux
 Tremblay | Alice  | Bases de donnees

[14:19:13] Termine en 1.97 secondes!
```

---

## 🏆 Fonctionnalités bonus

### 🧩 1. Conteneur en paramètre
```powershell
.\load-db.ps1 mon-conteneur
```

### 📋 2. Fichier log horodaté — `execution.log`
```
[14:19:11] Demarrage du chargement...
[14:19:11] Execution de DDL.sql
[14:19:11] Execution de DML.sql
[14:19:12] Execution de DCL.sql
[14:19:12] Execution de DQL.sql
[14:19:13] Termine en 1.97 secondes!
```

### ⏱️ 3. Temps d'exécution
Le script affiche automatiquement le temps total d'exécution en secondes.

---

## ✅ Vérification

Se connecter dans le conteneur :

```powershell
docker exec -it postgres-lab psql -U postgres -d ecole
```

Puis tester dans psql :

```sql
SELECT * FROM etudiants;
SELECT * FROM cours;
\q
```

---

## 📌 Conclusion

Ce laboratoire démontre comment automatiser le chargement d'une base de données PostgreSQL avec PowerShell et Docker. Les quatre types de scripts SQL ont été exécutés avec succès en moins de **2 secondes**, avec journalisation complète dans `execution.log`.

---

<div align="center">

![SQL](https://img.shields.io/badge/SQL-DDL%20%7C%20DML%20%7C%20DCL%20%7C%20DQL-orange?style=flat-square)
![Status](https://img.shields.io/badge/Statut-Complété%20✅-brightgreen?style=flat-square)

*Laboratoire BATCH — Automatisation PostgreSQL avec Docker & PowerShell*

</div>
