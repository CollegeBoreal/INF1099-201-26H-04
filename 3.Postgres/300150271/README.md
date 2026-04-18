<<<<<<< HEAD

=======
# 🛠️ TP PostgreSQL avec Docker – Base Sakila

**Nom : Mazigh Bareche**
**Code étudiant : 300150205**

---

## 🎯 Objectifs

* Installer PostgreSQL avec Docker
* Importer la base Sakila
* Utiliser pgAdmin
* Exécuter des requêtes SQL

---

## 🚀 Étapes

### 1. Lancer PostgreSQL

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

---

### 2. Télécharger Sakila

```powershell
Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
-OutFile schema.sql
```

```powershell
Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
-OutFile data.sql
```

---

### 3. Copier dans Docker

```powershell
docker cp schema.sql postgres:/schema.sql
docker cp data.sql postgres:/data.sql
```

---

### 4. Exécuter SQL

```powershell
docker exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker exec -it postgres psql -U postgres -d appdb -f /data.sql
```

---

### 5. Vérification

```sql
\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
```

---

## 📸 Captures

* docker ps
* téléchargement fichiers
* docker cp
* création tables
* insertion données
* \dt
* COUNT

---

## ✅ Conclusion

Ce TP m’a permis de comprendre comment utiliser Docker avec PostgreSQL, importer une base de données et exécuter des requêtes SQL.
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
