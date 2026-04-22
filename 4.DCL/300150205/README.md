# 🔐 TP PostgreSQL — DCL (Data Control Language)

**Nom : Mazigh Bareche**
**Code étudiant : 300150271**
**Cours : INF1099 — Bases de données**
**Session : Hiver 2026**

---

## 🚀 Étapes du laboratoire

### Étape 0 : Connexion au container Docker

```bash
docker container exec --interactive --tty postgres bash
psql -U postgres
```

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 0](images/Screenshot_2026-04-22_153919.png)
<img width="586" height="133" alt="Screenshot 2026-04-22 153919" src="https://github.com/user-attachments/assets/871d0ab4-5a7f-4e62-adcd-1b99981519ff" />

</details>

---

### Étape 1 : Créer la base de données et le schéma

```sql
CREATE DATABASE cours;
\c cours
CREATE SCHEMA tp_dcl;
```

<details>
<summary>📋 Output attendu</summary>

```
CREATE DATABASE
You are now connected to database "cours" as user "postgres".
CREATE SCHEMA
```
</details>

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 1](images/Screenshot_2026-04-22_153929.png)
<img width="500" height="115" alt="Screenshot 2026-04-22 153929" src="https://github.com/user-attachments/assets/9e67cbd7-5c9d-4ff0-9243-0bc5e057304b" />

</details>

---

### Étape 2 : Créer la table

```sql
CREATE TABLE tp_dcl.etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT,
    moyenne NUMERIC
);
```

<details>
<summary>📋 Output attendu</summary>

```
CREATE TABLE
```
</details>

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 2](images/Screenshot_2026-04-22_153940.png)
<img width="324" height="114" alt="Screenshot 2026-04-22 153940" src="https://github.com/user-attachments/assets/c2c82cef-78e9-45c6-ae22-da485a157dea" />

</details>

---

### Étape 3 : Créer les utilisateurs

```sql
CREATE USER etudiant WITH PASSWORD 'etudiant123';
CREATE USER professeur WITH PASSWORD 'prof123';
```

<details>
<summary>📋 Output attendu</summary>

```
CREATE ROLE
CREATE ROLE
```
</details>

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 3](images/Screenshot_2026-04-22_153951.png)
<img width="471" height="75" alt="Screenshot 2026-04-22 153951" src="https://github.com/user-attachments/assets/68519308-0eb4-4770-9221-1a6743c110c7" />

</details>

---

### Étape 4 : Donner les droits (GRANT)

```sql
GRANT CONNECT ON DATABASE cours TO etudiant, professeur;
GRANT USAGE ON SCHEMA tp_dcl TO etudiant, professeur;
GRANT SELECT ON tp_dcl.etudiants TO etudiant;
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_dcl.etudiants TO professeur;
GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_dcl.etudiants_id_seq TO professeur;
```

<details>
<summary>📋 Output attendu</summary>

```
GRANT
GRANT
GRANT
GRANT
GRANT
```
</details>

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 4](images/Screenshot_2026-04-22_154002.png)
<img width="706" height="251" alt="Screenshot 2026-04-22 154002" src="https://github.com/user-attachments/assets/bf843d77-73e4-487e-b0d8-77478e6e378b" />

</details>

---

### Étape 5 : Tester les droits de l'étudiant

```bash
\q
psql -U etudiant -d cours
```

```sql
SELECT * FROM tp_dcl.etudiants;
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Patrick', 85);
```

<details>
<summary>📋 Output attendu</summary>

```
 id | nom | moyenne
----+-----+---------
(0 rows)

ERROR:  permission denied for table etudiants
```
</details>

---

### Étape 6 : Tester les droits du professeur

```bash
\q
psql -U professeur -d cours
```

```sql
INSERT INTO tp_dcl.etudiants(nom, moyenne) VALUES ('Khaled', 90);
UPDATE tp_dcl.etudiants SET moyenne=95 WHERE nom='Khaled';
SELECT * FROM tp_dcl.etudiants;
```

<details>
<summary>📋 Output attendu</summary>

```
INSERT 0 1
UPDATE 1
 id |  nom   | moyenne
----+--------+---------
  1 | Khaled |      95
(1 row)
```
</details>

---

### Étape 7 : Retirer des droits (REVOKE)

```bash
\q
psql -U postgres -d cours
```

```sql
REVOKE SELECT ON tp_dcl.etudiants FROM etudiant;
\c - etudiant
SELECT * FROM tp_dcl.etudiants;
```

<details>
<summary>📋 Output attendu</summary>

```
REVOKE
ERROR:  permission denied for table etudiants
```
</details>

---

### Étape 8 : Supprimer les utilisateurs (DROP USER)

```bash
\c - postgres
```

```sql
DROP USER etudiant;
DROP USER professeur;
```

<details>
<summary>📋 Output attendu</summary>

```
ERROR:  role "etudiant" cannot be dropped because some objects depend on it
ERROR:  role "professeur" cannot be dropped because some objects depend on it
```
</details>

---

## 🔑 Rappel : Hiérarchie des droits PostgreSQL

```
Cluster PostgreSQL
 ├── Base : cours
 │     └── Schéma : tp_dcl
 │           ├── Table : etudiants
 │           └── Séquence : etudiants_id_seq
 └── Utilisateurs : etudiant, professeur
```

> Pour qu'un utilisateur puisse accéder à une table, il faut **3 niveaux de droits** :
> 1. `GRANT CONNECT` sur la **base**
> 2. `GRANT USAGE` sur le **schéma**
> 3. `GRANT SELECT/INSERT/...` sur la **table**

---

## ✅ Conclusion

Ce TP m'a permis de :

- Comprendre le DCL (Data Control Language)
- Créer et gérer des utilisateurs PostgreSQL
- Attribuer et retirer des permissions
- Tester les droits avec différents utilisateurs

---

## 📌 Références

- https://www.postgresql.org/docs/current/sql-grant.html
- https://www.postgresql.org/docs/current/sql-revoke.html
