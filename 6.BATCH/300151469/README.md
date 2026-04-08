
# Laboratoire BATCH — Chargement PostgreSQL avec Docker

**Auteure :** Rabia BOUHALI  
**Matricule :** 300151469  
**Cours :** INF1099-201-26H-04  
**Domaine :** Rendez-vous TCF Canada  

---

## 1. Description du laboratoire

Ce laboratoire consiste à automatiser le chargement d'une base de données PostgreSQL en utilisant un script PowerShell et Docker.

Les objectifs sont :
- comprendre les types de scripts SQL (DDL, DML, DCL, DQL)
- utiliser Docker pour exécuter PostgreSQL
- écrire un script PowerShell d'automatisation
- charger plusieurs scripts SQL automatiquement

---

## 2. Structure des fichiers

```
300151469/
├── DDL.sql        ← Création des tables
├── DML.sql        ← Insertion des données
├── DCL.sql        ← Gestion des permissions
├── DQL.sql        ← Requêtes de consultation
├── load-db.ps1    ← Script PowerShell d'automatisation
├── execution.log  ← Fichier log généré automatiquement
└── README.md      ← Documentation du laboratoire
```

---

## 3. Types de scripts SQL

| Type | Signification | Exemple utilisé |
|------|---------------|-----------------|
| DDL | Data Definition Language | `CREATE TABLE candidat` |
| DML | Data Manipulation Language | `INSERT INTO candidat` |
| DCL | Data Control Language | `GRANT SELECT` |
| DQL | Data Query Language | `SELECT * FROM rendezvous` |

Ordre d'exécution : **DDL → DML → DCL → DQL**

---

## 4. Démarrer PostgreSQL avec Docker

```powershell
docker container run -d `
  --name postgres-lab `
  -e POSTGRES_PASSWORD=postgres `
  -p 5432:5432 `
  postgres
```

Vérifier que le conteneur est actif :

```powershell
docker container ls
```

---

## 5. Exécuter le script

### Utilisation de base

```powershell
pwsh ./load-db.ps1
```

### Défi bonus — passer le nom du conteneur en paramètre

```powershell
pwsh ./load-db.ps1 postgres-lab
```

### Sortie attendue

```
========================================
 Chargement de la base : tcf_canada_300151469
 Conteneur             : postgres-lab
========================================
Conteneur actif. Debut du chargement...

Execution de DDL.sql ...
   CREATE TABLE

Execution de DML.sql ...
   INSERT 0 3

Execution de DCL.sql ...
   GRANT

Execution de DQL.sql ...
    id_candidat | nom     | prenom
   -------------+---------+--------
             1  | Bouhali | Rabia

========================================
 Chargement termine en 3.45 secondes.
 Log sauvegarde dans : execution.log
========================================
```

---

## 6. Explication du script PowerShell

### Paramètre optionnel (défi bonus)
```powershell
param (
    [string]$Container = "postgres-lab"
)
```
Permet de passer le nom du conteneur en argument. Si aucun argument n'est donné, la valeur par défaut `postgres-lab` est utilisée.

### Vérification du conteneur
```powershell
$ContainerRunning = docker ps --format "{{.Names}}" | Select-String $Container
```
Vérifie que le conteneur PostgreSQL est bien actif avant d'exécuter les scripts.

### Envoi des scripts SQL dans le conteneur
```powershell
Get-Content $file | docker exec -i $Container psql -U $User
```

| Commande | Rôle |
|----------|------|
| `Get-Content` | Lit le fichier SQL |
| `docker exec` | Exécute une commande dans le conteneur |
| `psql` | Client PostgreSQL |

### Fichier log (défi bonus)
```powershell
$Output | Out-File -FilePath $LogFile -Append
```
Chaque résultat est enregistré dans `execution.log` avec la date et l'heure.

### Temps d'exécution (défi bonus)
```powershell
$Chrono = [System.Diagnostics.Stopwatch]::StartNew()
# ... exécution ...
$Chrono.Stop()
$Elapsed = $Chrono.Elapsed.TotalSeconds
```
Mesure le temps total d'exécution du script.

---

## 7. Vérification manuelle

Se connecter dans le conteneur :

```powershell
docker container exec -it postgres-lab psql -U postgres
```

Puis vérifier les données :

```sql
\c tcf_canada_300151469
SELECT * FROM candidat;
SELECT * FROM rendezvous;
```

---

## 8. Défi bonus — résumé

| Fonctionnalité | Implémentée |
|----------------|-------------|
| Nom du conteneur en paramètre (`./load-db.ps1 postgres-lab`) | ✅ |
| Génération d'un fichier log (`execution.log`) | ✅ |
| Affichage du temps d'exécution | ✅ |
