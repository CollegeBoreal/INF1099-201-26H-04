-- ============================================================
-- test.sql - BorealFit - Tests requetes JSONB
-- Auteur : Amine Kahil - 300151292
-- ============================================================

-- Afficher toutes les seances
SELECT data FROM seances;

-- Recherche par categorie
SELECT data FROM seances
WHERE data->>'categorie' = 'Cardio';

-- Recherche par tag intensif
SELECT data FROM seances
WHERE data->'tags' @> '["intensif"]'::jsonb;

-- Recherche par coach
SELECT data FROM seances
WHERE data->>'coach' = 'Patrick Lemieux';

-- Mise a jour partielle
UPDATE seances
SET data = data || '{"salle": "Salle E"}'::jsonb
WHERE data->>'nom' = 'Zumba';

-- Verification apres update
SELECT data->>'nom' AS nom, data->>'salle' AS salle FROM seances;

-- Afficher les logs
SELECT * FROM seances ORDER BY id;
