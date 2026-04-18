# 🐳 INF1099 — MySQL 8.0 avec Podman sur Windows

> **Collège Boréal · INF1099 · 2026**  
> **Auteur :** Salim Amir

---

## 📋 Table des matières

1. [Objectif du projet](#-objectif-du-projet)
2. [Prérequis](#-prérequis)
3. [Étape 1 — Installation de Podman](#-étape-1--installation-de-podman)
4. [Étape 2 — Création du dossier de travail](#-étape-2--création-du-dossier-de-travail)
5. [Étape 3 — Extraction de Sakila](#-étape-3--extraction-de-sakila)
6. [Étape 4 — Alias Docker → Podman](#-étape-4--alias-docker--podman)
7. [Étape 5 — Démarrage de la machine Podman](#-étape-5--démarrage-de-la-machine-podman)
8. [Étape 6 — Déploiement du conteneur MySQL](#-étape-6--déploiement-du-conteneur-mysql)
9. [Étape 7 — Création de la base de données](#-étape-7--création-de-la-base-de-données)
10. [Étape 8 — Création de l'utilisateur](#-étape-8--création-de-lutilisateur)
11. [Étape 9 — Importation de Sakila](#-étape-9--importation-de-sakila)
12. [Étape 10 — Vérification & Script d'automatisation](#-étape-10--vérification--script-dautomatisation)
13. [Étape 11 — Connexion MySQL Workbench](#-étape-11--connexion-mysql-workbench)
14. [Résultat final](#-résultat-final)

---

## 🎯 Objectif du projet

Ce projet a pour but de mettre en place un environnement MySQL 8.0 conteneurisé sur Windows, en utilisant **Podman** comme moteur de conteneurs. L'ensemble du workflow est automatisé via **PowerShell**.

| Objectif | Description |
|----------|-------------|
| 🖥 Podman sur Windows | Installation et configuration via Chocolatey |
| 🔄 Alias Docker | Utiliser `docker` comme alias vers `podman` |
| 🐳 Conteneur MySQL 8.0 | Déploiement avec port mapping 3306 |
| 🗄 Base Sakila | Création, importation du schéma et des données |
| ⚡ Automatisation | Script PowerShell `.ps1` complet |
| 📊 Requêtes SQL | GROUP BY, JOIN sur la base Sakila |
| 🔗 Workbench | Connexion GUI validée |

---

## 🔧 Prérequis

- Windows 10/11 avec **WSL2** activé
- [Chocolatey](https://chocolatey.org/) installé
- PowerShell en mode **Administrateur**
- Archive `sakila-db.zip` dans le dossier `Downloads`
- (Optionnel) MySQL Workbench pour la connexion graphique

---

## 🛠 Étape 1 — Installation de Podman

Podman est installé via **Chocolatey**, le gestionnaire de paquets Windows.

```powershell
choco install podman-desktop -y
podman --version
podman info
```

<!-- ============================================================ -->
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%201.png)                      -->
<!--             -->
<!--                          -->
<!-- ============================================================ -->

> ✅ Podman version **5.8.0** détecté, architecture `windows/amd64`.

---

## 📁 Étape 2 — Création du dossier de travail

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
ls "$env:USERPROFILE\Downloads"
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%202.png)                      -->
<!--                            -->
<!-- ============================================================ -->

> ✅ Dossier `INF1099` créé dans `C:\Users\Administrator\Downloads`.

---

## 📦 Étape 3 — Extraction de Sakila

```powershell
ls "$env:USERPROFILE\Downloads\sakila*"
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape3.1.png)    -->
<!       -->
<!

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" `
               -DestinationPath "$env:USERPROFILE\Downloads\INF1099" -Force
ls "$env:USERPROFILE\Downloads\INF1099"
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape3.2.png)     -->
<!                      -->
<!-- ============================================================ -->

```powershell
ls "$env:USERPROFILE\Downloads\INF1099\sakila-db"
```

<!-- ============================================================ -->
<!   -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape3.3.png)               -->
<!-- ============================================================ -->

> ✅ Fichiers extraits : `sakila-schema.sql`, `sakila-data.sql`, `sakila.mwb`.

---

## 🔄 Étape 4 — Alias Docker → Podman

```powershell
Set-Alias docker podman
Get-Alias docker
docker --version
```

<!-- ============================================================ -->
<!-- 📸 COLLE ICI : CAPTURE 4 (étape 4.png)                      -->
<!([wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%204.png)                           -->
<!-- ============================================================ -->

> ✅ `docker` redirige vers `podman.exe`.

---

## ⚙️ Étape 5 — Démarrage de la machine Podman

```powershell
podman machine start
podman machine list
```

<!-- ============================================================ -->
<!-- 📸 COLLE ICI : CAPTURE 5 (étape 5.png)                      -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%205.png)                          -->
<!-- ============================================================ -->

> ✅ Machine `podman-machine-default` — **8 CPUs, 2 GiB RAM, 100 GiB disque**.

---

## 🐳 Étape 6 — Déploiement du conteneur MySQL

```powershell
docker run -d `
  --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0

docker ps
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%206.png)                      -->
<!                         -->
<!-- ============================================================ -->

> ✅ Conteneur `INF1099-mysql` en cours d'exécution sur le port `3306`.

---

## 🗄 Étape 7 — Création de la base de données

```powershell
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec INF1099-mysql mysql -u root -prootpass -e "SHOW DATABASES;"
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%207.png)                      -->
<!--                          -->
<!-- ============================================================ -->

> ✅ Base `sakila` présente dans la liste des bases de données.

---

## 👤 Étape 8 — Création de l'utilisateur

```powershell
docker exec -it INF1099-mysql mysql -u root -prootpass -e `
  "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"

docker exec -it INF1099-mysql mysql -u root -prootpass -e `
  "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"

docker exec INF1099-mysql mysql -u root -prootpass -e `
  "SELECT User, Host FROM mysql.user;"
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%208.png)               -->
<!--                          -->
<!-- ============================================================ -->

> ✅ Utilisateur `etudiants@localhost` créé et listé dans `mysql.user`.

---

## 📥 Étape 9 — Importation de Sakila

### Configuration de la politique d'exécution

```powershell
cd "$env:USERPROFILE\Downloads\INF1099"
notepad start-sakila-INF1099.ps1
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
Get-ExecutionPolicy -List
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape9.1.png)                   -->
<!--                         -->
<!-- ============================================================ -->

### Importation du schéma et des données

```powershell
# Schéma
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# Données
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape9.2.png)                   -->
<!--                         -->
<!-- ============================================================ -->

> ✅ Schéma et données importés avec succès dans la base `sakila`.

---

## ⚡ Étape 10 — Vérification & Script d'automatisation

### Vérification des tables

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%2010.png)          -->
<!--                           -->
<!-- ============================================================ -->

### Connexion interactive au shell MySQL

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

<!-- ============================================================ -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%2010.1.png)                -->
<!--                       -->
<!-- ============================================================ -->

### Requêtes SQL

**Requête 1 — Films par classification :**

```sql
SELECT rating, COUNT(*) AS total
FROM film
GROUP BY rating;
```

**Requête 2 — Clients avec leur ville :**

```sql
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city    ON address.city_id = city.city_id;
```

<!-- ============================================================ -->
<!--                 -->
<![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%2010.2.png)                   -->
<!-- ============================================================ -->

<!-- ============================================================ -->
<!--             -->
<! [wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%2010.22.png)             -->
<!-- ============================================================ -->

### Script d'automatisation complet

**Fichier :** `start-sakila-INF1099.ps1`

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"

# Suppression du conteneur existant
docker rm -f -v INF1099-mysql 2>$null

# Démarrage du conteneur MySQL
docker run -d `
  --name INF1099-mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -p 3306:3306 `
  mysql:8.0

# Attente du démarrage de MySQL
Start-Sleep -Seconds 40

# Création de la base et de l'utilisateur
docker exec INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec INF1099-mysql mysql -u root -prootpass -e `
  "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
docker exec INF1099-mysql mysql -u root -prootpass -e `
  "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"

# Importation
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
  docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

# Vérification finale
docker exec INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

**Exécution :**

```powershell
.\start-sakila-INF1099.ps1
```

<!-- ============================================================ -->
<! [wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/2.MySQL/300150293/images/etape%2011.png)        -->
<!--                    -->
<!-- ============================================================ -->

---

## 🖥 Étape 11 — Connexion MySQL Workbench

| Paramètre | Valeur |
|-----------|--------|
| Host | `127.0.0.1` |
| Port | `3306` |
| Utilisateur | `etudiants` |
| Mot de passe | `etudiants_1` |
| Base de données | `sakila` |

<!-- ============================================================ -->
<!-- 📸 COLLE ICI : CAPTURE 12 — connexion MySQL Workbench        -->
<!-- ![Étape 11 Workbench](images/TON_FICHIER.png)                -->
<!-- ============================================================ -->

> ✅ Connexion graphique validée — MySQL Community Server **8.0.45**.

---

## 🎉 Résultat final

| Composant | Statut |
|-----------|--------|
| Podman installé (v5.8.0) | ✅ |
| Alias `docker` → `podman` | ✅ |
| Machine Podman (WSL2) | ✅ |
| Conteneur MySQL 8.0 | ✅ |
| Base `sakila` créée | ✅ |
| Utilisateur `etudiants` configuré | ✅ |
| Schéma + données importés | ✅ |
| Script `.ps1` automatisé | ✅ |
| Requêtes SQL exécutées | ✅ |
| Connexion Workbench validée | ✅ |

---

<div align="center">

**Salim Amir · INF1099 · Collège Boréal · 2026**

</div>
