# 🧪 Laboratoire PostgreSQL – Automatisation avec PowerShell et Podman

## 📌 Présentation

Ce projet démontre comment **automatiser le chargement d’une base de données PostgreSQL** à l’aide d’un **script PowerShell** et d’un **conteneur PostgreSQL exécuté avec Podman**.

Le script permet d’exécuter automatiquement plusieurs fichiers SQL dans le bon ordre afin de :

* créer la structure de la base de données
* insérer des données
* gérer les permissions
* exécuter des requêtes de vérification

Ce laboratoire simule un **déploiement automatisé d’une base de données**, une pratique courante en environnement professionnel.

---

# 🎯 Objectifs

À la fin de ce laboratoire, l’étudiant sera capable de :

* Comprendre les différents **types de scripts SQL**
* Exécuter **PostgreSQL dans un conteneur**
* Automatiser des opérations avec **PowerShell**
* Charger automatiquement plusieurs scripts SQL
* Organiser un projet simple d’**automatisation de base de données**

---

# 📂 Structure du projet

```id="fs4yax"
300141550/
│
├── DDL.sql        # Création de la structure de la base de données
├── DML.sql        # Insertion des données
├── DCL.sql        # Gestion des rôles et permissions
├── DQL.sql        # Requêtes pour consulter les données
└── load-db.ps1    # Script PowerShell d'automatisation
```

---

# 🗄 Types de scripts SQL

| Type | Signification              | Exemple      |
| ---- | -------------------------- | ------------ |
| DDL  | Data Definition Language   | CREATE TABLE |
| DML  | Data Manipulation Language | INSERT       |
| DQL  | Data Query Language        | SELECT       |
| DCL  | Data Control Language      | GRANT        |

### Ordre d'exécution

Les scripts doivent être exécutés dans l’ordre suivant :

```id="hzvrpj"
DDL → DML → DCL → DQL
```

---

# 🐳 Démarrer PostgreSQL avec Podman

Lancer un conteneur PostgreSQL :

```bash id="csqawf"
podman run -d \
--name postgres \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=ecole \
-p 5432:5432 \
docker.io/library/postgres:16
```

Vérifier que le conteneur fonctionne :

```bash id="b4avgi"
podman ps
```

---

# ⚙ Script PowerShell

Le fichier **load-db.ps1** permet d’exécuter automatiquement tous les scripts SQL.

Fonctionnement du script :

* vérifie que chaque fichier SQL existe
* lit le contenu du fichier
* envoie le script dans le conteneur PostgreSQL
* exécute les scripts dans l’ordre défini

Commande utilisée dans le script :

```powershell id="q2q0y4"
Get-Content $file | podman exec -i $Container psql -U $User -d $Database
```

---

# ▶ Exécution du script

Dans PowerShell :

```powershell id="nhfpk1"
pwsh ./load-db.ps1
```

Exemple de sortie :

```id="t3rzsq"
Chargement de la base de données...

Execution de DDL.sql
CREATE TABLE

Execution de DML.sql
INSERT 0 3

Execution de DCL.sql
GRANT

Execution de DQL.sql
Affichage des résultats...

Chargement terminé.
```

---

# 🔎 Vérification dans PostgreSQL

Connexion au conteneur :

```bash id="eqksdx"
podman exec -it postgres psql -U postgres -d ecole
```

Exemple de requête :

```sql id="ijlj4r"
SELECT * FROM etudiants;
```

Résultat attendu :

```id="ghxw4g"
 id | nom     | prenom
----+---------+--------
 1  | Dupont  | Marie
 2  | Martin  | Jean
 3  | Bernard | Sophie
```

---

# 📊 Fonctionnalités démontrées

✔ Déploiement d’une base PostgreSQL dans un conteneur
✔ Automatisation avec PowerShell
✔ Exécution séquentielle de scripts SQL
✔ Gestion des rôles et permissions
✔ Validation des données avec des requêtes SQL

---

# 🧠 Technologies utilisées

* PostgreSQL 16
* Podman
* PowerShell
* SQL
* Git & GitHub

---

# 👩‍💻 Auteur

**Emeraude Santu**
Étudiante en informatique

Ce projet a été réalisé dans le cadre d’un **laboratoire d’automatisation de base de données**.
