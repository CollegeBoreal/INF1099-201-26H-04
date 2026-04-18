CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);
INSERT INTO etudiants (data) VALUES
('{
  "nom": "Alice",
  "age": 25,
  "email": "alice@ecole.ca",
  "ville": "Montreal",
  "statut": "temps plein",
  "competences": ["Python", "Docker"],
  "notes": { "INF1099": 85, "INF1007": 78 }
}'),
('{
  "nom": "Bob",
  "age": 22,
  "email": "bob@ecole.ca",
  "ville": "Toronto",
  "statut": "temps partiel",
  "competences": ["Java", "SQL"],
  "notes": { "INF1099": 72, "INF1010": 80 }
}'),
('{
  "nom": "Charlie",
  "age": 30,
  "email": "charlie@ecole.ca",
  "ville": "Quebec",
  "statut": "temps plein",
  "competences": ["Linux", "Bash", "Python"],
  "notes": { "INF1099": 90, "INF2010": 88 }
}'),
('{
  "nom": "Diana",
  "age": 27,
  "email": "diana@ecole.ca",
  "ville": "Laval",
  "statut": "temps plein",
  "competences": ["JavaScript", "Node.js", "MongoDB"],
  "notes": { "INF1099": 95 }
}');


