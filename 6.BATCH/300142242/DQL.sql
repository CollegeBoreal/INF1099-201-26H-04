SELECT E.nom, C.titre 
FROM INSCRIPTION I
JOIN ETUDIANT E ON I.id_etudiant = E.id_etudiant
JOIN COURS C ON I.id_cours = C.id_cours;