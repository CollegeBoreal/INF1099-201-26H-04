-- Création d’un rôle pour consultation des données
CREATE ROLE agent_consultation LOGIN PASSWORD 'agent123';

-- Autoriser la connexion à la base
GRANT CONNECT ON DATABASE ecole TO agent_consultation;

-- Autoriser l'accès au schéma public
GRANT USAGE ON SCHEMA public TO agent_consultation;

-- Autoriser la lecture des tables principales
GRANT SELECT ON 
CompagnieAerienne,
Avion,
Vol,
Passager,
Reservation,
Billet,
Bagage,
Personnel,
ControleSecurite,
Maintenance,
Incident,
ServiceSol
TO agent_consultation;