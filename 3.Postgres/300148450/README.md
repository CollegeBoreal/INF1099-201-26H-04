# TP PostgreSQL avec Docker – Base Sakila

**Adjaoud Hocine** · `300148450`

---

## Objectifs

À la fin de ce TP, l'étudiant sera capable de :

1. Installer PostgreSQL dans Docker
2. Charger la base de données Sakila dans PostgreSQL
3. Installer pgAdmin 4 avec Chocolatey
4. Utiliser pgAdmin 4 pour se connecter et explorer la base de données

---

## Prérequis

- Docker Desktop installé et en cours d'exécution
- PowerShell ouvert en mode Administrateur
- Connexion Internet

---

## 1. Installer PostgreSQL avec Docker

Lancer le conteneur PostgreSQL dans PowerShell :

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

Vérifier que le conteneur est actif :

```powershell
docker ps
```

---

## 2. Charger la base Sakila

### Télécharger les fichiers SQL

```powershell
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile postgres-sakila-insert-data.sql
```

### Copier les fichiers dans le conteneur

```powershell
docker cp postgres-sakila-schema.sql postgres:/schema.sql
docker cp postgres-sakila-insert-data.sql postgres:/data.sql
```

### Exécuter les fichiers SQL

```powershell
docker exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker exec -it postgres psql -U postgres -d appdb -f /data.sql
```

### Vérifier les tables

```powershell
docker exec -it postgres psql -U postgres -d appdb
```

```sql
\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
```

---

## 3. Installer pgAdmin 4

Dans PowerShell en mode Administrateur :

```powershell
choco install pgadmin4 -y
```

Lancer depuis le menu Démarrer ou via :

```powershell
pgadmin4
```

---

## 4. Connecter pgAdmin 4 à PostgreSQL

1. Cliquer sur **Add New Server**
2. Onglet **General** → Name : `Postgres Docker`
3. Onglet **Connection** :

| Champ | Valeur |
|-------|--------|
| Host | `localhost` |
| Port | `5432` |
| Username | `postgres` |
| Password | `postgres` |
| Database | `appdb` |

4. Cliquer sur **Save**

Navigation vers les tables : `Servers → Postgres Docker → Databases → appdb → Schemas → public → Tables`

---

## Commandes `psql` utiles

| Commande | Description |
|----------|-------------|
| `\dt` | Lister toutes les tables |
| `\d table` | Structure d'une table |
| `\l` | Lister les bases de données |
| `\c dbname` | Changer de base |
| `\conninfo` | Infos de connexion actuelle |
| `\x` | Mode affichage étendu |
| `\q` | Quitter psql |

---

## Nettoyage

Supprimer le conteneur et les données :

```powershell
docker container rm -f postgres
docker volume rm postgres_data
```

---

## Références

- [Documentation PostgreSQL 16](https://www.postgresql.org/docs/16/)
- [Image Docker postgres:16](https://hub.docker.com/_/postgres)
- [Base Sakila – jOOQ](https://github.com/jOOQ/sakila/tree/main/postgres-sakila-db)
- [Documentation pgAdmin 4](https://www.pgadmin.org/docs/)
