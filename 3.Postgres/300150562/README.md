# README - PostgreSQL avec Docker et utilisation de la base appdb

## 1. Prérequis
- **Docker** installé sur votre machine.
- Connaissance basique de la ligne de commande.
- (Optionnel) `psql` pour se connecter à PostgreSQL.

## 2. Lancer PostgreSQL avec Docker
1. Récupérer l’image PostgreSQL 16 :  
```bash
docker pull postgres:16
2.Créer et lancer un conteneur PostgreSQL :
docker run --name postgres -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:16

Schema | Name           | Type  | Owner
-------+----------------+-------+-------
public | actor          | table | postgres
public | address        | table | postgres
public | category       | table | postgres
public | film           | table | postgres
public | payment        | table | postgres
...
```
<img width="975" height="801" alt="image" src="https://github.com/user-attachments/assets/5258f377-7dde-492d-9ef4-e34885b3aaed" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f55cf870-2e68-4d95-b0da-582d354b8c69" />
Exercice 2
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e06687d6-28f7-4083-b037-612438d04a3d" />




