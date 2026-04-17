-- =========================
-- 1. Requêtes simples
-- =========================

-- Liste des passagers
SELECT * FROM aeroport.Passager;

-- Liste des vols
SELECT * FROM aeroport.Vol;

-- Liste des avions
SELECT * FROM aeroport.Avion;


-- =========================
-- 2. Requêtes avec conditions
-- =========================

-- Vols au départ de Paris
SELECT * 
FROM aeroport.Vol
WHERE origine = 'Paris';

-- Réservations confirmées
SELECT * 
FROM aeroport.Reservation
WHERE statut = 'Confirmée';


-- =========================
-- 3. Jointures simples
-- =========================

-- Passagers avec leurs réservations
SELECT p.nom, p.prenom, r.id_reservation, r.statut
FROM aeroport.Passager p
JOIN aeroport.Reservation r 
ON p.id_passager = r.id_passager;

-- Vols avec avion utilisé
SELECT v.numero_vol, a.modele, a.capacite
FROM aeroport.Vol v
JOIN aeroport.Avion a 
ON v.id_avion = a.id_avion;


-- =========================
-- 4. Jointures avancées
-- =========================

-- Détails complets d’une réservation
SELECT 
    p.nom, 
    p.prenom, 
    v.numero_vol, 
    v.origine, 
    v.destination,
    r.statut
FROM aeroport.Reservation r
JOIN aeroport.Passager p ON r.id_passager = p.id_passager
JOIN aeroport.Vol v ON r.id_vol = v.id_vol;

-- Billets avec informations passager
SELECT 
    p.nom,
    p.prenom,
    b.numero_siege,
    b.classe
FROM aeroport.Billet b
JOIN aeroport.Reservation r ON b.id_reservation = r.id_reservation
JOIN aeroport.Passager p ON r.id_passager = p.id_passager;


-- =========================
-- 5. Requêtes avec plusieurs tables
-- =========================

-- Vol + Gate + Terminal
SELECT 
    v.numero_vol,
    g.code_gate,
    t.nom AS terminal
FROM aeroport.Vol v
JOIN aeroport.Gate g ON v.id_gate = g.id_gate
JOIN aeroport.Terminal t ON g.id_terminal = t.id_terminal;

-- Contrôle sécurité avec personnel
SELECT 
    p.nom AS passager,
    per.nom AS agent,
    cs.statut
FROM aeroport.ControleSecurite cs
JOIN aeroport.Passager p ON cs.id_passager = p.id_passager
JOIN aeroport.Personnel per ON cs.id_personnel = per.id_personnel;


-- =========================
-- 6. Agrégations (IMPORTANT)
-- =========================

-- Nombre de passagers
SELECT COUNT(*) AS total_passagers
FROM aeroport.Passager;

-- Nombre de vols par origine
SELECT origine, COUNT(*) AS nombre_vols
FROM aeroport.Vol
GROUP BY origine;

-- Capacité moyenne des avions
SELECT AVG(capacite) AS moyenne_capacite
FROM aeroport.Avion;


-- =========================
-- 7. Requêtes avancées (niveau professeur)
-- =========================

-- Vols avec incidents
SELECT 
    v.numero_vol,
    i.description,
    i.type_incident
FROM aeroport.Vol v
JOIN aeroport.Incident i ON v.id_vol = i.id_vol;

-- Avions ayant subi maintenance
SELECT 
    a.modele,
    m.type_intervention,
    m.cout
FROM aeroport.Avion a
JOIN aeroport.Maintenance m ON a.id_avion = m.id_avion;

-- Services au sol par vol
SELECT 
    v.numero_vol,
    s.type_service,
    s.statut
FROM aeroport.Vol v
JOIN aeroport.ServiceSol s ON v.id_vol = s.id_vol;