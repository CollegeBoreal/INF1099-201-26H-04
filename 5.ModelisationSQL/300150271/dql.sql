SELECT * FROM Client;
SELECT * FROM Immeuble;
SELECT * FROM Appartement;
SELECT * FROM Vente;

SELECT c.Nom, v.DateVente
FROM Client c
JOIN Vente v ON c.IdClient = v.IdClient;