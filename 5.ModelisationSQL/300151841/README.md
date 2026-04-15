<<<<<<< HEAD
 # 🛠️ TP Modélisation SQL

## Gestion de tournois e-sport

**Cours :** INF1099 – Bases de données
**SGBD :** PostgreSQL 16
**Environnement :** Docker / Podman
**Schéma :** `gestion des tournois esport`
**Auteur :** Massinissa Mameri

---

# 🎯 Aperçu du projet

Ce projet consiste à concevoir et implémenter une **base de données relationnelle** permettant de gérer des **tournois e-sport**.

La base de données permet de gérer :

* les jeux utilisés dans les compétitions
* les tournois organisés
* les matchs disputés
* les équipes participantes
* les joueurs
* les scores des matchs
* la composition des équipes

L’objectif du projet est d’appliquer les concepts de :

* modélisation de bases de données
* normalisation
* gestion des droits d’accès SQL

---

# 📁 Structure du projet

```
TP_SQL/
│
├── README.md
├── ddl.sql
├── dml.sql
├── dcl.sql
└── images/
    ├── 1_structure_projet.png
    ├── 2_creation_database.png
    ├── 3_creation_schema.png
    ├── 4_table_game.png
    ├── 5_verification_tables.png
    ├── 6_all_tables_created.png
    ├── 7_insert_data.png
    ├── 8_select_matches.png
    ├── 9_scores_matchs.png
    ├── 10_create_users.png
    ├── 11_grant_permissions.png
    ├── 12_test_player_user.png
    ├── 13_test_admin_user.png
    └── 14_revoke_select.png
```

⚠️ Les scripts SQL doivent être exécutés dans cet ordre :

```
ddl.sql → dml.sql → dcl.sql
```

---

# 🔄 Normalisation

## 1️⃣ Première Forme Normale (1FN)

Toutes les données sont organisées dans des tables avec :

* des attributs **atomiques**
* aucune répétition de colonnes
* une **clé primaire unique** par table

Exemples d’entités :

* Game
* Tournament
* Match
* Team
* Player

---

## 2️⃣ Deuxième Forme Normale (2FN)

Les dépendances partielles sont éliminées en séparant les entités.

Relations principales :

| Entité A   | Relation         | Entité B   |
| ---------- | ---------------- | ---------- |
| Game       | est utilisé dans | Tournament |
| Tournament | contient         | Match      |
| Match      | implique         | Team       |
| Team       | possède          | Player     |

---

## 3️⃣ Troisième Forme Normale (3FN)

La structure finale supprime les dépendances transitives.

Les relations entre les tables sont assurées par **des clés étrangères**.

Tables finales :

| Table       | Description                          |
| ----------- | ------------------------------------ |
| game        | Jeux e-sport                         |
| tournament  | Tournois                             |
| match       | Matchs                               |
| team        | Équipes                              |
| player      | Joueurs                              |
| match_team  | Participation des équipes aux matchs |
| team_member | Composition des équipes              |

---

# 📊 Diagramme ER

Le diagramme ER représente les entités et les relations de la base de données.

Il permet de visualiser :

* les tables
* les clés primaires
* les clés étrangères
* les relations entre les entités

Le diagramme est disponible dans :

```
images/diagramme_er.png
```

---

# 🚀 Démarrage rapide

### 1️⃣ Entrer dans le conteneur PostgreSQL

```
podman exec -it postgres bash
```

### 2️⃣ Se connecter à PostgreSQL

```
psql -U postgres
```

### 3️⃣ Créer la base de données

```
CREATE DATABASE esport_tournament;
\c esport_tournament
```

### 4️⃣ Exécuter les scripts SQL

```
=======
 <div align="center">

# 🎮 TP Modélisation SQL
### Gestion de tournois e-sport

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Podman-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-DDL%20%7C%20DML%20%7C%20DCL-00f5a0?style=for-the-badge&logo=databricks&logoColor=white)
![Cours](https://img.shields.io/badge/Cours-INF1099-a855f7?style=for-the-badge)

> Conception et implémentation d'une base de données relationnelle pour la gestion de tournois e-sport.

**Auteur :** Massinissa Mameri &nbsp;|&nbsp; **Schéma :** `esport` &nbsp;|&nbsp; **SGBD :** PostgreSQL 16

</div>

---

## 📋 Table des matières

- [🎯 Aperçu du projet](#-aperçu-du-projet)
- [🔄 Normalisation](#-normalisation)
- [🚀 Démarrage rapide](#-démarrage-rapide)
- [🏗️ DDL — Définition des structures](#️-ddl--définition-des-structures)
- [📝 DML — Manipulation des données](#-dml--manipulation-des-données)
- [🔎 Requêtes SELECT](#-requêtes-select)
- [🔐 DCL — Gestion des accès](#-dcl--gestion-des-accès)
- [🎯 Conclusion](#-conclusion)

---

## 🎯 Aperçu du projet

La base de données permet de gérer :

| Entité | Description |
|--------|-------------|
| 🎮 **Jeux** | Les jeux e-sport utilisés dans les compétitions |
| 🏆 **Tournois** | Les tournois organisés |
| ⚔️ **Matchs** | Les matchs disputés par round et date |
| 👥 **Équipes** | Les équipes participantes |
| 🕹️ **Joueurs** | Les joueurs avec pseudo et email |
| 📊 **Scores** | Les scores par équipe et par match |
| 🔗 **Compositions** | La composition des équipes (`team_member`) |

**Concepts appliqués :** modélisation · normalisation · gestion des droits d'accès SQL

---

## 🔄 Normalisation

### 1️⃣ Première Forme Normale (1FN)

- Attributs **atomiques** — aucune répétition de colonnes
- Une **clé primaire unique** par table
- Entités : `game`, `tournament`, `match`, `team`, `player`

### 2️⃣ Deuxième Forme Normale (2FN)

Dépendances partielles éliminées par séparation des entités :

| Entité A | Relation | Entité B |
|----------|----------|----------|
| `Game` | est utilisé dans | `Tournament` |
| `Tournament` | contient | `Match` |
| `Match` | implique | `Team` |
| `Team` | possède | `Player` |

### 3️⃣ Troisième Forme Normale (3FN)

Dépendances transitives supprimées — relations assurées par **clés étrangères**.

**Tables finales :**

| Table | Description | Clé primaire |
|-------|-------------|--------------|
| `game` | Jeux e-sport | `game_id` |
| `tournament` | Tournois | `tournament_id` |
| `match` | Matchs | `match_id` |
| `team` | Équipes | `team_id` |
| `player` | Joueurs | `player_id` |
| `match_team` | Participation des équipes aux matchs | `(match_id, team_id)` |
| `team_member` | Composition des équipes | `(team_id, player_id)` |

---

## 🚀 Démarrage rapide

> ⚠️ **Ordre d'exécution obligatoire :** `ddl.sql` → `dml.sql` → `dcl.sql`

### Étape 1 — Entrer dans le conteneur

```bash
podman exec -it postgres bash
```

### Étape 2 — Se connecter à PostgreSQL

```bash
psql -U postgres
```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/2_connexion_postgres.png.png)

### Étape 3 — Créer la base de données

```sql
CREATE DATABASE esport_tournament;
\c esport_tournament
```
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/2_creation_database.png.png)

### Étape 4 — Exécuter les scripts

```sql
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
\i ddl.sql
\i dml.sql
\i dcl.sql
```

---

<<<<<<< HEAD
# 🏗️ DDL — Définition des structures

Le fichier **ddl.sql** contient la structure de la base de données.

Il inclut :

* la création du schéma
* la création des tables
* les clés primaires
* les clés étrangères

Exemple :

```
CREATE SCHEMA esport;
```

Tables créées :

* game
* tournament
* match
* team
* player
* match_team
* team_member

---

# 📝 DML — Manipulation des données

Le fichier **dml.sql** contient les commandes permettant d'insérer les données.

Opérations réalisées :

* insertion des jeux
* insertion des tournois
* insertion des équipes
* insertion des joueurs
* insertion des matchs
* insertion des scores

Exemple :

```
INSERT INTO esport.game (game_name)
VALUES ('League of Legends');
```

---

# 🔎 Requêtes SELECT

### Afficher les matchs et leurs tournois

```
=======
## 🏗️ DDL — Définition des structures

### Création du schéma

```sql
CREATE SCHEMA esport;
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/3_creation_schema.png.png)

### Exemple — Table `game`

```sql
CREATE TABLE esport.game (
    game_id   SERIAL PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL
);
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/4_table_game.png.png)

### Vérification en cours de création

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/5_verification_tables.png.png)
### ✅ Toutes les tables créées (7 tables)

 ![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/6_all_tables_created.png.png)

---

## 📝 DML — Manipulation des données

### Exemple d'insertion

```sql
INSERT INTO esport.game (game_name)
VALUES ('League of Legends');

INSERT INTO esport.team (team_name)
VALUES ('Team Alpha'), ('Team Bravo'), ('Team Delta');

INSERT INTO esport.player (pseudo, email)
VALUES ('Shadow', 'shadow@email.com'),
       ('Blaze',  'blaze@email.com');
```

### Données insérées — jeux, équipes, joueurs

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/7_insert_data.png.png)


![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/8_insert_data.png.png)
---

## 🔎 Requêtes SELECT

### Afficher les matchs et leurs tournois

```sql
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
SELECT
    m.match_id,
    t.tournament_name,
    m.round,
    m.match_datetime
FROM esport.match m
<<<<<<< HEAD
JOIN esport.tournament t
ON m.tournament_id = t.tournament_id;
```

### Afficher les scores

```
=======
JOIN esport.tournament t ON m.tournament_id = t.tournament_id;
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/9_select_matches.png.png)

### Afficher les scores

```sql
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
SELECT
    m.match_id,
    t.team_name,
    mt.score
FROM esport.match_team mt
JOIN esport.match m ON mt.match_id = m.match_id
<<<<<<< HEAD
JOIN esport.team t ON mt.team_id = t.team_id;
```

---

# 🔐 DCL — Gestion des accès

Deux utilisateurs sont créés pour tester les permissions.

| Utilisateur | Rôle          |
| ----------- | ------------- |
| player_user | lecture seule |
| admin_user  | accès complet |

### Création des utilisateurs

```
CREATE USER player_user WITH PASSWORD 'player123';
CREATE USER admin_user WITH PASSWORD 'admin123';
```

### Attribution des permissions

```
GRANT CONNECT ON DATABASE esport_tournament TO player_user, admin_user;
GRANT USAGE ON SCHEMA esport TO player_user, admin_user;
```

### Permissions sur les tables

```
GRANT SELECT ON ALL TABLES IN SCHEMA esport TO player_user;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA esport
TO admin_user;
```

### Révocation d’un droit

```
REVOKE SELECT ON ALL TABLES IN SCHEMA esport FROM player_user;
```

---

# 📸 Captures d'écran

Le dossier **images/** contient les preuves d'exécution du TP :

* création de la base
* création du schéma
* création des tables
* insertion des données
* requêtes SELECT
* gestion des utilisateurs
* attribution et révocation des droits

Ces captures permettent de **valider chaque étape du projet**.

---

# 🎯 Conclusion

Ce projet a permis de mettre en pratique les concepts fondamentaux des bases de données relationnelles :

* modélisation de données
* normalisation
* création de structures SQL
* manipulation des données
* gestion des permissions

L'utilisation de **PostgreSQL dans un environnement Docker/Podman** permet également de reproduire facilement l'environnement de travail et d'assurer la **portabilité du projet**.
=======
JOIN esport.team  t ON mt.team_id  = t.team_id;
```
![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/10_scores_matchs.png.png)
---

## 🔐 DCL — Gestion des accès

### Utilisateurs créés

| Utilisateur | Rôle | SELECT | INSERT | UPDATE | DELETE |
|-------------|------|:------:|:------:|:------:|:------:|
| `player_user` | Lecture seule | ✅ | ❌ | ❌ | ❌ |
| `admin_user` | Accès complet | ✅ | ✅ | ✅ | ✅ |

### Création des utilisateurs

```sql
CREATE USER player_user WITH PASSWORD 'player123';
CREATE USER admin_user  WITH PASSWORD 'admin123';
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/11_create_users.png.png)

### Attribution des permissions

```sql
-- Connexion et accès au schéma
GRANT CONNECT ON DATABASE esport_tournament TO player_user, admin_user;
GRANT USAGE ON SCHEMA esport TO player_user, admin_user;

-- player_user : lecture seule
GRANT SELECT ON ALL TABLES IN SCHEMA esport TO player_user;

-- admin_user : accès complet
GRANT SELECT, INSERT, UPDATE, DELETE
    ON ALL TABLES IN SCHEMA esport TO admin_user;

-- Séquences pour admin_user
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA esport TO admin_user;
```
![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/12_grant_permissions.png.png)


### ✅ Test — `player_user` (lecture seule)

`SELECT` autorisé · `INSERT` refusé avec `permission denied`

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/13_test_player_user.png.png)

### ✅ Test — `admin_user` (accès complet)

`INSERT`, `UPDATE` et `SELECT` fonctionnent sans restriction

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/14_test_admin_user.png.png)

### ⛔ Révocation d'un droit

```sql
REVOKE SELECT ON ALL TABLES IN SCHEMA esport FROM player_user;
```

![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/15_revoke_select.png.png)

### 🔒 Test après révocation

`player_user` ne peut plus lire les tables — `ERROR: permission denied`


![](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/5.ModelisationSQL/300151841/images/16_test_revoke_player.png.png)
---

## 🎯 Conclusion

Ce projet a permis de mettre en pratique les concepts fondamentaux des bases de données relationnelles :

- ✅ **Modélisation de données** — diagramme ER, entités et relations
- ✅ **Normalisation** — 1FN, 2FN, 3FN appliquées
- ✅ **Création de structures SQL** — DDL complet avec clés primaires et étrangères
- ✅ **Manipulation des données** — insertions, requêtes JOIN
- ✅ **Gestion des permissions** — GRANT, REVOKE, utilisateurs différenciés
- ✅ **Environnement Docker/Podman** — portabilité et reproductibilité

---

<div align="center">

**INF1099 — Bases de données · PostgreSQL 16 · Massinissa Mameri**

</div>
>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
