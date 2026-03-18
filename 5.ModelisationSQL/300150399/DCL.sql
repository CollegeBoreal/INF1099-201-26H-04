CREATE USER vendeur_user WITH PASSWORD 'vendeur123';
CREATE USER admin_user WITH PASSWORD 'admin123';

GRANT CONNECT ON DATABASE maillotsdb TO vendeur_user,admin_user;

GRANT USAGE ON SCHEMA boutique TO vendeur_user,admin_user;

-- vendeur lecture
GRANT SELECT ON ALL TABLES IN SCHEMA boutique TO vendeur_user;

-- admin complet
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA boutique TO admin_user;
GRANT USAGE,SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA boutique TO admin_user;
