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

