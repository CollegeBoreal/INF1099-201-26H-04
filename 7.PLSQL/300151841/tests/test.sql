CALL ajouter_etudiant('Nadia', 23, 'nadia@email.com');

SELECT nombre_etudiants_par_age(18, 25);

CALL inscrire_etudiant_cours('alice@email.com', 'Bases de donnees');

SELECT * FROM etudiants;
SELECT * FROM cours;
SELECT * FROM inscriptions;
SELECT * FROM logs;