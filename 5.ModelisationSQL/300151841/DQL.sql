-- Liste des jeux disponibles

SELECT * 
FROM esport.game;


-- Liste des tournois

SELECT 
    tournament_id,
    tournament_name,
    start_date,
    end_date,
    format
FROM esport.tournament;


-- Liste des équipes

SELECT 
    team_id,
    team_name
FROM esport.team;


-- Liste des joueurs

SELECT 
    player_id,
    pseudo,
    email
FROM esport.player;


-- Afficher les matchs avec le tournoi

SELECT
    m.match_id,
    t.tournament_name,
    m.round,
    m.match_datetime
FROM esport.match m
JOIN esport.tournament t
ON m.tournament_id = t.tournament_id;


-- Afficher les scores des équipes dans les matchs

SELECT
    m.match_id,
    t.team_name,
    mt.score
FROM esport.match_team mt
JOIN esport.match m 
ON mt.match_id = m.match_id
JOIN esport.team t 
ON mt.team_id = t.team_id;


-- Voir les joueurs dans les équipes

SELECT
    tm.team_id,
    t.team_name,
    p.player_id,
    p.pseudo
FROM esport.team_member tm
JOIN esport.team t
ON tm.team_id = t.team_id
JOIN esport.player p
ON tm.player_id = p.player_id;