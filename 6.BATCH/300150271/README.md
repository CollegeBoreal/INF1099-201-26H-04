<div align="center">

# 🏢 TP Batch — PowerShell & PostgreSQL (Immobilier)

<img src="https://readme-typing-svg.herokuapp.com?font=JetBrains+Mono&size=22&pause=1000&color=00F7FF&center=true&vCenter=true&width=750&lines=Base+de+donnees+Immobiliere;Automatisation+PostgreSQL;PowerShell+%2B+Docker" />

<br/>

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=for-the-badge\&logo=postgresql\&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Conteneur-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-Script-5391FE?style=for-the-badge\&logo=powershell\&logoColor=white)

</div>

---

## 🎯 Objectifs

| # | Objectif                                | Statut |
| - | --------------------------------------- | ------ |
| 1 | Comprendre DDL, DML, DCL, DQL           | ✅      |
| 2 | Utiliser Docker avec PostgreSQL         | ✅      |
| 3 | Automatiser avec PowerShell             | ✅      |
| 4 | Charger les scripts SQL automatiquement | ✅      |

---

## 📁 Structure du projet

```
300150271/
 ┣ DDL.sql
 ┣ DML.sql
 ┣ DCL.sql
 ┣ DQL.sql
 ┣ load-db.ps1
 ┣ images/
 ┗ README.md
```

---

## 🏢 Domaine

Système de gestion des ventes d’appartements dans des immeubles.

---

## 🗂️ Types de scripts SQL

| Type    | Description             | Commandes |
| ------- | ----------------------- | --------- |
| 🏗️ DDL | Création des tables     | CREATE    |
| 📥 DML  | Insertion des données   | INSERT    |
| 🔐 DCL  | Gestion des permissions | GRANT     |
| 🔍 DQL  | Requêtes                | SELECT    |

---

## 🐳 Démarrage avec Docker

### Lancer PostgreSQL

```powershell
docker run -d --name postgres-immo -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=immobilier -p 5432:5432 postgres
```

---

## ⚡ Exécution

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\load-db.ps1
```

---

## 📝 Scripts SQL

### 🏗️ DDL.sql

Création des tables :

* client
* immeuble
* appartement
* vente

---

### 📥 DML.sql

Insertion des données :

* clients
* immeubles
* appartements
* ventes

---

### 🔐 DCL.sql

Gestion des accès :

```sql
DROP ROLE IF EXISTS lecteur;
CREATE ROLE lecteur LOGIN PASSWORD '1234';
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lecteur;
```

---

### 🔍 DQL.sql

Requêtes :

```sql
SELECT * FROM client;
SELECT * FROM appartement;
```

---

## 🔧 Script PowerShell

Automatisation complète de l’exécution des scripts SQL dans Docker.

---

## 📊 Résultat

```
Execution DDL
DROP TABLE
CREATE TABLE

Execution DML
INSERT

Execution DCL
GRANT

Execution DQL
SELECT ...
```

---

## 📸 Captures

* docker ps
* structure du dossier
* exécution du script

---

## 👨‍🎓 Auteur

Mazigh Bareche
Matricule : 300150271
