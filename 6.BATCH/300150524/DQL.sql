-- ==========================================
-- CarGoRent - DQL (Data Query Language)
-- Étudiant : Taki Eddine Choufa
-- Projet : Modélisation SQL CarGoRent
-- ==========================================

-- Vérification simple des tables
SELECT * FROM cargorent.client;
SELECT * FROM cargorent.categorie;
SELECT * FROM cargorent.agence;
SELECT * FROM cargorent.voiture;
SELECT * FROM cargorent.employe;
SELECT * FROM cargorent.reservation;
SELECT * FROM cargorent.contrat_location;
SELECT * FROM cargorent.paiement;

-- Requête A : réservations détaillées
SELECT
    r.id_reservation,
    c.nom,
    c.prenom,
    v.marque,
    v.modele,
    r.date_debut,
    r.date_fin,
    r.statut
FROM cargorent.reservation r
JOIN cargorent.client c ON r.id_client = c.id_client
JOIN cargorent.voiture v ON r.id_voiture = v.id_voiture
ORDER BY r.date_debut;

-- Requête B : paiements détaillés
SELECT
    p.id_paiement,
    p.montant,
    p.date_paiement,
    p.mode,
    c.nom,
    c.prenom
FROM cargorent.paiement p
JOIN cargorent.contrat_location cl ON p.id_contrat = cl.id_contrat
JOIN cargorent.reservation r ON cl.id_reservation = r.id_reservation
JOIN cargorent.client c ON r.id_client = c.id_client
ORDER BY p.date_paiement;

-- Requête C : voitures avec catégorie et agence
SELECT
    v.id_voiture,
    v.marque,
    v.modele,
    cat.nom AS categorie,
    a.nom AS agence,
    a.ville
FROM cargorent.voiture v
JOIN cargorent.categorie cat ON v.id_categorie = cat.id_categorie
JOIN cargorent.agence a ON v.id_agence = a.id_agence
ORDER BY v.id_voiture;
