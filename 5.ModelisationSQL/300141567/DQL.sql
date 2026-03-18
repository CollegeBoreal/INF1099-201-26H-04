SELECT * FROM ticket;

SELECT t.titre, u.nom
FROM ticket t
JOIN utilisateur u ON t.id_utilisateur = u.id_utilisateur;

SELECT i.commentaire, te.nom
FROM intervention i
JOIN technicien te ON i.id_technicien = te.id_technicien;