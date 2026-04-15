# 🧪 TP PostgreSQL — NoSQL avec JSONB

## 👤 Informations de l’étudiant
- **Nom :** Adjaoud Hocine  
- **Numéro étudiant :** 300148450  

---

## 📌 Description du laboratoire

Ce laboratoire a pour objectif de mettre en œuvre un modèle NoSQL dans PostgreSQL en utilisant le type de données **JSONB**.

L’utilisation de JSONB permet de stocker des données semi-structurées tout en bénéficiant des performances et des fonctionnalités d’un SGBD relationnel.

---

## 🎯 Objectifs pédagogiques

- Comprendre le fonctionnement du JSONB dans PostgreSQL  
- Manipuler des données NoSQL dans une base relationnelle  
- Utiliser Docker pour déployer PostgreSQL  
- Développer un script Python pour interagir avec la base  
- Effectuer des opérations CRUD sur des données JSON  

---

## ⚙️ Environnement technique

- **SGBD :** PostgreSQL  
- **Type NoSQL :** JSONB  
- **Conteneurisation :** Docker  
- **Langage :** Python  
- **Bibliothèque :** psycopg2  

---

## 🚀 Lancement de PostgreSQL avec Docker

### Windows (PowerShell)

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

## 📄 Initialisation de la base

Le fichier `init.sql` permet de :

- créer la table `etudiants`
- ajouter un index GIN
- insérer des données JSON

---

## 📦 Installation des dépendances

```bash
pip install -r requirements.txt
```

---

## 🐍 Exécution du script Python

```bash
python app.py
```

---

## 🔍 Fonctionnalités implémentées

### 🔹 INSERT
Ajout d’un étudiant en format JSON

### 🔹 SELECT
Affichage de tous les étudiants

### 🔹 SEARCH
- recherche par nom  
- recherche par compétence  

### 🔹 UPDATE
Modification d’une valeur JSON (`age`)

### 🔹 DELETE
Suppression d’un étudiant

---

## 🧪 Requêtes SQL importantes

### Accéder à une clé JSON

```sql
data->>'nom'
```

### Accéder à un tableau

```sql
data->'competences'
```

### Recherche dans un tableau JSON

```sql
WHERE data->'competences' ? 'Python'
```

---

## 📁 Structure du projet

```text
300148450/
├── README.md
├── init.sql
├── app.py
├── requirements.txt
└── images/
```

---

## 📊 Résultats attendus

- affichage des étudiants  
- insertion réussie  
- recherche fonctionnelle  
- mise à jour correcte  
- suppression effective  

---

## 🧠 Analyse

Le JSONB permet de combiner :

- flexibilité du NoSQL  
- puissance du SQL  

Il est particulièrement utile pour :

- stocker des données dynamiques  
- éviter les schémas rigides  
- améliorer les performances avec les index GIN  

---

## 🚀 Améliorations possibles

- ajouter validation JSON  
- utiliser API Flask  
- sécuriser la connexion  
- gérer erreurs Python  

---

## 🧾 Conclusion

Ce TP démontre qu’il est possible d’utiliser PostgreSQL comme une base NoSQL grâce à JSONB.

Cette approche hybride est largement utilisée dans les applications modernes nécessitant flexibilité et performance.

---

## 📎 Remarque

Ce travail a été réalisé dans un cadre pédagogique afin de maîtriser les bases du NoSQL avec PostgreSQL et Python.
