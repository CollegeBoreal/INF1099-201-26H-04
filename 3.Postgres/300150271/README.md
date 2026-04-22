# 🐘 TP PostgreSQL avec Docker — Base Sakila

**Nom : Mazigh Bareche**
**Code étudiant : 300150271**
**Cours : INF1099 — Bases de données**
**Session : Hiver 2026**

---

## 🎯 Objectifs

1. Installer PostgreSQL dans Docker
2. Charger la base de données Sakila dans PostgreSQL
3. Installer pgAdmin 4
4. Utiliser pgAdmin 4 pour se connecter et explorer la base de données

---

## 🖥️ Environnement utilisé

- Windows 10/11
- PowerShell (mode administrateur)
- Docker
- PostgreSQL 16 (conteneur)
- pgAdmin 4

---

## 🚀 Étapes du laboratoire

### Étape 1 : Créer et lancer le conteneur PostgreSQL

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

### Étape 2 : Vérifier que PostgreSQL fonctionne

```powershell
docker ps
```

<details>
<summary>🖼️ Capture d'écran</summary>

![docker ps](images/mysql%201.png)

</details>

---

### Étape 3 : Télécharger les fichiers Sakila

```powershell
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile data.sql
```

---

### Étape 4 : Copier les fichiers dans le conteneur

```powershell
docker cp schema.sql postgres:/schema.sql
docker cp data.sql postgres:/data.sql
```

---

### Étape 5 : Exécuter les fichiers SQL dans PostgreSQL

```powershell
docker exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker exec -it postgres psql -U postgres -d appdb -f /data.sql
```

---

### Étape 6 : Vérifier que les tables Sakila sont présentes

```powershell
docker exec -it postgres psql -U postgres -d appdb
```

```sql
\dt
```

<details>
<summary>🖼️ Capture d'écran</summary>

![Tables Sakila](images/mysql%203.png)

</details>

```sql
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
```

<details>
<summary>🖼️ Capture d'écran</summary>

![COUNT film et actor](images/mysql%204.png)

</details>

---

### Étape 7 : Installer pgAdmin 4

```powershell
choco install pgadmin4 -y
```

---

### Étape 8 : Configurer la connexion dans pgAdmin 4

1. Cliquer sur **Add New Server**
2. **Onglet General :** Name → `Postgres Docker`
3. **Onglet Connection :**
   - Host : `localhost`
   - Port : `5432`
   - Username : `postgres`
   - Password : `postgres`
   - Database : `appdb`
4. Cliquer sur **Save**

<details>
<summary>🖼️ Capture d'écran</summary>

![pgAdmin](images/mysql%205.png)

</details>

---

## 📂 Structure du projet
