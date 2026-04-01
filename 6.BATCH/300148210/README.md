# Laboratoire BATCH – Chargement PostgreSQL avec Docker et PowerShell

## Objectif du laboratoire

Ce laboratoire vise à automatiser le chargement d’une base de données PostgreSQL à l’aide d’un script PowerShell exécuté dans un environnement Docker.

À la fin de ce travail, le système permet :

* d’exécuter plusieurs scripts SQL automatiquement
* de respecter l’ordre logique d’exécution
* d’éviter les erreurs manuelles
* de rendre le processus reproductible

---

## Environnement technique

* **SGBD** : PostgreSQL (conteneur Docker)
* **Automatisation** : PowerShell
* **Système** : Windows
* **Interface SQL** : psql (via Docker)

---

## Structure du projet

Le projet est organisé comme suit :

```
/300148210
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
└── load-db.ps1
```

---

## Types de scripts SQL

| Type | Description                | Rôle                    |
| ---- | -------------------------- | ----------------------- |
| DDL  | Data Definition Language   | Création des tables     |
| DML  | Data Manipulation Language | Insertion des données   |
| DCL  | Data Control Language      | Gestion des permissions |
| DQL  | Data Query Language        | Requêtes d’analyse      |

---

## Ordre d’exécution

L’ordre est obligatoire pour respecter les dépendances :

```
DDL → DML → DCL → DQL
```

* DDL crée la structure
* DML insère les données
* DCL applique la sécurité
* DQL exploite les données

---

## Démarrage de PostgreSQL avec Docker

Le conteneur est lancé avec la configuration suivante :

```powershell
docker container run -d `
--name labo-postgres `
-e POSTGRES_USER=admin `
-e POSTGRES_PASSWORD=admin123 `
-e POSTGRES_DB=laboratoire `
-p 5432:5432 `
postgres
```

Vérification :

```powershell
docker container ls
```

---

## Script PowerShell

Le fichier `load-db.ps1` permet d’exécuter automatiquement tous les scripts SQL.

### Fonctionnement

* vérifie la présence des fichiers
* envoie chaque fichier SQL dans PostgreSQL
* respecte l’ordre d’exécution
* affiche les résultats dans la console

### Script utilisé

```powershell
chcp 65001
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$Container = "labo-postgres"
$Database  = "laboratoire"
$User      = "admin"

$Files = @("DDL.sql","DML.sql","DCL.sql","DQL.sql")

Write-Output "Chargement base laboratoire..."

foreach ($file in $Files) {

    if (Test-Path $file) {

        Write-Output "Execution de $file"

        Get-Content $file -Encoding UTF8 | docker exec -i $Container psql -U $User -d $Database

    } else {

        Write-Output "ERREUR fichier manquant : $file"
        exit
    }
}

Write-Output "Chargement terminé."
```

---

## Exécution du script

Dans PowerShell :

```powershell
.\load-db.ps1
```

---

## Résultat attendu

* création des tables
* insertion des données
* attribution des permissions
* exécution des requêtes

Les résultats des requêtes SQL sont affichés directement dans la console.

---

## Vérification

Connexion manuelle :

```powershell
docker exec -it labo-postgres psql -U admin -d laboratoire
```

Test :

```sql
SELECT * FROM client;
SELECT * FROM analyse_lab;
```

---

## Version avancée (bonus)

Le script peut être amélioré pour :

### 1. Paramètre du conteneur

```powershell
param([string]$Container = "labo-postgres")
```

---

### 2. Fichier log

```powershell
$LogFile = "execution.log"
```

Utilisation :

```powershell
Write-Output "Execution de $file" | Tee-Object -FilePath $LogFile -Append
```

---

### 3. Temps d’exécution

```powershell
$start = Get-Date
# exécution
$end = Get-Date
$duration = $end - $start
Write-Output "Temps : $duration"
```

---

## Validation du laboratoire

Le laboratoire est validé si :

* le conteneur PostgreSQL est actif
* les scripts SQL sont exécutés sans erreur critique
* les données sont visibles dans la base
* les requêtes retournent des résultats corrects

---

## Conclusion

Ce laboratoire démontre l’utilisation conjointe de Docker, PostgreSQL et PowerShell pour automatiser le chargement d’une base de données.

L’approche permet :

* un gain de temps significatif
* une réduction des erreurs humaines
* une exécution standardisée
* une meilleure maintenabilité du système

Le système obtenu est reproductible, stable et conforme aux pratiques professionnelles.

