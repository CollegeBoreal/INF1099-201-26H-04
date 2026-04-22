## Types de scripts SQL

| Type | Signification | Exemple |
|------|--------------|---------|
| DDL | Data Definition Language | CREATE TABLE |
| DML | Data Manipulation Language | INSERT |
| DQL | Data Query Language | SELECT |
| DCL | Data Control Language | GRANT |

## Étapes

### 1. Lancer le conteneur PostgreSQL
```powershell
docker container run -d \
  --name postgres-lab \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  postgres
```

### 2. Vérifier que le conteneur est actif
```powershell
docker container ls
```
<img width="947" height="142" alt="6 1" src="https://github.com/user-attachments/assets/99afcdfb-713b-4ded-929f-7687690b6fe8" />

### 3. Exécuter le script PowerShell
```powershell
powershell -ExecutionPolicy Bypass -File ./load-db.ps1
```
<img width="906" height="312" alt="6 2" src="https://github.com/user-attachments/assets/3e74101e-feb2-4a1d-93af-caa4ac9e40e4" />

### 4. Vérification dans psql
```powershell
docker container exec -it postgres-lab psql -U postgres -d ecole
```
```sql
SELECT * FROM etudiants;
```
<img width="892" height="276" alt="6 3" src="https://github.com/user-attachments/assets/f158765d-aad9-4c61-b485-95c15fa70fa4" />

## Résultat
Les 5 étudiants sont bien insérés dans la base de données `ecole` :

| id | nom   | age |
|----|-------|-----|
| 1  | Alice | 20  |
| 2  | Bob   | 22  |
| 3  | Clara | 21  |
| 4  | David | 23  |
| 5  | Emma  | 19  |
