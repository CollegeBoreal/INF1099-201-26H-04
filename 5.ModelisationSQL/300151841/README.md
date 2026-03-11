🛠️ TP Modélisation SQL
Gestion de tournois e-sport

Cours : INF1099 – Bases de données
SGBD : PostgreSQL 16
Environnement : Docker / Podman
Schéma : esport
Auteur : Massinissa Mameri

🎯 Aperçu du projet

Ce projet consiste à concevoir et implémenter une base de données relationnelle permettant de gérer des tournois e-sport.

La base de données permet de gérer :

les jeux utilisés dans les compétitions

les tournois organisés

les matchs disputés

les équipes participantes

les joueurs

les scores des matchs

la composition des équipes

L’objectif du projet est d’appliquer les concepts de modélisation de bases de données, de normalisation, et de gestion des droits d’accès SQL.

📁 Structure du projet

Le projet est organisé de la façon suivante :

TP_SQL/
├── README.md
├── ddl.sql
├── dml.sql
├── dcl.sql
└── images/
    ├── 1_structure_projet.png
    ├── 2_creation_database.png
    ├── 3_creation_schema.png
    ├── 4_table_game.png
    ├── 5_verification_tables.png
    ├── 6_all_tables_created.png
    ├── 7_insert_data.png
    ├── 8_select_matches.png
    ├── 9_scores_matchs.png
    ├── 10_create_users.png
    ├── 11_grant_permissions.png
    ├── 12_test_player_user.png
    ├── 13_test_admin_user.png
    ├── 14_revoke_select.png

⚠️ Les scripts SQL doivent être exécutés dans cet ordre :

ddl.sql → dml.sql → dcl.sql
🔄 Normalisation
1️⃣ Première Forme Normale (1FN)

Toutes les données sont organisées dans des tables avec :

des attributs atomiques

aucune répétition de colonnes

une clé primaire unique par table

Exemples d’entités :

Game

Tournament

Match

Team

Player

2️⃣ Deuxième Forme Normale (2FN)

Les dépendances partielles sont éliminées en séparant les entités.

Relations principales :

Entité A	Relation	Entité B
Game	est utilisé dans	Tournament
Tournament	contient	Match
Match	implique	Team
Team	possède	Player
3️⃣ Troisième Forme Normale (3FN)

La structure finale supprime les dépendances transitives.

Les relations entre les tables sont assurées par des clés étrangères.

Tables finales du modèle :

Table	Description
game	Jeux e-sport
tournament	Tournois
match	Matchs
team	Équipes
player	Joueurs
match_team	Participation des équipes aux matchs
team_member	Composition des équipes
📊 Diagramme ER

Le diagramme ER représente les entités et les relations de la base de données.

Il permet de visualiser :

les tables

les clés primaires

les clés étrangères

les relations entre les entités

Le diagramme est disponible dans :

images/diagramme_er.png
🚀 Démarrage rapide
1️⃣ Entrer dans le conteneur PostgreSQL
podman exec -it postgres bash
2️⃣ Se connecter à PostgreSQL
psql -U postgres
3️⃣ Créer la base de données
CREATE DATABASE esport_tournament;
\c esport_tournament
4️⃣ Exécuter les scripts SQL
\i ddl.sql
\i dml.sql
\i dcl.sql
🏗️ DDL — Définition des structures

Le fichier ddl.sql contient la structure de la base de données.

Il inclut :

la création du schéma

la création des tables

les clés primaires

les clés étrangères

Exemple :

CREATE SCHEMA esport;

Tables créées :

game

tournament

match

team

player

match_team

team_member

📝 DML — Manipulation des données

Le fichier dml.sql contient les commandes permettant d'insérer et manipuler les données.

Opérations réalisées :

insertion des jeux

insertion des tournois

insertion des équipes

insertion des joueurs

insertion des matchs

insertion des scores

Exemple :

INSERT INTO esport.game (game_name)
VALUES ('League of Legends');
🔎 Requêtes SELECT

Exemple de requête pour afficher les matchs et leurs tournois :

SELECT
    m.match_id,
    t.tournament_name,
    m.round,
    m.match_datetime
FROM esport.match m
JOIN esport.tournament t
ON m.tournament_id = t.tournament_id;

Exemple pour afficher les scores :

SELECT
    m.match_id,
    t.team_name,
    mt.score
FROM esport.match_team mt
JOIN esport.match m ON mt.match_id = m.match_id
JOIN esport.team t ON mt.team_id = t.team_id;
🔐 DCL — Gestion des accès

Deux utilisateurs sont créés pour tester les permissions :

Utilisateur	Rôle
player_user	lecture seule
admin_user	accès complet
Création des utilisateurs
CREATE USER player_user WITH PASSWORD 'player123';
CREATE USER admin_user WITH PASSWORD 'admin123';
Attribution des permissions
GRANT CONNECT ON DATABASE esport_tournament TO player_user, admin_user;
GRANT USAGE ON SCHEMA esport TO player_user, admin_user;
Permissions des tables
GRANT SELECT ON ALL TABLES IN SCHEMA esport TO player_user;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA esport
TO admin_user;
Révocation d'un droit
REVOKE SELECT ON ALL TABLES IN SCHEMA esport FROM player_user;
📸 Captures d'écran

Le dossier images/ contient les preuves d'exécution du TP :

création de la base

création du schéma

création des tables

insertion des données

requêtes SELECT

gestion des utilisateurs

attribution et révocation des droits

Ces captures permettent de valider chaque étape du projet.

🎯 Conclusion

Ce projet a permis de mettre en pratique les concepts fondamentaux des bases de données relationnelles :

modélisation de données

normalisation

création de structures SQL

manipulation des données

gestion des permissions

L'utilisation de PostgreSQL dans un environnement Docker/Podman permet également de reproduire facilement l'environnement de travail et d'assurer la portabilité du projet.