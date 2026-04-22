# ============================================================
# app.py
# TP NoSQL — PostgreSQL JSONB + Python
# Centre Sportif — Gestion de Terrains & Réservations
# #300150293
# ============================================================

import psycopg2
import json

# Connexion a PostgreSQL
conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

# ============================================================
# INSERT — Ajouter un nouveau terrain
# ============================================================
nouveau_terrain = {
    "nom": "Terrain C1",
    "type": "Gazon naturel",
    "tarif": 90,
    "eclairage": True,
    "statut": "Disponible",
    "ville": "Quebec"
}

cur.execute(
    "INSERT INTO terrains (data) VALUES (%s)",
    [json.dumps(nouveau_terrain)]
)
conn.commit()
print("Terrain C1 ajoute avec succes.")

# ============================================================
# SELECT ALL — Afficher tous les terrains
# ============================================================
print("\nTous les terrains :")
cur.execute("SELECT id, data FROM terrains")
for row in cur.fetchall():
    print(f"  [{row[0]}] {row[1]}")

# ============================================================
# SEARCH par nom
# ============================================================
print("\nRecherche par nom (Terrain A1) :")
cur.execute("""
    SELECT data FROM terrains
    WHERE data->>'nom' = 'Terrain A1'
""")
for row in cur.fetchall():
    print(f"  {row[0]}")

# ============================================================
# SEARCH par type de surface
# ============================================================
print("\nTerrains avec eclairage :")
cur.execute("""
    SELECT data FROM terrains
    WHERE (data->>'eclairage')::boolean = true
""")
for row in cur.fetchall():
    print(f"  {row[0]}")

# ============================================================
# SEARCH par ville
# ============================================================
print("\nTerrains a Laval :")
cur.execute("""
    SELECT data FROM terrains
    WHERE data->>'ville' = 'Laval'
""")
for row in cur.fetchall():
    print(f"  {row[0]}")

# ============================================================
# UPDATE — Mettre a jour le tarif de Terrain A2
# ============================================================
cur.execute("""
    UPDATE terrains
    SET data = data || '{"tarif": 55}'::jsonb
    WHERE data->>'nom' = 'Terrain A2'
""")
conn.commit()

print("\nMise a jour tarif de Terrain A2 (50 -> 55) :")
cur.execute("SELECT data FROM terrains WHERE data->>'nom' = 'Terrain A2'")
for row in cur.fetchall():
    print(f"  {row[0]}")

# ============================================================
# DELETE — Supprimer Terrain B1
# ============================================================
cur.execute("""
    DELETE FROM terrains
    WHERE data->>'nom' = 'Terrain B1'
""")
conn.commit()
print("\nSuppression de Terrain B1 :")
print("  Terrain B1 supprime.")

# ============================================================
# SELECT FINAL — Etat final de la table
# ============================================================
print("\nEtat final de la table :")
cur.execute("SELECT id, data FROM terrains")
for row in cur.fetchall():
    print(f"  [{row[0]}] {row[1]}")

# Fermeture de la connexion
cur.close()
conn.close()
print("\nConnexion fermee.")
