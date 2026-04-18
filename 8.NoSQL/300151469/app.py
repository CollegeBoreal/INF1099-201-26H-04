
"""
app.py
TP NoSQL — PostgreSQL JSONB avec Python
Auteur  : Rabia Bouhali — 300151469
Cours   : INF1099 — Collège Boréal
Date    : Avril 2026

Opérations démontrées :
  - Connexion à PostgreSQL via psycopg2
  - INSERT d'un document JSON
  - SELECT ALL
  - Recherche par nom          (->>)
  - Recherche par compétence   (@>)
  - UPDATE d'un champ JSON     (BONUS)
  - DELETE d'un enregistrement (BONUS)
"""

import psycopg2
import json

# ===========================================================================
# Connexion à la base de données
# ===========================================================================

def get_connection():
    """Crée et retourne une connexion PostgreSQL."""
    return psycopg2.connect(
        dbname="ecole",
        user="postgres",
        password="postgres",
        host="localhost",
        port=5432
    )


def separateur(titre):
    """Affiche un séparateur visuel pour la lisibilité des sorties."""
    print(f"\n{'=' * 50}")
    print(f"  {titre}")
    print('=' * 50)


# ===========================================================================
# Partie 1 — INSERT
# ===========================================================================

def inserer_etudiant(cur, conn):
    """Insère un nouvel étudiant sous forme de document JSON."""
    separateur("INSERT — Ajout de Diana")

    nouvel_etudiant = {
        "nom": "Diana",
        "age": 28,
        "competences": ["DevOps", "Kubernetes"]
    }

    cur.execute(
        "INSERT INTO etudiants (data) VALUES (%s) RETURNING id",
        [json.dumps(nouvel_etudiant)]
    )

    new_id = cur.fetchone()[0]
    conn.commit()

    print(f"✅ Étudiant inséré avec succès (id = {new_id})")
    print(f"   Données : {json.dumps(nouvel_etudiant, ensure_ascii=False)}")


# ===========================================================================
# Partie 2 — SELECT ALL
# ===========================================================================

def afficher_tous(cur):
    """Affiche tous les étudiants de la base."""
    separateur("SELECT ALL — Tous les étudiants")

    cur.execute("SELECT id, data FROM etudiants ORDER BY id")
    rows = cur.fetchall()

    print(f"  {len(rows)} étudiant(s) trouvé(s) :\n")
    for row in rows:
        etudiant = row[1]
        print(f"  [{row[0]}] {etudiant.get('nom')} | "
              f"Âge : {etudiant.get('age')} | "
              f"Compétences : {', '.join(etudiant.get('competences', []))}")


# ===========================================================================
# Partie 3 — SEARCH par nom (->>)
# ===========================================================================

def rechercher_par_nom(cur, nom):
    """
    Recherche un étudiant par son nom.
    Utilise l'opérateur ->>'nom' pour extraire la valeur texte du champ JSON.
    """
    separateur(f"SEARCH — Recherche par nom : '{nom}'")

    cur.execute("""
        SELECT id, data
        FROM etudiants
        WHERE data->>'nom' = %s
    """, [nom])

    rows = cur.fetchall()

    if rows:
        for row in rows:
            print(f"  ✅ Trouvé : {json.dumps(row[1], ensure_ascii=False)}")
    else:
        print(f"  ❌ Aucun étudiant nommé '{nom}' trouvé.")


# ===========================================================================
# Partie 4 — SEARCH par compétence (@>)
# ===========================================================================

def rechercher_par_competence(cur, competence):
    """
    Recherche les étudiants possédant une compétence spécifique.
    Utilise l'opérateur @> (contient) pour chercher dans un tableau JSON.
    """
    separateur(f"SEARCH — Compétence : '{competence}'")

    cur.execute("""
        SELECT id, data
        FROM etudiants
        WHERE data @> %s::jsonb
    """, [json.dumps({"competences": [competence]})])

    rows = cur.fetchall()

    if rows:
        print(f"  {len(rows)} étudiant(s) avec la compétence '{competence}' :\n")
        for row in rows:
            etudiant = row[1]
            print(f"  [{row[0]}] {etudiant.get('nom')} — "
                  f"{', '.join(etudiant.get('competences', []))}")
    else:
        print(f"  ❌ Aucun étudiant avec la compétence '{competence}'.")


# ===========================================================================
# BONUS — UPDATE : modifier un champ JSON
# ===========================================================================

def mettre_a_jour_age(cur, conn, nom, nouvel_age):
    """
    Met à jour le champ 'age' d'un étudiant identifié par son nom.
    Utilise la fonction jsonb_set() pour modifier un champ sans écraser tout le document.
    """
    separateur(f"UPDATE (BONUS) — Modifier l'âge de '{nom}'")

    cur.execute("""
        UPDATE etudiants
        SET data = jsonb_set(data, '{age}', %s::jsonb)
        WHERE data->>'nom' = %s
        RETURNING id, data
    """, [str(nouvel_age), nom])

    row = cur.fetchone()
    conn.commit()

    if row:
        print(f"  ✅ Mise à jour réussie (id = {row[0]})")
        print(f"     Nouvelles données : {json.dumps(row[1], ensure_ascii=False)}")
    else:
        print(f"  ❌ Étudiant '{nom}' introuvable.")


# ===========================================================================
# BONUS — DELETE : supprimer un étudiant
# ===========================================================================

def supprimer_etudiant(cur, conn, nom):
    """
    Supprime un étudiant identifié par son nom.
    Utilise l'opérateur ->> pour filtrer sur le champ JSON 'nom'.
    """
    separateur(f"DELETE (BONUS) — Supprimer '{nom}'")

    cur.execute("""
        DELETE FROM etudiants
        WHERE data->>'nom' = %s
        RETURNING id, data
    """, [nom])

    row = cur.fetchone()
    conn.commit()

    if row:
        print(f"  ✅ Étudiant supprimé (id = {row[0]}) : "
              f"{row[1].get('nom')}")
    else:
        print(f"  ❌ Étudiant '{nom}' introuvable.")


# ===========================================================================
# Programme principal
# ===========================================================================

if __name__ == "__main__":
    print("\n🐘 TP NoSQL — PostgreSQL JSONB")
    print("   Rabia Bouhali | 300151469 | INF1099\n")

    conn = get_connection()
    cur  = conn.cursor()

    try:
        # Partie obligatoire
        inserer_etudiant(cur, conn)
        afficher_tous(cur)
        rechercher_par_nom(cur, "Alice")
        rechercher_par_competence(cur, "Python")

        # Bonus
        mettre_a_jour_age(cur, conn, "Bob", 23)
        supprimer_etudiant(cur, conn, "Diana")

        # Affichage final après toutes les opérations
        separateur("ÉTAT FINAL — Tous les étudiants")
        afficher_tous(cur)

    except Exception as e:
        print(f"\n❌ Erreur : {e}")
        conn.rollback()

    finally:
        cur.close()
        conn.close()
        print("\n🔌 Connexion fermée.\n")
