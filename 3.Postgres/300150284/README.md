📦 PostgreSQL avec Docker – TP
🎯 Objectifs
Installer PostgreSQL avec Docker
Charger la base de données Sakila
Installer pgAdmin 4
Se connecter et explorer la base
🐳 1. Installation PostgreSQL avec Docker
Commande (Windows PowerShell)
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
<img width="940" height="110" alt="image" src="https://github.com/user-attachments/assets/c7911c67-e82f-4360-8673-13858f09952e" />

📥 2. Télécharger la base Sakila
Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
-OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql 
-OutFile postgres-sakila-insert-data.sql
📂 3. Copier les fichiers dans le conteneur
docker container cp postgres-sakila-schema.sql postgres:/schema.sql
docker container cp postgres-sakila-insert-data.sql postgres:/data.sql
<img width="869" height="88" alt="image" src="https://github.com/user-attachments/assets/3ab0e453-bcf0-4e30-9997-3dec3eb0ac0a" />

⚙️ 4. Charger la base de données
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql
<img width="928" height="703" alt="image" src="https://github.com/user-attachments/assets/c4bbdd52-962b-4475-a52c-0a5b7f3419e3" />
<img width="358" height="499" alt="image" src="https://github.com/user-attachments/assets/04ed6d24-f5cb-44ed-a1d5-c5c1fec45689" />


🔎 5. Vérification
docker container exec -it postgres psql -U postgres -d appdb

Dans PostgreSQL :

\dt
SELECT COUNT(*) FROM film;
SELECT COUNT(*) FROM actor;
<img width="550" height="600" alt="image" src="https://github.com/user-attachments/assets/59af2fbf-8bbe-4cfd-a2e4-a9a68329f845" />

🖥️ 6. Installation pgAdmin 4
choco install pgadmin4 -y
<img width="893" height="353" alt="image" src="https://github.com/user-attachments/assets/6b4bccbb-07b8-4ca5-9455-3fcc5bc061a7" />

🔗 7. Connexion avec pgAdmin
Host : localhost
Port : 5432
User : postgres
Password : postgres
Database : appdb
📚 Commandes utiles (psql)
\dt        -- afficher les tables
\d film    -- structure d’une table
\l         -- bases de données
\du        -- utilisateurs
\q         -- quitter
🔥 Réinitialisation (si erreur)
docker container rm -f postgres
docker volume rm postgres_data
✅ Conclusion

Dans ce TP, nous avons installé PostgreSQL avec Docker, importé la base Sakila et utilisé pgAdmin pour explorer les données.
