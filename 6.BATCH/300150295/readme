## 📚 Informations du cours

**Cours :** INF1099 - Administration des bases de données  
**Section :** 201-26H-04  
**Date :** 2026-03-11  
**Collège :** Collège Boréal  

---

## 📋 Description

Ce laboratoire démontre comment **automatiser le chargement de scripts SQL dans PostgreSQL** en utilisant :

- **Docker** pour exécuter PostgreSQL
- **PowerShell** pour automatiser l'exécution des scripts SQL
- **Scripts SQL** organisés selon leur type (DDL, DML, DCL, DQL)

Les scripts sont exécutés automatiquement **dans le bon ordre** afin de construire la base de données.

---

## 🎯 Objectifs du laboratoire

À la fin de ce laboratoire, l'étudiant sera capable de :

- Comprendre les différents **types de scripts SQL**
- Utiliser **Docker pour exécuter PostgreSQL**
- Écrire un **script PowerShell d'automatisation**
- Charger **plusieurs scripts SQL automatiquement**

---

## 🗂️ Structure du projet
300150295/
│
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
├── load-db.ps1
├── execution.log
└── images/
├── structure-dossier.png
├── docker-run.png
├── docker-ps.png
├── execution-script.png
├── logs-execution.png
└── verification-sql.png
plain
Copy

---

## 📊 Types de scripts SQL

| Type | Signification | Exemple |
|------|---------------|---------|
| **DDL** | Data Definition Language | `CREATE TABLE` |
| **DML** | Data Manipulation Language | `INSERT` |
| **DCL** | Data Control Language | `GRANT` |
| **DQL** | Data Query Language | `SELECT` |

---

## 🔄 Ordre d'exécution

Les scripts doivent être exécutés dans cet ordre :
DDL.sql → création des tables
↓
DML.sql → insertion des données
↓
DCL.sql → gestion des permissions
↓
DQL.sql → vérification des données
plain
Copy

---

## 🚀 Commandes utilisées

### 1️⃣ Vérifier la structure du dossier

```powershell
cd C:\Users\300150295\INF1099-201-26H-04\6.BATCH\300150295
Get-ChildItem
images/structure-dossier.png
2️⃣ Démarrer PostgreSQL avec Docker
powershell
Copy
docker run -d --name postgres-lab -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres:latest
images/docker-run.png
3️⃣ Vérifier que le conteneur fonctionne
powershell
Copy
docker ps
images/docker-ps.png
4️⃣ Exécuter le script PowerShell
powershell
Copy
.\load-db.ps1
Ce script va automatiquement exécuter :
✅ DDL.sql
✅ DML.sql
✅ DCL.sql
✅ DQL.sql
images/execution-script.png
5️⃣ Vérifier les logs
powershell
Copy
Get-Content execution.log
images/logs-execution.png
6️⃣ Vérifier les données dans PostgreSQL
powershell
Copy
docker exec -it postgres-lab psql -U postgres -d ecole -c "SELECT * FROM etudiants;"
images/verification-sql.png
✅ Résultats attendus
[x] Conteneur PostgreSQL démarré avec Docker
[x] Base de données ecole créée
[x] Tables créées et peuplées avec données de test
[x] Utilisateur lecteur_ecole configuré avec droits limités
[x] Logs d'exécution générés dans execution.log
📝 Auteur
Étudiant : 300150295
Cours : INF1099 - Administration des bases de données
Collège Boréal | 2026
'@
