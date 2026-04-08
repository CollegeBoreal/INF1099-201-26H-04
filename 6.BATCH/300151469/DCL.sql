-- DCL.sql
-- Auteure : Rabia BOUHALI | Matricule : 300151469
-- Gestion des permissions TCF Canada
 
\c tcf_canada_300151469;
 
CREATE USER etudiant300151469 WITH PASSWORD 'Password123!';
 
GRANT SELECT, INSERT, UPDATE
    ON candidat, lieu, session, rendezvous, paiement
    TO etudiant300151469;
 
GRANT USAGE, SELECT
    ON ALL SEQUENCES IN SCHEMA public
    TO etudiant300151469;
 
