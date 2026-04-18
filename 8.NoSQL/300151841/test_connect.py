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
con.close()
