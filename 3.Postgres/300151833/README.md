# 🐘 TP – PostgreSQL avec Docker & pgAdmin
### Base de données Sakila | INF1099
> Cours : Manipulation de données avec MySQL et administration

---

## 🎯 Objectifs

À la fin de ce TP, l'étudiant est capable de :

- ✅ Lancer un serveur PostgreSQL dans un conteneur Docker
- ✅ Importer la base de données **Sakila** (version PostgreSQL)
- ✅ Se connecter via **pgAdmin 4** et explorer la base
- ✅ Exécuter des requêtes SQL de base (`SELECT`, `COUNT`, `ILIKE`, `LIMIT`)

---

## 🛠️ Environnement utilisé

| Composant | Version / Détail |
|-----------|-----------------|
| Système d'exploitation | Windows 11 64 bits |
| Moteur de conteneur | Docker (via Podman 5.7.1) |
| Base de données | PostgreSQL 16 |
| Interface graphique | pgAdmin 4 v9.11.0 |
| Base importée | Sakila (version PostgreSQL – GitHub jOOQ) |

---

## 📁 Structure du projet

```
projet/
├── images/                           # 📸 Dossier des captures d'écran
├── postgres-sakila-schema.sql        # Schéma de la base Sakila
├── postgres-sakila-insert-data.sql   # Données de la base Sakila
└── README.md
```

---

## ✅ Étape 1 — Lancer le conteneur PostgreSQL

```powershell
docker run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
```

**Vérification :**

```powershell
docker ps
```

```
CONTAINER ID  IMAGE        STATUS          PORTS                    NAMES
bec49bcd855e  postgres:16  Up 25 minutes   0.0.0.0:5432->5432/tcp   postgres
```

📸 **Capture — Conteneur PostgreSQL lancé (`docker ps`) :**

![Capture étape 1 - docker ps](images/etape1-docker-ps.png)

---

## ✅ Étape 2 — Importer la base Sakila

### Téléchargement des fichiers (PowerShell)

```powershell
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile postgres-sakila-insert-data.sql
```

### Copie dans le conteneur

```powershell
docker cp postgres-sakila-schema.sql postgres:/schema.sql
docker cp postgres-sakila-insert-data.sql postgres:/data.sql
```

📸 **Capture — Copie des fichiers dans le conteneur :**

![Capture étape 2a - docker cp](images/etape2a-docker-cp.png)

### Exécution des scripts SQL

```powershell
docker exec -i postgres psql -U postgres -d appdb -f /schema.sql
docker exec -i postgres psql -U postgres -d appdb -f /data.sql
```

> ✔️ Les scripts s'exécutent avec succès (`INSERT 0 1` répétés, `ALTER TABLE`).

📸 **Capture — Exécution des scripts SQL (INSERT / ALTER TABLE) :**

![Capture étape 2b - importation SQL](images/etape2b-import-sql.png)

---

## ✅ Étape 3 — Vérification des tables

```powershell
docker exec -it postgres psql -U postgres -d appdb
```

```sql
appdb=# \dt
```

```
           List of relations
 Schema |       Name        | Type  |  Owner
--------+-------------------+-------+----------
 public | actor             | table | postgres
 public | address           | table | postgres
 public | category          | table | postgres
 public | city              | table | postgres
 public | country           | table | postgres
 public | customer          | table | postgres
 public | film              | table | postgres
 public | film_actor        | table | postgres
 public | film_category     | table | postgres
 public | inventory         | table | postgres
 public | language          | table | postgres
 public | payment           | table | postgres
 public | payment_p2007_01  | table | postgres
 public | payment_p2007_02  | table | postgres
 public | payment_p2007_03  | table | postgres
 public | payment_p2007_04  | table | postgres
 public | payment_p2007_05  | table | postgres
 public | payment_p2007_06  | table | postgres
 public | rental            | table | postgres
 public | staff             | table | postgres
 public | store             | table | postgres
(21 rows)
```

📸 **Capture — Liste des 21 tables (`\dt`) :**

![Capture étape 3 - liste des tables](images/etape3-liste-tables.png)

---

## ✅ Étape 4 — Installation de pgAdmin 4

```powershell
choco install pgadmin4
```

> pgAdmin 4 v9.11.0 installé avec succès.

📸 **Capture — Installation pgAdmin 4 via Chocolatey :**

![Capture étape 4a - installation pgadmin](images/etape4a-install-pgadmin.png)

### Paramètres de connexion

| Paramètre | Valeur |
|-----------|--------|
| Name | Postgres Docker |
| Host | localhost |
| Port | 5432 |
| Username | postgres |
| Password | postgres |

📸 **Capture — Dashboard pgAdmin 4 connecté au serveur :**

![Capture étape 4b - pgadmin dashboard](images/etape4b-pgadmin-dashboard.png)

---

## ✅ Étape 5 — Exercices SQL

### Requête 1 — Compter les films

```sql
SELECT COUNT(*) FROM film;
```

| count |
|-------|
| 1000  |

📸 **Capture — Résultat COUNT films :**

![Capture requête 1 - count film](images/etape5-count-film.png)

---

### Requête 2 — Compter les acteurs

```sql
SELECT COUNT(*) FROM actor;
```

| count |
|-------|
| 200   |

📸 **Capture — Résultat COUNT acteurs :**

![Capture requête 2 - count actor](images/etape5-count-actor.png)

---

### Requête 3 — Films contenant "Star"

```sql
SELECT title FROM film WHERE title ILIKE '%Star%';
```

| title |
|-------|
| STAR OPERATION |
| TURN STAR |

📸 **Capture — Résultat recherche ILIKE '%Star%' :**

![Capture requête 3 - ilike star](images/etape5-ilike-star.png)

---

### Requête 4 — 5 premiers clients

```sql
SELECT customer_id, first_name, last_name, email
FROM customer
LIMIT 5;
```

| customer_id | first_name | last_name | email |
|-------------|------------|-----------|-------|
| 1 | MARY | SMITH | MARY.SMITH@sakilacustomer.org |
| 2 | PATRICIA | JOHNSON | PATRICIA.JOHNSON@sakilacustomer.org |
| 3 | LINDA | WILLIAMS | LINDA.WILLIAMS@sakilacustomer.org |
| 4 | BARBARA | JONES | BARBARA.JONES@sakilacustomer.org |
| 5 | ELIZABETH | BROWN | ELIZABETH.BROWN@sakilacustomer.org |

📸 **Capture — Résultat SELECT customers LIMIT 5 :**

![Capture requête 4 - customers limit 5](images/etape5-customers-limit5.png)

---

## 🔧 Commandes utiles

| Commande | Description |
|----------|-------------|
| `docker ps -a` | Lister tous les conteneurs |
| `docker stop postgres` | Arrêter le conteneur |
| `docker start postgres` | Démarrer le conteneur |
| `docker logs postgres` | Voir les logs du serveur |
| `docker exec -it postgres psql -U postgres -d appdb` | Se connecter à PostgreSQL |

---

## 📝 Conclusion

Ce TP m'a permis de :

- 🐳 Installer **PostgreSQL 16** dans un conteneur Docker
- 📦 Importer la base **Sakila** (1000 films, 200 acteurs, 21 tables)
- 🖥️ Connecter **pgAdmin 4** pour explorer la base visuellement
- 🔍 Exécuter des requêtes SQL : `COUNT`, `ILIKE`, `LIMIT`, `SELECT`

> J'ai appris à utiliser les commandes `psql` ainsi que l'interface graphique pgAdmin 4 pour gérer une base de données PostgreSQL dans un environnement Docker conteneurisé.

---

## 📚 Références

- [PostgreSQL 16 – Docker Hub](https://hub.docker.com/_/postgres)
- [Sakila PostgreSQL – GitHub jOOQ](https://github.com/jOOQ/sakila)
- [pgAdmin 4](https://www.pgadmin.org/)
- [Chocolatey](https://chocolatey.org/) – `choco install pgadmin4`
