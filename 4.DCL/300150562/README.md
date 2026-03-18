1. Description du projet

Ce projet implémente une base de données pour une boutique de maillots, permettant de gérer :

Les clients et leurs informations personnelles

Les adresses de livraison

Les maillots et leurs catégories

Les commandes et leurs lignes de commande

Les paiements associés aux commandes

Les livraisons et les livreurs

La structure de la base suit le diagramme Mermaid suivant :

erDiagram
    CLIENT ||--o{ ADRESSE : has
    CLIENT ||--o{ COMMANDE : places
    ADRESSE ||--o{ COMMANDE : "used for delivery"
    COMMANDE ||--o{ LIGNE_COMMANDE : contains
    COMMANDE ||--o{ PAIEMENT : has
    COMMANDE ||--o{ LIVRAISON : has
    MAILLOT ||--o{ LIGNE_COMMANDE : "ordered in"
    CATEGORIE_MAILLOT ||--o{ MAILLOT : contains
    LIVREUR ||--o{ LIVRAISON : performs
    PAIEMENT ||--o{ COMMANDE : "payment for"
2. Structure des tables (PostgreSQL)
CLIENT

ID_Client (PK)

Nom

Prénom

PostNom

Téléphone

Email

Mot_de_passe

ADRESSE

ID_Adresse (PK)

ID_Client (FK)

Numéro_rue, Rue, Ville, Province, Pays, Code_postal

Type_adresse

CATEGORIE_MAILLOT

ID_Categorie (PK)

Nom_catégorie

Description

MAILLOT

ID_Maillot (PK)

ID_Categorie (FK)

ID_Pays_origine

Nom_maillot, Description, Prix, Statut, Taille, Couleur, Marque, Saison

COMMANDE

ID_Commande (PK)

ID_Client (FK)

ID_Adresse_livraison (FK)

Date_commande, Statut_commande, Total_commande

LIGNE_COMMANDE

ID_Ligne (PK)

ID_Commande (FK)

ID_Maillot (FK)

Quantité, Prix_unitaire, Total_ligne

PAIEMENT

ID_Paiement (PK)

ID_Commande (FK)

Date_paiement, Montant, Mode_paiement, Statut_paiement, Référence_paiement

LIVREUR

ID_Livreur (PK)

Nom, Prénom, PostNom, Téléphone, Email, Statut_livreur

LIVRAISON

ID_Livraison (PK)

ID_Commande (FK)

ID_Livreur (FK)

Date_livraison, Statut_livraison, Frais_livraison, Date_expédition, Numéro_suivi

3. Scripts SQL inclus

DDL – Création des tables et relations

DML – Insertion de données exemples

DQL – Requêtes SELECT pour extraire des informations

DCL – Gestion des droits utilisateurs

4. Exemple de requêtes
-- Lister toutes les commandes d'un client
SELECT c.Nom, c.Prénom, co.ID_Commande, co.Date_commande, co.Total_commande
FROM CLIENT c
JOIN COMMANDE co ON c.ID_Client = co.ID_Client
WHERE c.ID_Client = 1;
-- Détails d'une commande
SELECT co.ID_Commande, lc.ID_Ligne, m.Nom_maillot, lc.Quantité, lc.Total_ligne, p.Montant, p.Mode_paiement
FROM COMMANDE co
JOIN LIGNE_COMMANDE lc ON co.ID_Commande = lc.ID_Commande
JOIN MAILLOT m ON lc.ID_Maillot = m.ID_Maillot
LEFT JOIN PAIEMENT p ON co.ID_Commande = p.ID_Commande
WHERE co.ID_Commande = 1;
5. Instructions d’installation

Installer PostgreSQL et pgAdmin

Créer une base de données, par ex. boutique_maillots

Exécuter le script DDL pour créer les tables

Exécuter le script DML pour insérer des données exemples

Tester les requêtes DQL avec pgAdmin ou psql

6. Gestion des utilisateurs (DCL)
-- Créer un utilisateur
CREATE USER utilisateur_app WITH PASSWORD 'MotDePasse123';

-- Donner les droits
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO utilisateur_app;
GRANT CREATE ON SCHEMA public TO utilisateur_app;

-- Retirer un droit exemple
REVOKE DELETE ON COMMANDE FROM utilisateur_app;
7. Contact / Auteur

Nom : Corneil Ekofo Wema

Email : corneilekofo003@gmail.com

