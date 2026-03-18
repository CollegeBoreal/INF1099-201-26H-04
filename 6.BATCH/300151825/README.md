# 🪤 BATCH REALISÉ par Freedy EBAH

## 1. Démarrer Podman
```powershell
podman machine start
```
Résultat:
![Texte alternatif](images/1.png)

## 2. Créer le conteneur PostgreSQL
```powershell
docker run -d `
  --name postgres-lab `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  postgres
```
Résultat:
![Texte alternatif](images/2.png)

## 3. Vérifier le conteneur
```powershell
docker container ls
```
Résultat:
![Texte alternatif](images/3.png)

## 4. Exécuter le script PowerShell
```powershell
./load-db.ps1
```
Résultat:
![Texte alternatif](images/4.png)

## 5. Se connecter à la base de données
```powershell
docker container exec -it postgres-lab psql -U postgres -d ecole
```
Résultat:
![Texte alternatif](images/5.png)

## 6. Vérifier les tables
```sql
\dt
```
Résultat:
![Texte alternatif](images/6.png)

Résultat:
![Texte alternatif](images/2.png)

## 7. Requête sur la table client
```sql
SELECT * FROM client;
```
Résultat:
![Texte alternatif](images/2.png)
