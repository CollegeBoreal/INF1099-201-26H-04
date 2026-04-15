# TP PostgreSQL — Procédures Stockées, Fonctions et Triggers

**Cours :** INF1099-201-26H-04  
**Étudiant :** 300150303  
**Technologies :** PostgreSQL 15, Docker, PL/pgSQL

---

## 📁 Structure du projet

```
300150303/
├── init/
│   ├── 01-ddl.sql            → Création des tables
│   ├── 02-dml.sql            → Données initiales
│   └── 03-programmation.sql  → Procédures, fonctions et triggers
├── tests/
│   └── test.sql              → Scénarios de tests
└── README.md
```

---

## 🗄️ Modèle de données

| Table         | Description                                  |
|---------------|----------------------------------------------|
| `etudiants`   | Informations des étudiants (nom, age, email) |
| `cours`       | Liste des cours disponibles                  |
| `inscriptions`| Lien entre étudiants et cours                |
| `logs`        | Journal de toutes les actions effectuées     |

---

## 🐳 Lancer le projet avec Docker

### 1. Démarrer le conteneur PostgreSQL

Depuis le dossier `300150303/` dans PowerShell :

```powershell
docker run -d `
  --name tp_postgres `
  -e POSTGRES_USER=etudiant `
  -e POSTGRES_PASSWORD=etudiant `
  -e POSTGRES_DB=tpdb `
  -p 5432:5432 `
  -v ${PWD}/init:/docker-entrypoint-initdb.d `
  postgres:15
```

> Les fichiers SQL dans `init/` sont exécutés automatiquement au démarrage dans l'ordre alphabétique.

### 2. Vérifier que le conteneur tourne

```powershell
docker ps
```

### 3. Se connecter à PostgreSQL

```powershell
docker exec -it tp_postgres psql -U etudiant -d tpdb
```

---

## ⚙️ Objets PL/pgSQL implémentés

### 1. Procédure `ajouter_etudiant`

Ajoute un étudiant avec validations complètes.

```sql
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');
```

**Validations :**
- Âge minimum de 18 ans
- Format d'email valide (`xxx@xxx.xxx`)
- Email unique (pas de doublon)

**Comportements :**
- `RAISE NOTICE` en cas de succès
- `RAISE NOTICE` avec message d'erreur détaillé en cas d'échec
- Journalisation automatique dans la table `logs`

---

### 2. Fonction `nombre_etudiants_par_age`

Retourne le nombre d'étudiants dans une tranche d'âge.

```sql
SELECT nombre_etudiants_par_age(18, 30);
```

**Validations :**
- Les âges doivent être positifs
- `min_age` ne peut pas être supérieur à `max_age`

---

### 3. Procédure `inscrire_etudiant_cours`

Inscrit un étudiant à un cours existant.

```sql
CALL inscrire_etudiant_cours('ali@email.com', 'Informatique');
```

**Validations :**
- L'étudiant doit exister (vérification par email)
- Le cours doit exister (vérification par nom)
- L'étudiant ne doit pas être déjà inscrit à ce cours

---

### 4. Trigger `trg_valider_etudiant` (BEFORE INSERT)

Se déclenche automatiquement avant chaque insertion dans `etudiants`.

- Vérifie que l'âge >= 18
- Vérifie le format de l'email
- Bloque l'insertion si une validation échoue

---

### 5. Triggers de log (`trg_log_etudiant` et `trg_log_inscription`)

Se déclenchent après chaque modification (INSERT, UPDATE, DELETE) sur `etudiants` et `inscriptions`.

- Enregistre l'opération, la table concernée et le nom de l'étudiant
- Gère les cas INSERT, UPDATE et DELETE avec les valeurs `NEW` et `OLD`

---

## 🧪 Exécuter les tests

```powershell
docker exec -i tp_postgres psql -U etudiant -d tpdb -f /tests/test.sql
```

### Scénarios de test couverts

| # | Test                                      | Résultat attendu              |
|---|-------------------------------------------|-------------------------------|
| 1 | Ajouter un étudiant valide                | NOTICE succès + log créé      |
| 2 | Ajouter un étudiant avec age < 18         | NOTICE erreur (age invalide)  |
| 3 | Ajouter un étudiant avec email invalide   | NOTICE erreur (email invalide)|
| 4 | Ajouter un étudiant avec email en double  | NOTICE erreur (doublon)       |
| 5 | Compter étudiants entre 18 et 30 ans      | Retourne un entier            |
| 6 | Inscrire un étudiant à un cours           | NOTICE succès + log créé      |
| 7 | Double inscription au même cours          | NOTICE erreur (déjà inscrit)  |
| 8 | Vérifier la table `etudiants`             | Liste des étudiants           |
| 9 | Vérifier les inscriptions (JOIN)          | Liste étudiant + cours        |
|10 | Vérifier la table `logs`                 | Historique des actions        |

---

## 🔄 Arrêter / Relancer le conteneur

```powershell
# Arrêter
docker stop tp_postgres

# Redémarrer
docker start tp_postgres

# Supprimer et recommencer à zéro
docker rm -f tp_postgres
```

> ⚠️ Pour réinitialiser la base de données, il faut supprimer et recréer le conteneur.

---

## 📝 Notes

- Le double trigger (procédure + trigger) sur `etudiants` est intentionnel : le trigger protège les insertions directes (hors procédure), la procédure offre des messages d'erreur plus riches.
- Les logs capturent toutes les opérations DML grâce aux triggers `AFTER INSERT OR UPDATE OR DELETE`.
