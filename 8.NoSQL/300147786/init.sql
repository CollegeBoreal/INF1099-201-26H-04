CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);

INSERT INTO etudiants (data) VALUES
('{"nom": "Alice", "age": 25, "competences": ["Python", "Docker"]}'),
('{"nom": "Bob", "age": 22, "competences": ["Java", "SQL"]}'),
('{"nom": "Charlie", "age": 30, "competences": ["Linux", "Bash", "Python"]}'),
('{"nom": "David", "age": 27, "competences": ["C++", "Git", "Linux"]}'),
('{"nom": "Emma", "age": 24, "competences": ["JavaScript", "React", "CSS"]}'),
('{"nom": "Fay", "age": 29, "competences": ["SQL", "Python", "AWS"]}'),
('{"nom": "George", "age": 23, "competences": ["Docker", "Kubernetes", "Go"]}'),
('{"nom": "Hana", "age": 26, "competences": ["Python", "Flask", "PostgreSQL"]}');
