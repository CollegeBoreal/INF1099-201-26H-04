# 📘 TP – Manipulation de données avec MySQL (Docker)
---

# 🎯 Objectif

* Utiliser MySQL avec Docker
* Importer la base Sakila
* Exécuter des requêtes SQL

---

# ⚙️ Environnement

* Windows 10/11
* Docker Desktop
* MySQL 8.0

---

# 🚀 Étapes du TP

## 1️⃣ Lancement du conteneur MySQL

```bash
docker run -d --name INF1099-mysql -e MYSQL_ROOT_PASSWORD=rootpass -p 3306:3306 mysql:8.0
```

📸 **Capture 1 – Conteneur MySQL en cours d’exécution**
<img width="997" height="365" alt="01" src="https://github.com/user-attachments/assets/a3065040-a051-4a28-8dec-10d500fa620f" />

👉 Insère ici ta capture (docker ps)

---

## 2️⃣ Vérification de la base Sakila

```sql
SHOW TABLES;
```

📸 **Capture 2 – Tables de la base Sakila**
<img width="722" height="939" alt="02" src="https://github.com/user-attachments/assets/59d981e9-6d16-4cc3-be9e-6e0c29eb5d19" />

👉 Insère ici ta capture (actor, film, customer…)

---

## 3️⃣ Requête SELECT *

```sql
SELECT * FROM actor;
```

📸 **Capture 3 – Résultat de SELECT ***
<img width="965" height="912" alt="03" src="https://github.com/user-attachments/assets/b16ebf2e-9e71-4704-95bd-6d925cd81273" />


👉 Insère ici ta capture (liste des acteurs)

---

## 4️⃣ Requête SELECT spécifique

```sql
SELECT first_name, last_name FROM actor;
```

📸 **Capture 4 – Affichage des noms et prénoms**
<img width="714" height="949" alt="04" src="https://github.com/user-attachments/assets/a4f26487-e66d-43fc-96c3-7e91d8d571e3" />


👉 Insère ici ta capture

---

## 5️⃣ Tri des données

```sql
SELECT * FROM actor
ORDER BY last_name ASC;
```

📸 **Capture 5 – Résultat trié (ORDER BY)**
<img width="1434" height="734" alt="05" src="https://github.com/user-attachments/assets/0a82e14f-e22d-43c5-ba81-d7e7f86639f4" />

👉 Insère ici ta capture

---

# ⚠️ Problèmes rencontrés

* Podman non fonctionnel → remplacé par Docker
* Erreurs de chemin → corrigées
* Accès utilisateur MySQL → corrigé

---

# ✅ Résultat

* ✔️ MySQL fonctionne avec Docker
* ✔️ Base Sakila importée
* ✔️ Requêtes SQL exécutées avec succès

---

# 📚 Conclusion

Ce TP m’a permis de :

* Comprendre l’utilisation de Docker avec MySQL
* Manipuler une base de données réelle
* Exécuter des requêtes SQL (SELECT, ORDER BY)

---

# 🏁 Fin du TP
