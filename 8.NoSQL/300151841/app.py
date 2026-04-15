import pg8000.native
import json

con = pg8000.native.Connection(
    user="postgres",
    password="postgres",
    host="127.0.0.1",
    port=5432,
    database="ecole"
)

print("Connexion OK")

nouveau_tournoi = {
    "tournament_name": "Autumn Masters 2026",
    "game": "Rocket League",
    "start_date": "2026-09-20",
    "end_date": "2026-09-21",
    "format": "BO5",
    "teams": ["Sky Riders", "Turbo Stars"],
    "location": "Quebec City"
}
con.run("INSERT INTO tournaments (data) VALUES (:data)", data=json.dumps(nouveau_tournoi))
print("INSERT OK")

rows = con.run("SELECT data FROM tournaments")
print("\nTous les tournois :")
for row in rows:
    print(row[0])

rows = con.run("SELECT data FROM tournaments WHERE data->>'game' = 'Valorant'")
print("\nTournois Valorant :")
for row in rows:
    print(row[0])

rows = con.run("SELECT data FROM tournaments WHERE data->'teams' @> :team::jsonb", team='["Alpha Wolves"]')
print("\nTournois avec Alpha Wolves :")
for row in rows:
    print(row[0])

con.run("UPDATE tournaments SET data = data || :patch::jsonb WHERE data->>'tournament_name' = 'Summer Cup 2026'", patch=json.dumps({"location": "Vancouver"}))
print("\nUPDATE OK")

con.run("DELETE FROM tournaments WHERE data->>'tournament_name' = 'Autumn Masters 2026'")
print("DELETE OK")

con.close()
print("\nConnexion fermee")
