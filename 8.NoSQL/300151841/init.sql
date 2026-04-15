CREATE TABLE tournaments (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_tournaments_data ON tournaments USING GIN (data);

INSERT INTO tournaments (data) VALUES
('{"tournament_name": "Winter Clash 2026", "game": "Valorant", "start_date": "2026-03-10", "end_date": "2026-03-12", "format": "BO3", "teams": ["Alpha Wolves", "Nova Esport"], "location": "Toronto"}'),
('{"tournament_name": "Spring Arena 2026", "game": "League of Legends", "start_date": "2026-04-05", "end_date": "2026-04-07", "format": "BO5", "teams": ["Maple Dragons", "Cyber Fox"], "location": "Ottawa"}'),
('{"tournament_name": "Summer Cup 2026", "game": "Counter-Strike 2", "start_date": "2026-06-15", "end_date": "2026-06-18", "format": "BO3", "teams": ["Team North", "Pixel Storm"], "location": "Montreal"}');
