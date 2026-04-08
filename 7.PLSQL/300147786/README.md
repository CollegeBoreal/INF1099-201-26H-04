# 🐘 PL/pgSQL — Procédures, Fonctions & Triggers

Démonstration de PL/pgSQL avec PostgreSQL via Podman : tables, données, procédures stockées, fonctions et triggers.

---

## 📁 Structure
📁 /
├── tests/
│   ├── 01-ddl.sql
│   ├── 02-dml.sql
│   └── 03-programmation.sql

---

## 🚀 Démarrage rapide

**Se connecter à la base :**

```powershell
podman exec -it tp_postgres psql -U etudiant -d tpdb
```

**Charger les scripts dans l'ordre :**

```sql
\i /tests/01-ddl.sql
\i /tests/02-dml.sql
\i /tests/03-programmation.sql
```

---

## ✅ Résultats
<img width="1330" height="377" alt="PLSQL" src="https://github.com/user-attachments/assets/344ece92-5472-4a48-85e1-093266b6bebd" />


**DML — Insertion de 10 étudiants**
---

## 🔍 Vérifications

**Table `etudiants` — 10 enregistrements**

```sql
SELECT * FROM etudiants;
```
<img width="829" height="440" alt="PLSQL2026" src="https://github.com/user-attachments/assets/53a9ac8e-ecea-46a5-b032-f17fdc2cc164" />


**Table `logs` — Trigger actif à chaque INSERT**

```sql
SELECT * FROM logs;
```

Chaque insertion dans `etudiants` génère automatiquement une entrée dans `logs` grâce au trigger.

---
<img width="816" height="401" alt="PLSQL2027" src="https://github.com/user-attachments/assets/9ba19abb-df39-4725-b672-e0ad2ca5cfb1" />

```sql

SELECT COUNT(*) FROM etudiants;  -- 10
```
<img width="563" height="200" alt="PLSQL2028" src="https://github.com/user-attachments/assets/8c1b34cc-aaec-4977-85d8-f127ad6ed471" />


## 🔧 Technologies

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Podman-892CA0?style=for-the-badge&logo=podman&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)
