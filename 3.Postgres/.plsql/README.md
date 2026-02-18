# 📝 PostgreSQL / psql Cheat Sheet

## 1️⃣ Connexion et info

| Commande             | Description                                   |
| -------------------- | --------------------------------------------- |
| `psql -U user`       | Se connecter à PostgreSQL avec un utilisateur |
| `psql -U user -d db` | Se connecter directement à une base           |
| `\conninfo`          | Affiche la base et l’utilisateur connectés    |
| `\c dbname`          | Se connecter à une autre base                 |
| `\q`                 | Quitter psql                                  |

---

## 2️⃣ Bases de données

| Commande                  | Description             |
| ------------------------- | ----------------------- |
| `\l` ou `\list`           | Lister toutes les bases |
| `CREATE DATABASE dbname;` | Créer une base          |
| `DROP DATABASE dbname;`   | Supprimer une base      |

---

## 3️⃣ Schémas

| Commande                     | Description             |
| ---------------------------- | ----------------------- |
| `\dn`                        | Lister tous les schémas |
| `CREATE SCHEMA schema_name;` | Créer un schéma         |
| `DROP SCHEMA schema_name;`   | Supprimer un schéma     |

---

## 4️⃣ Tables

| Commande       | Description                                |
| -------------- | ------------------------------------------ |
| `\dt`          | Lister toutes les tables du schéma courant |
| `\dt schema.*` | Lister les tables d’un schéma spécifique   |
| `\d table`     | Décrire la structure d’une table           |
| `\d+ table`    | Décrire avec détails (taille, ACL)         |
| `\di schema.*` | Lister les index                           |
| `\dv schema.*` | Lister les vues                            |

---

## 5️⃣ Séquences

| Commande                           | Description                 |
| ---------------------------------- | --------------------------- |
| `\d sequence_name`                 | Décrire une sequence        |
| `SELECT nextval('sequence_name');` | Obtenir la prochaine valeur |

---

## 6️⃣ Données (DML / DQL)

| Commande                                    | Description           |
| ------------------------------------------- | --------------------- |
| `SELECT * FROM table;`                      | Lire les données      |
| `INSERT INTO table(col1,col2) VALUES(...);` | Ajouter des données   |
| `UPDATE table SET col=val WHERE ...;`       | Modifier des données  |
| `DELETE FROM table WHERE ...;`              | Supprimer des données |

---

## 7️⃣ Utilisateurs / Rôles (DCL)

| Commande                                 | Description                          |
| ---------------------------------------- | ------------------------------------ |
| `\du`                                    | Lister tous les rôles / utilisateurs |
| `CREATE USER name WITH PASSWORD 'pwd';`  | Créer un utilisateur                 |
| `DROP USER name;`                        | Supprimer un utilisateur             |
| `GRANT SELECT, INSERT ON table TO user;` | Donner des droits                    |
| `REVOKE SELECT ON table FROM user;`      | Retirer des droits                   |

---

## 8️⃣ Transactions (TCL)

| Commande    | Description              |
| ----------- | ------------------------ |
| `BEGIN;`    | Démarrer une transaction |
| `COMMIT;`   | Valider la transaction   |
| `ROLLBACK;` | Annuler la transaction   |

---

## 9️⃣ Aide et commandes psql

| Commande | Description                     |
| -------- | ------------------------------- |
| `\?`     | Liste toutes les commandes psql |
| `\h`     | Aide sur les commandes SQL      |
| `\q`     | Quitter psql                    |

---

💡 **Astuce** :

* Les commandes qui commencent par `\` sont des **métacommandes psql**, pas du SQL standard.
* Les permissions et séquences sont importantes : pour insérer dans une table avec `SERIAL`, il faut donner accès à la **sequence** (`GRANT USAGE, SELECT, UPDATE ON SEQUENCE seq_name TO user;`).

---

# 🔹 **métacommande**

Dans **psql**, `\d` est une **métacommande** qui permet de **décrire un objet** (table, vue, sequence…) dans PostgreSQL.

### 1️⃣ Décrire une table

```sql
\d nom_table
```

* Affiche :

  * Les colonnes et leurs types (`id SERIAL`, `nom TEXT`, etc.)
  * Les clés primaires et étrangères
  * Les index associés

Exemple :

```sql
\d tp_dcl.etudiants
```

Sortie typique :

```
            Table "tp_dcl.etudiants"
 Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
 id     | integer |           | not null | nextval('etudiants_id_seq'::regclass)
 nom    | text    |           |          |
 moyenne| numeric |           |          |
Indexes:
    "etudiants_pkey" PRIMARY KEY, btree (id)
```

---

### 2️⃣ Décrire avec plus de détails

```sql
\d+ nom_table
```

* Montre en plus :

  * La **taille de la table**
  * Les **ACL** (droits sur la table)
  * Les **séquences** utilisées

---

### 3️⃣ Décrire d’autres objets

* Séquences :

```sql
\d nom_sequence
```

* Vues :

```sql
\d nom_vue
```

* Tout objet d’un schéma :

```sql
\d tp_dcl.*
```

---

# 🔹 Résumé

| Commande      | Signification                                    |
| ------------- | ------------------------------------------------ |
| `\d table`    | Décrire la structure de la table                 |
| `\d+ table`   | Décrire avec plus de détails (ACL, taille, etc.) |
| `\d schema.*` | Lister tous les objets d’un schéma               |

💡 **Astuce pour étudiants :**

* `\d` = “**describe**”
* C’est une **métacommande psql**, **pas du SQL standard**.
* Très utile pour explorer rapidement la structure d’une base avant de faire des `SELECT` ou des `INSERT`.

