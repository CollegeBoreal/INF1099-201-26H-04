# 🐘 Devoir — PostgreSQL avec Docker, Sakila & pgAdmin 4


# Jesmina DOS-REIS 300150303
## 📋 Objectifs

- Installer PostgreSQL dans Docker
- Charger la base de données Sakila dans PostgreSQL
- Installer pgAdmin 4 avec Chocolatey (Windows)
- Utiliser pgAdmin 4 pour se connecter et explorer la base de données

---

## 🖥️ Environnement

| Élément | Version |
|---|---|
| Système d'exploitation | Windows |
| PostgreSQL | 16 |
| pgAdmin 4 | v9.13.0 |

---

## 1️⃣ Installation de PostgreSQL avec Docker

### Commande exécutée

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

### Capture d'écran — Lancement du conteneur

![Lancement du conteneur PostgreSQL](./images/Screenshot%202026-03-25%20154635.png)

---

### Vérification du conteneur

```powershell
docker container ls
docker container logs postgres
```

### Capture d'écran — Conteneur en cours d'exécution

![Conteneur postgres en statut Up](./images/Screenshot%202026-03-25%20154754.png)

---

## 2️⃣ Chargement de la base Sakila

### Téléchargement des fichiers SQL

```powershell
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile postgres-sakila-insert-data.sql
```

### Capture d'écran — Fichiers téléchargés

![Téléchargement des fichiers Sakila](./images/Screenshot%202026-03-25%20155105.png)

---

### Copie des fichiers dans le conteneur

```powershell
docker container cp postgres-sakila-schema.sql postgres:/schema.sql
docker container cp postgres-sakila-insert-data.sql postgres:/data.sql
```

### Capture d'écran — Copie des fichiers

![Copie des fichiers SQL dans le conteneur](./images/Screenshot%202026-03-26%20152154.png)

---

### Exécution des scripts SQL

```powershell
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql
```

### Capture d'écran — Insertion des données

![Insertion des données Sakila](./images/Screenshot%202026-03-26%20153111.png)

---

### Vérification des tables

```sql
\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
```

### Capture d'écran — Liste des tables (`\dt`)

![Liste des tables Sakila](./images/Screenshot%202026-03-26%20153228.png)

### Capture d'écran — COUNT films (1000)

![SELECT COUNT(*) FROM film = 1000](./images/Screenshot%202026-03-26%20153348.png)

### Capture d'écran — COUNT acteurs (200)

![SELECT COUNT(*) FROM actor = 200](./images/Screenshot%202026-03-26%20153529.png)

---

## 3️⃣ Installation de pgAdmin 4 avec Chocolatey

### Commande exécutée (PowerShell Administrateur)

```powershell
choco install pgadmin4 -y
```

### Capture d'écran — Installation pgAdmin 4

![Installation pgAdmin4 via Chocolatey](./images/Screenshot%202026-03-26%20154309.png)

---

## 4️⃣ Connexion à PostgreSQL via pgAdmin 4

### Configuration du serveur

| Champ | Valeur |
|---|---|
| Name | Postgres Docker |
| Host | localhost |
| Port | 5432 |
| Username | postgres |
| Password | postgres |
| Maintenance DB | appdb |

### Capture d'écran — Serveur connecté dans pgAdmin

![Serveur postgres Docker connecté dans pgAdmin](./images/Screenshot%202026-03-26%20155655.png)

---

## 5️⃣ Exercices SQL dans pgAdmin

### Requêtes exécutées

```sql
-- Films contenant "Star"
SELECT title FROM film WHERE title ILIKE '%Star%';

-- Nombre d'acteurs
SELECT COUNT(*) FROM actor;
```

### Capture d'écran — Résultats dans le Query Tool

![Résultats des requêtes SQL dans pgAdmin](./images/Screenshot%202026-03-26%20160932.png)

---

## 🧹 Nettoyage (remise à zéro)

Pour supprimer complètement l'environnement :

```powershell
# Supprimer le conteneur
docker container rm -f postgres

# Supprimer le volume (⚠️ efface toutes les données)
docker volume rm postgres_data

# Vérifier
docker volume ls
```

---

## 📚 Références

- [jOOQ Sakila pour PostgreSQL](https://github.com/jOOQ/sakila/tree/master/postgres-sakila-db)
- [Documentation officielle PostgreSQL](https://www.postgresql.org/docs/)
- [pgAdmin 4](https://www.pgadmin.org/)
- [Chocolatey](https://chocolatey.org/)
