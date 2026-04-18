-- ============================================================
-- init.sql - Base NoSQL avec JSONB
-- Cours : INF1099 | Domaine : AeroVoyage
-- SGBD : PostgreSQL
-- ============================================================

DROP TABLE IF EXISTS vols;

CREATE TABLE vols (
    id   SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_vols_data ON vols USING GIN (data);

INSERT INTO vols (data) VALUES
('{
    "numero_vol": "AC801",
    "compagnie": "Air Canada",
    "origine": "Montreal",
    "destination": "Toronto",
    "date_depart": "2025-06-15",
    "heure_depart": "07:30",
    "classe": "Economique",
    "places_dispo": 45,
    "statut": "Planifie",
    "equipement": ["Boeing 737", "WiFi", "Repas inclus"]
}'),
('{
    "numero_vol": "TS101",
    "compagnie": "Air Transat",
    "origine": "Montreal",
    "destination": "Paris",
    "date_depart": "2025-06-20",
    "heure_depart": "22:00",
    "classe": "Affaires",
    "places_dispo": 12,
    "statut": "Planifie",
    "equipement": ["Airbus A330", "WiFi", "Siège-lit", "Repas gastronomique"]
}'),
('{
    "numero_vol": "AC205",
    "compagnie": "Air Canada",
    "origine": "Montreal",
    "destination": "Quebec",
    "date_depart": "2025-06-18",
    "heure_depart": "09:15",
    "classe": "Economique",
    "places_dispo": 78,
    "statut": "Planifie",
    "equipement": ["Airbus A320", "Collation"]
}');
