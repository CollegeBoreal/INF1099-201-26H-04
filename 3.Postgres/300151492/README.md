# TP PostgreSQL avec Docker - Base Sakila

**HAMMICHE MOHAND L'HACENE — 300151492**

---

## 🎯 Objectifs

- Installer PostgreSQL dans Docker
- Charger la base de données Sakila
- Installer pgAdmin 4
- Explorer la base de données

---

## 1️⃣ Lancer PostgreSQL avec Docker

```powershell
docker container run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
```

Vérifier que le conteneur tourne :

```powershell
docker container ls
```

> ✅ Le conteneur `postgres` apparaît avec le statut `Up`

---

## 2️⃣ Charger la base Sakila

**Télécharger les fichiers :**

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql -OutFile postgres-sakila-schema.sql

Invoke-WebRequest https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql -OutFile postgres-sakila-insert-data.sql
```

**Copier dans le conteneur :**

```powershell
docker container cp postgres-sakila-schema.sql postgres:/schema.sql
docker container cp postgres-sakila-insert-data.sql postgres:/data.sql
```

**Exécuter les fichiers SQL :**

```powershell
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql
```

**Vérification :**

```powershell
docker container exec -it postgres psql -U postgres -d appdb -c "SELECT COUNT(*) FROM film;"
docker container exec -it postgres psql -U postgres -d appdb -c "SELECT COUNT(*) FROM actor;"
```

| Table   | Résultat |
|---------|----------|
| `film`  | 1000 lignes ✅ |
| `actor` | 200 lignes ✅ |

---

## 3️⃣ Installer pgAdmin 4

```powershell
choco install pgadmin4 -y
```

---

## 4️⃣ Connexion pgAdmin 4

| Paramètre | Valeur |
|-----------|--------|
| Host | `localhost` |
| Port | `5432` |
| Database | `appdb` |
| Username | `postgres` |
| Password | `postgres` |

---

## 5️⃣ Exercices pratiques

**Films contenant "Star" :**

```sql
SELECT title FROM film WHERE title ILIKE '%Star%';
```

```
     title
----------------
 STAR OPERATION
 TURN STAR
(2 rows)
```

**Nombre d'acteurs :**

```sql
SELECT COUNT(*) FROM actor;
```

```
 count
-------
   200
(1 row)
```

**5 premiers clients :**

```sql
SELECT customer_id, first_name, last_name, email 
FROM customer 
LIMIT 5;
```

---

## 🗑️ Nettoyage

```powershell
docker container rm -f postgres
docker volume rm postgres_data
```
