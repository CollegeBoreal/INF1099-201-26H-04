
README.md — PostgreSQL avec Docker & pgAdmin
Rabia bouhali

id; 3001514169


# PostgreSQL avec Docker 

## Objectifs

À la fin de cette activité, j’ai été capable de :

- Installer PostgreSQL avec Docker
- Charger la base de données Sakila
- Installer pgAdmin 4 avec Chocolatey
- Me connecter à PostgreSQL via pgAdmin
- Explorer et interroger la base de données

---

## 1️ Installation de PostgreSQL avec Docker

### Commande utilisée (Windows)

```powershell
docker container run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16

Vérification
docker container ls
docker container logs postgres


Résultat : le conteneur est Up et PostgreSQL accepte les connexions.

2️   Chargement de la base Sakila
Téléchargement des fichiers
Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
-OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
-OutFile postgres-sakila-insert-data.sql

Copier dans le conteneur
docker container cp postgres-sakila-schema.sql postgres:/schema.sql
docker container cp postgres-sakila-insert-data.sql postgres:/data.sql

Exécuter les scripts
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql

Vérification
docker exec postgres psql -U postgres -d appdb -c "\dt"


Résultat : 21 tables créées (actor, film, customer, etc.)

3️   Installation de pgAdmin 4
choco install pgadmin4 -y


Lancement via le menu Démarrer.

4️   Connexion à PostgreSQL dans pgAdmin

Paramètres utilisés :

Host : localhost

Port : 5432

Username : postgres

Password : postgres

Database : appdb

Connexion réussie 

5️  Requêtes test

Compter les acteurs :

SELECT COUNT(*) FROM actor;


Lister les films contenant “Star” :

SELECT title FROM film WHERE title ILIKE '%Star%';

 Commandes psql utiles
Commande	Description
\dt	Liste des tables
\d table	Structure d’une table
\l	Liste des bases
\du	Liste des utilisateurs
\q	Quitter
🔥 Remise à zéro complète
docker container rm -f postgres
docker volume rm postgres_data
