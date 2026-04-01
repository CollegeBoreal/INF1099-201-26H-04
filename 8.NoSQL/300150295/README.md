# TP NoSQL — PostgreSQL JSONB
**Cours : INF1099-201-26H-04 | Étudiant : 300150295**

---

## 📁 Structure du projet

\\\
300150295/
├── README.md
├── images/
│   ├── Le conteneur Docker.png
│   ├── Les données dans la base (init.sql chargé).png
│   ├── L'index GIN présent.png
│   ├── Recherche par compétence Python.png
│   └── Le script Python qui tourne.png
├── init.sql
├── app.py
└── requirements.txt
\\\

---

## 🧱 Partie 1 — Docker

### Lancer PostgreSQL avec Docker (PowerShell)

\\\powershell
docker run --name postgres-nosql \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=ecole \
  -p 5432:5432 \
  -v \C:\Users\300150295\INF1099-201-26H-04\8.NoSQL\300150295/../init.sql:/docker-entrypoint-initdb.d/init.sql \
  -d postgres
\\\

### ✅ Vérifier que le conteneur tourne

\\\powershell
docker ps
\\\

![Le conteneur Docker](images/Le%20conteneur%20Docker.png)

---

## 🟡 Partie 2 — SQL NoSQL (JSONB)

### Table etudiants + Index GIN

Le fichier \init.sql\ est automatiquement chargé au démarrage du conteneur.
Il crée la table \etudiants\, un index GIN, et insère 3 étudiants.

\\\sql
CREATE TABLE etudiants (
    id   SERIAL PRIMARY KEY,
    data JSONB NOT NULL
);

CREATE INDEX idx_etudiants_data
ON etudiants USING GIN (data);
\\\

### ✅ Vérifier le chargement des données

\\\powershell
docker exec -it postgres-nosql psql -U postgres -d ecole -c "SELECT * FROM etudiants;"
\\\

![Les données dans la base](images/Les%20données%20dans%20la%20base%20(init.sql%20chargé).png)

### ✅ Vérifier l'index GIN

\\\powershell
docker exec -it postgres-nosql psql -U postgres -d ecole -c "\d etudiants"
\\\

![L'index GIN présent](images/L'index%20GIN%20présent.png)

### ✅ Recherche par compétence Python

\\\powershell
docker exec -it postgres-nosql psql -U postgres -d ecole -c "SELECT data FROM etudiants WHERE data->>'competences' LIKE '%Python%';"
\\\

![Recherche par compétence Python](images/Recherche%20par%20compétence%20Python.png)

### Opérateurs JSONB utilisés

| Opérateur | Rôle | Exemple |
|-----------|------|---------|
| \->\ | Retourne une valeur **JSONB** | \data->'competences'\ → \["Python","Docker"]\ |
| \->>\ | Retourne une valeur **texte** | \data->>'nom'\ → \Alice\ |
| \@>\ | Vérifie si JSONB **contient** une valeur | \data->'competences' @> '["Python"]'\ |
| \jsonb_set\ | **Modifie** un champ JSONB | \jsonb_set(data, '{age}', '23')\ |

---

## 🔵 Partie 3 — Python

### Installer les dépendances

\\\powershell
pip install -r requirements.txt
\\\

### Lancer le script

\\\powershell
python app.py
\\\

![Le script Python qui tourne](images/Le%20script%20Python%20qui%20tourne.png)

### Ce que fait app.py

| Opération | Description |
|-----------|-------------|
| **Connexion** | Connexion à PostgreSQL via \psycopg2\ |
| **INSERT** | Ajoute l'étudiant Diana en JSON |
| **SELECT ALL** | Affiche tous les étudiants |
| **SEARCH nom** | Recherche Alice avec \->>\ |
| **SEARCH compétence** | Recherche les étudiants Python avec \@>\ |
| **BONUS UPDATE** | Modifie l'âge de Bob avec \jsonb_set\ |
| **BONUS DELETE** | Supprime Diana par nom |

---

## 🟣 Bonus

### UPDATE — Modifier un champ JSON

\\\sql
UPDATE etudiants
SET    data = jsonb_set(data, '{age}', '23')
WHERE  data->>'nom' = 'Bob';
\\\

### DELETE — Supprimer un étudiant

\\\sql
DELETE FROM etudiants
WHERE data->>'nom' = 'Diana';
\\\

---

## 🛑 Arrêter le conteneur

\\\powershell
docker stop postgres-nosql
docker rm postgres-nosql
\\\

---

## 🎓 Compétences démontrées

- ✅ Déploiement d'un conteneur PostgreSQL avec Docker
- ✅ Modélisation NoSQL via JSONB dans PostgreSQL
- ✅ Index GIN pour des recherches performantes
- ✅ Script Python avec psycopg2 (INSERT, SELECT, filtre)
- ✅ Opérateurs JSONB : \->\, \->>\, \@>\, \jsonb_set\
- ✅ Gestion propre des dépendances via requirements.txt
