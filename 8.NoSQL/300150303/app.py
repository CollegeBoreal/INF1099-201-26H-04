import psycopg2
import json

# ============================================
# Connexion a PostgreSQL
# ============================================
conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

# ============================================
# PARTIE 1 - INSERT : Ajouter un etudiant
# ============================================
print("\n➕ INSERT - Ajout de Diana :")
nouvel_etudiant = {
    "nom": "Diana",
    "age": 28,
    "competences": ["DevOps", "Kubernetes"]
}

cur.execute(
    "INSERT INTO etudiants (data) VALUES (%s)",
    [json.dumps(nouvel_etudiant)]
)
conn.commit()
print("   Diana ajoutee avec succes !")

# ============================================
# PARTIE 2 - SELECT ALL : Tous les etudiants
# ============================================
print("\n📌 SELECT ALL - Tous les etudiants :")
cur.execute("SELECT id, data FROM etudiants")

for row in cur.fetchall():
    print(f"   ID {row[0]} -> {row[1]}")

# ============================================
# PARTIE 3 - SEARCH par nom (operateur ->>)
# ============================================
print("\n🔎 SEARCH - Recherche par nom (Alice) :")
cur.execute("""
    SELECT id, data FROM etudiants
    WHERE data->>'nom' = 'Alice'
""")

for row in cur.fetchall():
    print(f"   Trouve : {row[1]}")

# ============================================
# PARTIE 4 - SEARCH par competence (operateur @>)
# ============================================
print("\n🔎 SEARCH - Etudiants avec la competence Python :")
cur.execute("""
    SELECT id, data FROM etudiants
    WHERE data->'competences' @> '["Python"]'
""")

for row in cur.fetchall():
    print(f"   Trouve : {row[1]}")

# ============================================
# BONUS 1 - UPDATE JSON : Modifier l'age de Bob
# ============================================
print("\n✏️  UPDATE - Modifier l'age de Bob (22 -> 23) :")
cur.execute("""
    UPDATE etudiants
    SET data = jsonb_set(data, '{age}', '23')
    WHERE data->>'nom' = 'Bob'
""")
conn.commit()

# Verification de l'update
cur.execute("SELECT data FROM etudiants WHERE data->>'nom' = 'Bob'")
row = cur.fetchone()
print(f"   Apres update : {row[0]}")

# ============================================
# BONUS 2 - UPDATE : Ajouter une competence a Charlie
# ============================================
print("\n✏️  UPDATE - Ajouter 'Docker' aux competences de Charlie :")
cur.execute("""
    UPDATE etudiants
    SET data = jsonb_set(
        data,
        '{competences}',
        (data->'competences') || '["Docker"]'
    )
    WHERE data->>'nom' = 'Charlie'
""")
conn.commit()

cur.execute("SELECT data FROM etudiants WHERE data->>'nom' = 'Charlie'")
row = cur.fetchone()
print(f"   Apres update : {row[0]}")

# ============================================
# BONUS 3 - DELETE : Supprimer un etudiant par nom
# ============================================
print("\n🗑️  DELETE - Suppression de Diana :")
cur.execute("""
    DELETE FROM etudiants
    WHERE data->>'nom' = 'Diana'
""")
conn.commit()
print("   Diana supprimee !")

# Verification finale
print("\n✅ ETAT FINAL - Tous les etudiants :")
cur.execute("SELECT id, data FROM etudiants ORDER BY id")
for row in cur.fetchall():
    print(f"   ID {row[0]} -> {row[1]}")

# ============================================
# Demonstration operateurs -> et ->>
# ============================================
print("\n📖 DEMO operateurs -> et ->> :")
cur.execute("""
    SELECT
        data->>'nom'   AS nom_texte,
        data->'age'    AS age_json,
        data->>'age'   AS age_texte
    FROM etudiants
    LIMIT 2
""")
print("   nom_texte | age_json | age_texte")
print("   " + "-" * 40)
for row in cur.fetchall():
    print(f"   {row[0]:10} | {row[1]:8} | {row[2]}")

cur.close()
conn.close()
print("\n🎉 Script termine avec succes !")
