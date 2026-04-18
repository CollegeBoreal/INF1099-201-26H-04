import psycopg2
import json

# Connexion à PostgreSQL
conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

# 🔹 INSERT JSON
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

# 🔹 Recherche par nom
print("\n🔎 Recherche Alice :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->>'nom' = 'Alice'
""")
for row in cur.fetchall():
    print(row[0])

cur.execute("""
    DELETE FROM etudiants
    WHERE data->>'nom' = 'Bob'
""")
conn.commit()

cur.execute("""
	UPDATE etudiants
	SET data = jsonb_set (data, '{age}', '31')
	WHERE data->>'nom' = 'charlie'
""")
conn.commit()
cur.close()
conn.close()
