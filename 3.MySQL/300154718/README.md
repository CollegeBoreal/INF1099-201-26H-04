# INF1099 – TP MySQL avec Podman sur Windows

👤 **Auteur : Stéphane Tidjet**  
🎓 Collège Boréal – Techniques des systèmes informatiques  
📘 Cours : INF1099  
💻 Environnement : Windows 11 + Podman + MySQL 8.0  

---

## 🎯 Objectifs

Ce TP permet de :

- Configurer Podman avec alias Docker
- Créer une machine Linux Podman
- Lancer un conteneur MySQL
- Créer la base de données Sakila
- Ajouter un utilisateur MySQL
- Importer le schéma et les données
- Vérifier les tables SQL

---

## 📁 Étape 1 — Création du projet INF1099

Création du dossier INF1099 dans Downloads.

![Creation dossier](screenshots/q1.PNG)

---

## 🐧 Étape 2 — Initialisation et démarrage Podman

Initialisation de la machine Linux Podman puis démarrage.

![Initialisation Podman](screenshots/initalisation%202.PNG)

![Podman Machine Start](screenshots/podman2.PNG)

---

## 🐳 Étape 3 — Lancement du conteneur MySQL

Démarrage du conteneur MySQL avec Docker alias Podman.

![Docker Run MySQL](screenshots/leneecement%203.PNG)

Vérification des logs MySQL :

![Logs MySQL](screenshots/question%206.PNG)

---

## 🗄️ Étape 4 — Création de la base de données Sakila

Création de la base via MySQL dans le conteneur.

![Create Database](screenshots/creation%20la%20base%20de%20donne%20sakila%204.PNG)

---

## 👤 Étape 5 — Création de l’utilisateur etudiants

Création et vérification de l'utilisateur MySQL.

![Create User](screenshots/Étape%205%20–%20Création%20de%20l'utilisateur%20étudian.PNG)

---

## 📦 Étape 6 — Vérification des fichiers Sakila

Validation de la présence des fichiers SQL.

![Fichiers Sakila](screenshots/sakila.PNG)

---

## 🧩 Étape 7 — Importation du schéma et des données

Import du fichier sakila-schema.sql et sakila-data.sql.

![Import Sakila](screenshots/question%207%20et%208.PNG)

---

## ✅ Étape 8 — Vérification des tables

Affichage des tables pour confirmer l’importation réussie.

![Show Tables](screenshots/q9.PNG)

---

## 🧪 Résultat final

Les bases suivantes sont disponibles :

- information_schema
- mysql
- performance_schema
- sakila
- sys

La base **sakila** contient les tables actor, film, customer, rental, payment, etc.

---

## 📚 Commandes utiles

```powershell
docker ps -a
docker logs INF1099-mysql
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1
