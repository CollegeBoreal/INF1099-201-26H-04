import psycopg2
import json

conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

# 🔹 INSERT
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

# 🔹 SELECT ALL
print("\n📌 Tous les étudiants :")
cur.execute("SELECT data FROM etudiants")

for row in cur.fetchall():
    print(row[0])

# 🔹 SEARCH (utilisation de ->>)
print("\n🔎 Recherche Alice :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->>'nom' = 'Alice'
""")

for row in cur.fetchall():
    print(row[0])

# 🔹 SEARCH avec -> (JSON)
print("\n🔎 Étudiants avec Python :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->'competences' ? 'Python'
""")

for row in cur.fetchall():
    print(row[0])

# 🔹 UPDATE JSON
print("\n✏️ Mise à jour de l'âge de Bob :")
cur.execute("""
    UPDATE etudiants
    SET data = jsonb_set(data, '{age}', '26')
    WHERE data->>'nom' = 'Bob'
""")

conn.commit()

# 🔹 DELETE
print("\n🗑️ Suppression de Charlie :")
cur.execute("""
    DELETE FROM etudiants
    WHERE data->>'nom' = 'Charlie'
""")

conn.commit()

# 🔹 SELECT FINAL
print("\n📌 Données après modifications :")
cur.execute("SELECT data FROM etudiants")

for row in cur.fetchall():
    print(row[0])

cur.close()
conn.close()
