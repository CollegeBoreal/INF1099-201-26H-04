$readme = @"
# TP PostgreSQL — Stored Procedures, Fonctions et Triggers
**Etudiant :** 300148210  
**Cours :** INF1099-201-26H-04  
**Date :** 2026-04-20

---

## Structure du projet

\`\`\`
300148210/
|
├── init/
│   ├── 01-ddl.sql              # Creation des tables
│   ├── 02-dml.sql              # Donnees initiales
│   ├── 03-programmation.sql    # Procedures, fonctions, triggers
│   └── fix_trigger.sql         # Correctif trigger log_action
|
├── tests/
│   └── test.sql                # Tests des procedures et fonctions
|
└── README.md
\`\`\`

---

## Lancer le projet avec Docker

\`\`\`powershell
docker run -d \`
  --name tp_postgres \`
  -e POSTGRES_USER=etudiant \`
  -e POSTGRES_PASSWORD=etudiant \`
  -e POSTGRES_DB=tpdb \`
  -p 5433:5432 \`
  -v \${PWD}/init:/docker-entrypoint-initdb.d \`
  postgres:15
\`\`\`

---

## Lancer les tests

\`\`\`powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
\`\`\`

---

## Ce qui a ete implemente

### 1. Procedure ajouter_etudiant
- Valide que l age est >= 18
- Valide le format de l email
- Insere l etudiant dans la table
- Journalise l action dans logs
- Gere les exceptions avec RAISE NOTICE

### 2. Fonction nombre_etudiants_par_age
- Retourne le nombre d etudiants dans une tranche d age
- Utilise COUNT(*) avec BETWEEN

### 3. Procedure inscrire_etudiant_cours
- Verifie l existence de l etudiant et du cours
- Verifie que l inscription n existe pas deja
- Insere dans la table inscriptions
- Journalise l action

### 4. Trigger trg_valider_etudiant (BEFORE INSERT)
- Valide age >= 18 avant chaque insertion
- Valide le format email

### 5. Trigger trg_log_etudiant et trg_log_inscription (AFTER INSERT/UPDATE/DELETE)
- Journalise automatiquement toutes les modifications
- Enregistre l operation (INSERT/UPDATE/DELETE), la table et l id

---

## Resultats des tests

### Capture 1 — Tests initiaux : ajout etudiant, validation age, fonction

<img width="920" height="526" alt="Screenshot 2026-04-20 181958" src="https://github.com/user-attachments/assets/f197b732-4777-40d0-80f3-51e4183d98b7" />

- Etudiant Ali ajoute avec succes
- Bob rejete car age < 18 (Age invalide pour Bob)
- nombre_etudiants_par_age retourne 2

### Capture 2 — Logs apres fix du trigger

<img width="928" height="403" alt="Screenshot 2026-04-20 182132" src="https://github.com/user-attachments/assets/d9e2cc43-3a5c-47bc-9fd2-85b67aa95526" />

- Trigger log corrige pour la table inscriptions
- 4 entrees dans les logs : INSERT etudiants, ajout etudiant, INSERT inscriptions, inscription cours

### Capture 3 — Logs complets finaux

<img width="933" height="583" alt="Screenshot 2026-04-20 182627" src="https://github.com/user-attachments/assets/6dddaa1e-a555-4f47-a95e-4a4e801a0efd" />

- Tous les logs s affichent correctement
- Trigger et procedures fonctionnent ensemble

---

