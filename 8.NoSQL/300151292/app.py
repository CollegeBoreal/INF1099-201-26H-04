import psycopg2
import json

# ============================================================
# app.py - BorealFit - Script Python NoSQL JSONB
# Auteur : Amine Kahil - 300151292
# ============================================================

conn = psycopg2.connect(
    dbname="borealfit",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

# INSERT - Ajouter une nouvelle seance
print("\n INSERT - Ajout d une nouvelle seance :")
nouvelle_seance = {
    "nom": "Kickboxing",
    "categorie": "Arts martiaux",
    "coach": "Alex Bergeron",
    "salle": "Salle D",
    "capacite": 10,
    "tags": ["combat", "cardio", "intensif"]
}
cur.execute(
    "INSERT INTO seances (data) VALUES (%s)",
    [json.dumps(nouvelle_seance)]
)
conn.commit()
print("Seance ajoutee : Kickboxing")

# SELECT ALL - Toutes les seances
print("\n SELECT ALL - Toutes les seances :")
cur.execute("SELECT data FROM seances")
for row in cur.fetchall():
    print(row[0])

# SELECT filtre par categorie
print("\n SELECT FILTRE - Seances Cardio :")
cur.execute("""
    SELECT data FROM seances
    WHERE data->>'categorie' = 'Cardio'
""")
for row in cur.fetchall():
    print(row[0])

# SELECT filtre par tag
print("\n SELECT FILTRE - Seances avec tag 'intensif' :")
cur.execute("""
    SELECT data FROM seances
    WHERE data->'tags' @> '["intensif"]'::jsonb
""")
for row in cur.fetchall():
    print(row[0])

# UPDATE - Modifier un champ JSON
print("\n UPDATE - Modifier la salle de Zumba :")
cur.execute("""
    UPDATE seances
    SET data = data || '{"salle": "Salle E"}'::jsonb
    WHERE data->>'nom' = 'Zumba'
""")
conn.commit()
print("Salle de Zumba mise a jour -> Salle E")

# DELETE - Supprimer une seance
print("\n DELETE - Supprimer Kickboxing :")
cur.execute("""
    DELETE FROM seances
    WHERE data->>'nom' = 'Kickboxing'
""")
conn.commit()
print("Seance Kickboxing supprimee")

# Verification finale
print("\n VERIFICATION FINALE - Toutes les seances :")
cur.execute("SELECT data->>'nom' AS nom, data->>'categorie' AS categorie, data->>'coach' AS coach FROM seances")
for row in cur.fetchall():
    print(f"  {row[0]} | {row[1]} | {row[2]}")

cur.close()
conn.close()
print("\nConnexion fermee.")
