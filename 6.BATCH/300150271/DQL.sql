SELECT * FROM client;
SELECT * FROM immeuble;
SELECT * FROM appartement;
SELECT * FROM vente;

SELECT c.nom, i.adresse, a.num_appartement, v.date_vente
FROM vente v
JOIN client c ON v.id_client = c.id_client
JOIN appartement a ON v.id_appartement = a.id_appartement
JOIN immeuble i ON a.id_immeuble = i.id_immeuble;