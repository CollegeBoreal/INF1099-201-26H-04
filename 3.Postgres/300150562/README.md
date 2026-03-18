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
<img width="416" height="323" alt="image" src="https://github.com/user-attachments/assets/a94a9d53-4ff9-420e-900f-1968d87f1880" />


(21 tables)

