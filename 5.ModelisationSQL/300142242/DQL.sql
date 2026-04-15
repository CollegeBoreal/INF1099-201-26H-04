-- ============================================================
--  DQL.sql — Interrogation des données (Data Query Language)
--  Projet  : Gestion Scolaire (Moodle)
-- ============================================================

-- ============================================================
--  1. REQUÊTES DE BASE (SELECT simple)
-- ============================================================
SELECT * FROM ETUDIANT ORDER BY nom;
SELECT titre, credits FROM COURS ORDER BY titre;

-- ============================================================
--  2. REQUÊTES AVEC JOINTURES (JOIN)
-- ============================================================
-- 2.1 Relevé de notes complet par étudiant
SELECT E.nom, E.prenom, C.titre, D.note_finale, S.nom_session
FROM ETUDIANT E
JOIN INSCRIPTION I ON E.id_etudiant = I.id_etudiant
JOIN SESSION_SCOLAIRE S ON I.id_session = S.id_session
JOIN DETAIL_INSCRIPTION D ON I.id_inscription = D.id_inscription
JOIN COURS C ON D.id_cours = C.id_cours
ORDER BY E.nom, C.titre;

-- 2.2 Professeurs et leurs départements
SELECT P.nom, P.prenom, DEP.nom_departement
FROM PROFESSEUR P
JOIN DEPARTEMENT DEP ON P.id_departement = DEP.id_departement;

-- ============================================================
--  3. REQUÊTES D'AGRÉGATION (GROUP BY)
-- ============================================================
-- 3.1 Moyenne des notes par cours
SELECT C.titre, AVG(D.note_finale) AS moyenne_classe, COUNT(D.id_detail) AS nb_etudiants
FROM COURS C
JOIN DETAIL_INSCRIPTION D ON C.id_cours = D.id_cours
GROUP BY C.titre
ORDER BY moyenne_classe DESC;

-- ============================================================
--  4. REQUÊTES AVEC FILTRES (WHERE / HAVING)
-- ============================================================
-- 4.1 Étudiants ayant une note supérieure à 80
SELECT E.nom, C.titre, D.note_finale
FROM ETUDIANT E
JOIN INSCRIPTION I ON E.id_etudiant = I.id_etudiant
JOIN DETAIL_INSCRIPTION D ON I.id_inscription = D.id_inscription
JOIN COURS C ON D.id_cours = C.id_cours
WHERE D.note_finale > 80;

-- ============================================================
--  5. SOUS-REQUÊTES
-- ============================================================
-- 5.1 Étudiants sans inscription
SELECT nom, prenom, email
FROM ETUDIANT
WHERE id_etudiant NOT IN (SELECT DISTINCT id_etudiant FROM INSCRIPTION);