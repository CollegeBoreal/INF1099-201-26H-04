
-- ==================================================================================
-- init.sql
-- TP NoSQL — PostgreSQL JSONB
-- Création de la table, index GIN et données initiales
-- ==================================================================================

-- Table principale : stocke les étudiants sous forme de documents JSON
CREATE TABLE etudiants (
    id   SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

-- Index GIN : optimise les recherches sur les champs JSONB
-- Permet des requêtes rapides avec les opérateurs @>, ?, ->>, etc.
CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);

-- Données initiales
INSERT INTO etudiants (data) VALUES
    ('{"nom": "Alice",   "age": 25, "competences": ["Python", "Docker"]}'),
    ('{"nom": "Bob",     "age": 22, "competences": ["Java", "SQL"]}'),
    ('{"nom": "Charlie", "age": 30, "competences": ["Linux", "Bash", "Python"]}');
