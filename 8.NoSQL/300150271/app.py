import psycopg

print("=== DEMARRAGE SCRIPT ===\n")

try:
    conn = psycopg.connect(
        dbname="immobilier",
        user="postgres",
        password="postgres",
        host="localhost",
        port="5432"
    )

    cur = conn.cursor()
    print("Connexion OK\n")

    cur.execute("SELECT * FROM CLIENT")
    rows = cur.fetchall()

    print("Liste des clients :")
    for row in rows:
        print(row)

    cur.close()
    conn.close()

    print("\n=== FIN SCRIPT ===")

except Exception as e:
    print("ERREUR :", e)