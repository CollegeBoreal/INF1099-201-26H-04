-- ============================================================
-- 02-dml.sql
-- Data Manipulation Language
-- TP PostgreSQL — Stored Procedures
-- #300150205
-- Prérequis : 01-ddl.sql doit avoir été exécuté
-- ============================================================

-- Étudiants
INSERT INTO etudiants (nom, age, email) VALUES
    ('Alice Tremblay',  22, 'alice.tremblay@email.com'),
    ('Luc Gagnon',      25, 'luc.gagnon@email.com'),
    ('Marie Côté',      20, 'marie.cote@email.com'),
    ('Test Valide',     19, 'test@email.com');

-- Cours
INSERT INTO cours (nom, credits) VALUES
    ('Bases de donnees',        3),
    ('Reseaux informatiques',   3),
    ('Systemes exploitation',   3),
    ('Programmation Web',       3);
