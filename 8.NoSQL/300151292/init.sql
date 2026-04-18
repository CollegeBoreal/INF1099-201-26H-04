-- ============================================================
-- init.sql - BorealFit - Base NoSQL avec JSONB
-- Auteur : Amine Kahil — 300151292
-- ============================================================

CREATE TABLE IF NOT EXISTS seances (
    id   SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_seances_data ON seances USING GIN (data);

INSERT INTO seances (data) VALUES
('{"nom": "Spinning", "categorie": "Cardio", "coach": "Patrick Lemieux", "salle": "Salle A", "capacite": 15, "tags": ["cardio", "velo", "intensif"]}'),
('{"nom": "Hatha Yoga", "categorie": "Yoga", "coach": "Camille Fortin", "salle": "Salle C", "capacite": 12, "tags": ["yoga", "zen", "flexibilite"]}'),
('{"nom": "HIIT", "categorie": "Cardio", "coach": "Julie Paradis", "salle": "Salle B", "capacite": 20, "tags": ["cardio", "intensif", "bruler"]}'),
('{"nom": "Bench Press", "categorie": "Musculation", "coach": "Patrick Lemieux", "salle": "Salle B", "capacite": 8, "tags": ["musculation", "force", "halteres"]}'),
('{"nom": "Zumba", "categorie": "Danse", "coach": "Julie Paradis", "salle": "Salle A", "capacite": 25, "tags": ["danse", "cardio", "rythme"]}');
