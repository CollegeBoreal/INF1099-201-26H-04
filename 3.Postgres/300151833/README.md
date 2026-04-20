# 📚 TP 03 - PostgreSQL avec Docker et pgAdmin

---

## 🎯 Objectif

- Installer PostgreSQL avec Docker
- Charger la base de données Sakila
- Explorer la base avec pgAdmin
- Exécuter des requêtes SQL

---

# 🚀 Lancement de PostgreSQL avec Docker

```bash
docker container run -d --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=appdb -p 5432:5432 postgres:16
🔗 Connexion à PostgreSQL
docker container exec -it postgres psql -U postgres -d appdb
📊 Liste des tables

🧪 Requêtes SQL
👥 Nombre d’acteurs
SELECT COUNT(*) FROM actor;

🎥 Nombre de films
SELECT COUNT(*) FROM film;

⭐ Films contenant "Star"
SELECT title FROM film WHERE title ILIKE '%Star%';

👤 Exemple de clients
SELECT customer_id, first_name, last_name, email
FROM customer
LIMIT 5;

🖥️ Connexion avec pgAdmin
Host : localhost
Port : 5432
User : postgres
Password : postgres
Database : appdb
📸 Interface pgAdmin

📁 Structure du projet
📁 projet
 ├── README.md
 ├── 📁 images
 │    ├── tables.png
 │    ├── actor.png
 │    ├── film.png
 │    ├── star.png
 │    ├── customer.png
 │    ├── pgadmin.png
📚 Projet personnel : Bibliothèque universitaire
🎯 Description

Système permettant :

Gestion des membres
Gestion des livres
Gestion des emprunts
Gestion des paiements
Gestion des employés
🧩 Entités
Membre
Adresse
Livre
Catégorie
Auteur
Emprunt
Ligne_Emprunt
Paiement
Employé
🧪 Normalisation
1FN

Membre(id_membre, nom, email)

2FN

Emprunt(id_emprunt, date_emprunt, id_membre)

3FN

Livre(id_livre, titre, id_categorie
