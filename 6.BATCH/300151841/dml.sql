INSERT INTO esport.game (game_name)
VALUES 
('League of Legends'),
('Counter-Strike 2'),
('Valorant');

INSERT INTO esport.tournament (tournament_name, start_date, end_date, format, game_id)
VALUES
('World Championship', '2024-10-01', '2024-10-20', '5v5', 1),
('CS2 Major', '2024-11-10', '2024-11-25', '5v5', 2);

INSERT INTO esport.team (team_name)
VALUES
('Team Alpha'),
('Team Bravo'),
('Team Delta');

INSERT INTO esport.player (pseudo, email)
VALUES
('Shadow', 'shadow@email.com'),
('Blaze', 'blaze@email.com'),
('Phantom', 'phantom@email.com'),
('Nova', 'nova@email.com');

INSERT INTO esport.team_member (team_id, player_id)
VALUES
(1,1),
(1,2),
(2,3),
(2,4);

INSERT INTO esport.match (tournament_id, round, match_datetime)
VALUES
(1,'Quarter Final','2024-10-05 18:00'),
(1,'Semi Final','2024-10-10 20:00');

INSERT INTO esport.match_team (match_id, team_id, score)
VALUES
(1,1,2),
(1,2,1),
(2,1,2),
(2,3,0);