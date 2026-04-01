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

print("=" * 50)
print("  TP NoSQL - PostgreSQL JSONB")
print("=" * 50)

# INSERT
print("\n INSERT - Ajout de Diana")
nouvel_etudiant = {"nom": "Diana", "age": 28, "competences": ["DevOps", "Kubernetes"]}
cur.execute("INSERT INTO etudiants (data) VALUES (%s)", [json.dumps(nouvel_etudiant)])
conn.commit()
print("   Diana ajoutee avec succes.")

# SELECT ALL
print("\n SELECT ALL - Tous les etudiants :")
cur.execute("SELECT id, data FROM etudiants ORDER BY id")
for row in cur.fetchall():
    e = row[1]
    print(f"   [{row[0]}] {e['nom']} ({e['age']} ans) - {', '.join(e.get('competences', []))}")

# SEARCH par nom
print("\n SEARCH - Recherche Alice :")
cur.execute("SELECT data FROM etudiants WHERE data->>'nom' = 'Alice'")
for row in cur.fetchall():
    print(f"   Trouve : {row[0]}")

# SEARCH par competence
print("\n SEARCH - Etudiants maitrisant Python :")
cur.execute("SELECT data FROM etudiants WHERE data->'competences' @> '[\"Python\"]'")
for row in cur.fetchall():
    print(f"   {row[0]['nom']}")

# BONUS UPDATE
print("\n BONUS UPDATE - Modifier age de Bob a 23 ans :")
cur.execute("UPDATE etudiants SET data = jsonb_set(data, '{age}', '23') WHERE data->>'nom' = 'Bob' RETURNING data")
updated = cur.fetchone()
conn.commit()
if updated:
    print(f"   Bob mis a jour : {updated[0]}")

# BONUS DELETE
print("\n BONUS DELETE - Supprimer Diana :")
cur.execute("DELETE FROM etudiants WHERE data->>'nom' = 'Diana'")
conn.commit()
print(f"   {cur.rowcount} etudiant(e) supprime(e).")

# Etat final
print("\n Etat final :")
cur.execute("SELECT id, data->>'nom', data->>'age' FROM etudiants ORDER BY id")
for row in cur.fetchall():
    print(f"   [{row[0]}] {row[1]} - {row[2]} ans")

cur.close()
conn.close()
print("\n Connexion fermee. TP termine.")
