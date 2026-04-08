# 🐘 Laboratoire PostgreSQL + Docker + PowerShell

Automatisation du chargement de scripts SQL dans PostgreSQL via Docker et PowerShell.

---

## 🎯 Objectifs

À la fin de ce laboratoire, l'étudiant sera capable de :

- Comprendre les types de scripts SQL
- Utiliser Docker pour exécuter PostgreSQL
- Écrire un script PowerShell d'automatisation
- Charger plusieurs scripts SQL automatiquement

---

## 📚 1. Les types de scripts SQL

| Type | Signification | Exemple |
|------|--------------|---------|
| **DDL** | Data Definition Language | `CREATE TABLE` |
| **DML** | Data Manipulation Language | `INSERT` |
| **DQL** | Data Query Language | `SELECT` |
| **DCL** | Data Control Language | `GRANT` |

**Fichiers utilisés dans ce laboratoire :**
---

## 🔍 6. Explication du script

**Liste des fichiers**

```powershell
$Files = @(
    "DDL.sql",
    "DML.sql",
    "DCL.sql",
    "DQL.sql"
)
```

Tableau PowerShell contenant les scripts SQL à exécuter dans l'ordre.

**Vérification de l'existence du fichier**

```powershell
Test-Path $file
```

Permet de s'assurer que le fichier existe avant de tenter de l'exécuter.

**Envoi du script dans le conteneur**

```powershell
Get-Content $file | docker exec -i $Container psql -U $User -d $Database
```

| Commande | Rôle |
|----------|------|
| `Get-Content` | Lit le contenu du fichier |
| `docker exec` | Exécute une commande dans le conteneur |
| `psql` | Client PostgreSQL |

---


---


