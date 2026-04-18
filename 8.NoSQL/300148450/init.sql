-- =========================================================
-- init.sql
-- Création table NoSQL + données JSONB
-- =========================================================

DROP TABLE IF EXISTS etudiants;

CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);

INSERT INTO etudiants (data) VALUES
('{"nom": "Alice", "age": 25, "competences": ["Python", "Docker"]}'),
('{"nom": "Bob", "age": 22, "competences": ["Java", "SQL"]}'),
('{"nom": "Charlie", "age": 30, "competences": ["Linux", "Bash", "Python"]}');
