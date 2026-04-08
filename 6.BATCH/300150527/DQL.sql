SELECT * FROM CompagnieAerienne;

SELECT a.modele, a.capacite, c.nom
FROM Avion a
JOIN CompagnieAerienne c ON a.id_compagnie = c.id_compagnie;

SELECT v.numero_vol, v.origine, v.destination, g.code_gate, r.code_runway
FROM Vol v
JOIN Gate g ON v.id_gate = g.id_gate
JOIN Runway r ON v.id_runway = r.id_runway;

SELECT p.nom, p.prenom, v.numero_vol
FROM Passager p
JOIN Reservation res ON p.id_passager = res.id_passager
JOIN Vol v ON res.id_vol = v.id_vol;

SELECT COUNT(*) FROM Passager;

SELECT numero_vol, origine, destination
FROM Vol
WHERE destination = 'Paris';

SELECT numero_vol, date_depart
FROM Vol
ORDER BY date_depart DESC;

SELECT i.description, v.numero_vol
FROM Incident i
JOIN Vol v ON i.id_vol = v.id_vol;

SELECT v.numero_vol, s.type_service, s.statut
FROM ServiceSol s
JOIN Vol v ON s.id_vol = v.id_vol;

SELECT modele, capacite
FROM Avion
WHERE capacite > 200;