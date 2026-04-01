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

# 🔹 SEARCH
print("\n🔎 Recherche Alice :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->>'nom' = 'Alice'
""")

for row in cur.fetchall():
    print(row[0])

cur.close()
conn.close()