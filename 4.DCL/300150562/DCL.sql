-- Créer un utilisateur
CREATE USER utilisateur_app WITH PASSWORD 'MotDePasse123';

-- Donner des droits SELECT, INSERT, UPDATE, DELETE sur toutes les tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO utilisateur_app;

-- Donner des droits pour créer de nouvelles tables si nécessaire
GRANT CREATE ON SCHEMA public TO utilisateur_app;

-- Retirer un droit (exemple)
REVOKE DELETE ON COMMANDE FROM utilisateur_app;