-- DCL.sql - DjaberBenyezza - 300146667

CREATE ROLE lecteur LOGIN PASSWORD 'lecteur123';
GRANT CONNECT ON DATABASE ecole TO lecteur;
GRANT USAGE ON SCHEMA public TO lecteur;
GRANT SELECT ON etudiants, cours, inscriptions TO lecteur;
