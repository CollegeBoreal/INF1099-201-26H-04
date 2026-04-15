-- DQL.sql - DjaberBenyezza - 300146667

SELECT * FROM etudiants;
SELECT * FROM cours;

SELECT e.nom, e.prenom, c.titre AS cours
FROM inscriptions i
JOIN etudiants e ON e.id = i.etudiant_id
JOIN cours     c ON c.id = i.cours_id
ORDER BY e.nom;
