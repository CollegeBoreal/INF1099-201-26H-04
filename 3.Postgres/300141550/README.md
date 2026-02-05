
Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
  -OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
  https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
  -OutFile postgres-sakila-insert-data.sql



commande pour entrer dans la base de donnee 
podman exec -it postgres psql -U postgres -d appdb

<img width="945" height="482" alt="image" src="https://github.com/user-attachments/assets/df792af6-75e3-4e3b-8dcf-1ddf9f7b1b80" />

<img width="945" height="500" alt="image" src="https://github.com/user-attachments/assets/53dc6ca2-d919-4f81-a6c8-828074ed080e" />


Exploration de la base Sakila
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f55cf870-2e68-4d95-b0da-582d354b8c69" />

Exercice 1 
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d5a1cde6-94b8-4a68-b278-a457d712a60b" />

Exercice 2
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e06687d6-28f7-4083-b037-612438d04a3d" />
