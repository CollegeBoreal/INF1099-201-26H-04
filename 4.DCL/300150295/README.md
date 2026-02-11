# 📚 TP – DCL (Data Control Language) – PostgreSQL avec Docker

**Nom :** Lounas Allouti  
**Cours :** INF1099  
**Session :** Hiver 2026  
**Base de données :** PostgreSQL (Docker)

---

## 🎯 Objectif du TP

Ce TP consiste à maîtriser les commandes DCL (Data Control Language) dans PostgreSQL :
- Créer des rôles (utilisateurs)
- Accorder des privilèges (`GRANT`)
- Retirer des privilèges (`REVOKE`)
- Tester les permissions
- Supprimer les rôles (`DROP USER`)
- Vérifier la gestion des droits dans PostgreSQL

---

## 📋 Table des matières

1. [Prérequis](#-prérequis)
2. [Installation et configuration](#-installation-et-configuration)
3. [Étapes du TP](#-étapes-du-tp)
4. [Résultats et captures](#-résultats-et-captures)
5. [Conclusion](#-conclusion)

---

## 🔧 Prérequis

- Docker installé sur votre machine
- Connaissances de base en SQL
- Accès à un terminal

---

## 🚀 Installation et configuration

### 🐳 1️⃣ Lancement de PostgreSQL avec Docker

Démarrer un conteneur PostgreSQL :

```bash
docker run --name postgres_tp -e POSTGRES_PASSWORD=admin -p 5432:5432 -d postgres
```

Vérifier que le conteneur est actif :

```bash
docker ps
```

![Conteneur Docker actif](./screenshots/01-docker-ps.png)

---

## 📝 Étapes du TP

### 🗄️ 2️⃣ Connexion à PostgreSQL

Se connecter au conteneur PostgreSQL :

```bash
docker exec -it postgres_tp psql -U postgres
```

![Connexion réussie](./screenshots/02-connexion.png)

---

### 🏗️ 3️⃣ Création de la base et du schéma

Créer la base de données et le schéma :

```sql
CREATE DATABASE cours;
\c cours

CREATE SCHEMA tp_dcl;
```

![Base et schéma créés](./screenshots/03-base-schema.png)

---

### 👥 4️⃣ Création des utilisateurs

Créer les rôles `etudiant` et `professeur` :

```sql
CREATE USER etudiant WITH PASSWORD '1234';
CREATE USER professeur WITH PASSWORD '1234';
```

![Création des rôles](./screenshots/04-creation-roles.png)

---

### 📊 5️⃣ Création de la table

Créer la table `etudiants` dans le schéma `tp_dcl` :

```sql
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    moyenne DECIMAL(4,2)
);
```

![Table créée](./screenshots/05-creation-table.png)

---

### 🔐 6️⃣ Attribution des privilèges (GRANT)

#### Privilèges pour l'étudiant (lecture seule)

```sql
GRANT USAGE ON SCHEMA tp_dcl TO etudiant;
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
```

#### Privilèges pour le professeur (tous les droits)

```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp_dcl TO professeur;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA tp_dcl TO professeur;
```

![GRANT effectué](./screenshots/06-grant.png)

---

### ❌ 7️⃣ Retrait des privilèges (REVOKE)

Retirer les privilèges de lecture à l'étudiant :

```sql
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

![REVOKE effectué](./screenshots/07-revoke.png)

---

### 🧪 8️⃣ Test des permissions

Connexion avec l'utilisateur `etudiant` :

```bash
psql -U etudiant -d cours
```

Tentative de lecture de la table :

```sql
SELECT * FROM tp_dcl.etudiants;
```

**Résultat attendu :**

```
ERROR: permission denied for table etudiants
```

![Permission denied](./screenshots/08-permission-denied.png)

---

### 🗑️ 9️⃣ Suppression des utilisateurs

#### Révocation des privilèges avant suppression

Pour le professeur :

```sql
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp_dcl FROM professeur;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA tp_dcl FROM professeur;
REVOKE ALL PRIVILEGES ON SCHEMA tp_dcl FROM professeur;
```

Pour l'étudiant :

```sql
REVOKE ALL PRIVILEGES ON SCHEMA tp_dcl FROM etudiant;
REVOKE ALL PRIVILEGES ON DATABASE cours FROM etudiant;
```

#### Suppression des utilisateurs

```sql
DROP USER etudiant;
DROP USER professeur;
```

![Suppression réussie](./screenshots/09-drop-users.png)

---


---

## ✅ Conclusion

Ce TP m'a permis de :

✔️ **Comprendre** la gestion des rôles dans PostgreSQL  
✔️ **Manipuler** les commandes `GRANT` et `REVOKE`  
✔️ **Vérifier** les permissions utilisateur  
✔️ **Gérer** les dépendances avant suppression d'un rôle  
✔️ **Utiliser** PostgreSQL dans un environnement Docker

---

## 📚 Ressources

- [Documentation PostgreSQL - DCL](https://www.postgresql.org/docs/current/sql-grant.html)
- [Docker Hub - PostgreSQL](https://hub.docker.com/_/postgres)
- [Tutoriel PostgreSQL Roles](https://www.postgresql.org/docs/current/user-manag.html)

---

## 📧 Contact

**Lounas Allouti**  
Cours INF1099 - Hiver 2026

---

*Dernière mise à jour : Février 2026*
