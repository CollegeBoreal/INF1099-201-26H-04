-- ============================================
-- TP NoSQL - PostgreSQL JSONB
-- Fichier d'initialisation automatique
-- ============================================

-- Création de la table avec colonne JSONB
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

-- Index GIN pour accélerer les recherches JSONB
CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);

-- Insertion des données initiales
INSERT INTO etudiants (data) VALUES
('{"nom": "Alice", "age": 25, "competences": ["Python", "Docker"]}'),
('{"nom": "Bob", "age": 22, "competences": ["Java", "SQL"]}'),
('{"nom": "Charlie", "age": 30, "competences": ["Linux", "Bash", "Python"]}');
