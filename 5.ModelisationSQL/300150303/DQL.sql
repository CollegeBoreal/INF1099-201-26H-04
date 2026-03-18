-- ============================================================
--  DQL.sql — Interrogation des données (Data Query Language)
--  Projet  : Gestion d'un Salon de Coiffure
--  SGBD    : PostgreSQL
--  Auteur  : Jesmina
-- ============================================================

-- ============================================================
--  1. REQUÊTES DE BASE (SELECT simple)
-- ============================================================

-- 1.1 Lister tous les clients
SELECT * FROM CLIENT ORDER BY Nom;

-- 1.2 Lister tous les services avec leur prix
SELECT Nom_service, Prix
FROM SERVICE
ORDER BY Prix DESC;

-- 1.3 Lister toutes les coiffeuses
SELECT Nom, Specialite FROM COIFFEUSE;

-- ============================================================
--  2. REQUÊTES AVEC JOINTURES (JOIN)
-- ============================================================

-- 2.1 Liste complete des rendez-vous avec tous les details
SELECT
    rv.id_rdv,
    rv.Date_rdv,
    rv.Heure_rdv,
    c.Nom         AS Client,
    c.Prenom,
    cf.Nom        AS Coiffeuse,
    s.Nom_service AS Service,
    s.Prix,
    m.Nom_modele  AS Modele
FROM RENDEZ_VOUS rv
JOIN CLIENT      c  ON c.id_client     = rv.id_client
JOIN COIFFEUSE   cf ON cf.id_coiffeuse = rv.id_coiffeuse
JOIN SERVICE     s  ON s.id_service    = rv.id_service
JOIN MODELE      m  ON m.id_modele     = rv.id_modele
ORDER BY rv.Date_rdv, rv.Heure_rdv;

-- 2.2 Rendez-vous avec informations de paiement
SELECT
    rv.id_rdv,
    rv.Date_rdv,
    c.Nom         AS Client,
    s.Nom_service,
    p.Montant,
    p.Mode_payement
FROM RENDEZ_VOUS rv
JOIN CLIENT    c ON c.id_client   = rv.id_client
JOIN SERVICE   s ON s.id_service  = rv.id_service
JOIN PAYEMENT  p ON p.id_rdv      = rv.id_rdv
ORDER BY rv.Date_rdv;

-- 2.3 Rendez-vous d'une coiffeuse specifique
SELECT
    rv.Date_rdv,
    rv.Heure_rdv,
    c.Nom AS Client,
    s.Nom_service
FROM RENDEZ_VOUS rv
JOIN CLIENT    c  ON c.id_client     = rv.id_client
JOIN SERVICE   s  ON s.id_service    = rv.id_service
JOIN COIFFEUSE cf ON cf.id_coiffeuse = rv.id_coiffeuse
WHERE cf.Nom = 'Beaumont'
ORDER BY rv.Date_rdv;

-- ============================================================
--  3. REQUÊTES D'AGRÉGATION (GROUP BY)
-- ============================================================

-- 3.1 Nombre de rendez-vous par client
SELECT
    c.Nom,
    c.Prenom,
    COUNT(rv.id_rdv) AS Nb_rendez_vous
FROM CLIENT c
LEFT JOIN RENDEZ_VOUS rv ON rv.id_client = c.id_client
GROUP BY c.id_client, c.Nom, c.Prenom
ORDER BY Nb_rendez_vous DESC;

-- 3.2 Chiffre d'affaires total par coiffeuse
SELECT
    cf.Nom         AS Coiffeuse,
    COUNT(rv.id_rdv)   AS Nb_rdv,
    SUM(p.Montant)     AS CA_total,
    AVG(p.Montant)     AS Panier_moyen
FROM COIFFEUSE cf
JOIN RENDEZ_VOUS rv ON rv.id_coiffeuse = cf.id_coiffeuse
JOIN PAYEMENT    p  ON p.id_rdv        = rv.id_rdv
GROUP BY cf.id_coiffeuse, cf.Nom
ORDER BY CA_total DESC;

-- 3.3 Services les plus demandes
SELECT
    s.Nom_service,
    COUNT(rv.id_rdv) AS Nb_reservations,
    SUM(p.Montant)   AS Revenus_total
FROM SERVICE s
JOIN RENDEZ_VOUS rv ON rv.id_service = s.id_service
JOIN PAYEMENT    p  ON p.id_rdv      = rv.id_rdv
GROUP BY s.id_service, s.Nom_service
ORDER BY Nb_reservations DESC;

-- 3.4 Total paye par client
SELECT
    c.Nom,
    c.Prenom,
    SUM(p.Montant) AS Total_paye
FROM CLIENT c
JOIN RENDEZ_VOUS rv ON rv.id_client = c.id_client
JOIN PAYEMENT    p  ON p.id_rdv     = rv.id_rdv
GROUP BY c.id_client, c.Nom, c.Prenom
ORDER BY Total_paye DESC;

-- ============================================================
--  4. REQUÊTES AVEC FILTRES (WHERE / HAVING)
-- ============================================================

-- 4.1 Rendez-vous dans une plage de dates
SELECT
    rv.Date_rdv,
    rv.Heure_rdv,
    c.Nom AS Client,
    s.Nom_service
FROM RENDEZ_VOUS rv
JOIN CLIENT  c ON c.id_client  = rv.id_client
JOIN SERVICE s ON s.id_service = rv.id_service
WHERE rv.Date_rdv BETWEEN '2025-11-10' AND '2025-11-14'
ORDER BY rv.Date_rdv;

-- 4.2 Clients ayant depense plus de 100$
SELECT
    c.Nom,
    c.Prenom,
    SUM(p.Montant) AS Total_paye
FROM CLIENT c
JOIN RENDEZ_VOUS rv ON rv.id_client = c.id_client
JOIN PAYEMENT    p  ON p.id_rdv     = rv.id_rdv
GROUP BY c.id_client, c.Nom, c.Prenom
HAVING SUM(p.Montant) > 100
ORDER BY Total_paye DESC;

-- 4.3 Paiements par carte seulement
SELECT
    p.id_payement,
    p.Date_payement,
    p.Montant,
    c.Nom AS Client
FROM PAYEMENT p
JOIN RENDEZ_VOUS rv ON rv.id_rdv    = p.id_rdv
JOIN CLIENT      c  ON c.id_client  = rv.id_client
WHERE p.Mode_payement = 'Carte'
ORDER BY p.Date_payement;

-- ============================================================
--  5. SOUS-REQUÊTES
-- ============================================================

-- 5.1 Clients qui n'ont jamais pris de rendez-vous
SELECT Nom, Prenom, Email
FROM CLIENT
WHERE id_client NOT IN (
    SELECT DISTINCT id_client FROM RENDEZ_VOUS
);

-- 5.2 Service le plus cher
SELECT Nom_service, Prix
FROM SERVICE
WHERE Prix = (SELECT MAX(Prix) FROM SERVICE);

-- 5.3 Rendez-vous avec un paiement superieur au prix moyen
SELECT
    rv.id_rdv,
    rv.Date_rdv,
    p.Montant
FROM RENDEZ_VOUS rv
JOIN PAYEMENT p ON p.id_rdv = rv.id_rdv
WHERE p.Montant > (SELECT AVG(Montant) FROM PAYEMENT)
ORDER BY p.Montant DESC;
