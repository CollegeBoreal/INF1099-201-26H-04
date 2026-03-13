CREATE SCHEMA esport;

CREATE TABLE esport.game (
    game_id SERIAL PRIMARY KEY,
    game_name VARCHAR(100) NOT NULL
);

CREATE TABLE esport.tournament (
    tournament_id SERIAL PRIMARY KEY,
    tournament_name VARCHAR(150) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    format VARCHAR(50) NOT NULL,
    game_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES esport.game(game_id)
);

CREATE TABLE esport.match (
    match_id SERIAL PRIMARY KEY,
    tournament_id INT NOT NULL,
    round VARCHAR(50) NOT NULL,
    match_datetime TIMESTAMP NOT NULL,
    FOREIGN KEY (tournament_id) REFERENCES esport.tournament(tournament_id)
);

CREATE TABLE esport.team (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL
);

CREATE TABLE esport.player (
    player_id SERIAL PRIMARY KEY,
    pseudo VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL
);

CREATE TABLE esport.match_team (
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    score INT DEFAULT 0,
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES esport.match(match_id),
    FOREIGN KEY (team_id) REFERENCES esport.team(team_id)
);

CREATE TABLE esport.team_member (
    team_id INT NOT NULL,
    player_id INT NOT NULL,
    PRIMARY KEY (team_id, player_id),
    FOREIGN KEY (team_id) REFERENCES esport.team(team_id),
    FOREIGN KEY (player_id) REFERENCES esport.player(player_id)
);