🛒 Boutique de Maillots – Base de Données PostgreSQL
📌 Description

Base de données pour gérer une boutique de maillots :

👤 Clients

📍 Adresses

🛍️ Commandes

👕 Maillots & Catégories

💳 Paiements

🚚 Livraisons & Livreurs

# 1. Créer la base
createdb boutique_maillots

# 2. Exécuter les scripts
psql -d boutique_maillots -f ddl.sql
psql -d boutique_maillots -f dml.sql

🔍 Exemples de requêtes
-- Commandes d’un client
SELECT * FROM COMMANDE WHERE ID_Client = 1;
-- Détails d’une commande
SELECT m.Nom_maillot, lc.Quantité
FROM LIGNE_COMMANDE lc
JOIN MAILLOT m ON m.ID_Maillot = lc.ID_Maillot;
🔐 Permissions (DCL)
CREATE USER app_user WITH PASSWORD '1234';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;
