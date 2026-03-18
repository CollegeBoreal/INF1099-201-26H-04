# :test_tube: Laboratoire BATCH : 

[:tada: Participation](.scripts/Participation.md)

Script `Batch PowerShell` pour charger `PostgreSQL` avec `Docker`

## Objectifs

À la fin de ce laboratoire, l’étudiant sera capable de :

* Comprendre les types de scripts SQL
* Utiliser Docker pour exécuter PostgreSQL
* Écrire un **script PowerShell d’automatisation**
* Charger plusieurs scripts SQL automatiquement

---

# 1. Les types de scripts SQL

| Type    | Signification              | Exemple      |
| ------- | -------------------------- | ------------ |
| **DDL** | Data Definition Language   | CREATE TABLE |
| **DML** | Data Manipulation Language | INSERT       |
| **DQL** | Data Query Language        | SELECT       |
| **DCL** | Data Control Language      | GRANT        |

Fichiers utilisés dans ce laboratoire :

```
DDL.sql
DML.sql
DCL.sql
DQL.sql
```

Ordre d’exécution :

```
DDL → DML → DCL → DQL
```

---

# 2. Structure du laboratoire


```
🆔/
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
└── load-db.ps1
```

---

# 3. Démarrer PostgreSQL avec Docker

Créer un conteneur : (modifier en fonction de ta base)

🪟 PowerShell

```powershell
docker container run -d `
--name postgres-lab `
-e POSTGRES_PASSWORD=postgres `
-e POSTGRES_DB=ecole `
-p 5432:5432 `
postgres
```

🐧 *nux

```bash
docker container run -d \
--name postgres-lab \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=ecole \
-p 5432:5432 \
postgres
```


Vérifier :

```bash
docker container ls
```

---

# 4. Script PowerShell

Créer le fichier :

```
load-db.ps1
```

### Script

```powershell
# ---------------------------------------
# Script PowerShell pour charger PostgreSQL
# ---------------------------------------

$Container = "postgres-lab"
$Database  = "ecole"
$User      = "postgres"

$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)

Write-Output "Chargement de la base de données..."

foreach ($file in $Files) {

    if (Test-Path $file) {

        Write-Output "Execution de $file"

        Get-Content $file | docker exec -i $Container psql -U $User -d $Database

    }
    else {

        Write-Output "ERREUR : fichier $file introuvable"
    }

}

Write-Output "Chargement terminé."
```

---

# 5. Exécuter le script

Dans PowerShell :

```powershell
pwsh ./load-db.ps1
```

Sortie possible :

```
Chargement de la base de données...

Execution de DDL.sql
CREATE TABLE

Execution de DML.sql
INSERT 0 5

Execution de DCL.sql
GRANT

Execution de DQL.sql
 id | nom
----+------
 1  | Alice
 2  | Bob

Chargement terminé.
```

---

# 6. Explication du script

### Liste des fichiers

```powershell
$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)
```

Tableau PowerShell contenant les scripts SQL.

---

### Vérification du fichier

```powershell
Test-Path $file
```

Permet de vérifier que le fichier existe.

---

### Envoi du script dans le conteneur

```powershell
Get-Content $file | docker exec -i $Container psql -U $User -d $Database
```

Explication :

| Commande    | Rôle                                   |
| ----------- | -------------------------------------- |
| Get-Content | lit le fichier                         |
| |           | pipeline                               |
| docker exec | exécute une commande dans le conteneur |
| psql        | client PostgreSQL                      |

---

# 7. Version avancée (plus robuste)

Script avec vérification du conteneur.

```powershell
$Container = "postgres-lab"
$Database  = "ecole"
$User      = "postgres"

$Files = "DDL.sql","DML.sql","DCL.sql","DQL.sql"

$containerRunning = docker ps --format "{{.Names}}" | Select-String $Container

if (-not $containerRunning) {

    Write-Output "ERREUR : le conteneur $Container n'est pas actif."
    exit

}

foreach ($file in $Files) {

    if (-not (Test-Path $file)) {

        Write-Output "ERREUR : fichier manquant : $file"
        exit
    }

    Write-Output "Execution de $file"

    Get-Content $file | docker exec -i $Container psql -U $User -d $Database
}

Write-Output "Base de données chargée avec succès."
```

---

# 8. Travail demandé

1️⃣ Créer les fichiers SQL :

```
DDL.sql
DML.sql
DCL.sql
DQL.sql
```

2️⃣ Écrire le script :

```
load-db.ps1
```

3️⃣ Lancer le conteneur PostgreSQL.

4️⃣ Exécuter le script.

---

# 9. Vérification

Connexion dans le conteneur :

```bash
docker container exec -it postgres psql -U postgres -d ecole
```

Puis :

```sql
SELECT * FROM ma_table;
```

---

# 10. Défi (bonus)

Modifier le script pour :

* accepter **le nom du conteneur en paramètre**

```
./load-db.ps1 postgres-lab
```

* générer un **fichier log**

```
execution.log
```

* afficher le **temps d’exécution**

