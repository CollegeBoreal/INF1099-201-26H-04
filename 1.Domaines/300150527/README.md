**📘 Projet Base de Données**
**Système de gestion d’un aéroport**

# 🧾 1. Présentation du projet :

Ce projet consiste à concevoir et implémenter une base de données relationnelle permettant la gestion complète des activités d’un aéroport.
La base de données couvre plusieurs aspects essentiels tels que :

- Les compagnies aériennes et leurs avions
- Les vols, pistes (runways) et portes d’embarquement (gates)
- Les passagers, réservations, billets et bagages
- Le personnel, la sécurité, la maintenance et les incidents
- Les services au sol

Le projet a été réalisé en respectant les règles de normalisation (1NF, 2NF, 3NF) afin d’assurer la cohérence, l’intégrité et l’absence de redondance des données.

# 🎯 2. Objectifs du projet :

- Concevoir une base de données structurée et normalisée
- Appliquer correctement les formes normales (1NF, 2NF, 3NF)
- Modéliser les relations entre les différentes entités de l’aéroport
- Garantir l’intégrité référentielle à l’aide des clés primaires et étrangères
- Fournir un diagramme entité–relation (ER) clair et fidèle au schéma SQL

# 🗂️ 3. Structure de la base de données :

La base de données boreal_aeroport est composée des tables suivantes :

- CompagnieAerienne
- Avion
- Terminal
- Gate
- Runway
- Vol
- Passager
- Reservation
- Billet
- Bagage
- Personnel
- ControleSecurite
- Maintenance
- Incident
- ServiceSol

Chaque table possède une clé primaire (ID) et certaines contiennent des clés étrangères permettant de relier les entités entre elles.

# 🧩 4. Normalisation des données :

# 🔹 Première Forme Normale (1NF) :

- Toutes les tables possèdent des attributs atomiques
- Absence de groupes répétitifs
- Chaque table est identifiée par une clé primaire

# 🔹 Deuxième Forme Normale (2NF) :

- La base est en 1NF
- Toutes les dépendances fonctionnelles sont complètes
- Aucune dépendance partielle (clés primaires simples)

# 🔹 Troisième Forme Normale (3NF) :

- La base est en 2NF
- Absence de dépendances transitives
- Les informations sont réparties dans des tables distinctes sans redondance

# 🔗 5. Relations entre les entités :

Les relations entre les tables sont assurées par des clés étrangères, par exemple :

Une compagnie aérienne possède plusieurs avions

Un vol utilise un avion, une porte et une piste

Un passager peut effectuer plusieurs réservations

Une réservation génère un billet

Un avion peut subir plusieurs maintenances

Ces relations sont représentées graphiquement dans le diagramme ER.

-----------------------------------------

# 📊 6. Diagramme Entité–Relation (ER) :

<img width="8192" height="6132" alt="diagramme1" src="https://github.com/user-attachments/assets/60b9a2a5-7b7b-42ae-b52c-5f7deabc9db7" />

Un diagramme ER a été généré à l’aide de Mermaid, à partir du schéma SQL.
Il représente fidèlement :

- Les entités (tables)

- Les attributs

- Les clés primaires (PK)

- Les clés étrangères (FK)

- Les cardinalités entre les entités

<img width="1384" height="1183" alt="diagramme2" src="https://github.com/user-attachments/assets/d87e69a6-2a84-42e1-8634-54a8869c5345" />

---------------------

<img width="3049" height="1953" alt="diagramme3" src="https://github.com/user-attachments/assets/db47cf3e-485f-49f1-9c84-c3f0adb5391e" />


-------------------------------------------------

# 🛠️ 7. Technologies utilisées :

- MySQL / SQL : création et gestion de la base de données

- Mermaid : génération du diagramme entité–relation

--------------------------------------

#  8. Conclusion :

Ce projet permet de démontrer une bonne maîtrise, de la modélisation des bases de données, des formes normales
des relations entre entités, et de la traduction d’un besoin réel (gestion d’un aéroport) en une base de données 
fonctionnelle et cohérente.

La base de données est prête à être utilisée comme fondation pour une application de gestion aéroportuaire.

# 📌 Auteur :
**Bouraoui Akrem - 300150527**
**📚 Matière : Base de données**
**🏫 Projet académique**


