# TP PostgreSQL avec Podman - Base Sakila

Massinissa Mameri 
INF1099

Ce laboratoire présente l'installation de PostgreSQL dans un conteneur Podman, l'importation de la base de données Sakila et l'utilisation de pgAdmin pour explorer les données.

---

🎯 Objectifs

Installer PostgreSQL dans un conteneur 
Importer la base de données Sakila 
Installer pgAdmin 
Vérifier les tables et les données 

---

🚀 Étapes du laboratoire

### Étape 1 : Créer le conteneur PostgreSQL

Commande utilisée :

podman run -d \
--name postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_DB=appdb \
-p 5432:5432 \
-v postgres_data:/var/lib/postgresql/data \
docker.io/library/postgres:16

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/dc10b721-0e76-42af-80f6-1954115d1fd3)

---

### Étape 2 : Vérifier que le conteneur fonctionne

Commande :

podman ps

Cette commande permet de vérifier que le conteneur PostgreSQL est en cours d'exécution.

🖼️ Capture d'écran
 ![wait](https://github.com/user-attachments/assets/8e847964-75a0-45fb-94bb-0ba75e78785b)

---

### Étape 3 : Télécharger la base Sakila

Commande PowerShell :

Invoke-WebRequest \
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql \
-OutFile postgres-sakila-schema.sql

Invoke-WebRequest \
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql \
-OutFile postgres-sakila-insert-data.sql

🖼️ Capture d'écran
 ![wait](https://github.com/user-attachments/assets/0cf446bd-fc87-4b50-bf6c-e8f28334b313)

---

### Étape 4 : Importer la base de données

Commande :

podman exec -i postgres psql -U postgres -d appdb < postgres-sakila-schema.sql

podman exec -i postgres psql -U postgres -d appdb < postgres-sakila-insert-data.sql

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/eabe2289-daf7-4f55-a3bc-dcdc4aa99c6b)

---

### Étape 5 : Vérifier les tables

Commande :

podman exec -it postgres psql -U postgres -d appdb -c "\dt"

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/d3dc1430-68e9-4cab-9be0-e4fb468911e1)

---

### Étape 6 : Vérifier les données

SELECT COUNT(*) FROM film;

SELECT COUNT(*) FROM actor;

🖼️ Capture d'écran
![wait](https://github.com/user-attachments/assets/ef53e845-a497-49a3-883f-9345db9452ec)







![wait](https://github.com/user-attachments/assets/6c3ffa19-41cd-4dd1-b0b0-dd0274e01977)

