# 📚 TP – DCL (Data Control Language) – PostgreSQL avec Docker

**Nom :** Lounas Allouti  
**Cours :** INF1099  
**Session :** Hiver 2026  
**Base de données :** PostgreSQL (Docker)

---

##  Objectif du TP

Ce TP consiste à maîtriser les commandes DCL (Data Control Language) dans PostgreSQL :
- Créer des rôles (utilisateurs)
- Accorder des privilèges (`GRANT`)
- Retirer des privilèges (`REVOKE`)
- Tester les permissions
- Supprimer les rôles (`DROP USER`)
- Vérifier la gestion des droits dans PostgreSQL

---

---

##  Installation et configuration

###  1️⃣ Lancement de PostgreSQL avec Docker

Démarrer un conteneur PostgreSQL :

```bash
docker run --name postgres_tp -e POSTGRES_PASSWORD=admin -p 5432:5432 -d postgres
```

Vérifier que le conteneur est actif :

```bash
docker ps
```

<img width="932" height="71" alt="image" src="https://github.com/user-attachments/assets/7232a3a7-8736-4ac5-8661-e2996242c006" />


---

##  Étapes du TP

###  2️⃣ Connexion à PostgreSQL

Se connecter au conteneur PostgreSQL :

```bash
docker exec -it postgres_tp psql -U postgres
```



---

###  3️⃣ Création de la base et du schéma

Créer la base de données et le schéma :

```sql
CREATE DATABASE cours;
\c cours

CREATE SCHEMA tp_dcl;
```

<img width="962" height="165" alt="creation bd" src="https://github.com/user-attachments/assets/586cb363-fe51-44a5-a9d0-5a25c9112d8f" />


---

###  4️⃣ Création des utilisateurs

Créer les rôles `etudiant` et `professeur` :

```sql
CREATE USER etudiant WITH PASSWORD '1234';
CREATE USER professeur WITH PASSWORD '1234';
```

<img width="583" height="119" alt="Créer les utilisateurs" src="https://github.com/user-attachments/assets/e50a69e9-ef2f-4886-85b7-eceb94d8b657" />


---

### 📊 5️⃣ Création de la table

Créer la table `etudiants` dans le schéma `tp_dcl` :

```sql
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    moyenne DECIMAL(4,2)
);
```

<img width="656" height="205" alt="Accès à la base et au schéma" src="https://github.com/user-attachments/assets/dd0b673b-fd60-45b5-adbd-a1b8b014a92e" />


---

###  6️⃣ Attribution des privilèges (GRANT)

#### Privilèges pour l'étudiant (lecture seule)

```sql
GRANT USAGE ON SCHEMA tp_dcl TO etudiant;
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
```

#### Privilèges pour le professeur (tous les droits)

```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp_dcl TO professeur;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA tp_dcl TO professeur;
```

<img width="890" height="93" alt="Droits sur la séquence SERIAL" src="https://github.com/user-attachments/assets/23a07ddd-96f1-462f-810f-bb2c676fbc71" />




---

###  7️⃣ Retrait des privilèges (REVOKE)

Retirer les privilèges de lecture à l'étudiant :

```sql
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
```

<img width="917" height="285" alt="revok prof" src="https://github.com/user-attachments/assets/ff368be8-bbca-4147-8708-d70aaead8c1a" />


---

###  8️⃣ Test des permissions

Connexion avec l'utilisateur `etudiant` :

```bash
psql -U etudiant -d cours
```

Tentative de lecture de la table :

```sql
SELECT * FROM tp_dcl.etudiants;
```

**Résultat attendu :**

```
ERROR: permission denied for table etudiants
```

<img width="951" height="368" alt="test " src="https://github.com/user-attachments/assets/8dd523a3-ac70-461d-8b8e-3b97f3cc1d75" />

<img width="899" height="372" alt="test prof" src="https://github.com/user-attachments/assets/a287d600-ff8f-4bc3-af92-f335bdf5ab90" />



---

###  9️⃣ Suppression des utilisateurs

#### Révocation des privilèges avant suppression

Pour le professeur :

```sql
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA tp_dcl FROM professeur;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA tp_dcl FROM professeur;
REVOKE ALL PRIVILEGES ON SCHEMA tp_dcl FROM professeur;
```

Pour l'étudiant :

```sql
REVOKE ALL PRIVILEGES ON SCHEMA tp_dcl FROM etudiant;
REVOKE ALL PRIVILEGES ON DATABASE cours FROM etudiant;
```

#### Suppression des utilisateurs

```sql
DROP USER etudiant;
DROP USER professeur;
```

<img width="752" height="749" alt="image" src="https://github.com/user-attachments/assets/80fa552a-32d7-4520-8448-13d3732e2352" />


---


---

## ✅ Conclusion

Ce TP m'a permis de :

✔️ **Comprendre** la gestion des rôles dans PostgreSQL  
✔️ **Manipuler** les commandes `GRANT` et `REVOKE`  
✔️ **Vérifier** les permissions utilisateur  
✔️ **Gérer** les dépendances avant suppression d'un rôle  
✔️ **Utiliser** PostgreSQL dans un environnement Docker

---



---



**Lounas Allouti**  
Cours INF1099 - Hiver 2026
---
