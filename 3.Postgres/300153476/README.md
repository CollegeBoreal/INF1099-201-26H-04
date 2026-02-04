## Resultat
<img src="images/Illustration_postgres.png" width="800">

---
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




