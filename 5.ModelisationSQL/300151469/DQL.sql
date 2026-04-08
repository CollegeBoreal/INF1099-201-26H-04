USE tcf_canada_300151469;

-- 1. Afficher tous les candidats
SELECT * FROM candidat;

-- 2. Afficher tous les lieux
SELECT * FROM lieu;

-- 3. Afficher toutes les sessions
SELECT * FROM session;

-- 4. Afficher tous les rendez-vous
SELECT * FROM rendezvous;

-- 5. Afficher tous les paiements
SELECT * FROM paiement;

-- 6. Afficher les rendez-vous avec le nom du candidat et la date de session
SELECT 
    r.id_rendezvous,
    c.nom,
    c.prenom,
    s.date_session,
    s.heure_session,
    r.statut
FROM rendezvous r
JOIN candidat c ON r.id_candidat = c.id_candidat
JOIN session s ON r.id_session = s.id_session;

-- 7. Afficher les paiements avec les informations du candidat
SELECT
    p.id_paiement,
    p.montant,
    p.mode_paiement,
    p.date_paiement,
    c.nom,
    c.prenom
FROM paiement p
JOIN rendezvous r ON p.id_rendezvous = r.id_rendezvous
JOIN candidat c ON r.id_candidat = c.id_candidat;

-- 8. Afficher les sessions avec le lieu
SELECT
    s.id_session,
    s.date_session,
    s.heure_session,
    s.type_test,
    l.nom_lieu,
    l.adresse
FROM session s
JOIN lieu l ON s.id_lieu = l.id_lieu;

-- 9. Afficher les rendez-vous confirmés
SELECT *
FROM rendezvous
WHERE statut = 'Confirmé';
