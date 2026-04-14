# TP PostgreSQL avec Docker - Base Sakila
# DjaberBenyezza

# 300146667

---

Ce TP nous guide à travers l'installation et la configuration de PostgreSQL avec Docker, ainsi que l'utilisation de pgAdmin 4.

## 🎯 **Objectifs**
1. Installer PostgreSQL dans Docker
2. Charger la base de données Sakila dans PostgreSQL
3. Installer pgAdmin 4 avec Chocolatey (Windows)
4. Utiliser pgAdmin 4 pour se connecter et explorer la base de données

---

# 🚀 Étapes du laboratoire

## Étape 1 : Créer et lancer le conteneur PostgreSQL

### 🪟 Windows (PowerShell)
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

**Explications des paramètres :**
- `POSTGRES_USER` : nom de l'utilisateur principal
- `POSTGRES_PASSWORD` : mot de passe de l'utilisateur
- `POSTGRES_DB` : base de données principale
- `-p 5432:5432` : mappe le port du conteneur sur le port local
- `-v postgres_data:/var/lib/postgresql/data` : persistance des données

---

## Étape 2 : Vérifier que PostgreSQL fonctionne

```powershell
docker container ls
```

Résultat obtenu :
```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                         NAMES
79c0dcae0842   postgres:16   "docker-entrypoint.s…"   23 seconds ago   Up 19 seconds   0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp   postgres
```

✅ Le conteneur est actif avec le port 5432 exposé.

---

## Étape 3 : Télécharger les fichiers Sakila

### 🪟 Windows (PowerShell)
```powershell
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile postgres-sakila-insert-data.sql
```

---

## Étape 4 : Copier les fichiers dans le conteneur

```powershell
docker container cp postgres-sakila-schema.sql postgres:/schema.sql
docker container cp postgres-sakila-insert-data.sql postgres:/data.sql
```

Résultat :
```
Successfully copied 52.7kB to postgres:/schema.sql
Successfully copied 7.97MB to postgres:/data.sql
```

---

## Étape 5 : Exécuter les fichiers SQL dans PostgreSQL

```powershell
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql
```

---

## Étape 6 : Vérifier que les tables Sakila sont présentes

```powershell
docker container exec -it postgres psql -U postgres -d appdb
```

**Commandes SQL de vérification :**
```sql
\dt
```

Résultat :
```
              List of relations
 Schema |       Name       | Type  |  Owner
--------+------------------+-------+----------
 public | actor            | table | postgres
 public | address          | table | postgres
 public | category         | table | postgres
 public | city             | table | postgres
 public | country          | table | postgres
 public | customer         | table | postgres
 public | film             | table | postgres
 public | film_actor       | table | postgres
 public | film_category    | table | postgres
 public | inventory        | table | postgres
 public | language         | table | postgres
 public | payment          | table | postgres
 public | payment_p2007_01 | table | postgres
 public | payment_p2007_02 | table | postgres
 public | payment_p2007_03 | table | postgres
 public | payment_p2007_04 | table | postgres
 public | payment_p2007_05 | table | postgres
 public | payment_p2007_06 | table | postgres
 public | rental           | table | postgres
 public | staff            | table | postgres
 public | store            | table | postgres
(21 rows)
```

```sql
SELECT COUNT(*) FROM film;
```

Résultat :
```
 count
-------
  1000
(1 row)
```

```sql
SELECT COUNT(*) FROM actor;
```

Résultat :
```
 count
-------
   200
(1 row)
```

---

## Étape 7 : Installer pgAdmin 4 avec Chocolatey (Windows)

### Ouvrir PowerShell en mode Administrateur

```powershell
choco install pgadmin4 -y
```

Résultat :
```
Chocolatey v2.6.0
pgadmin4 v9.14.0 [Approved]
The install of pgadmin4 was successful.
Deployed to 'C:\Program Files\pgAdmin 4\'
Chocolatey installed 1/1 packages.
```

---

## Étape 8 : Configurer la connexion dans pgAdmin 4

### Ajouter un nouveau serveur

1. Cliquer sur **Add New Server**
2. **Onglet General :** Name : `Postgres Docker`
3. **Onglet Connection :**
   - Host name / address : `localhost`
   - Port : `5432`
   - Username : `postgres`
   - Password : `postgres`
   - Maintenance database : `appdb`
4. Cliquer sur **Save**

✅ Serveur **Postgres Docker** connecté avec succès dans pgAdmin 4.

---

## Étape 9 : Explorer la base Sakila dans pgAdmin

1. Naviguer vers : **Servers → Postgres Docker → Databases → appdb → Schemas → public → Tables**
2. Clic droit sur une table (ex: `film`) → **View/Edit Data → All Rows**
3. Utiliser l'éditeur SQL intégré : **Tools → Query Tool**

✅ Les 21 tables Sakila sont visibles dans pgAdmin.

---

## Étape 10 : Exercices pratiques

### 📝 Exercice 1 : Lister tous les films dont le titre contient "Star"

```sql
SELECT title FROM film WHERE title ILIKE '%Star%';
```

Résultat :
```
 title
------------------
 STAR OPERATION
 TURN STAR
(2 rows)
```

---

### 📝 Exercice 2 : Compter le nombre d'acteurs

```sql
SELECT COUNT(*) FROM actor;
```

Résultat :
```
 count
-------
   200
(1 row)
```

---

### 📝 Exercice 3 : Afficher les 5 premiers clients

```sql
SELECT customer_id, first_name, last_name, email 
FROM customer 
LIMIT 5;
```

Résultat :
```
 customer_id | first_name | last_name |              email
-------------+------------+-----------+----------------------------------
           1 | MARY       | SMITH     | MARY.SMITH@sakilacustomer.org
           2 | PATRICIA   | JOHNSON   | PATRICIA.JOHNSON@sakilacustomer.org
           3 | LINDA      | WILLIAMS  | LINDA.WILLIAMS@sakilacustomer.org
           4 | BARBARA    | JONES     | BARBARA.JONES@sakilacustomer.org
           5 | ELIZABETH  | BROWN     | ELIZABETH.BROWN@sakilacustomer.org
(5 rows)
```

---