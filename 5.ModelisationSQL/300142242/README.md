# Analyse et Modélisation - Projet Moodle (ID 300142242)

## 1. Analyse des besoins
* **Utilisateurs** : Administrateurs, Professeurs, Étudiants.
* **Règles d'affaires** :
    * Un étudiant peut s'inscrire à plusieurs cours par session.
    * Un professeur appartient à un seul département.
    * Chaque cours doit être rattaché à un professeur responsable.

## 2. Justification Technique
* **Modèle ER** : Choisi pour sa clarté dans la représentation des relations entités-attributs.
* **Normalisation (3FN)** : Appliquée pour minimiser le dédoublement de données et assurer l'intégrité.
* **Choix SGBD** : PostgreSQL a été sélectionné pour sa gestion des relations fortes et sa robustesse transactionnelle.

## 3. Plan d'Optimisation
Pour garantir la performance lors de la croissance des données, nous avons implémenté :
* Des index sur les clés étrangères et les colonnes de recherche (`nom`, `titre`).
* Une analyse de coût via la commande `EXPLAIN` pour les requêtes de moyennes de notes.
