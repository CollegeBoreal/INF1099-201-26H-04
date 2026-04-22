##🧪 TP NoSQL — PostgreSQL JSONB
##Étudiant : 300148210 — Feriel Ziani
##Cours : INF1099-201-26H-04

🟢 Partie 1 — Docker


Lancer PostgreSQL avec Podman
powershellpodman container run --name postgres-nosql `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=ecole `
  -p 5432:5432 `
  -v ${PWD}/init.sql:/docker-entrypoint-initdb.d/init.sql `
  -d postgres
  
✅ Résultat — Conteneur lancé
<img width="935" height="409" alt="Screenshot 2026-04-19 195126" src="https://github.com/user-attachments/assets/fff50f2b-7e68-4126-a700-006bca8bca6c" />

🟡 Partie 2 — SQL NoSQL
Table etudiants + données
sqlSELECT * FROM etudiants;
✅ Résultat — Tous les étudiants

<img width="915" height="447" alt="Screenshot 2026-04-19 195254" src="https://github.com/user-attachments/assets/829ec559-96da-4a40-adcc-4aed883f90c6" />

Index GIN
sql\d etudiants

✅ Résultat — Index GIN présent
Show Image
<img width="937" height="305" alt="Screenshot 2026-04-19 195339" src="https://github.com/user-attachments/assets/c1f296fd-99cb-49c3-a58f-3b9c30f9e39e" />

Recherche par nom (opérateur ->>)
sqlSELECT data FROM etudiants WHERE data->>'nom' = 'Alice';
Recherche par compétence (opérateur ->)
sqlSELECT data FROM etudiants WHERE data->'competences' ? 'Python';

✅ Résultat — Recherches
Show Image
<img width="941" height="429" alt="Screenshot 2026-04-19 195413" src="https://github.com/user-attachments/assets/83602b95-3335-49ff-a80d-100649c53be0" />

🔵 Partie 3 — Python
Installation des dépendances
powershellpython -m pip install -r requirements.txt
✅ Résultat — pip install

Show Image
<img width="927" height="355" alt="Screenshot 2026-04-19 195524" src="https://github.com/user-attachments/assets/954c7ce7-d075-49d6-943e-78c85738deaf" />

Lancement du script
powershellpython app.py

✅ Résultat — app.py
Show Image
<img width="935" height="292" alt="Screenshot 2026-04-19 195606" src="https://github.com/user-attachments/assets/d6d76f70-5b13-4e67-8737-813c3042cbab" />

🎓 Compétences démontrées

✅ Déploiement container PostgreSQL avec Podman
✅ NoSQL avec JSONB dans PostgreSQL
✅ Index GIN pour la performance
✅ Opérateurs -> et ->>
✅ Script Python avec INSERT, SELECT, SEARCH
✅ Gestion des dépendances avec requirements.txt
