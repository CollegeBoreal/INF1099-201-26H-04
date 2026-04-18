-- =========================================
-- DCL.sql
-- Gestion des droits
-- =========================================

DO
$$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'lecture_user') THEN
        CREATE ROLE lecture_user LOGIN PASSWORD 'lecture123';
    END IF;

    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'admin_user') THEN
        CREATE ROLE admin_user LOGIN PASSWORD 'admin123';
    END IF;
END
$$;

GRANT USAGE ON SCHEMA tp_sql TO lecture_user, admin_user;

GRANT SELECT ON tp_sql.etudiants TO lecture_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON tp_sql.etudiants TO admin_user;

GRANT USAGE, SELECT, UPDATE ON SEQUENCE tp_sql.etudiants_id_seq TO admin_user;
