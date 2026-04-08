# 🗄️ TP PostgreSQL — Stored Procedures
### Fonctions, Procédures Stockées et Triggers
> **Cours :** INF1099 · **Étudiant :** Massinissa Mameri

---

## 🎯 Objectifs du TP

| # | Objectif |
|---|----------|
| 1 | Comprendre la différence entre **fonction** et **procédure** |
| 2 | Créer et utiliser des **procédures** en PL/pgSQL |
| 3 | Créer et utiliser des **fonctions** |
| 4 | Utiliser les **triggers** pour automatiser des actions |
| 5 | Gérer les **erreurs** et les **validations** |

---

## 📁 Structure du Projet

```
300151841/
│
├── init/
│   ├── 01-ddl.sql          ← Structure des tables
│   ├── 02-dml.sql          ← Données initiales
│   └── 03-programmation.sql ← Procédures, fonctions, triggers
│
├── tests/
│   └── test.sql            ← Scénarios de test
│
├── images/                 ← Captures d'écran (voir section ci-dessous)
│
└── README.md
```

---

## 🖼️ Captures d'écran

### 📌 01 — Structure du projet
 

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/7.PLSQL/300151841/images/Screenshot%202026-04-08%20142647.png)

---

### 📌 02 — Fichiers SQL

 

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/7.PLSQL/300151841/images/Screenshot%202026-04-08%20142842.png)

---

### 📌 03 — PostgreSQL lancé avec Podman

 
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/7.PLSQL/300151841/images/psql%203.png)

---

### 📌 04 — Tables créées dans PostgreSQL

 

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/7.PLSQL/300151841/images/psql%205.png)

---

### 📌 05 — Tests exécutés

 
![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/7.PLSQL/300151841/images/psql%206.png)

---

 

## 🗂️ Concepts Utilisés

| Élément | Description | Exemple |
|---------|-------------|---------|
| `FUNCTION` | Retourne une valeur | `SELECT nombre_etudiants_par_age(18, 25);` |
| `PROCEDURE` | Exécute des actions | `CALL ajouter_etudiant('Ali', 22, 'ali@email.com');` |
| `TRIGGER` | Exécuté automatiquement | Sur `INSERT` / `UPDATE` / `DELETE` |

---

## 🐳 Lancer PostgreSQL avec Podman

```powershell
podman run -d `
  --name tp_postgres `
  -e POSTGRES_USER=etudiant `
  -e POSTGRES_PASSWORD=etudiant `
  -e POSTGRES_DB=tpdb `
  -p 5432:5432 `
  -v ${PWD}/init:/docker-entrypoint-initdb.d `
  postgres:15
```

---

## 📋 Description des Fichiers SQL

### 1️⃣ `01-ddl.sql` — Structure

Définit les tables de la base de données :

- `etudiants` — Informations sur les étudiants
- `cours` — Catalogue des cours disponibles
- `inscriptions` — Relations étudiant ↔ cours
- `logs` — Journal des actions automatiques

---

### 2️⃣ `02-dml.sql` — Données initiales

Insère les données de départ :

- **4 étudiants** de test
- **4 cours** disponibles

---

### 3️⃣ `03-programmation.sql` — PL/pgSQL

#### ✅ Procédure : `ajouter_etudiant`

- Vérifie que l'âge est **≥ 18**
- Vérifie que l'**email est valide** (format)
- Vérifie que l'**email est unique**
- Ajoute l'étudiant dans la base
- Génère un **log automatique**

#### ✅ Fonction : `nombre_etudiants_par_age`

- Retourne le **nombre d'étudiants** dans une tranche d'âge donnée

#### ✅ Procédure : `inscrire_etudiant_cours`

- Vérifie que l'**étudiant existe**
- Vérifie que le **cours existe**
- Vérifie l'**absence de doublon**
- Enregistre l'inscription
- Génère un **log automatique**

#### ✅ Trigger : Validation étudiant

- Vérifie automatiquement l'**âge** et le format de l'**email** à chaque insertion

#### ✅ Trigger : Journalisation (logs)

- Enregistre **toutes les actions** (`INSERT`, `UPDATE`, `DELETE`) dans la table `logs`

---

## 🧪 Exécution des Tests

```powershell
Get-Content .\tests\test.sql | podman exec -i tp_postgres psql -U etudiant -d tpdb
```

---

## 🔍 Vérification des Données

```sql
SELECT * FROM etudiants;
SELECT * FROM cours;
SELECT * FROM inscriptions;
SELECT * FROM logs ORDER BY date_action;
```

---

## ✅ Résultat Final

| Élément | Statut |
|---------|--------|
| Procédures | ✔ Fonctionnelles |
| Fonction | ✔ Fonctionnelle |
| Triggers | ✔ Fonctionnels |
| Logs automatiques | ✔ Générés correctement |

---

## 💡 Conclusion

Ce TP démontre l'utilisation de **PL/pgSQL** pour :

- Intégrer de la **logique métier** directement dans la base de données
- **Automatiser des actions** grâce aux triggers
- **Sécuriser et valider** les données en amont

> 👉 Un modèle de données simple a été volontairement choisi afin de se concentrer sur la **programmation procédurale** en PostgreSQL.
