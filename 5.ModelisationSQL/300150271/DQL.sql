-- SELECT simple
SELECT * FROM Client;

-- SELECT avec jointure
SELECT 
    c.Nom,
    a.NumAppartement,
    v.DateVente
FROM Vente v
JOIN Client c ON v.IdClient = c.IdClient
JOIN Appartement a ON v.IdAppartement = a.IdAppartement;
