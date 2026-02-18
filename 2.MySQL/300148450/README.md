# TP MySQL avec Podman sur Windows  

## 👤 Adjaoud Hocine  
## 📚 INF1099  
## 🗓 Session Hiver 2026  

---

## 🎯 Objectif du TP

Ce laboratoire consiste à installer et configurer MySQL 8.0 dans un conteneur Podman sur Windows, puis importer la base de données Sakila afin de vérifier son bon fonctionnement à l’aide de requêtes SQL.

---

## ⚙️ Configuration des variables

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099_Hocine"
```

---

## 📁 Création du dossier de projet

```powershell
New-Item -ItemType Directory -Path $projectDir -Force
```

---

## 📦 Décompression de Sakila DB

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir -Force
```

---

## 🔁 Configuration de l’alias Docker vers Podman

Alias temporaire :

```powershell
Set-Alias docker podman
```

Alias permanent :

```powershell
notepad $PROFILE
```

Ajouter la ligne suivante dans le fichier :

```powershell
Set-Alias docker podman
```

---

## 🖥 Initialisation de la machine Podman

```powershell
podman machine init
```

---

## ▶️ Démarrage de la machine Podman

```powershell
podman machine start
podman ps -a
```

---

## 🐬 Lancement du conteneur MySQL

```powershell
docker run -d --name INF1099-hocine-mysql `
-e MYSQL_ROOT_PASSWORD=HocineRoot2026 `
-p 3306:3306 mysql:8.0
```

Vérification :

```powershell
docker ps
```

---

## 🗄 Création de la base de données

```powershell
docker exec -it INF1099-hocine-mysql mysql -u root -pHocineRoot2026 -e "CREATE DATABASE sakila_hocine;"
```

Vérification :

```powershell
docker exec -it INF1099-hocine-mysql mysql -u root -pHocineRoot2026 -e "SHOW DATABASES;"
```

---

## 👤 Création de l’utilisateur MySQL

```powershell
docker exec -it INF1099-hocine-mysql mysql -u root -pHocineRoot2026 -e "CREATE USER 'hocine'@'localhost' IDENTIFIED BY 'Hocine123!';"
docker exec -it INF1099-hocine-mysql mysql -u root -pHocineRoot2026 -e "GRANT ALL PRIVILEGES ON sakila_hocine.* TO 'hocine'@'localhost';"
docker exec -it INF1099-hocine-mysql mysql -u root -pHocineRoot2026 -e "FLUSH PRIVILEGES;"
```

---

## 📥 Importation du schéma Sakila

```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" | docker exec -i INF1099-hocine-mysql mysql -u hocine -pHocine123! sakila_hocine
```

---

## 📥 Importation des données Sakila

```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" | docker exec -i INF1099-hocine-mysql mysql -u hocine -pHocine123! sakila_hocine
```

---

## ✅ Vérification des tables

```powershell
docker exec -it INF1099-hocine-mysql mysql -u hocine -pHocine123! -e "USE sakila_hocine; SHOW TABLES;"
```

---

## 🧪 Test des requêtes SQL

Connexion interactive :

```powershell
docker exec -it INF1099-hocine-mysql mysql -u hocine -pHocine123! sakila_hocine
```

Requêtes de test :

```sql
SELECT COUNT(*) AS total_films FROM film;
SELECT first_name, last_name FROM actor LIMIT 5;
```

---

## 📚 Commandes utiles

| Commande | Description |
|----------|------------|
| docker ps -a | Lister les conteneurs |
| docker stop INF1099-hocine-mysql | Arrêter le conteneur |
| docker start INF1099-hocine-mysql | Démarrer le conteneur |
| docker logs INF1099-hocine-mysql | Voir les logs |
| podman machine stop | Arrêter la VM Podman |
| podman machine start | Démarrer la VM Podman |

---

## 📝 Conclusion

Ce TP m’a permis de :

- Installer et configurer Podman sur Windows  
- Utiliser Docker via alias  
- Déployer un conteneur MySQL 8.0  
- Créer une base de données et un utilisateur personnalisé  
- Importer la base Sakila (schéma et données)  
- Tester le fonctionnement avec des requêtes SQL  

Le laboratoire démontre la maîtrise de la virtualisation légère via conteneur et la gestion d’une base de données MySQL dans un environnement Linux virtualisé sur Windows.
