import psycopg2

try:
    conn = psycopg2.connect(
        host="localhost",
        database="cargorent_tp",
        user="postgres",
        password="postgres",
        port="5432"
    )

    print("Connexion réussie !")

    conn.close()

except Exception as e:
    print("Erreur :", e)