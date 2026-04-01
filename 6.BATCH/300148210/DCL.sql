DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'admin_role') THEN
      CREATE ROLE admin_role LOGIN PASSWORD 'admin123';
   END IF;

   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'analyste_role') THEN
      CREATE ROLE analyste_role LOGIN PASSWORD 'analyste123';
   END IF;

   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'client_role') THEN
      CREATE ROLE client_role LOGIN PASSWORD 'client123';
   END IF;
END
$$;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_role;

GRANT SELECT, INSERT, UPDATE ON 
    analyse_lab,
    resultat_analyse,
    conformite,
    rapport
TO analyste_role;

GRANT SELECT ON 
    client,
    echantillon,
    lot,
    produit_alimentaire,
    type_analyse,
    norme
TO analyste_role;

GRANT SELECT ON 
    facture,
    paiement,
    rapport
TO client_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO admin_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE ON TABLES TO analyste_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO client_role;
-- ======================
-- PRIVILEGES ADMIN
-- ======================

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_role;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_role;

-- ======================
-- PRIVILEGES ANALYSTE
-- ======================

GRANT SELECT, INSERT, UPDATE ON 
    ANALYSE_LAB,
    RESULTAT_ANALYSE,
    CONFORMITE,
    RAPPORT
TO analyste_role;

GRANT SELECT ON 
    CLIENT,
    ECHANTILLON,
    LOT,
    PRODUIT_ALIMENTAIRE,
    TYPE_ANALYSE,
    NORME
TO analyste_role;

-- ======================
-- PRIVILEGES CLIENT
-- ======================

GRANT SELECT ON 
    FACTURE,
    PAIEMENT,
    RAPPORT
TO client_role;

-- ======================
-- ACCES FUTUR (important)
-- ======================

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO admin_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE ON TABLES TO analyste_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO client_role;