

---

## Types de scripts SQL

- **DDL** : création de la table (CREATE TABLE)
- **DML** : insertion des données (INSERT)
- **DCL** : gestion des droits (GRANT)
- **DQL** : requête (SELECT)

---

## Étapes


# TP PostgreSQL avec Docker et PowerShell

## Description

Ce laboratoire montre comment automatiser le chargement d’une base de données PostgreSQL en utilisant Docker et un script PowerShell.

Le projet utilise plusieurs scripts SQL exécutés automatiquement dans un conteneur PostgreSQL.

---

## Objectifs

- Comprendre les types de scripts SQL (DDL, DML, DCL, DQL)
- Utiliser Docker pour lancer PostgreSQL
- Automatiser l’exécution des scripts avec PowerShell
- Charger une base de données en une seule commande

---

## Structure du projet


labo-postgres/
├── DDL.sql
├── DML.sql
├── DCL.sql
├── DQL.sql
└── load-db.ps1


---

## Types de scripts SQL

- **DDL** : création de la table (CREATE TABLE)
- **DML** : insertion des données (INSERT)
- **DCL** : gestion des droits (GRANT)
- **DQL** : requête (SELECT)

---

## Étapes

### 1. Démarrer Docker

Ouvrir Docker Desktop et attendre qu’il soit en cours d’exécution.

---

### 2. Lancer PostgreSQL

```powershell
docker container run -d --name postgres-lab -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres
3. Exécuter le script
.\load-db.ps1
4. Vérifier les données
docker exec -it postgres-lab psql -U postgres -d ecole

Puis :

SELECT * FROM etudiants;
Résultat attendu
 id | nom     | prenom | age | programme
----+---------+--------+-----+-------------------
 1  | Dupont  | Alice  | 20  | Informatique
 2  | Martin  | Bob    | 22  | Réseau
 3  | Bernard | Claire | 19  | Cybersécurité
 4  | Petit   | David  | 21  | Base de données
 5  | Robert  | Emma   | 23  | Programmation
Remarque

Si le script est exécuté plusieurs fois, des doublons peuvent apparaître.

Solution :

Ajouter DELETE FROM etudiants; dans DML.sql
ou DROP TABLE IF EXISTS etudiants; dans DDL.sql
Conclusion

Ce TP permet de comprendre comment automatiser le chargement d’une base de données avec Docker et PowerShell de manière simple et efficace.



Dans PowerShell :

```powershell

