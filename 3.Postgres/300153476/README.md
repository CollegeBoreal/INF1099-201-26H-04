# 📦 PostgreSQL Docker + Base de données Sakila
---
**Cours :** INF1099 – Systèmes de bases de données  
**Étudiante :** Ramatoulaye Diallo  
**Matricule :** 300153476  
**Environnement :** Windows 11 + Podman (compatibilité Docker CLI) + PostgreSQL 16 + pgAdmin 4  

---

## 📌 Objectif du projet

Ce projet démontre comment :

- Déployer PostgreSQL 16 dans un conteneur Docker (via Podman)
- Configurer la persistance des données
- Importer la base d'exemple **Sakila** (version PostgreSQL)
- Se connecter via **pgAdmin 4**
- Exécuter et valider des requêtes SQL

L’objectif est de comprendre le déploiement d’une base de données conteneurisée et l’architecture client-serveur.

---
# Resultat
<img src="images/Illustration_postgres.png" width="800">

---
## 📁 Structure du projet
```
300153476/
│
├── postgres-sakila-schema.sql
├── postgres-sakila-insert-data.sql
├── images/
└── README.md
```
---

## 🖥️ Environnement utilisé

### 1️⃣ Runtime de conteneur

- Podman 5.7.1 (mode compatibilité Docker)
- Backend WSL2
- Mode rootless

---

## 🐳 Installation de PostgreSQL via Docker

### Étape 1 — Création et lancement du conteneur

```powershell
docker run -d `
  --name postgres16 `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
```
---

## 🔎 Explication des paramètres Docker

| Paramètre | Description |
|------------|-------------|
| POSTGRES_USER | Utilisateur principal |
| POSTGRES_PASSWORD | Mot de passe |
| POSTGRES_DB | Base créée au démarrage |
| -p 5432:5432 | Mapping du port hôte → conteneur |
| -v postgres_data | Volume pour persistance |

---

## 🔍 Vérification du fonctionnement

```powershell
docker ps
docker logs postgres16
```
---

# 📥 Importation de la base Sakila

## Étape 1 — Télécharger les fichiers SQL

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql" -OutFile "postgres-sakila-schema.sql"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql" -OutFile "postgres-sakila-insert-data.sql"
```
## Étape 2 — Copier les fichiers dans le conteneur
```
docker cp postgres-sakila-schema.sql postgres16:/schema.sql
docker cp postgres-sakila-insert-data.sql postgres16:/data.sql
```
## Étape 3 — Exécuter les scripts SQL
```
docker exec -it postgres16 psql -U postgres -d appdb -f /schema.sql
docker exec -it postgres16 psql -U postgres -d appdb -f /data.sql
```
# 🧪 Validation de la base de données
## Connexion au serveur
```
docker exec -it postgres16 psql -U postgres -d appdb
```
## Commandes à exécuter dans psql
```
\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
```
## ✔ Résultats attendus :
- Plus de 1000 films
- 200 acteurs
---
# 🖥️ Configuration de pgAdmin 4
## Paramètres de connexion
| Champ |	Valeur |
|------ | ------- |
| Host	| localhost|
| Port | 5432 |
| Database |	appdb |
| User |	postgres |
| Password |	postgres |
---
## Connexion confirmée :
```
psql (18.0, server 16.11)
appdb=#
```
# 📊 Exemples de requêtes SQL
## Lister tous les acteurs
```
SELECT * FROM actor;
```
## Compter les acteurs
```
SELECT COUNT(*) FROM actor;
```
## Rechercher les films contenant "Star"
```
SELECT title 
FROM film 
WHERE title ILIKE '%Star%';
```
# 🧠 Concepts démontrés

- Déploiement d’une base conteneurisée
- Persistance via volume Docker
- Mapping de ports
- Architecture client-serveur PostgreSQL
- Exécution de scripts SQL
- Connexion via interface graphique (pgAdmin)
- Utilisation de Podman en mode rootless





