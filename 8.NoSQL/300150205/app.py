# ============================================================
# app.py
# Mini base NoSQL avec PostgreSQL JSONB
# #300150205
# ============================================================

import psycopg2
import json

# ------------------------------------------------------------
# Connexion à PostgreSQL
# ------------------------------------------------------------
conn = psycopg2.connect(
    dbname="ecole",
    user="postgres",
    password="postgres",
    host="localhost",
    port=5432
)

cur = conn.cursor()

# ------------------------------------------------------------
# INSERT — Ajouter un étudiant
# ------------------------------------------------------------
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

# ------------------------------------------------------------
# SELECT ALL — Afficher tous les étudiants
# ------------------------------------------------------------
print("\nTous les etudiants :")
cur.execute("SELECT id, data FROM etudiants ORDER BY id")

for row in cur.fetchall():
    print(f"  [{row[0]}] {row[1]}")

# ------------------------------------------------------------
# SEARCH — Rechercher par nom
# ------------------------------------------------------------
print("\nRecherche par nom (Alice) :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->>'nom' = 'Alice'
""")

for row in cur.fetchall():
    print(f"  {row[0]}")

# ------------------------------------------------------------
# SEARCH — Rechercher par compétence (Python)
# ------------------------------------------------------------
print("\nEtudiants avec la competence Python :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->'competences' ? 'Python'
""")

for row in cur.fetchall():
    print(f"  {row[0]}")

# ------------------------------------------------------------
# BONUS — UPDATE JSON
# Mettre à jour l'âge de Bob
# ------------------------------------------------------------
print("\nMise a jour age de Bob (22 -> 23) :")
cur.execute("""
    UPDATE etudiants
    SET data = data || '{"age": 23}'::jsonb
    WHERE data->>'nom' = 'Bob'
""")

conn.commit()

cur.execute("SELECT data FROM etudiants WHERE data->>'nom' = 'Bob'")
for row in cur.fetchall():
    print(f"  {row[0]}")

# ------------------------------------------------------------
# BONUS — DELETE
# Supprimer un étudiant par nom
# ------------------------------------------------------------
print("\nSuppression de Charlie :")
cur.execute("""
    DELETE FROM etudiants
    WHERE data->>'nom' = 'Charlie'
""")

conn.commit()
print("  Charlie supprime.")

# ------------------------------------------------------------
# Vérification finale
# ------------------------------------------------------------
print("\nEtat final de la table :")
cur.execute("SELECT id, data FROM etudiants ORDER BY id")

for row in cur.fetchall():
    print(f"  [{row[0]}] {row[1]}")

# ------------------------------------------------------------
# Fermeture de la connexion
# ------------------------------------------------------------
cur.close()
conn.close()
print("\nConnexion fermee.")
