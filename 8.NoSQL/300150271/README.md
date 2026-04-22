\# TP NoSQL — 300150271



\## Description

Mini base NoSQL avec PostgreSQL JSONB, Docker et Python.



\## Lancer PostgreSQL avec Docker

```powershell

docker container run --name postgres-nosql `

&#x20; -e POSTGRES\_USER=postgres `

&#x20; -e POSTGRES\_PASSWORD=postgres `

&#x20; -e POSTGRES\_DB=ecole `

&#x20; -p 5432:5432 `

&#x20; -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `

&#x20; -d postgres

```



\## Installer les dependances

pip install -r requirements.txt



\## Executer les requetes

docker cp queries.sql postgres-nosql:/queries.sql

docker exec postgres-nosql psql -U postgres -d ecole -f /queries.sql

