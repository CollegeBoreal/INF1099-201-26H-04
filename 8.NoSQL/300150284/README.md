# 🧪🐘 TP NoSQL — PostgreSQL JSONB + Python

## 👤 Informations de l’étudiant

* **Nom :** Aroua Mohand Tahar
* **Numéro étudiant :** 300150284

---

## 📌 Contexte du TP

Ce travail pratique consiste à implémenter une **base de données NoSQL simulée** en utilisant PostgreSQL avec le type **JSONB**.

Contrairement aux bases relationnelles classiques, les données sont stockées sous forme de **documents JSON**, ce qui permet :

* 📦 une structure flexible
* ⚡ des requêtes rapides avec index GIN
* 🔄 une adaptation facile aux données semi-structurées

---

## 🎯 Objectifs pédagogiques

Ce TP permet de :

* 🐳 Déployer PostgreSQL avec Docker
* 🧠 Comprendre le concept NoSQL avec JSONB
* 🔎 Manipuler les données JSON en SQL
* 🐍 Interagir avec la base via Python
* 📦 Gérer les dépendances avec `requirements.txt`

---

## 🧱 Structure du projet

```text
📁 TP/
├── README.md
├── init.sql
├── app.py
├── requirements.txt
└── 📁 images/
```

---

## ⚙️ Implémentation technique

### 🗄️ 1. Base de données NoSQL (JSONB)

Une table unique a été créée :

* 📌 `etudiants`

  * `id` → clé primaire
  * `data` → champ JSONB

👉 Cela permet de stocker directement des objets JSON.

---

### 📊 2. Indexation

Un index **GIN** a été ajouté :

* ⚡ améliore les performances des recherches JSON
* 🔎 utile pour filtrer rapidement

---

### 🧪 3. Requêtes SQL NoSQL

Exemples réalisés :

* afficher tous les étudiants
* rechercher un étudiant par nom
* rechercher par compétence

---

### 🐍 4. Script Python

Le script Python permet :

* 🔗 connexion à PostgreSQL
* ➕ insertion d’un étudiant JSON
* 📊 affichage des données
* 🔎 recherche filtrée

---

## 🐳 Exécution avec Docker

```powershell
docker run --name postgres-nosql `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `
  -d postgres
```

---

## 🐍 Installation des dépendances

```bash
pip install -r requirements.txt
```

---

## ▶️ Exécution du script

```bash
python app.py
```

---

## 🔍 Résultats attendus

* ✔️ données JSON insérées
* ✔️ affichage de tous les étudiants
* ✔️ recherche par nom fonctionne
* ✔️ recherche par compétence fonctionne

---

## ⚠️ Limites

* base simplifiée
* pas d’interface graphique
* données statiques

---

## 🎯 Conclusion

Ce TP démontre que PostgreSQL peut être utilisé comme une **base NoSQL** grâce à JSONB.

Cela permet :

* ⚡ flexibilité des données
* 📦 stockage de documents
* 🔎 requêtes puissantes

👉 Une solution hybride entre SQL et NoSQL.

---

## 🚀 Améliorations possibles

* ✏️ update JSON
* ❌ suppression
* 🔎 requêtes plus complexes
* 🌐 API avec Python

---

✨ **Fin du TP**
