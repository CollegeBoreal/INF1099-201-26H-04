# TP NoSQL - DjaberBenyezza - 300146667

## Mini base NoSQL avec PostgreSQL JSONB et Python

## Structure du projet

300146667/
- README.md
- init.sql
- app.py
- requirements.txt
- images/

## Lancer PostgreSQL avec Docker

docker run --name postgres-nosql -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=ecole -p 5433:5432 -d postgres

## Charger init.sql

docker cp init.sql postgres-nosql:/init.sql
docker exec -i postgres-nosql psql -U postgres -d ecole -f /init.sql

## Installer les dependances Python

pip install -r requirements.txt

## Lancer le script Python

python app.py

## Operateurs JSONB

->> : Accede a un champ texte
->  : Accede a un champ JSON
?   : Verifie si une cle existe
||  : Fusionne deux objets JSON
