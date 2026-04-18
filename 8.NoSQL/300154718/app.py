import psycopg2
import json

# ============================================================
# Connexion a PostgreSQL
# ============================================================
conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

print("=" * 55)
print("   AeroVoyage — Base NoSQL PostgreSQL JSONB")
print("=" * 55)

# ============================================================
# INSERT — Ajouter un nouveau vol
# ============================================================
nouveau_vol = {
    "numero_vol": "WS302",
    "compagnie": "WestJet",
    "origine": "Montreal",
    "destination": "Vancouver",
    "date_depart": "2025-06-25",
    "heure_depart": "14:00",
    "classe": "Premium",
    "places_dispo": 20,
    "statut": "Planifie",
    "equipement": ["Boeing 737 MAX", "WiFi", "Repas inclus"]
}

cur.execute("INSERT INTO vols (data) VALUES (%s)", [json.dumps(nouveau_vol)])
conn.commit()
print("\n➕ Vol insere : WS302 Montreal -> Vancouver")

# ============================================================
# SELECT ALL — Afficher tous les vols
# ============================================================
print("\n📋 Tous les vols disponibles :")
print("-" * 55)
cur.execute("SELECT data->>'numero_vol', data->>'destination', data->>'compagnie', data->>'places_dispo' FROM vols")
for row in cur.fetchall():
    print(f"  Vol {row[0]} | {row[2]} | Destination: {row[1]} | Places: {row[3]}")

# ============================================================
# SELECT filtre — Recherche par compagnie
# ============================================================
print("\n🔎 Vols Air Canada uniquement :")
print("-" * 55)
cur.execute("""
    SELECT data FROM vols
    WHERE data->>'compagnie' = 'Air Canada'
""")
for row in cur.fetchall():
    vol = row[0]
    print(f"  {vol['numero_vol']} | {vol['origine']} -> {vol['destination']} | {vol['heure_depart']}")

# ============================================================
# SELECT filtre — Recherche par equipement (tableau JSONB)
# ============================================================
print("\n📡 Vols avec WiFi :")
print("-" * 55)
cur.execute("""
    SELECT data->>'numero_vol', data->>'destination'
    FROM vols
    WHERE data->'equipement' @> '["WiFi"]'::jsonb
""")
for row in cur.fetchall():
    print(f"  Vol {row[0]} -> {row[1]}")

# ============================================================
# UPDATE — Modifier le statut d'un vol
# ============================================================
cur.execute("""
    UPDATE vols
    SET data = data || '{"statut": "Embarquement"}'::jsonb
    WHERE data->>'numero_vol' = 'AC801'
""")
conn.commit()
print("\n✏️  Statut du vol AC801 mis a jour : Embarquement")

# ============================================================
# DELETE — Supprimer un vol
# ============================================================
cur.execute("""
    DELETE FROM vols
    WHERE data->>'numero_vol' = 'WS302'
""")
conn.commit()
print("\n🗑️  Vol WS302 supprime")

# ============================================================
# Verification finale
# ============================================================
print("\n✅ Vols restants dans la base :")
print("-" * 55)
cur.execute("SELECT data->>'numero_vol', data->>'destination', data->>'statut' FROM vols")
for row in cur.fetchall():
    print(f"  Vol {row[0]} -> {row[1]} | Statut: {row[2]}")

print("\n" + "=" * 55)
print("   Script termine avec succes !")
print("=" * 55)

cur.close()
conn.close()
