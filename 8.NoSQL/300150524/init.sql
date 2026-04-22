-- =========================
-- Table JSONB CarGoRent
-- =========================
CREATE TABLE cargorent_json (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

-- Index GIN (performance)
CREATE INDEX idx_cargorent_json ON cargorent_json USING GIN (data);

-- =========================
-- INSERT JSON
-- =========================
INSERT INTO cargorent_json (data) VALUES
('{
  "client": {"nom": "Taki", "prenom": "Choufa"},
  "voiture": {"marque": "Toyota", "modele": "Corolla"},
  "reservation": {"date_debut": "2026-04-20", "date_fin": "2026-04-25", "statut": "confirmée"}
}'),

('{
  "client": {"nom": "Houcine", "prenom": "Benhaib"},
  "voiture": {"marque": "Honda", "modele": "CRV"},
  "reservation": {"date_debut": "2026-04-22", "date_fin": "2026-04-24", "statut": "confirmée"}
}'),

('{
  "client": {"nom": "Maya", "prenom": "Abd"},
  "voiture": {"marque": "BMW", "modele": "320i"},
  "reservation": {"date_debut": "2026-04-26", "date_fin": "2026-04-28", "statut": "en attente"}
}');