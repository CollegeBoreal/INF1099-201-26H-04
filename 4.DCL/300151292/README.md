📦 🐘 TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)

🎯 Objectif du TP

Ce TP a pour objectif de comprendre la gestion des utilisateurs et des permissions dans PostgreSQL à l’aide des commandes DCL.


Nous avons appris à :

créer des utilisateurs
attribuer des permissions
tester les accès
retirer des permissions
supprimer des utilisateurs
🏋️ Présentation – BorealFit


BorealFit est une plateforme de réservation de séances de sport destinée aux étudiants.


Elle permet de :

réserver des séances
gérer les activités sportives
suivre les réservations
gérer les utilisateurs et les accès
🛠 Technologies utilisées
PowerShell
Docker / Podman
PostgreSQL 16
psql

1️⃣ Connexion à PostgreSQL
docker container exec --interactive --tty postgres bash
psql -U postgres

<img width="458" height="66" alt="1" src="https://github.com/user-attachments/assets/839458cd-489f-4040-a98d-e4ec694d5914" />



2️⃣ Création de la base de données
CREATE DATABASE borealfit;
\c borealfit

<img width="446" height="88" alt="2" src="https://github.com/user-attachments/assets/3c027cd8-d3a2-4c89-92f9-910a70cfc775" />



3️⃣ Création du schéma et de la table
CREATE SCHEMA tp_dcl;

CREATE TABLE tp_dcl.reservation (
    id SERIAL PRIMARY KEY,
    utilisateur_id INT,
    date_reservation DATE,
    statut_reservation VARCHAR(50)
);

\dt tp_dcl.*

<img width="407" height="206" alt="3" src="https://github.com/user-attachments/assets/f35852ad-f4ab-4ea6-8874-f6fcb965c58e" />



4️⃣ Création des utilisateurs
CREATE USER client_borealfit WITH PASSWORD 'client123';
CREATE USER gestionnaire_borealfit WITH PASSWORD 'gest123';

<img width="438" height="87" alt="4" src="https://github.com/user-attachments/assets/67e49845-324f-458a-a03a-54a4b5b46081" />



5️⃣ Attribution des permissions (base et schéma)
GRANT CONNECT ON DATABASE borealfit TO client_borealfit, gestionnaire_borealfit;
GRANT USAGE ON SCHEMA tp_dcl TO client_borealfit, gestionnaire_borealfit;

<img width="458" height="48" alt="5" src="https://github.com/user-attachments/assets/0d5626b5-b369-46a8-8a67-3cd07fea62de" />



6️⃣ Permissions sur la table
GRANT SELECT ON tp_dcl.reservation TO client_borealfit;

GRANT SELECT, INSERT, UPDATE, DELETE 
ON tp_dcl.reservation TO gestionnaire_borealfit;

GRANT USAGE, SELECT, UPDATE 
ON SEQUENCE tp_dcl.reservation_id_seq TO gestionnaire_borealfit;

<img width="453" height="76" alt="6" src="https://github.com/user-attachments/assets/764c985d-362e-450d-933a-1a8746a18fa2" />



7️⃣ Test avec client_borealfit
SELECT * FROM tp_dcl.reservation;

INSERT INTO tp_dcl.reservation(utilisateur_id, date_reservation, statut_reservation)
VALUES (1, '2026-04-14', 'confirmée');

Résultat : accès refusé pour INSERT
<img width="464" height="115" alt="7" src="https://github.com/user-attachments/assets/ac6fdea9-0e61-48e6-b1f3-ed0eb3c805e3" />


8️⃣ Test avec gestionnaire_borealfit
INSERT INTO tp_dcl.reservation(utilisateur_id, date_reservation, statut_reservation)
VALUES (1, '2026-04-14', 'confirmée');

UPDATE tp_dcl.reservation
SET statut_reservation = 'terminée'
WHERE id = 1;

SELECT * FROM tp_dcl.reservation;
<img width="473" height="157" alt="8" src="https://github.com/user-attachments/assets/2865b5d3-1487-455f-906c-b7ba16cd7092" />



9️⃣ Retrait d’une permission
REVOKE SELECT ON tp_dcl.reservation FROM client_borealfit;
<img width="467" height="68" alt="9" src="https://github.com/user-attachments/assets/d9f9ed2e-1c83-4150-b491-207e26f5f08c" />



🔟 Test après retrait
SELECT * FROM tp_dcl.reservation;

Résultat : accès refusé
<img width="471" height="73" alt="10" src="https://github.com/user-attachments/assets/360a2cf8-1864-4fae-ade0-66ea1250d5e2" />



1️⃣1️⃣ Suppression des permissions et utilisateurs
REVOKE CONNECT ON DATABASE borealfit FROM client_borealfit, gestionnaire_borealfit;

REVOKE USAGE ON SCHEMA tp_dcl FROM client_borealfit, gestionnaire_borealfit;

REVOKE SELECT, INSERT, UPDATE, DELETE 
ON tp_dcl.reservation FROM gestionnaire_borealfit;

REVOKE USAGE, SELECT, UPDATE 
ON SEQUENCE tp_dcl.reservation_id_seq FROM gestionnaire_borealfit;

DROP USER client_borealfit;
DROP USER gestionnaire_borealfit;

<img width="471" height="156" alt="11" src="https://github.com/user-attachments/assets/7889c287-9673-409c-9e31-3e7692ddf8ea" />



🧾 Conclusion

Dans ce TP, nous avons appris à gérer les utilisateurs et les permissions dans PostgreSQL.

Les commandes principales utilisées sont :

CREATE USER
GRANT
REVOKE
DROP USER

Ces commandes permettent de sécuriser l’accès aux données.

👤 Auteur

Nom : Kahil Amine

Numéro étudiant : 300151292

Cours : INF1099

Année : 2026
