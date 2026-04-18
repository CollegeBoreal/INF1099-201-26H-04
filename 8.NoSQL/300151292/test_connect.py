import psycopg2

# ============================================================
# test_connect.py - BorealFit - Test de connexion PostgreSQL
# Auteur : Amine Kahil - 300151292
# ============================================================

try:
    conn = psycopg2.connect(
        dbname="borealfit",
        user="postgres",
        password="postgres",
        host="localhost",
        port=5432
    )
    print("Connexion reussie a PostgreSQL !")
    print(f"Version : {conn.server_version}")

    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM seances;")
    count = cur.fetchone()[0]
    print(f"Nombre de seances dans la base : {count}")

    cur.close()
    conn.close()
    print("Connexion fermee.")

except Exception as e:
    print(f"Erreur de connexion : {e}")
