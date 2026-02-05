# 🐘 PostgreSQL Sakila Database (Podman + pgAdmin4)

## 👤 Étudiant
- **Nom :** Abdelatif Nemous

---


## 🎯 Objectifs du TP
À la fin de ce TP, l’étudiant sera capable de :

- Installer PostgreSQL dans un conteneur avec **Podman**
- Charger la base de données **Sakila** dans PostgreSQL
- Installer **pgAdmin 4** avec Chocolatey sur Windows
- Se connecter à PostgreSQL via pgAdmin et explorer la base Sakila
- Exécuter des requêtes SQL de vérification

---

## 🛠️ Prérequis
Avant de commencer, il faut avoir :

- Windows 10/11
- PowerShell
- Podman installé
- Chocolatey installé

---

## 1️⃣ Démarrer Podman (WSL Machine)

### Vérifier la version Podman
```powershell
podman --version

```

### Démarrer la machine Podman
```powershell
podman machine start
```

### Vérifier que Podman fonctionne

```powershell
podman info
```

## 3️⃣ Installer PostgreSQL dans un conteneur

Commande utilisée pour lancer PostgreSQL :
```powershell
docker run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
```

### Vérifier que le conteneur est en cours d’exécution
```powershell
docker ps

```

## 4️⃣ Télécharger la base Sakila (PostgreSQL)

### Télécharger le schéma (tables + relations)
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql" -OutFile "postgres-sakila-schema.sql"
```

### Télécharger les données (INSERT)
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql" -OutFile "postgres-sakila-insert-data.sql"
```

## 5️⃣ Copier les fichiers SQL dans le conteneur PostgreSQL

```powershell

docker cp .\postgres-sakila-schema.sql postgres:/schema.sql
docker cp .\postgres-sakila-insert-data.sql postgres:/data.sql

```

## 6️⃣ Importer Sakila dans PostgreSQL

### Charger le schéma
```powershell
docker exec -it postgres psql -U postgres -d appdb -f /schema.sql
```
### Charger les données
```powershell
docker exec -it postgres psql -U postgres -d appdb -f /data.sql
```

⚠️ Cette étape peut prendre quelques minutes car il y a beaucoup de données.


## 7️⃣ Vérifier que Sakila est bien chargée
Lister les tables
```powershell
docker exec -it postgres psql -U postgres -d appdb -c "\dt"
```
### Vérifier le nombre de films
```powershell
docker exec -it postgres psql -U postgres -d appdb -c "SELECT COUNT(*) FROM film;"
```

### Exemple de requête (films contenant "Star")

```powershell
docker exec -it postgres psql -U postgres -d appdb -c "SELECT title FROM film WHERE title ILIKE '%Star%';"


```
![TABLE_POWERSHELL](./images/POOOOST1.PNG)



## 8️⃣ Installer pgAdmin 4 avec Chocolatey

### 📍 Ouvrir PowerShell en mode Administrateur :

```powershell
choco install pgadmin4 -y

```
Ensuite, ouvrir pgAdmin 4 depuis le menu Démarrer.


### 9️⃣ Connexion PostgreSQL dans pgAdmin 4

Dans pgAdmin :
{
  General: {
    Name: "Postgres Docker"
  },
  Connection: {
    Host: "localhost",
    Port: 5432,
    Username: "postgres",
    Password: "postgres",
    MaintenanceDatabase: "appdb"
  }
}

## 🔍 Vérification dans pgAdmin

###  Dans Query Tool :


```powershell
SELECT * FROM film;
```

Résultat attendu : affichage des films dans la table film.

![CAPTURE_pgAdmin4](./images/POOOOST.PNG)


## ✅ Conclusion

Le TP est réussi car :

PostgreSQL est lancé dans Podman

Sakila a été importée avec succès

Les tables sont visibles

Les données sont présentes (film = 1000)

pgAdmin se connecte correctement et affiche les données

## 📌 Commandes utiles PostgreSQL (psql)
Commande	Description
\dt	Liste toutes les tables
\d film	Affiche la structure de la table film
\l	Liste toutes les bases de données
\c appdb	Se connecter à la base appdb
\q	Quitter psql
