1. Description du projet

Ce projet consiste à concevoir et implémenter une base de données PostgreSQL permettant de gérer des étudiants.
Il inclut la création de la structure, l’insertion de données ainsi que l’utilisation de fonctionnalités avancées comme les procédures, fonctions et triggers.

L’ensemble a été réalisé dans un environnement Docker, permettant une exécution simple et reproductible.

🔹 2. Objectifs

Créer une base de données relationnelle
Manipuler les données avec SQL
Implémenter des éléments avancés en PL/pgSQL
Valider et sécuriser les données automatiquement
Tester le bon fonctionnement du système

🔹 3. Environnement technique

PostgreSQL
Docker
PowerShell
PL/pgSQL

🔹 4. Structure du projet

Le projet est organisé en deux parties principales :

init/
Contient les scripts de création et de programmation
tests/
Contient les scénarios de test

🔹 5. Réalisation

📌 Création de la base de données

Une base de données a été mise en place avec deux tables principales :

une table pour stocker les étudiants
une table pour enregistrer les logs des actions

📌 Manipulation des données

Des données de test ont été insérées afin de valider le fonctionnement du système.


📌 Programmation avancée

✔ Procédure stockée

Une procédure a été développée pour ajouter un étudiant avec :

validation de l’âge
validation du format de l’email
gestion des erreurs
affichage de messages informatifs

✔ Fonction

Une fonction permet de calculer le nombre total d’étudiants dans la base de données.

✔ Trigger de validation

Un trigger a été mis en place pour :

vérifier automatiquement l’âge avant insertion
empêcher l’ajout de données invalides

✔ Trigger de journalisation

Un second trigger permet :

d’enregistrer automatiquement les actions effectuées
d’assurer la traçabilité des opérations

🔹 6. Tests effectués

Plusieurs scénarios ont été testés :


✔ Insertion valide d’un étudiant

✔ Tentative d’insertion invalide (âge incorrect)

✔ Vérification du nombre d’étudiants

✔ Vérification des logs générés

Les résultats obtenus confirment le bon fonctionnement des validations et des mécanismes de gestion des erreurs.

🔹 7. Résultats

Les données sont correctement enregistrées
Les règles de validation sont respectées
Les erreurs sont détectées et gérées
Les actions sont automatiquement journalisées

🔹 8. Conclusion

Ce projet démontre l’utilisation complète de PostgreSQL, incluant :

la gestion des données
la programmation avec PL/pgSQL
la mise en place de contrôles automatiques

L’utilisation de Docker a permis de travailler dans un environnement stable et efficace.

<img src="images/Capture d'écran 2026-04-08 144519.png" width="600">
<img src="images/Capture d'écran 2026-04-08 145111.png" width="600">
<img src="images/Capture d'écran 2026-04-08 144505.png" width="600">
