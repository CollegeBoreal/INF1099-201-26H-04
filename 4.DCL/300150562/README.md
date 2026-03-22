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

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Boutique de Maillots – Base de Données PostgreSQL</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; padding: 20px; background-color: #f8f9fa; color: #212529; }
        h1, h2, h3 { color: #2c3e50; }
        code { background-color: #e9ecef; padding: 2px 4px; border-radius: 4px; }
        pre { background-color: #e9ecef; padding: 10px; border-radius: 6px; overflow-x: auto; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        table, th, td { border: 1px solid #dee2e6; }
        th, td { padding: 8px; text-align: left; }
        th { background-color: #343a40; color: white; }
        tr:nth-child(even) { background-color: #f1f3f5; }
        .badge { display: inline-block; padding: 2px 6px; background-color: #17a2b8; color: white; border-radius: 4px; font-size: 0.9em; }
    </style>
</head>
<body>

<h1>🛒 Boutique de Maillots – Base de Données PostgreSQL</h1>

<h2>📌 Description</h2>
<p>Base de données pour gérer une boutique de maillots :</p>
<ul>
    <li><span class="badge">👤</span> Clients</li>
    <li><span class="badge">📍</span> Adresses</li>
    <li><span class="badge">🛍️</span> Commandes</li>
    <li><span class="badge">👕</span> Maillots & Catégories</li>
    <li><span class="badge">💳</span> Paiements</li>
    <li><span class="badge">🚚</span> Livraisons & Livreurs</li>
</ul>

<h2>🧱 Structure (Mermaid)</h2>
<pre><code>
erDiagram
    CLIENT ||--o{ ADRESSE : has
    CLIENT ||--o{ COMMANDE : places
    ADRESSE ||--o{ COMMANDE : delivery
    COMMANDE ||--o{ LIGNE_COMMANDE : contains
    COMMANDE ||--o{ PAIEMENT : has
    COMMANDE ||--o{ LIVRAISON : has
    MAILLOT ||--o{ LIGNE_COMMANDE : ordered
    CATEGORIE_MAILLOT ||--o{ MAILLOT : contains
    LIVREUR ||--o{ LIVRAISON : performs
</code></pre>

<h2>🗄️ Tables principales</h2>
<table>
    <tr>
        <th>Table</th>
        <th>Description</th>
    </tr>
    <tr><td>CLIENT</td><td>Informations des clients</td></tr>
    <tr><td>ADRESSE</td><td>Adresses de livraison</td></tr>
    <tr><td>MAILLOT</td><td>Produits</td></tr>
    <tr><td>CATEGORIE_MAILLOT</td><td>Catégories</td></tr>
    <tr><td>COMMANDE</td><td>Commandes clients</td></tr>
    <tr><td>LIGNE_COMMANDE</td><td>Détails des commandes</td></tr>
    <tr><td>PAIEMENT</td><td>Paiements</td></tr>
    <tr><td>LIVRAISON</td><td>Suivi des livraisons</td></tr>
    <tr><td>LIVREUR</td><td>Livreurs</td></tr>
</table>

<h2>⚙️ Installation</h2>
<pre><code>
# 1. Créer la base
createdb boutique_maillots

# 2. Exécuter les scripts SQL
psql -d boutique_maillots -f ddl.sql
psql -d boutique_maillots -f dml.sql
</code></pre>

<h2>🔍 Exemples de requêtes</h2>
<pre><code>
-- Commandes d’un client
SELECT * FROM COMMANDE WHERE ID_Client = 1;

-- Détails d’une commande
SELECT m.Nom_maillot, lc.Quantité
FROM LIGNE_COMMANDE lc
JOIN MAILLOT m ON m.ID_Maillot = lc.ID_Maillot;
</code></pre>

<h2>🔐 Permissions (DCL)</h2>
<pre><code>
CREATE USER app_user WITH PASSWORD '1234';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;
</code></pre>

<h2>👨‍💻 Auteur</h2>
<p><strong>Corneil Ekofo Wema</strong><br>
📧 corneilekofo003@gmail.com</p>

</body>
</html>

<img width="975" height="801" alt="image" src="https://github.com/user-attachments/assets/38d7a3ec-3d62-4e83-9f86-1c4c9432fd79" />

