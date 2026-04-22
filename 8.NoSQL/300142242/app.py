import psycopg2
import json

# Connexion à la base ecole lancée via Docker
conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)
cur = conn.cursor()

# 🔹 INSERT : Ajout d'un étudiant
print("\n➕ Ajout de Diana...")
nouveau = {"nom": "Diana", "age": 28, "competences": ["DevOps", "Kubernetes"]}
cur.execute("INSERT INTO etudiants (data) VALUES (%s)", [json.dumps(nouveau)])

# 🔹 UPDATE (Bonus) : Changer l'âge de Bob
print("🔄 Mise à jour de l'âge de Bob...")
cur.execute("UPDATE etudiants SET data = jsonb_set(data, '{age}', '23') WHERE data->>'nom' = 'Bob'")

# 🔹 DELETE (Bonus) : Supprimer Charlie
print("❌ Suppression de Charlie...")
cur.execute("DELETE FROM etudiants WHERE data->>'nom' = 'Charlie'")

conn.commit()

# 🔹 SELECT ALL
print("\n📌 Liste actuelle des étudiants :")
cur.execute("SELECT data FROM etudiants")
for row in cur.fetchall():
    print(row[0])

# 🔹 SEARCH : Recherche par compétence
print("\n🔎 Étudiants ayant la compétence 'Python' :")
cur.execute("SELECT data FROM etudiants WHERE data @> '{\"competences\": [\"Python\"]}'")
for row in cur.fetchall():
    print(row[0])

cur.close()
conn.close()
