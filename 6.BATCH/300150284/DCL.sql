DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'prof') THEN
      CREATE ROLE prof LOGIN PASSWORD 'prof123';
   END IF;
END
$$;

GRANT CONNECT ON DATABASE ecole TO prof;
GRANT USAGE ON SCHEMA public TO prof;
GRANT SELECT ON etudiants TO prof;
