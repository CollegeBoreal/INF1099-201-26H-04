# Manipulation de données avec MySQL et administration

[:tada: Participation](.scripts/Participation.md)

## 🎯 Objectifs

À la fin de ce TP, l’étudiant sera capable de :

1. Installer et configurer [**Podman**](../D.Podman) avec alias **Docker** sur Windows
2. Créer et démarrer la machine Podman (VM Linux)
3. Lancer un conteneur **MySQL**
4. Créer une base de données et un utilisateur
5. Importer la base de données **Sakila**
6. Manipuler les tables pour des exercices SQL

---

## 1️⃣ Prérequis

* Windows 10/11 64 bits
* **Podman installé**
* PowerShell (de préférence Administrateur)
* Accès Internet

---

## 2️⃣ Préparer le projet dans Downloads

On utilise un dossier temporaire dans **Downloads** :

```powershell
# Créer le dossier INF1099 dans Downloads
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```

---

## 3️⃣ Télécharger et décompresser Sakila DB

1. Télécharger ZIP : [Sakila DB](http://downloads.mysql.com/docs/sakila-db.zip)
2. Décompresser dans `$projectDir` :

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir
```

* Le contenu sera dans `$projectDir\sakila-db`

---

## 4️⃣ Configurer Podman avec alias Docker

```powershell
# Alias temporaire
Set-Alias docker podman

# Pour rendre l'alias permanent
notepad $PROFILE
# Ajouter la ligne suivante dans le fichier :
Set-Alias docker podman
```

---

## 5️⃣ Initialiser et démarrer la machine Podman

```powershell
# Initialiser la machine Linux
podman machine init

# Démarrer la machine
podman machine start
```

Vérifie le fonctionnement :

```powershell
podman ps -a
```

* La liste peut être vide → normal, aucune VM/MySQL lancée encore

---

## 6️⃣ Lancer le conteneur MySQL

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

* Vérifie :

```powershell
docker ps
```

* Tu devrais voir **INF1099-mysql** en cours d’exécution

---

## 7️⃣ Créer la base de données Sakila

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
```

* Mot de passe root : `rootpass`

Vérification :

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "SHOW DATABASES;"
```

---

## 8️⃣ Créer l’utilisateur **etudiants**

```powershell
docker exec -it INF1099-mysql `
     mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
```

```powershell
docker exec -it INF1099-mysql `
  mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```

* Mot de passe : `etudiants_1`
* Vérifie la création :

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "SELECT User, Host FROM mysql.user;"
```

---

## 9️⃣ Importer la base Sakila

### Charger le schéma

```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
 docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

### Charger les données

```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
 docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

---

## 10️⃣ Vérifier l’importation

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

* Tables attendues : `actor`, `film`, `customer`, etc.

---

## 11️⃣ Commandes Podman/Docker utiles

| Commande                                                         | Description                |
| ---------------------------------------------------------------- | -------------------------- |
| `docker ps -a`                                                   | Lister tous les conteneurs |
| `docker stop INF1099-mysql`                                      | Arrêter le conteneur       |
| `docker start INF1099-mysql`                                     | Démarrer le conteneur      |
| `docker logs INF1099-mysql`                                      | Voir les logs du serveur   |
| `docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1` | Se connecter à MySQL       |

---

## 12️⃣ Automatiser le TP avec un script

Crée **`start-sakila-INF1099.ps1`** :

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# Lancer MySQL
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

# Créer la base et l’utilisateur
docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1' WITH GRANT OPTION;"
```

# Importer le schéma et les données

```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```
Exécuter :

```powershell
.\start-sakila-INF1099.ps1
```

---

✅ Ce TP est maintenant **complètement fonctionnel sur Windows avec Podman**, avec :

* VM Linux Podman
* Alias Docker
* MySQL en conteneur
* Base Sakila importée

# :books: References

```powershell
choco install mysql.workbench
```
