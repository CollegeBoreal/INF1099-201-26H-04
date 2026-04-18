DROP ROLE IF EXISTS player_user;
DROP ROLE IF EXISTS admin_user;

CREATE ROLE player_user LOGIN PASSWORD 'player123';
CREATE ROLE admin_user LOGIN PASSWORD 'admin123';

GRANT CONNECT ON DATABASE ecole TO player_user, admin_user;

GRANT USAGE ON SCHEMA public TO player_user, admin_user;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO player_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin_user;