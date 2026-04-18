📦 INF1099 – PostgreSQL avec Docker (Podman) et pgAdmin 4

🎯 Objectif du TP



Ce laboratoire a pour objectif de :



Vérifier l’installation de Docker (via Podman Engine)

Déployer un conteneur PostgreSQL

Créer une base de données appdb

Télécharger et importer la base de données Sakila

Tester les tables avec psql

Se connecter via pgAdmin 4

Exécuter des requêtes SQL

1️⃣ Vérification de Docker

Vérifier la version

docker version

Vérifier les informations système

docker info

<img width="266" height="362" alt="1" src="https://github.com/user-attachments/assets/1dcdc84e-8a9e-465a-95fe-de9669489d56" />

<img width="434" height="106" alt="2" src="https://github.com/user-attachments/assets/916d2eb7-0b58-489a-88ee-cf276249e295" />



✔ Docker fonctionne avec Podman Engine

✔ Architecture : amd64

✔ API Version : 5.7.1



2️⃣ Lancement du conteneur PostgreSQL

docker container run -d `

\--name postgres `

\-e POSTGRES\_USER=postgres `

\-e POSTGRES\_PASSWORD=postgres `

\-e POSTGRES\_DB=appdb `

\-p 5432:5432 `

\-v pgdata:/var/lib/postgresql/data `

postgres:16

<img width="434" height="106" alt="2" src="https://github.com/user-attachments/assets/55d4aee8-7d9d-47d3-bf38-9698e7448ad5" />



3️⃣ Vérification du conteneur

docker container ls

<img width="443" height="74" alt="3" src="https://github.com/user-attachments/assets/99db16b7-3ebe-48cc-b85c-1b6963e849b3" />




✔ Le conteneur postgres est en état Up

✔ Port exposé : 5432



4️⃣ Vérification des logs

docker container logs postgres



Message attendu :



database system is ready to accept connections

<img width="436" height="299" alt="4" src="https://github.com/user-attachments/assets/7ef89279-c8cb-4c83-b4ec-b2a74980da11" />



✔ PostgreSQL est prêt



5️⃣ Création du dossier Sakila

mkdir sakila\_pg

cd sakila\_pg

<img width="368" height="115" alt="5" src="https://github.com/user-attachments/assets/f5cf4a07-df0d-433f-b163-d8f9e0b7241e" />




6️⃣ Téléchargement des fichiers Sakila

Invoke-WebRequest `

https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `

\-OutFile postgres-sakila-schema.sql



Invoke-WebRequest `

https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `

\-OutFile postgres-sakila-insert-data.sql

Vérification

dir

<img width="442" height="191" alt="6" src="https://github.com/user-attachments/assets/27cb36dd-bd2c-41ae-b607-5ed9381a8270" />






✔ Les deux fichiers sont présents



7️⃣ Copier les fichiers dans le conteneur

docker container cp .\\postgres-sakila-schema.sql postgres:/schema.sql

docker container cp .\\postgres-sakila-insert-data.sql postgres:/data.sql



<img width="440" height="65" alt="7" src="https://github.com/user-attachments/assets/a8f68bfa-71b2-4a72-94b3-8ded1ee05a07" />




8️⃣ Importer le schéma

docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql


<img width="438" height="374" alt="8" src="https://github.com/user-attachments/assets/a057d75d-0e12-4c70-b098-e716f9f85f2e" />




✔ Création des tables réussie



9️⃣ Importer les données

docker container exec -it postgres psql -U postgres -d appdb -f /data.sql


<img width="451" height="229" alt="9" src="https://github.com/user-attachments/assets/c665169d-f879-49b8-8b70-4808fd8ab134" />




✔ Données insérées avec succès



🔟 Vérification avec psql



Connexion :



docker container exec -it postgres psql -U postgres -d appdb



Lister les tables :



\\dt

<img width="435" height="264" alt="10" src="https://github.com/user-attachments/assets/8e069f88-4553-4c44-9cbb-990c3f1c0227" />




✔ 21 tables créées



1️⃣1️⃣ Requêtes de vérification

Compter les films

SELECT COUNT(\*) FROM film;



Résultat : 1000 films



Compter les acteurs

SELECT COUNT(\*) FROM actor;



Résultat : 200 acteurs

<img width="298" height="131" alt="11" src="https://github.com/user-attachments/assets/2c70a16e-4a52-44ab-aa17-a5caf8f76791" />




1️⃣2️⃣ Installation de pgAdmin 4

choco install pgadmin4 -y



<img width="739" height="505" alt="12" src="https://github.com/user-attachments/assets/1986352f-d42f-4866-aeea-356b66dd6c02" />




✔ Installation réussie



1️⃣3️⃣ Configuration du serveur dans pgAdmin

General

Name : Postgres Docker

Connection

Host : localhost

Port : 5432

Database : appdb

Username : postgres

Password : postgres

<img width="452" height="58" alt="13-1" src="https://github.com/user-attachments/assets/63247d4a-f765-406a-83a0-2d970cd73a55" />


<img width="434" height="502" alt="13-2" src="https://github.com/user-attachments/assets/458ecb79-58f4-4fa0-b2b2-e1187da74450" />




✔ Connexion réussie



1️⃣4️⃣ Vérification des tables dans pgAdmin



Chemin :



Servers → Postgres Docker → Databases → appdb → Schemas → public → Tables



<img width="438" height="509" alt="14" src="https://github.com/user-attachments/assets/bdf39bf6-2153-41ef-bfa8-260e7fdfa674" />



✔ Les 21 tables sont visibles





1️⃣5️⃣ Exécution de requêtes SQL dans pgAdmin

SELECT title

FROM film

WHERE title ILIKE '%Star%';



Résultat :



STAR OPERATION

TURN STAR


<img width="766" height="493" alt="15" src="https://github.com/user-attachments/assets/e0a21d85-217e-4cdc-8f58-f5056fc8fec7" />




✅ Conclusion



Dans ce TP nous avons :



Déployé PostgreSQL avec Docker (Podman)

Importé la base de données Sakila

Vérifié les tables avec psql

Installé et configuré pgAdmin 4

Exécuté des requêtes SQL avec succès



✔ Le système fonctionne correctement

✔ La base contient 1000 films et 200 acteurs



🚀 TP Réussi

👤 Auteur



Nom : Kahil Amine

Numéro étudiant : 300151292

🎓 Programme : INF1099

🏫 Collège Boréal

📅 Année : 2026

