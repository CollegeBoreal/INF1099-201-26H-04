# 📚 Projet NoSQL avec PostgreSQL et JSONB

## 🎯 Objectif

Ce projet a pour objectif de manipuler des données de type NoSQL en utilisant PostgreSQL avec le format JSONB. L’objectif principal est d’effectuer des opérations CRUD (Create, Read, Update, Delete) sur des données structurées en JSON.

---

## ⚙️ Environnement utilisé

* Docker (conteneur PostgreSQL)
* PostgreSQL
* Python
* Bibliothèque `psycopg2-binary`

---

## 🐳 Mise en place de la base de données

Un conteneur Docker PostgreSQL a été créé avec les paramètres suivants :

* Base de données : `ecole`
* Utilisateur : `postgres`
* Mot de passe : `postgres`
* Port : `5432`

Un fichier `init.sql` a été utilisé pour initialiser la base de données automatiquement au démarrage du conteneur.

---

## 🗄️ Structure de la base

Une table `etudiants` a été créée avec les colonnes suivantes :

* `id` : identifiant unique (clé primaire)
* `data` : champ JSONB contenant les informations de l’étudiant

Un index de type GIN a été ajouté sur la colonne `data` pour optimiser les recherches dans le JSON.

---

## 📥 Insertion des données

Des étudiants ont été insérés dans la base de données sous forme de documents JSON. Chaque étudiant contient :

* un nom
* un âge
* une liste de compétences

---

## 🐍 Script Python

Un script Python (`app.py`) a été développé pour interagir avec la base de données à l’aide de la bibliothèque `psycopg2`.

Le script permet de :

### 🔹 Ajouter un étudiant

Insertion d’un nouvel étudiant avec des données JSON.

### 🔹 Lire les données

Affichage de tous les étudiants présents dans la base.

### 🔹 Rechercher des données

* Recherche par nom en utilisant l’opérateur `->>`
* Recherche par compétence en utilisant l’opérateur `->`

### 🔹 Mettre à jour des données JSON

Modification d’un champ spécifique (âge) dans le document JSON avec `jsonb_set`.

### 🔹 Supprimer un étudiant

Suppression d’un étudiant en fonction de son nom.

---

## 🧠 Notions importantes

### 🔸 JSONB

Le type JSONB permet de stocker des données JSON de manière optimisée dans PostgreSQL.

### 🔸 Opérateurs JSON

* `->` : permet d’accéder à un élément JSON
* `->>` : permet de récupérer la valeur sous forme de texte

---

## 📦 Gestion des dépendances

Un fichier `requirements.txt` a été utilisé pour installer la dépendance suivante :

```
psycopg2-binary
```

Installation avec la commande :

```
pip install -r requirements.txt
```

---

## ✅ Conclusion

Ce projet démontre l’utilisation de PostgreSQL comme base de données NoSQL grâce au support du JSONB. Il permet de manipuler des données flexibles tout en profitant de la puissance des requêtes SQL.

<img src="images/Capture d'écran 2026-04-15 105449.png" width="500"/>
<img src="images/Capture d'écran 2026-04-15 105550.png" width="500"/>
<img src="images/Capture d'écran 2026-04-15 110028.png" width="500"/>
<img src="images/Capture d'écran 2026-04-15 110430.png" width="500"/>
