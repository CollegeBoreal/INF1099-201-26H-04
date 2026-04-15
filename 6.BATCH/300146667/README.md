# TP Batch - DjaberBenyezza - 300146667

## Automatisation PostgreSQL avec PowerShell et Docker

## Structure du projet

6.BATCH/300146667/
- DDL.sql
- DML.sql
- DCL.sql
- DQL.sql
- load-db.ps1
- README.md

## Types de scripts SQL

DDL : CREATE TABLE
DML : INSERT
DCL : GRANT
DQL : SELECT

Ordre execution : DDL -> DML -> DCL -> DQL

## Demarrer avec Docker

docker container run -d --name postgres-lab -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5432:5432 postgres

## Executer le script

cd 6.BATCH\300146667
pwsh ./load-db.ps1

## Resultat attendu

Demarrage du chargement...
Execution de DDL.sql
CREATE TABLE
Execution de DML.sql
INSERT 0 5
Execution de DCL.sql
GRANT
Execution de DQL.sql
 id | nom
----+------
 1  | Alice
Termine en 1.97 secondes!

## Verification

docker exec -it postgres psql -U postgres -d ecole
SELECT * FROM etudiants;
