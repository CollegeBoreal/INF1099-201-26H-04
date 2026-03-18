CREATE USER player_user WITH PASSWORD 'player123';
CREATE USER admin_user WITH PASSWORD 'admin123';

GRANT CONNECT ON DATABASE esport_tournament TO player_user, admin_user;

GRANT USAGE ON SCHEMA esport TO player_user, admin_user;

GRANT SELECT ON ALL TABLES IN SCHEMA esport TO player_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA esport TO admin_user;

GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA esport TO admin_user;

REVOKE SELECT ON ALL TABLES IN SCHEMA esport FROM player_user;