$readme = @'
# TP PostgreSQL — PL/pgSQL

**Etudiant** : 300151833
**Cours** : INF1099-201-26H-04
**SGBD** : PostgreSQL 15

---

## Structure du projet

    300151833/
    ├── init/
    │   ├── 01-ddl.sql
    │   ├── 02-dml.sql
    │   └── 03-programmation.sql
    ├── tests/
    │   └── test.sql
    ├── images/
    │   ├── tests-results.png
    │   └── psql-tables.png
    └── README.md

---

## Lancer le TP avec Docker

    docker run -d
      --name tp_postgres
      -e POSTGRES_USER=etudiant
      -e POSTGRES_PASSWORD=etudiant
      -e POSTGRES_DB=tpdb
      -p 5433:5432
      -v CHEMIN\init:/docker-entrypoint-initdb.d
      postgres:15

### Connexion psql

    docker exec -it tp_postgres psql -U etudiant -d tpdb

### Lancer les tests

    Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb

---

## Fonctionnalites implementees

### 1. Procedure ajouter_etudiant
- Valide age >= 18
- Valide format email
- Insere dans etudiants
- Journalise dans logs
- Gere les exceptions

### 2. Fonction nombre_etudiants_par_age
- Retourne le nombre d etudiants dans une tranche d age
- Valide que min_age <= max_age

### 3. Procedure inscrire_etudiant_cours
- Verifie existence etudiant et cours
- Bloque les doublons d inscription
- Journalise dans logs

### 4. Trigger trg_valider_etudiant
- BEFORE INSERT sur etudiants
- Valide age et email automatiquement

### 5. Triggers trg_log_etudiant et trg_log_inscription
- AFTER INSERT, UPDATE, DELETE
- Journalise toutes les modifications

---

## Tables

| Table | Description |
|-------|-------------|
| etudiants | Stocke les etudiants |
| cours | Stocke les cours |
| inscriptions | Lie etudiants et cours |
| logs | Journalise les actions |

---

## Resultats des tests

### Tests PowerShell - Procedures et logs

<img width="672" height="392" alt="7 1" src="https://github.com/user-attachments/assets/3aad6f85-6171-4869-b45c-e19e594892dd" />

### Verification des tables dans psql
<img width="932" height="490" alt="7 2" src="https://github.com/user-attachments/assets/03aeb909-9d77-4f28-9576-c53c0987b8a2" />

---

## Tests effectues

| Test | Resultat |
|------|----------|
| Insertion valide Ali 22 ans | OK |
| Insertion valide Sara 25 ans | OK |
| Insertion age invalide Bob 15 ans | Exception levee OK |
| Insertion email invalide | Exception levee OK |
| Fonction nombre_etudiants_par_age | Retourne 2 OK |
| Inscription etudiant cours | OK |
| Double inscription bloquee | Exception levee OK |
| Logs automatiques trigger | 4 entrees OK |
'@

Set-Content -Path "C:\WINDOWS\system32\INF1099-201-26H-04\7.PLSQL\300151833\README.md" -Value $readme -Encoding UTF8
Write-Host "README cree !"
