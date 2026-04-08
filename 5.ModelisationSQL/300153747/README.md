README — Système de Transit de Véhicules (Montréal → Conakry)


🔹 1. Description

Ce projet vise à concevoir une base de données relationnelle pour gérer le transit de véhicules entre Montréal et Conakry.
Le système permet de suivre les clients, véhicules, expéditions, ports et transporteurs.


🔹 2. Modélisation

📌 Étapes
Analyse des besoins : identification des entités et règles d’affaires
Modélisation conceptuelle : diagramme Entité-Relation
Modélisation logique : transformation en tables relationnelles
Modélisation physique : implémentation sous PostgreSQL

📌 Entités principales
Client
Vehicule
Expedition
Port
Transporteur


🔹 3. Implémentation SQL

🧱 DDL (Structure)
CREATE TABLE Client (
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    telephone VARCHAR(20)
);

CREATE TABLE Vehicule (
    id_vehicule SERIAL PRIMARY KEY,
    marque VARCHAR(50),
    modele VARCHAR(50),
    annee INT,
    id_client INT,
    id_expedition INT
);


📥 DML (Manipulation)
INSERT INTO Client (nom, telephone)
VALUES ('Bah', '5141234567');

INSERT INTO Vehicule (marque, modele, annee, id_client, id_expedition)
VALUES ('Toyota', 'Corolla', 2018, 1, 1);


🔍 DQL (Requêtes)
SELECT * FROM Vehicule;

SELECT c.nom, v.marque, v.modele
FROM Client c
JOIN Vehicule v ON c.id_client = v.id_client;


🔐 DCL (Sécurité)
GRANT SELECT ON Vehicule TO utilisateur;
REVOKE DELETE ON Vehicule FROM utilisateur;


🔹 4. Bonnes pratiques
Normalisation (jusqu’à 3FN)
Utilisation de clés primaires et étrangères
Réduction de la redondance
Optimisation des requêtes


🔹 5. Conclusion

Cette base de données permet une gestion efficace du transit international de véhicules en garantissant :

la cohérence des données
la performance
la sécurité
