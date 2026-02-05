# PostgreSQL DB 🧻 

## Objectifs

À la fin de cette leçon, l’étudiant sera capable de :

1. Installer PostgreSQL dans Docker.
2. Charger la base de données Sakila dans PostgreSQL.
3. Installer pgAdmin 4 avec Chocolatey (Windows).
4. Utiliser pgAdmin 4 pour se connecter et explorer la base de données.

---

## 1️⃣ Installer PostgreSQL avec Docker

### Étape 1 : Créer et lancer le conteneur PostgreSQL

- [ ] 🐧 Unix

```bash
docker run -d \
  --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=appdb \
  -p 5432:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:16
```

- [ ] 🪟 Windows

```bash
docker run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
```



**Explications :**

* `POSTGRES_USER` : nom de l’utilisateur principal
* `POSTGRES_PASSWORD` : mot de passe de l’utilisateur
* `POSTGRES_DB` : base de données principale
* `-p 5432:5432` : mappe le port du conteneur sur le port local
* `-v postgres_data:/var/lib/postgresql/data` : persistance des données

### Étape 2 : Vérifier que PostgreSQL fonctionne

```bash
docker ps
docker logs postgres
```

---

## 2️⃣ Charger la base Sakila

### Étape 1 : Télécharger les fichiers PostgreSQL Sakila

- [ ] 🐧 Linux

```bash
wget https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql
wget https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql
```

- [ ] 🪟 Windows

```bash
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile postgres-sakila-insert-data.sql
```


### Étape 2 : Copier les fichiers dans le conteneur

```bash
docker cp postgres-sakila-schema.sql postgres:/schema.sql
docker cp postgres-sakila-insert-data.sql postgres:/data.sql
```

### Étape 3 : Exécuter les fichiers SQL dans PostgreSQL

```bash
docker exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker exec -it postgres psql -U postgres -d appdb -f /data.sql
```

### Étape 4 : Vérifier que les tables Sakila sont présentes

```bash
docker exec -it postgres psql -U postgres -d appdb
```

```sql
\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
```

---

## 3️⃣ Installer pgAdmin 4 avec Chocolatey (Windows)

### Étape 1 : Ouvrir PowerShell en mode Administrateur

### Étape 2 : Installer pgAdmin

```powershell
choco install pgadmin4 -y
```

### Étape 3 : Lancer pgAdmin

* Depuis le menu Démarrer → **pgAdmin 4**
* Ou depuis PowerShell :

```powershell
pgadmin4
```

---

## 4️⃣ Utiliser pgAdmin 4 pour se connecter à PostgreSQL

### Étape 1 : Ajouter un serveur

1. Cliquer sur **Add New Server**.
2. Onglet **General** :

   * Name : `Postgres Docker`
3. Onglet **Connection** :

   * Host name / address : `localhost`
   * Port : `5432`
   * Username : `postgres`
   * Password : `postgres`
   * Maintenance database : `appdb`

### Étape 2 : Explorer la base Sakila

* Tables → `actor`, `film`, `customer`, etc.
* Visualiser les données avec **View/Edit Data**
* Exécuter vos propres requêtes SQL avec l’éditeur intégré.

---

## 5️⃣ Exercices pratiques (facultatif)

1. Lister tous les films dont le titre contient “Star” :

```sql
SELECT title FROM film WHERE title ILIKE '%Star%';
```

2. Compter le nombre d’acteurs :

```sql
SELECT COUNT(*) FROM actor;
```

---

Parfait ! Voici un **guide pratique des commandes de base PostgreSQL (`psql`)**, très utile pour les étudiants et pour naviguer dans les bases comme Sakila.

---

# Commandes de base `psql`

> Ces commandes commencent par **`\`** et ne sont pas du SQL standard : elles servent à interagir avec PostgreSQL dans le client `psql`.

---

## 1️⃣ Informations sur les tables

| Commande        | Description                                              |
| --------------- | -------------------------------------------------------- |
| `\dt`           | Liste toutes les tables dans la base de données courante |
| `\dt schema.*`  | Liste toutes les tables d’un schéma spécifique           |
| `\d table_name` | Affiche la structure (colonnes, types, clés) d’une table |

**Exemple :**

```sql
\dt
\d film
```

---

## 2️⃣ Informations sur les fonctions et procédures

| Commande            | Description                                                   |
| ------------------- | ------------------------------------------------------------- |
| `\df`               | Liste toutes les fonctions                                    |
| `\df+`              | Liste les fonctions avec détails (retour, propriétaire, etc.) |
| `\df function_name` | Détails d’une fonction spécifique                             |
| `\dp`               | Liste les privilèges (droits) sur tables, vues et séquences   |
| `\du`               | Liste les rôles/utilisateurs PostgreSQL                       |

**Exemple :**

```sql
\df
\df add_numbers_fn
\dp
\du
```

---

## 3️⃣ Connexion et bases

| Commande    | Description                        |
| ----------- | ---------------------------------- |
| `\c dbname` | Se connecter à une base de données |
| `\l`        | Liste toutes les bases de données  |
| `\conninfo` | Affiche la connexion actuelle      |

**Exemple :**

```sql
\c appdb
\conninfo
\l
```

---

## 4️⃣ Informations sur les schémas et séquences

| Commande          | Description                                     |
| ----------------- | ----------------------------------------------- |
| `\dn`             | Liste tous les schémas                          |
| `\d schema.table` | Affiche la structure d’une table dans un schéma |
| `\ds`             | Liste les séquences                             |
| `\dv`             | Liste les vues                                  |

---

## 5️⃣ Commandes pratiques supplémentaires

| Commande     | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| `\x`         | Active/désactive le mode étendu (affichage vertical des résultats) |
| `\q`         | Quitter `psql`                                                     |
| `\! command` | Exécute une commande shell depuis `psql`                           |

**Exemple :**

```sql
\x
SELECT * FROM film WHERE title ILIKE '%star%';
\q
```

---

💡 **Astuce pour étudiants :**

* Les commandes `\dt`, `\df`, `\dp`, `\du` sont vos **outils principaux pour explorer la base** sans connaître toutes les tables ou fonctions par cœur.
* `\d table_name` + `\df function_name` permet de comprendre rapidement la structure avant d’écrire des requêtes.

---

# :books: References


