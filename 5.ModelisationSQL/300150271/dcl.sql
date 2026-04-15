CREATE USER technicien_user WITH PASSWORD 'tech123';
CREATE USER gestionnaire_user WITH PASSWORD 'gest123';

GRANT CONNECT ON DATABASE postgres TO technicien_user, gestionnaire_user;
GRANT USAGE ON SCHEMA public TO technicien_user, gestionnaire_user;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO technicien_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO gestionnaire_user;