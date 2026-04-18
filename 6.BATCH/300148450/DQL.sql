-- =========================================
-- DQL.sql
-- Requêtes de consultation
-- =========================================

SELECT * FROM tp_sql.etudiants;

SELECT nom, note_finale
FROM tp_sql.etudiants
WHERE note_finale >= 80
ORDER BY note_finale DESC;
