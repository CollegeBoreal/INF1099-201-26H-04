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
<img width="1078" height="141" alt="Capture d’écran 2026-04-20 165528" src="https://github.com/user-attachments/assets/848c8f7e-d65e-4a0c-a252-09d7bb26cf77" />


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

<img width="757" height="241" alt="2" src="https://github.com/user-attachments/assets/1ef197be-9867-40de-9c5d-5c7091c7b2e0" />


### Exécution des scripts SQL

```powershell
docker exec -i postgres psql -U postgres -d appdb -f /schema.sql
docker exec -i postgres psql -U postgres -d appdb -f /data.sql
```

> ✔️ Les scripts s'exécutent avec succès (`INSERT 0 1` répétés, `ALTER TABLE`).

📸 **Capture — Exécution des scripts SQL (INSERT / ALTER TABLE) :**


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
<img width="477" height="577" alt="3" src="https://github.com/user-attachments/assets/9b72811b-5d8b-4304-a9ba-3564c65fa9c3" />

---

## ✅ Étape 4 — Installation de pgAdmin 4

```powershell
choco install pgadmin4
```

> pgAdmin 4 v9.11.0 installé avec succès.

📸 **Capture — Installation pgAdmin 4 via Chocolatey :**
<img width="668" height="635" alt="4" src="https://github.com/user-attachments/assets/3cb0b89c-9d63-4b8c-896d-018851f54629" />



### Paramètres de connexion

| Paramètre | Valeur |
|-----------|--------|
| Name | Postgres Docker |
| Host | localhost |
| Port | 5432 |
| Username | postgres |
| Password | postgres |

📸 **Capture — Dashboard pgAdmin 4 connecté au serveur :**
<img width="1920" height="1012" alt="5" src="https://github.com/user-attachments/assets/264e106c-f423-4b8d-8443-97d064cab180" />

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

<img width="1406" height="826" alt="07" src="https://github.com/user-attachments/assets/3dd99796-f8ab-4df2-8f64-432ec21bc514" />


---

### Requête 2 — Compter les acteurs

```sql
SELECT COUNT(*) FROM actor;
```

| count |
|-------|
| 200   |

📸 **Capture — Résultat COUNT acteurs :**
<img width="1261" height="945" alt="6" src="https://github.com/user-attachments/assets/2b045b8a-f9af-42e4-9a13-7cd850aec7b3" />


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


<img width="743" height="606" alt="image" src="https://github.com/user-attachments/assets/ce0166db-f52c-418d-a2f6-9e174e86de5b" />

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

<img width="872" height="754" alt="09" src="https://github.com/user-attachments/assets/ae357ff2-bbe4-4596-9c9d-574d01471467" />


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
