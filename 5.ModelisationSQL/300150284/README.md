# Système de Gestion d’une Salle de Sport

## Contexte du projet
Ce projet consiste à implémenter une base de données relationnelle permettant de gérer l’ensemble des activités d’une salle de sport. Le système couvre la gestion des membres, des abonnements, des coachs, des cours, des inscriptions et des paiements.

L’objectif est de garantir :

- la cohérence des données
- l’intégrité référentielle
- la traçabilité des inscriptions et paiements
- un accès sécurisé selon les rôles

## Environnement d’exécution

- SGBD : PostgreSQL
- Conteneurisation : Docker
- Interface d’exécution : PowerShell via psql
- Système : Windows

Le choix de PostgreSQL repose sur sa gestion robuste des contraintes, des transactions et des relations entre les tables.

## Organisation des fichiers

| Fichier   | Rôle |
|----------|------|
| DDL.sql  | Création de la structure (tables, clés, relations) |
| DML.sql  | Insertion des données de test |
| DQL.sql  | Requêtes d’exploitation des données |
| DCL.sql  | Gestion des rôles et des permissions |

## Structure fonctionnelle

La base de données repose sur plusieurs blocs logiques :

### 1. Gestion des utilisateurs
- Membres
- Coachs

### 2. Gestion des abonnements
- Types d’abonnement
- Abonnements des membres

### 3. Gestion des activités
- Salles
- Cours
- Inscriptions

### 4. Gestion administrative
- Paiements

Chaque entité est liée par des relations garantissant une navigation logique dans les données.

## Implémentation technique

### Création des tables (DDL)
Les tables ont été définies avec :

- des clés primaires (SERIAL)
- des clés étrangères (REFERENCES)
- des contraintes d’unicité
- des contraintes CHECK pour certains attributs

L’ordre de création respecte les dépendances entre les tables pour éviter les erreurs de références.

### Insertion des données (DML)
Chaque table contient au minimum 5 enregistrements. Les données sont insérées en respectant l’ordre hiérarchique :

1. Tables indépendantes (type_abonnement, coach, salle)
2. Tables liées (membre)
3. Tables métier (abonnement, cours, inscription)
4. Tables finales (paiement)

Cela garantit l’absence d’erreurs liées aux clés étrangères.

### Exploitation des données (DQL)
Les requêtes réalisées permettent :

- la consultation simple des tables
- les jointures multi-tables
- l’analyse des relations entre les entités
- les calculs statistiques (COUNT, SUM)
- le filtrage des données

Exemples de logique métier :

- afficher les membres inscrits à un cours
- afficher les cours donnés par un coach
- calculer le total payé par chaque membre
- consulter les abonnements actifs
- afficher les cours par salle

### Gestion des accès (DCL)
Trois rôles ont été définis pour simuler un environnement réel :

#### 1. Administrateur
- accès total à toutes les tables
- gestion complète du système

#### 2. Employé
- lecture et modification des membres, abonnements, inscriptions et paiements
- lecture des cours, salles et coachs

#### 3. Membre
- accès en lecture uniquement
- consultation des informations générales

Les permissions sont attribuées avec GRANT et appliquées également aux futures tables via ALTER DEFAULT PRIVILEGES.

## Exécution du projet

### Lancement du conteneur PostgreSQL
```powershell
docker run --name gym-postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 -e POSTGRES_DB=gym -p 5432:5432 -d postgres



