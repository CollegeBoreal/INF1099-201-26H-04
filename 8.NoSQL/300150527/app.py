import subprocess
import tempfile
import json

def run_psql(sql):
    subprocess.run([
        "powershell", "-Command",
        f'docker exec -i postgres-nosql psql -U postgres -d ecole -c "{sql}"'
    ])

def insert_json(obj):
    data = json.dumps(obj)
    sql = f"INSERT INTO etudiants (data) VALUES ('{data}');"
    subprocess.run(
        ["powershell", "-Command", "docker exec -i postgres-nosql psql -U postgres -d ecole"],
        input=sql.encode("utf-8")
    )

print("Ajout de Diana")

insert_json({
    "nom": "Diana",
    "age": 28,
    "competences": ["DevOps", "Kubernetes"]
})

print("\nTous les étudiants :")
run_psql("SELECT * FROM etudiants;")

print("\nRecherche Alice :")
run_psql("SELECT data FROM etudiants WHERE data->>'nom' = 'Alice';")

print("\nRecherche Python :")
run_psql("SELECT data FROM etudiants WHERE data->'competences' ? 'Python';")

print("\nMise a jour age de Bob (22 -> 23) :")

sql = """
UPDATE etudiants
SET data = data || '{"age": 23}'::jsonb
WHERE data->>'nom' = 'Bob';
"""

subprocess.run(
    ["powershell", "-Command", "docker exec -i postgres-nosql psql -U postgres -d ecole"],
    input=sql.encode("utf-8")
)

run_psql("SELECT data FROM etudiants WHERE data->>'nom' = 'Bob';")

print("\nSuppression de Charlie :")
run_psql("DELETE FROM etudiants WHERE data->>'nom' = 'Charlie';")

print("\nEtat final de la table :")
run_psql("SELECT * FROM etudiants;")