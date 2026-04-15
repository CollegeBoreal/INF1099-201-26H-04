SELECT c.Nom, v.DateVente
FROM Client c
JOIN Vente v ON c.IdClient = v.IdClient;
