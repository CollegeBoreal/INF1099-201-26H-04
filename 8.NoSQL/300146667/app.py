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

# INSERT
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
print("Etudiant Diana ajoute avec succes.")

# SELECT ALL
print("\nTous les etudiants :")
cur.execute("SELECT id, data FROM etudiants")
for row in cur.fetchall():
    print(f"  [{row[0]}] {row[1]}")

# SEARCH par nom
print("\nRecherche par nom (Alice) :")
cur.execute("SELECT data FROM etudiants WHERE data->>'nom' = 'Alice'")
for row in cur.fetchall():
    print(f"  {row[0]}")

# SEARCH par competence
print("\nEtudiants avec la competence Python :")
cur.execute("SELECT data FROM etudiants WHERE data->'competences' ? 'Python'")
for row in cur.fetchall():
    print(f"  {row[0]}")

# UPDATE
print("\nMise a jour age de Bob (22 -> 23) :")
cur.execute("""
    UPDATE etudiants
    SET data = data || '{\"age\": 23}'::jsonb
    WHERE data->>'nom' = 'Bob'
""")
conn.commit()
cur.execute("SELECT data FROM etudiants WHERE data->>'nom' = 'Bob'")
for row in cur.fetchall():
    print(f"  {row[0]}")

# DELETE
print("\nSuppression de Charlie :")
cur.execute("DELETE FROM etudiants WHERE data->>'nom' = 'Charlie'")
conn.commit()
print("  Charlie supprime.")

# ETAT FINAL
print("\nEtat final de la table :")
cur.execute("SELECT id, data FROM etudiants")
for row in cur.fetchall():
    print(f"  [{row[0]}] {row[1]}")

cur.close()
conn.close()
print("\nConnexion fermee.")
