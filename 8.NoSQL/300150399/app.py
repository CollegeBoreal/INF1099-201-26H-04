import subprocess

def run_query(query):
    command = [
        "podman", "exec", "-i", "postgres-nosql",
        "psql", "-U", "postgres", "-d", "restaurants_db",
        "-c", query
    ]
    result = subprocess.run(command, capture_output=True, text=True)
    print(result.stdout)

print("📋 Tous les restaurants :")
run_query("SELECT data FROM restaurants;")

print("🔎 Restaurants à Toronto :")
run_query("SELECT data FROM restaurants WHERE data->>'city' = 'Toronto';")

print("➕ Ajout d'un restaurant :")
run_query("""
INSERT INTO restaurants (data) VALUES
('{"restaurant_name": "Taco House", "city": "Ottawa", "cuisine": "Mexican", "menu": ["Tacos", "Burritos"], "rating": 4.3}');
""")

print("✏️ Mise à jour :")
run_query("""
UPDATE restaurants
SET data = data || '{"delivery": true}'::jsonb
WHERE data->>'restaurant_name' = 'Taco House';
""")

print("🗑️ Suppression :")
run_query("""
DELETE FROM restaurants
WHERE data->>'restaurant_name' = 'Taco House';
""")