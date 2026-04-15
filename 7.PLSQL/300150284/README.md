# 🐳📊 TP PostgreSQL — Fonctions, Procédures et Triggers

## 👤 Informations de l’étudiant

* **Nom :** Aroua Mohand Tahar
* **Numéro étudiant :** 300150284

---

## 📌 Contexte du TP

Ce travail pratique porte sur l’utilisation des **langages procéduraux en base de données**, plus précisément **PL/pgSQL** avec PostgreSQL.

L’objectif est d’ajouter de la **logique métier directement dans la base de données**, ce qui permet :

* ⚡ d’améliorer les performances
* 🔒 de sécuriser l’accès aux données
* 🔁 d’automatiser certaines opérations

---

## 🎯 Objectifs pédagogiques

Ce TP permet de :

* 📌 Comprendre la différence entre **fonction** et **procédure stockée**
* ⚙️ Créer des **procédures et fonctions en PL/pgSQL**
* 🔄 Utiliser des **triggers pour automatiser des actions**
* 🚨 Gérer les erreurs avec **RAISE EXCEPTION et RAISE NOTICE**
* 📊 Journaliser les actions dans une table de logs

---

## 🧩 Structure du projet

```
📁 TP/
│
├── 📁 init/
│   ├── 01-ddl.sql          → Création des tables
│   ├── 02-dml.sql          → Insertion des données
│   └── 03-programmation.sql → Fonctions, procédures et triggers
│
├── 📁 tests/
│   └── test.sql            → Tests du système
│
└── README.md              → Documentation du TP
```

---

## ⚙️ Implémentation technique

### 🗄️ 1. Création des tables (DDL)

Les tables suivantes ont été créées :

* 👨‍🎓 `etudiants` → stocke les étudiants
* 📝 `logs` → journalisation des actions
* 📚 `cours` → liste des cours
* 📌 `inscriptions` → lien entre étudiants et cours

Chaque table utilise :

* 🔑 clé primaire (SERIAL)
* 🔗 clés étrangères (REFERENCES)
* ⚠️ contraintes d’intégrité

---

### 🧪 2. Insertion des données (DML)

Des données de test ont été ajoutées :

* 👤 1 étudiant initial
* 📚 plusieurs cours

Cela permet de tester les procédures et les triggers.

---

### ⚙️ 3. Programmation PL/pgSQL

#### 🧠 Procédure : `ajouter_etudiant`

* ✔️ Vérifie que l’âge ≥ 18
* ✔️ Vérifie le format de l’email
* ✔️ Ajoute l’étudiant
* ✔️ Insère un log
* ✔️ Affiche un message avec `RAISE NOTICE`

---

#### 🔢 Fonction : `nombre_etudiants_par_age`

* 📊 Retourne le nombre d’étudiants dans une tranche d’âge
* 📌 Utilisée avec `SELECT`

---

#### 📌 Procédure : `inscrire_etudiant_cours`

* 🔍 Vérifie l’existence de l’étudiant
* 🔍 Vérifie l’existence du cours
* ⚠️ Empêche les doublons
* 📝 Ajoute l’inscription
* 📊 Enregistre un log

---

### 🔄 4. Triggers

#### 🚫 Trigger de validation

* Vérifie automatiquement :

  * âge ≥ 18
  * email valide

👉 empêche les insertions invalides

---

#### 📝 Trigger de log

* Enregistre automatiquement :

  * INSERT
  * UPDATE
  * DELETE

👉 assure la traçabilité des actions

---

### 🚨 5. Gestion des erreurs

Utilisation de :

* ❗ `RAISE EXCEPTION` → bloque l’exécution
* ℹ️ `RAISE NOTICE` → affiche un message

Cela permet :

* de détecter les erreurs
* d’améliorer le débogage

---

## 🐳 Exécution avec Docker

### ▶️ Lancer PostgreSQL

```powershell
docker run -d `
  --name tp_postgres `
  -e POSTGRES_USER=etudiant `
  -e POSTGRES_PASSWORD=etudiant `
  -e POSTGRES_DB=tpdb `
  -p 5432:5432 `
  -v ${PWD}/init:/docker-entrypoint-initdb.d `
  postgres:15
```

---

## 🧪 Exécution des tests

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

---

## 🔍 Résultats attendus

Après exécution :

* ✔️ insertion valide fonctionne
* ❌ insertion avec âge < 18 → erreur
* 📊 fonction retourne un nombre correct
* 📝 logs enregistrés automatiquement
* 🔄 triggers fonctionnent correctement

---

## ⚠️ Limites

* données fictives
* système simplifié
* pas d’interface graphique
* logique métier basique

---

## 🎯 Conclusion

Ce TP démontre l’importance des **langages procéduraux en base de données**.

Grâce à PL/pgSQL, il est possible de :

* ⚡ améliorer les performances
* 🔒 renforcer la sécurité
* 🔁 automatiser les traitements
* 📊 assurer la cohérence des données

👉 Le système réalisé est **fonctionnel, structuré et conforme aux bonnes pratiques**.

---

## 🚀 Améliorations possibles

* 📌 ajouter plus de validations
* 📊 améliorer les logs (OLD / NEW)
* 🔐 gérer des rôles utilisateurs
* ⚙️ ajouter des procédures plus complexes

---

✨ **Fin du TP**
