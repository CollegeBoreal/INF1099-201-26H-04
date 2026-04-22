# TP NoSQL - PostgreSQL JSONB & Python

## Structure du projet
- `init.sql` : Création de la table `etudiants` avec colonne `JSONB` et index `GIN`.
- `app.py` : Script Python pour l'insertion, la recherche, la mise à jour et la suppression.
- `requirements.txt` : Liste des dépendances.

## Installation et Lancement

1. **Lancer PostgreSQL avec Docker** :
```bash
docker container run --name postgres-nosql \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -d postgres
