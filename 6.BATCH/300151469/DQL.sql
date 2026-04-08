-- DQL.sql
-- Auteure : Rabia BOUHALI | Matricule : 300151469
-- Requêtes de consultation TCF Canada

\c tcf_canada_300151469;

-- 1. Tous les candidats
SELECT * FROM candidat;

-- 2. Tous les lieux
SELECT * FROM lieu;

-- 3. Toutes les sessions avec leur lieu
SELECT
    s.id_session,
    s.date_session,
    s.heure_session,
    s.type_test,
    l.nom_lieu,
    l.adresse
FROM session s
JOIN lieu l ON s.id_lieu = l.id_lieu;

-- 4. Rendez-vous avec nom du candidat et date de session
SELECT
    r.id_rendezvous,
    c.nom,
    c.prenom,
    s.date_session,
    s.heure_session,
    r.statut
FROM rendezvous r
JOIN candidat c ON r.id_candidat = c.id_candidat
JOIN session  s ON r.id_session  = s.id_session;

-- 5. Paiements avec informations du candidat
SELECT
    p.id_paiement,
    p.montant,
    p.mode_paiement,
    p.date_paiement,
    c.nom,
    c.prenom
FROM paiement p
JOIN rendezvous r ON p.id_rendezvous = r.id_rendezvous
JOIN candidat   c ON r.id_candidat   = c.id_candidat;

-- 6. Rendez-vous confirmés uniquement
SELECT * FROM rendezvous WHERE statut = 'Confirme';
