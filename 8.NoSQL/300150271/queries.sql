INSERT INTO etudiants (data) VALUES ('{"nom": "Diana", "age": 28, "competences": ["DevOps", "Kubernetes"]}');

SELECT data FROM etudiants;

SELECT data FROM etudiants WHERE data->>'nom' = 'Alice';

SELECT data FROM etudiants WHERE data->'competences' ? 'Python';

UPDATE etudiants SET data = jsonb_set(data, '{age}', '25') WHERE data->>'nom' = 'Bob';

DELETE FROM etudiants WHERE data->>'nom' = 'Charlie';

SELECT data FROM etudiants;