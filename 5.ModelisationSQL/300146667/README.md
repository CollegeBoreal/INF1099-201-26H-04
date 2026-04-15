# TP Modelisation SQL - DjaberBenyezza - 300146667

## Boutique de Reparation de Smartphones

## Structure du projet

5.Modelisation/300146667/
- README.md
- ddl.sql
- dml.sql
- dcl.sql
- images/

## Etape 1 : Connexion et creation de la base

docker container exec --interactive --tty postgres bash
psql -U postgres

CREATE DATABASE reparation_smartphones;
\c reparation_smartphones
CREATE SCHEMA boutique;

Resultat : CREATE DATABASE, CREATE SCHEMA

## Etape 2 : Creer les tables (DDL)

11 tables creees : Marque, Modele, Client, Adresse, Technicien, Appareil, Reparation, Piece_Rechange, Ligne_Reparation, Paiement, Garantie

Resultat : CREATE TABLE x11

## Etape 3 : Verifier les tables

\dt boutique.*

Resultat : 11 tables listees

## Etape 4 : Inserer des donnees (INSERT)

INSERT INTO boutique.Marque (Nom_Marque) VALUES ('Apple'), ('Samsung'), ('Google');

Resultat : INSERT x11

## Etape 5 : Lire les donnees (SELECT)

SELECT r.ID_Reparation, c.Nom AS Client, t.Nom AS Technicien
FROM boutique.Reparation r
JOIN boutique.Appareil a ON r.Num_IMEI = a.Num_IMEI
JOIN boutique.Client c ON a.ID_Client = c.ID_Client
JOIN boutique.Technicien t ON r.ID_Technicien = t.ID_Technicien;

Resultat : 2 lignes retournees

## Etape 6 : Modifier des donnees (UPDATE)

UPDATE boutique.Reparation SET Statut = 'Terminee' WHERE ID_Reparation = 1;

Resultat : UPDATE 1

## Etape 7 : Supprimer des donnees (DELETE)

DELETE FROM boutique.Garantie WHERE ID_Garantie = 2;

Resultat : DELETE 1

## Etape 8 : Creer les utilisateurs (DCL)

CREATE USER technicien_user WITH PASSWORD 'tech123';
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';

Resultat : CREATE ROLE x2

## Etape 9 : Donner les droits (GRANT)

GRANT CONNECT ON DATABASE reparation_smartphones TO technicien_user, gestionnaire_user;
GRANT USAGE ON SCHEMA boutique TO technicien_user, gestionnaire_user;
GRANT SELECT ON ALL TABLES IN SCHEMA boutique TO technicien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA boutique TO gestionnaire_user;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA boutique TO gestionnaire_user;

Resultat : GRANT x5

## Etape 10 : Tester technicien

SELECT * FROM boutique.Reparation;
INSERT INTO boutique.Marque (Nom_Marque) VALUES ('OnePlus');

Resultat : SELECT OK, INSERT permission denied

## Etape 11 : Tester gestionnaire

INSERT INTO boutique.Marque (Nom_Marque) VALUES ('OnePlus');
UPDATE boutique.Piece_Rechange SET Prix_Unitaire = 54.99 WHERE ID_Piece = 2;
SELECT * FROM boutique.Marque;

Resultat : INSERT 0 1, UPDATE 1, SELECT OK

## Etape 12 : Retirer des droits (REVOKE)

REVOKE SELECT ON ALL TABLES IN SCHEMA boutique FROM technicien_user;
SELECT * FROM boutique.Reparation;

Resultat : REVOKE OK, permission denied

## Etape 13 : Supprimer les utilisateurs (DROP USER)

DROP USER technicien_user;
DROP USER gestionnaire_user;

Resultat : ERROR role cannot be dropped because some objects depend on it
Mise à jour finale
