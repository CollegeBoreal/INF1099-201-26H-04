🐘 PostgreSQL Docker + Base de données Sakila


ChampDétailCoursINF1099 – Systèmes de bases de donnéesEnvironnementWindows 11 + Podman + PostgreSQL 16 + pgAdmin 4

📌 Objectif du projet
Ce projet démontre comment :

🐳 Déployer PostgreSQL 16 dans un conteneur Docker (via Podman)
💾 Configurer la persistance des données avec un volume
📦 Importer la base d'exemple Sakila (version PostgreSQL)
🖥️ Se connecter via pgAdmin 4
🔍 Exécuter et valider des requêtes SQL

L'objectif est de comprendre le déploiement d'une base de données conteneurisée et l'architecture client-serveur.

📁 Structure du projet
300153747/
│
├── postgres-sakila-schema.sql
├── postgres-sakila-insert-data.sql
├── images/
└── README.md

🖥️ Environnement utilisé

Podman 5.7.1 (mode compatibilité Docker CLI)
Backend WSL2
Mode rootless


🐳 Installation de PostgreSQL via Docker
Étape 1 — Création et lancement du conteneur
powershelldocker run -d `
  --name postgres16 `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
🔎 Explication des paramètres
ParamètreDescriptionPOSTGRES_USERUtilisateur principalPOSTGRES_PASSWORDMot de passePOSTGRES_DBBase créée au démarrage-p 5432:5432Mapping du port hôte → conteneur-v postgres_dataVolume pour la persistance des données
Vérification du fonctionnement
powershelldocker ps
docker logs postgres16

📥 Importation de la base Sakila
Étape 1 — Télécharger les fichiers SQL
powershellInvoke-WebRequest -Uri "https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql" -OutFile "postgres-sakila-schema.sql"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql" -OutFile "postgres-sakila-insert-data.sql"
Étape 2 — Copier les fichiers dans le conteneur
powershelldocker container cp postgres-sakila-schema.sql postgres:/schema.sql
docker container cp postgres-sakila-insert-data.sql postgres:/data.sql
Étape 3 — Exécuter les scripts SQL
powershelldocker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql

📸 Capture — Téléchargement des fichiers, copie et exécution du schéma Sakila :

Afficher l'image

🧪 Validation de la base de données
Étape 4 — Connexion et vérification
powershelldocker container exec -it postgres psql -U postgres -d appdb
sql\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;


🖥️ Configuration de pgAdmin 4
Installation via Chocolatey
powershellchoco install pgadmin4 -y


Afficher l'image

Lancement de pgAdmin 4

Afficher l'image

Ajout du serveur PostgreSQL
Onglet General — Nommer le serveur Postgres Docker :



Afficher l'image
Onglet Connection — Paramètres de connexion :
ChampValeurHostlocalhostPort5432DatabaseappdbUserpostgresPasswordpostgres

Connexion confirmée — Dashboard pgAdmin
📊 Exemples de requêtes SQL
Requêtes exécutées dans l'éditeur SQL de pgAdmin :
sql-- Lister tous les acteurs
SELECT * FROM actor;

-- Compter le nombre d'acteurs
SELECT COUNT(*) FROM actor;

-- Rechercher les films contenant "Star"
SELECT title FROM film WHERE title ILIKE '%Star%';


🧠 Concepts démontrés
ConceptDétailDéploiement conteneuriséPostgreSQL 16 via Podman/DockerPersistance des donnéesVolume Docker monté sur le conteneurMapping de ports5432:5432 hôte → conteneurArchitecture client-serveurpgAdmin 4 ↔ PostgreSQLImport de base de donnéesScripts SQL schema + dataInterface graphiquepgAdmin 4 connecté au conteneurMode rootlessPodman sans privilèges root
les captures 
<img src="images/Screenshot 2026-02-21 203147.png" width="600">
<img src="images/Screenshot 2026-02-21 203622.png" width="600">
<img src="images/Screenshot 2026-02-21 203932.png" width="600">
<img src="images/Screenshot 2026-02-21 204116.png" width="600">
<img src="images/Screenshot 2026-02-21 204442.png" width="600">
<img src="images/Screenshot 2026-02-21 204508.png" width="600">
<img src="images/Screenshot 2026-02-21 204748.png" width="600">
<img src="images/etape 4 prostgres.png" width="600">
<img src="images/instalion de pgADmin.png" width="600">



