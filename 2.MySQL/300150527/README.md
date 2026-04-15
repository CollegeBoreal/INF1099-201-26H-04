<<<<<<< HEAD
# 🚀 **INF1099 – MySQL 8 avec Podman sur Windows**

---

# 🎯 **Objectif du projet**

Ce TP a pour objectif de :

* 🖥 Installer et configurer **Podman Desktop**
* 🔄 Utiliser un alias Docker avec Podman
* 🐳 Déployer un conteneur **MySQL 8.0**
* 🗄 Créer et importer la base de données **Sakila**
* ⚡ Automatiser le déploiement avec un script PowerShell
* 📊 Exécuter des requêtes SQL (SELECT, GROUP BY, JOIN)
* 🔗 Connecter MySQL avec **MySQL Workbench**

---

# 🛠 **1️⃣ Installation de Podman**

## 📥 Installation

```powershell
choco install podman-desktop -y
```

## ✅ Vérification

```powershell
podman --version
podman info
```

<img width="1366" height="728" alt="1" src="https://github.com/user-attachments/assets/9e6a8aa7-6e28-4926-9f38-0dfeca84f4b3" />

---

# 📁 **2️⃣ Création du dossier de travail**

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```

---

# 📦 **3️⃣ Extraction de la base Sakila**

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir
```

<img width="1366" height="265" alt="2" src="https://github.com/user-attachments/assets/cfbfafd7-0995-40b5-af77-bde1c4fcd371" />
----------------
<img width="781" height="83" alt="3" src="https://github.com/user-attachments/assets/85d3fdf2-d0e0-4f93-8796-fb6e85500856" />

---

# 🔄 **4️⃣ Configuration de l’alias Docker**

```powershell
Set-Alias docker podman
```

Pour le rendre permanent :

```powershell
notepad $PROFILE
```
------------
<img width="492" height="75" alt="4" src="https://github.com/user-attachments/assets/4686bdb0-8f2b-4a36-a34a-d67baa49e480" />

----

Ajouter :

```powershell
Set-Alias docker podman
```

---

# ⚙️ **5️⃣ Initialisation de la machine Podman**

```powershell
podman machine init
podman machine start
```

<img width="552" height="132" alt="5" src="https://github.com/user-attachments/assets/d61e148f-8cf0-49e7-933e-a6957d9e32c6" />

---

# 🐳 **6️⃣ Déploiement du conteneur MySQL 8**

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

Vérification :

```powershell
docker ps
```

<img width="985" height="218" alt="6" src="https://github.com/user-attachments/assets/119bad59-1a89-4df0-9404-81871ab87979" />

---

# 🗄 **7️⃣ Création de la base de données**

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
```

<img width="828" height="270" alt="7" src="https://github.com/user-attachments/assets/912e3147-db66-45a9-80d1-7d1fb5ac6ac8" />

---

# 👤 **8️⃣ Création de l’utilisateur**

```powershell
docker exec -it INF1099-mysql `
mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
```

```powershell
docker exec -it INF1099-mysql `
mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```

<img width="979" height="460" alt="8" src="https://github.com/user-attachments/assets/a88c2e47-d5ce-4f00-8aa2-5dd8b31ce917" />


---

# 📥 **9️⃣ Importation de Sakila**

## Import du schéma

```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

## Import des données

```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

<img width="646" height="178" alt="9" src="https://github.com/user-attachments/assets/9317ccdc-5420-45e7-8925-bc68d08f4595" />

-------------

Vérification :

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

<img width="931" height="506" alt="10" src="https://github.com/user-attachments/assets/a11e2bed-eb1e-48b6-9adf-ce65182375ca" />


---

# ⚡ **🔟 Script d’automatisation**

Fichier : `start-sakila-INF1099.ps1`

<img width="1366" height="381" alt="11" src="https://github.com/user-attachments/assets/1e5afe38-2b9d-4c3c-83b6-a84878f78032" />

------


```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"

docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"

Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

<img width="1353" height="534" alt="12" src="https://github.com/user-attachments/assets/c2a2b3e1-574a-4300-b61c-bc17b359d0ce" />

---

# 📊 **1️⃣1️⃣ Requêtes SQL réalisées**

```sql
SELECT rating, COUNT(*) AS total
FROM film
GROUP BY rating;
```

```sql
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;
```

<img width="1364" height="718" alt="13" src="https://github.com/user-attachments/assets/7db0419b-a01f-49f4-a562-9be3e53d5d32" />

---

# 🖥 **1️⃣2️⃣ Connexion MySQL Workbench**

* Host : 127.0.0.1  
* Port : 3306  
* Utilisateur : etudiants  
* Mot de passe : etudiants_1  
* Schéma : sakila  

Connexion réussie ✔

------

<img width="1366" height="727" alt="14" src="https://github.com/user-attachments/assets/7ec5ed44-62a7-4dbe-8c49-063c8e144996" />

------

<img width="1366" height="723" alt="15" src="https://github.com/user-attachments/assets/bd8692fa-5d88-4ac7-8d11-26f3df12f041" />

------

<img width="1366" height="727" alt="16" src="https://github.com/user-attachments/assets/501ee4d0-1f0d-466b-8f6c-5b776da51e5a" />

------

# 👤 **Auteur**

**Nom : Bouraoui Akrem**  
🎓 Programme : INF1099  
🏫 Collège Boréal  
📅 Année : 2026  

---

# 🎉 **Résultat final**

* ✅ Podman configuré
* ✅ MySQL 8 opérationnel
* ✅ Base Sakila importée
* ✅ Script automatisé
* ✅ Requêtes SQL fonctionnelles
* ✅ Connexion Workbench validée

=======
# 🚀 **INF1099 – MySQL 8 avec Podman sur Windows**

---

# 🎯 **Objectif du projet**

Ce TP a pour objectif de :

* 🖥 Installer et configurer **Podman Desktop**
* 🔄 Utiliser un alias Docker avec Podman
* 🐳 Déployer un conteneur **MySQL 8.0**
* 🗄 Créer et importer la base de données **Sakila**
* ⚡ Automatiser le déploiement avec un script PowerShell
* 📊 Exécuter des requêtes SQL (SELECT, GROUP BY, JOIN)
* 🔗 Connecter MySQL avec **MySQL Workbench**

---

# 🛠 **1️⃣ Installation de Podman**

## 📥 Installation

```powershell
choco install podman-desktop -y
```

## ✅ Vérification

```powershell
podman --version
podman info
```

<img width="1366" height="728" alt="1" src="https://github.com/user-attachments/assets/9e6a8aa7-6e28-4926-9f38-0dfeca84f4b3" />

---

# 📁 **2️⃣ Création du dossier de travail**

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
```

---

# 📦 **3️⃣ Extraction de la base Sakila**

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir
```

<img width="1366" height="265" alt="2" src="https://github.com/user-attachments/assets/cfbfafd7-0995-40b5-af77-bde1c4fcd371" />
----------------
<img width="781" height="83" alt="3" src="https://github.com/user-attachments/assets/85d3fdf2-d0e0-4f93-8796-fb6e85500856" />

---

# 🔄 **4️⃣ Configuration de l’alias Docker**

```powershell
Set-Alias docker podman
```

Pour le rendre permanent :

```powershell
notepad $PROFILE
```
------------
<img width="492" height="75" alt="4" src="https://github.com/user-attachments/assets/4686bdb0-8f2b-4a36-a34a-d67baa49e480" />

----

Ajouter :

```powershell
Set-Alias docker podman
```

---

# ⚙️ **5️⃣ Initialisation de la machine Podman**

```powershell
podman machine init
podman machine start
```

<img width="552" height="132" alt="5" src="https://github.com/user-attachments/assets/d61e148f-8cf0-49e7-933e-a6957d9e32c6" />

---

# 🐳 **6️⃣ Déploiement du conteneur MySQL 8**

```powershell
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

Vérification :

```powershell
docker ps
```

<img width="985" height="218" alt="6" src="https://github.com/user-attachments/assets/119bad59-1a89-4df0-9404-81871ab87979" />

---

# 🗄 **7️⃣ Création de la base de données**

```powershell
docker exec -it INF1099-mysql mysql -u root -p -e "CREATE DATABASE sakila;"
```

<img width="828" height="270" alt="7" src="https://github.com/user-attachments/assets/912e3147-db66-45a9-80d1-7d1fb5ac6ac8" />

---

# 👤 **8️⃣ Création de l’utilisateur**

```powershell
docker exec -it INF1099-mysql `
mysql -u root -prootpass -e "CREATE USER 'etudiants'@'localhost' IDENTIFIED BY 'etudiants_1';"
```

```powershell
docker exec -it INF1099-mysql `
mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"
```

<img width="979" height="460" alt="8" src="https://github.com/user-attachments/assets/a88c2e47-d5ce-4f00-8aa2-5dd8b31ce917" />


---

# 📥 **9️⃣ Importation de Sakila**

## Import du schéma

```powershell
Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

## Import des données

```powershell
Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
```

<img width="646" height="178" alt="9" src="https://github.com/user-attachments/assets/9317ccdc-5420-45e7-8925-bc68d08f4595" />

-------------

Vérification :

```powershell
docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

<img width="931" height="506" alt="10" src="https://github.com/user-attachments/assets/a11e2bed-eb1e-48b6-9adf-ce65182375ca" />


---

# ⚡ **🔟 Script d’automatisation**

Fichier : `start-sakila-INF1099.ps1`

<img width="1366" height="381" alt="11" src="https://github.com/user-attachments/assets/1e5afe38-2b9d-4c3c-83b6-a84878f78032" />

------


```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"

docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0

docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'localhost' WITH GRANT OPTION;"

Get-Content "$projectDir\sakila-db\sakila-schema.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

Get-Content "$projectDir\sakila-db\sakila-data.sql" |
docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila

docker exec -it INF1099-mysql mysql -u etudiants -petudiants_1 -e "USE sakila; SHOW TABLES;"
```

<img width="1353" height="534" alt="12" src="https://github.com/user-attachments/assets/c2a2b3e1-574a-4300-b61c-bc17b359d0ce" />

---

# 📊 **1️⃣1️⃣ Requêtes SQL réalisées**

```sql
SELECT rating, COUNT(*) AS total
FROM film
GROUP BY rating;
```

```sql
SELECT customer.first_name, customer.last_name, city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id;
```

<img width="1364" height="718" alt="13" src="https://github.com/user-attachments/assets/7db0419b-a01f-49f4-a562-9be3e53d5d32" />

---

# 🖥 **1️⃣2️⃣ Connexion MySQL Workbench**

* Host : 127.0.0.1  
* Port : 3306  
* Utilisateur : etudiants  
* Mot de passe : etudiants_1  
* Schéma : sakila  

Connexion réussie ✔

------

<img width="1366" height="727" alt="14" src="https://github.com/user-attachments/assets/7ec5ed44-62a7-4dbe-8c49-063c8e144996" />

------

<img width="1366" height="723" alt="15" src="https://github.com/user-attachments/assets/bd8692fa-5d88-4ac7-8d11-26f3df12f041" />

------

<img width="1366" height="727" alt="16" src="https://github.com/user-attachments/assets/501ee4d0-1f0d-466b-8f6c-5b776da51e5a" />

------

# 👤 **Auteur**

**Nom : Bouraoui Akrem**  
🎓 Programme : INF1099  
🏫 Collège Boréal  
📅 Année : 2026  

---

# 🎉 **Résultat final**

* ✅ Podman configuré
* ✅ MySQL 8 opérationnel
* ✅ Base Sakila importée
* ✅ Script automatisé
* ✅ Requêtes SQL fonctionnelles
* ✅ Connexion Workbench validée

>>>>>>> 0f43d13a6d857fb06ce0359fb8c617a37ec59a23
