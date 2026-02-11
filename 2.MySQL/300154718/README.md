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

<img width="440" height="146" alt="q 1" src="https://github.com/user-attachments/assets/5a03045c-82c4-4dd5-8fdf-5d2091ec7da0" />


---

## 🐧 Étape 2 — Initialisation et démarrage Podman

Initialisation de la machine Linux Podman puis démarrage.

<img width="590" height="319" alt="initalisation 2" src="https://github.com/user-attachments/assets/3fe67d6d-28bc-4369-b113-920380213b29" />


<img width="579" height="224" alt="podman2" src="https://github.com/user-attachments/assets/03461386-8323-4476-8ada-99b3e63dddad" />

---

## 🐳 Étape 3 — Lancement du conteneur MySQL

Démarrage du conteneur MySQL avec Docker alias Podman.

<img width="948" height="141" alt="leneecement 3" src="https://github.com/user-attachments/assets/ab0b787d-6854-4bdd-bd92-d2a7c1379c2a" />


Vérification des logs MySQL :

<img width="449" height="121" alt="question 6" src="https://github.com/user-attachments/assets/fcf3c63d-3aaf-46ff-8a9b-bcd347782d29" />


---

## 🗄️ Étape 4 — Création de la base de données Sakila

Création de la base via MySQL dans le conteneur.

<img width="506" height="123" alt="creation la base de donne sakila 4" src="https://github.com/user-attachments/assets/ab004a60-d190-4632-9760-59af4ea42eef" />

---

## 👤 Étape 5 — Création de l’utilisateur etudiants

Création et vérification de l'utilisateur MySQL.

<img width="668" height="148" alt="Étape 5 – Création de l&#39;utilisateur étudian" src="https://github.com/user-attachments/assets/3e20e815-6de7-4ba9-9628-68e84f8af218" />

---

## 📦 Étape 6 — Vérification des fichiers Sakila

Validation de la présence des fichiers SQL.

<img width="586" height="172" alt="sakila" src="https://github.com/user-attachments/assets/bd3e0dca-03c6-46db-9524-32c42001f729" />

---

## 🧩 Étape 7 — Importation du schéma et des données

Import du fichier sakila-schema.sql et sakila-data.sql.

<img width="642" height="365" alt="question 7 et 8" src="https://github.com/user-attachments/assets/cdeecc9d-edf2-40e0-a4f7-55b13dcdaefe" />

---

## ✅ Étape 8 — Vérification des tables

Affichage des tables pour confirmer l’importation réussie.

<img width="960" height="272" alt="q9" src="https://github.com/user-attachments/assets/c68ccbf2-3922-4eef-9d25-5d3a683793f6" />

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
