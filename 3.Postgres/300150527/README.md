# **INF1099 – PostgreSQL avec Docker (Podman) et pgAdmin 4**

---

# **🎯 Objectif du TP**

Ce laboratoire a pour objectif de :

- Vérifier l’installation de Docker (via Podman Engine)
- Déployer un conteneur PostgreSQL
- Créer une base de données appdb
- Télécharger et importer la base de données Sakila
- Tester les tables avec psql
- Se connecter via pgAdmin 4
- Exécuter des requêtes SQL

---

# **1️⃣ Vérification de Docker**

## **Vérifier la version**

```powershell
docker version
```

## **Vérifier les informations système**

```powershell
docker info
```

-----

<img width="1366" height="730" alt="1" src="https://github.com/user-attachments/assets/7f26f70c-7da9-4af2-b420-5f79af85f80a" />

----

✔ Docker fonctionne avec Podman Engine  
✔ Architecture : amd64  
✔ API Version : 5.7.1  

---

# **2️⃣ Lancement du conteneur PostgreSQL**

```powershell
docker container run -d `
--name postgres `
-e POSTGRES_USER=postgres `
-e POSTGRES_PASSWORD=postgres `
-e POSTGRES_DB=appdb `
-p 5432:5432 `
-v pgdata:/var/lib/postgresql/data `
postgres:16
```

-----

<img width="839" height="337" alt="2" src="https://github.com/user-attachments/assets/001daf40-de1a-4164-a0d4-4aa07d25dcde" />


-----

# **3️⃣ Vérification du conteneur**

```powershell
docker container ls
```

----
<img width="1026" height="105" alt="3" src="https://github.com/user-attachments/assets/142e2328-9ead-41e5-91b4-9dffc2ce20be" />
----

✔ Le conteneur postgres est en état **Up**  
✔ Port exposé : 5432  

---

# **4️⃣ Vérification des logs**

```powershell
docker container logs postgres
```

Message important :

```
database system is ready to accept connections
```

-----

<img width="1350" height="554" alt="4" src="https://github.com/user-attachments/assets/15587d94-b3be-4ee7-a56f-3c66f5d27b61" />


✔ PostgreSQL est prêt

---

# **5️⃣ Création du dossier Sakila**

```powershell
mkdir sakila_pg
cd sakila_pg
```

-----

<img width="871" height="348" alt="5" src="https://github.com/user-attachments/assets/9eca4f15-204d-4a52-a617-e5a2f7424bed" />

---

# **6️⃣ Téléchargement des fichiers Sakila**

```powershell
Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `
-OutFile postgres-sakila-schema.sql

Invoke-WebRequest `
https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `
-OutFile postgres-sakila-insert-data.sql
```

Vérification :

```powershell
dir
```

-----
<img width="1083" height="423" alt="6" src="https://github.com/user-attachments/assets/2745d846-bdca-41ef-adaf-d050b89b93ed" />


✔ Les deux fichiers sont présents

---

# **7️⃣ Copier les fichiers dans le conteneur**

```powershell
docker container cp .\postgres-sakila-schema.sql postgres:/schema.sql
docker container cp .\postgres-sakila-insert-data.sql postgres:/data.sql
```

<img width="827" height="106" alt="8" src="https://github.com/user-attachments/assets/751bfd11-f734-4a11-9e87-9d2662c4117e" />

---

# **8️⃣ Importer le schéma**

```powershell
docker container exec -it postgres psql -U postgres -d appdb -f /schema.sql
```

<img width="812" height="425" alt="9" src="https://github.com/user-attachments/assets/fda2939e-c89f-48c3-a418-06fa2b581634" />


✔ Création des tables réussie

---

# **9️⃣ Importer les données**

```powershell
docker container exec -it postgres psql -U postgres -d appdb -f /data.sql
```

<img width="875" height="371" alt="10" src="https://github.com/user-attachments/assets/84c59c7d-54df-4b36-8fbe-d2443393da96" />


✔ Données insérées avec succès

---

# **🔟 Vérification avec psql**

Connexion interactive :

```powershell
docker container exec -it postgres psql -U postgres -d appdb
```

Lister les tables :

```sql
\dt
```

<img width="830" height="595" alt="11" src="https://github.com/user-attachments/assets/5314c925-1dfc-4535-92b2-6762eef9dc96" />


✔ 21 tables créées

---

# **1️⃣1️⃣ Requêtes de vérification**

## Compter les films

```sql
SELECT COUNT(*) FROM film;
```

Résultat :

- 1000 films

## Compter les acteurs

```sql
SELECT COUNT(*) FROM actor;
```

Résultat :

- 200 acteurs

---

<img width="993" height="290" alt="12" src="https://github.com/user-attachments/assets/8d7c5cf5-08f8-482d-adfb-d7dafea909da" />


---

# **1️⃣2️⃣ Installation de pgAdmin 4**

```powershell
choco install pgadmin4 -y
```

<img width="1366" height="531" alt="12 1" src="https://github.com/user-attachments/assets/1b76d9f7-3249-4386-8bc8-9ddd63610437" />
----
<img width="1366" height="768" alt="13" src="https://github.com/user-attachments/assets/44a7afbf-3afc-40ab-aed9-0b2e04c71c00" />


✔ Installation réussie

---

# **1️⃣3️⃣ Configuration du serveur dans pgAdmin**

## General

- Name : Postgres Docker

## Connection

- Host : localhost
- Port : 5432
- Database : appdb
- Username : postgres
- Password : postgres

-------
<img width="951" height="77" alt="15 1" src="https://github.com/user-attachments/assets/7d7bb56e-9512-4c42-9887-509cd199c84a" />
-------
<img width="1366" height="729" alt="14" src="https://github.com/user-attachments/assets/3b00312a-b0a6-4e79-b827-6edeb95a3e55" />
-------
<img width="1365" height="728" alt="15" src="https://github.com/user-attachments/assets/5e66b944-64d1-4b6b-9240-4e1bb088c774" />
-------
<img width="1366" height="727" alt="16" src="https://github.com/user-attachments/assets/0553ee37-445d-4a00-93fc-29d72047ea88" />

-------------------

✔ Connexion réussie

---

# **1️⃣4️⃣ Vérification des tables dans pgAdmin**

Chemin :

- Servers
- Postgres Docker
- Databases
- appdb
- Schemas
- public
- Tables

✔ Les 21 tables sont visibles
-----
<img width="1366" height="730" alt="18" src="https://github.com/user-attachments/assets/ff021fe8-938e-4c03-af52-d4d41d9ee12a" />
-----

# **1️⃣5️⃣ Exécution de requêtes SQL dans pgAdmin**

## Lister les films contenant "Star"

```sql
SELECT title
FROM film
WHERE title ILIKE '%Star%';
```

Résultat :

- STAR OPERATION
- TURN STAR

-----

<img width="1366" height="729" alt="19" src="https://github.com/user-attachments/assets/2423a8c3-e4ba-4eff-bd30-99b32232b8c8" />
----

<img width="1366" height="728" alt="20" src="https://github.com/user-attachments/assets/ff67a7f0-ec8e-4ab7-b4e2-2611495bacea" />

---

# **✅ Conclusion**

Dans ce TP nous avons :

- Déployé PostgreSQL avec Docker (Podman)
- Importé la base de données Sakila
- Vérifié les tables avec psql
- Installé et configuré pgAdmin 4
- Exécuté des requêtes SQL avec succès

✔ Le système fonctionne correctement  
✔ La base contient 1000 films et 200 acteurs  

---

# **🚀 TP Réussi**

------

# 👤 **Auteur**

**Nom : Bouraoui Akrem**  
🎓 Programme : INF1099  
🏫 Collège Boréal  
📅 Année : 2026  

