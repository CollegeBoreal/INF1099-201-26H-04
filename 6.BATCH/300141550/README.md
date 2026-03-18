# 🧪 Laboratoire BATCH – Chargement automatisé PostgreSQL avec Docker

## 📌 Description

Ce projet consiste à automatiser le chargement d’une base de données PostgreSQL à l’aide d’un script PowerShell et de Docker.

La base de données est basée sur un système de gestion de commandes de plats (clients, commandes, paiements, livraisons, etc.).

---

## 🎯 Objectifs

* Comprendre les différents types de scripts SQL (DDL, DML, DCL, DQL)
* Utiliser Docker pour exécuter PostgreSQL
* Automatiser l’exécution de scripts SQL avec PowerShell
* Structurer une base de données relationnelle

---

## 📁 Structure du projet

```
📁 projet/
├── DDL.sql        # Création des tables
├── DML.sql        # Insertion des données
├── DCL.sql        # Gestion des permissions
├── DQL.sql        # Requêtes SQL
└── load-db.ps1    # Script PowerShell
```

---

## 🧱 Modèle de données

La base contient les principales entités suivantes :

* CLIENT
* ADRESSE
* COMMANDE
* LIGNE_COMMANDE
* PLAT
* CATEGORIE
* PAYS_ORIGINE
* PAIEMENT
* LIVRAISON
* LIVREUR

Ces tables sont liées par des clés étrangères pour assurer l’intégrité des données.

---

## 🐳 Lancement de PostgreSQL avec Docker

### Commande PowerShell

```bash
docker container run -d `
--name postgres-lab `
-e POSTGRES_PASSWORD=postgres `
-e POSTGRES_DB=ecole `
-p 5432:5432 `
postgres
```

### Vérification

```bash
docker container ls
```

---

## ⚙️ Exécution du script

```bash
pwsh ./load-db.ps1
```

---

## 🔄 Ordre d’exécution des scripts

1. DDL → création des tables
2. DML → insertion des données
3. DCL → gestion des accès
4. DQL → requêtes de vérification

---

## 📊 Résultats attendus

* Tables créées avec succès
* Données insérées correctement
* Utilisateur créé avec permissions
* Requêtes SQL fonctionnelles

---

## 🧾 Fichier de log

Un fichier `execution.log` est généré automatiquement :

* Contient les résultats des requêtes
* Permet de vérifier l’exécution du script
* Utile pour le débogage

---

## ⚠️ Gestion des erreurs

Le script inclut :

* Vérification de l’existence des fichiers SQL
* Vérification que le conteneur Docker est actif
* Arrêt automatique en cas d’erreur SQL

---

## ⏱️ Temps d’exécution

Le script affiche le temps total d’exécution à la fin.

---

## ✅ Conclusion

Ce laboratoire démontre :

* L’automatisation du déploiement d’une base de données
* L’utilisation combinée de Docker et PowerShell
* La gestion complète d’un cycle SQL (DDL, DML, DCL, DQL)

---

## 🚀 Améliorations possibles

* Ajouter des contraintes (CHECK, NOT NULL)
* Créer des index pour optimiser les performances
* Ajouter des vues (VIEW)
* Implémenter des triggers

---
