import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="cargorent_tp",
    user="postgres",
    password="postgres",
    port="5432"
)

cur = conn.cursor()

cur.execute("SELECT data FROM cargorent_json;")

rows = cur.fetchall()

for row in rows:
    print(row)

cur.close()
conn.close()