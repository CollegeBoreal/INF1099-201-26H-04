# 🧪 TP : NoSQL 

## 🎯 Objectif

Construire une mini base NoSQL avec :

* PostgreSQL (JSONB)
* Docker (conteneur simple)
* Python + `requirements.txt` pour les dépendances

---

# 🧱 1️⃣ Lancer PostgreSQL avec Docker

```bash id="d6kq7x"
docker run --name postgres-nosql \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  -v $(pwd)/init.sql:/docker-entrypoint-initdb.d/init.sql \
  -d postgres
```

---

# 📄 2️⃣ Fichier SQL unique : `init.sql`

👉 Crée la table + charge les données

```sql id="g8m2pq"
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);

INSERT INTO etudiants (data) VALUES
('{"nom": "Alice", "age": 25, "competences": ["Python", "Docker"]}'),
('{"nom": "Bob", "age": 22, "competences": ["Java", "SQL"]}'),
('{"nom": "Charlie", "age": 30, "competences": ["Linux", "Bash", "Python"]}');
```

---

# 📦 3️⃣ Dépendances Python

## 📄 `requirements.txt`

```txt id="k1n7rt"
psycopg2-binary
```

---

## 📥 Installation

```bash id="p9x2lm"
pip install -r requirements.txt
```

---

# 🐍 4️⃣ Script Python

## 📄 `app.py`

```python id="t3v9qa"
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

# 🔹 INSERT
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

# 🔹 SELECT ALL
print("\n📌 Tous les étudiants :")
cur.execute("SELECT data FROM etudiants")

for row in cur.fetchall():
    print(row[0])

# 🔹 SEARCH
print("\n🔎 Recherche Alice :")
cur.execute("""
    SELECT data FROM etudiants
    WHERE data->>'nom' = 'Alice'
""")

for row in cur.fetchall():
    print(row[0])

cur.close()
conn.close()
```

---

# 🎯 5️⃣ Travail demandé (TP étudiant)

## 🟢 Partie 1 — Docker

* Lancer PostgreSQL avec Docker
* Vérifier que la base `ecole` fonctionne
* Vérifier le chargement automatique de `init.sql`

---

## 🟡 Partie 2 — SQL NoSQL

* Table `etudiants` créée automatiquement
* Index GIN présent
* Requêtes :

  * afficher tous les étudiants
  * rechercher par nom
  * rechercher compétence "Python"

---

## 🔵 Partie 3 — Python

* Installer dépendances via `requirements.txt`
* Connexion PostgreSQL
* INSERT JSON
* SELECT ALL
* Recherche filtrée

---

## 🟣 Bonus

* Ajouter suppression d’un étudiant
* Ajouter update JSON
* Utiliser `->` et `->>` correctement

---

# 📦 LIVRABLES

```text id="y5kq1v"
🆔/
├── README.md
├── images
├── init.sql
├── app.py
├── requirements.txt
```

---

# 🎓 COMPÉTENCES VISÉES

* Déploiement container PostgreSQL
* NoSQL avec JSONB
* Python backend simple
* Gestion dépendances propre (`requirements.txt`)

