# 📝 Leçon - Languages Procéduraux

[:tada: Participation](.scripts/Participation.md)

* **PL/SQL** (Procedural Language / SQL) a été **développé et popularisé par Oracle** dans les années **1980** pour ajouter des capacités procédurales à SQL.

* Avant PL/SQL, SQL était **strictement déclaratif**, donc limité pour :

  * Boucles, conditions, variables
  * Gestion d’erreurs avancée
  * Logique métier côté serveur

* PL/SQL est **intégré à tous les SGBD Oracle**, ce qui permet :

  * Procédures stockées
  * Fonctions
  * Triggers
  * Packages (ensembles de procédures et fonctions)

* Depuis, d’autres SGBD ont créé des langages similaires :

  * PostgreSQL → PL/pgSQL
  * SQL Server → T-SQL
  * MySQL → SQL/PSM

💡 En résumé : **Oracle a inventé et popularisé le concept de SQL procédural avec PL/SQL**, et les autres SGBD ont suivi avec leurs propres variantes.

---


## ⚠️ Limites et risques des PL dans une base

1. **Verrouillage sur un SGBD spécifique**

   * PL/SQL → Oracle
   * PL/pgSQL → PostgreSQL
   * T-SQL → SQL Server
   * Les procédures et fonctions écrites pour un SGBD **ne fonctionnent pas directement sur un autre**
     → Rend la base **difficile à migrer**.

2. **Complexité et maintenance**

   * Si tu mets trop de logique métier dans la base, ça devient **compliqué à maintenir**.
   * Les modifications nécessitent souvent des **redéploiements complexes**.

3. **Performance mal gérée**

   * Les PL peuvent être rapides pour certaines tâches, mais **si mal utilisées** (boucles lourdes, curseurs mal optimisés), elles **peuvent ralentir la base**.

4. **Testabilité réduite**

   * La logique métier dans la base est **moins facile à tester** qu’une application externe avec un framework moderne.

---

### ✅ En résumé :

> Le gros problème : **dépendance forte au SGBD et difficulté de maintenance**, surtout dans des environnements multi-SGBD ou évolutifs.

💡 Bonne pratique : **mettre dans les PL ce qui doit vraiment rester proche des données**, mais **laisser la logique applicative dans le code de l’application**.

---

## 1️⃣ Pourquoi les PL sont populaires

1. **Performance** :

   * Exécuter des calculs ou validations directement dans la base évite de transférer de gros volumes de données vers l’application.

2. **Centralisation de la logique métier** :

   * Les règles, validations, calculs, et traitements sont stockés **au même endroit** que les données, ce qui facilite maintenance et cohérence.

3. **Automatisation avec triggers** :

   * Déclencher des actions automatiquement sur `INSERT`, `UPDATE`, `DELETE` sans intervention côté application.

4. **Sécurité et contrôle** :

   * Limite l’accès direct aux tables sensibles via des procédures contrôlées.

---

## 2️⃣ Exemples de PL très utilisés

| SGBD            | Langage PL | Usage fréquent                                                         |
| --------------- | ---------- | ---------------------------------------------------------------------- |
| Oracle          | PL/SQL     | Procédures stockées, triggers, packages pour ERP et systèmes bancaires |
| PostgreSQL      | PL/pgSQL   | Logiciel métier, ETL, validations complexes, triggers                  |
| SQL Server      | T-SQL      | Procédures stockées, fonctions définies par l’utilisateur, reporting   |
| MySQL / MariaDB | SQL/PSM    | Procédures stockées simples, triggers pour apps web                    |

---

## 3️⃣ Cas typiques d’utilisation

* Calculs complexes avant insertion (ex : facturation, TVA, commissions)
* Validation automatique de données (ex : âge, email, cohérence entre tables)
* Génération de logs ou historiques via triggers
* Systèmes transactionnels (banque, ERP, gestion d’inventaire)

---

💡 **En résumé :**
Les PL **sont très utilisés dans le monde professionnel**, surtout dans des systèmes critiques où :

* La logique métier doit rester proche de la base
* Les performances sont importantes
* La sécurité et la cohérence des données sont cruciales


## 1️⃣ Objectifs pédagogiques

1. Expliquer la différence entre **fonction** et **procédure stockée**.
2. Montrer comment créer et appeler des fonctions et procédures en **PL/pgSQL**.
3. Illustrer l’usage des **triggers** pour automatiser la logique métier.
4. Montrer la gestion des exceptions et le logging dans PostgreSQL.

---

## 2️⃣ Définitions clés

| Élément                   | Description                                                                                | Exemple d’appel                                        |
| ------------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------ |
| **Fonction (FUNCTION)**   | Retourne une valeur ou un type, peut être utilisée dans un `SELECT`                        | `SELECT addition(2,3);`                                |
| **Procédure (PROCEDURE)** | Ne retourne pas directement de valeur, peut gérer des transactions                         | `CALL ajouter_etudiant('Alice',22,'alice@email.com');` |
| **Trigger**               | Fonction spéciale exécutée automatiquement sur un événement (`INSERT`, `UPDATE`, `DELETE`) | Automatiquement, pas d’appel manuel                    |

---

## 3️⃣ Syntaxe de base

### 3.1 Fonction

```sql
CREATE OR REPLACE FUNCTION nom_fonction(param1 type, param2 type, ...)
RETURNS type_retour
LANGUAGE plpgsql
AS $$
BEGIN
    -- instructions
    RETURN valeur;  -- obligatoire
END;
$$;
```

**Exemple :**

```sql
CREATE OR REPLACE FUNCTION addition(a INT, b INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a + b;
END;
$$;

SELECT addition(5,3); -- Résultat : 8
```

---

### 3.2 Procédure

```sql
CREATE OR REPLACE PROCEDURE nom_proc(param1 type, param2 type, ...)
LANGUAGE plpgsql
AS $$
BEGIN
    -- instructions
END;
$$;
```

**Exemple :**

```sql
CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO etudiants(nom, age, email) VALUES (nom, age, email);
    RAISE NOTICE 'Etudiant ajouté : %', nom;
END;
$$;

CALL ajouter_etudiant('Alice', 22, 'alice@email.com');
```

---

### 3.3 Trigger

* Déclenché automatiquement sur un **événement** (`BEFORE` ou `AFTER` insertion, mise à jour, suppression)
* Peut être utilisé pour :

  * Validation de données
  * Journalisation (logs)
  * Calcul automatique

**Exemple simple :**

```sql
CREATE OR REPLACE FUNCTION log_etudiant()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || NEW.nom);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER etudiant_log
AFTER INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_etudiant();
```

---

## 4️⃣ Gestion des exceptions

* `RAISE NOTICE 'message'` → Message informatif
* `RAISE EXCEPTION 'message'` → Interrompt l’exécution, déclenche une erreur

**Exemple :**

```sql
BEGIN
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide';
    END IF;
EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur détectée : %', SQLERRM;
END;
```

---

## 5️⃣ Bonnes pratiques à expliquer

1. **Toujours gérer les exceptions** pour éviter les interruptions de la base.
2. **RAISE NOTICE** utile pour le débogage et le suivi.
3. **Documenter** les fonctions et procédures : paramètres, retour, action.
4. **Limiter le travail dans les triggers** : privilégier les procédures pour la logique complexe.
5. **Tester systématiquement** : cas valides et invalides.

---

# 🐳 **TP PostgreSQL — Stored Proc**

## 1️⃣ Structure du projet

```
🆔/
│
├── init/
│   ├── 01-ddl.sql
│   ├── 02-dml.sql
│   └── 03-programmation.sql   <-- À compléter par l’étudiant
│
├── tests/
│   └── test.sql
│
└── README.md
```

---

## 2️⃣ Lancer PostgreSQL avec Docker

- [ ] 🪟 PowerShell

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

- [ ] 🐧 *nix

```bash
docker run -d \
  --name tp_postgres \
  -e POSTGRES_USER=etudiant \
  -e POSTGRES_PASSWORD=etudiant \
  -e POSTGRES_DB=tpdb \
  -p 5432:5432 \
  -v ${PWD}/init:/docker-entrypoint-initdb.d \
  postgres:15
```

### Explications

* `-v $(pwd)/init:/docker-entrypoint-initdb.d` → tous les fichiers SQL dans `init/` sont exécutés automatiquement au démarrage.
* `-p 5432:5432` → exposer PostgreSQL sur ton PC.
* Les étudiants peuvent compléter `03-programmation.sql` sans toucher à Docker.

---

## 3️⃣ Fichiers fournis

### 3.1 `01-ddl.sql`

```sql
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT,
    email TEXT UNIQUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3.2 `02-dml.sql`

```sql
INSERT INTO etudiants (nom, age, email)
VALUES ('Test', 20, 'test@email.com');
```

### 3.3 `03-programmation.sql`

> À compléter par l’étudiant :
>
> * procédure `ajouter_etudiant`
> * fonction `nombre_etudiants`
> * trigger validation âge
> * trigger log
> * RAISE NOTICE / gestion erreurs

---

## 4️⃣ Fichier tests/test.sql

```sql
-- Test insertion valide
CALL ajouter_etudiant('Ali', 22, 'ali@email.com');

-- Test insertion invalide
DO $$
BEGIN
    BEGIN
        CALL ajouter_etudiant('Bob', 15, 'bob@email.com');
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'Erreur attendue OK';
    END;
END;
$$;

-- Test fonction
SELECT nombre_etudiants();

-- Vérifier logs
SELECT * FROM logs;
```

---

## 5️⃣ Connexion à PostgreSQL

```bash
docker container exec -it tp_postgres psql -U etudiant -d tpdb
```

---

## 6️⃣ Automatiser les tests


- [ ] 🪟 Windows

```powershell
Get-Content tests/test.sql | docker exec -i tp_postgres psql -U etudiant -d tpdb
```

- [ ] 🐧 *nix

```bash
docker container exec -i tp_postgres psql -U etudiant -d tpdb < tests/test.sql
```

> Les étudiants verront directement les résultats des triggers et procédures.

---

## 7️⃣ Avantages de cette version

* Très simple : **une seule commande Docker** pour lancer PostgreSQL.
* Les volumes `init/` permettent aux étudiants de remettre leur code facilement.

---

**Fichier `03-programmation.sql` , les exemples et **les parties à compléter en commentaires** à coder.

---

```sql
-- ==================================================================================
-- 03-programmation.sql
-- TP PostgreSQL : Fonctions, Procédures Stockées et Triggers
-- ==================================================================================

-- ============================================================
-- 1️⃣ Procédure : ajouter_etudiant
-- ============================================================
-- Objectif : Ajouter un étudiant avec validations et journalisation
-- Étudiant doit compléter : la partie RAISE NOTICE, exceptions, validations
-- ============================================================

CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- TODO : Vérifier que l'âge >= 18
    IF age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', nom;
    END IF;

    -- TODO : Vérifier que l'email est valide et unique
    IF email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', nom;
    END IF;

    -- Insertion de l'étudiant
    INSERT INTO etudiants(nom, age, email)
    VALUES (nom, age, email);

    -- TODO : Ajouter journalisation dans logs
    INSERT INTO logs(action)
    VALUES ('Ajout étudiant : ' || nom);

    -- TODO : RAISE NOTICE indiquant succès
    RAISE NOTICE 'Etudiant ajouté : %', nom;

EXCEPTION
    WHEN others THEN
        -- TODO : RAISE NOTICE indiquant erreur
        RAISE NOTICE 'Erreur lors de l’ajout de % : %', nom, SQLERRM;
END;
$$;

-- ============================================================
-- 2️⃣ Fonction : nombre_etudiants_par_age
-- ============================================================
-- Objectif : Retourne le nombre d'étudiants dans une tranche d'âge
-- Étudiant doit compléter : éventuellement optimisations ou validations supplémentaires
-- ============================================================

CREATE OR REPLACE FUNCTION nombre_etudiants_par_age(min_age INT, max_age INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM etudiants
    WHERE age BETWEEN min_age AND max_age;

    RETURN total;
END;
$$;

-- ============================================================
-- 3️⃣ Procédure : inscrire_etudiant_cours
-- ============================================================
-- Objectif : Inscrire un étudiant à un cours
-- Étudiant doit compléter : vérification existence étudiant/cours, gestion erreurs
-- ============================================================

CREATE OR REPLACE PROCEDURE inscrire_etudiant_cours(etudiant_email TEXT, cours_nom TEXT)
LANGUAGE plpgsql
AS $$
DECLARE
    etudiant_id INT;
    cours_id INT;
BEGIN
    -- TODO : récupérer id étudiant et vérifier existence
    SELECT id INTO etudiant_id FROM etudiants WHERE email = etudiant_email;
    IF etudiant_id IS NULL THEN
        RAISE EXCEPTION 'Etudiant non trouvé : %', etudiant_email;
    END IF;

    -- TODO : récupérer id cours et vérifier existence
    SELECT id INTO cours_id FROM cours WHERE nom = cours_nom;
    IF cours_id IS NULL THEN
        RAISE EXCEPTION 'Cours non trouvé : %', cours_nom;
    END IF;

    -- TODO : Vérifier que l'inscription n'existe pas déjà
    IF EXISTS(SELECT 1 FROM inscriptions WHERE etudiant_id = etudiant_id AND cours_id = cours_id) THEN
        RAISE EXCEPTION 'Etudiant déjà inscrit à ce cours';
    END IF;

    -- Insertion dans inscriptions
    INSERT INTO inscriptions(etudiant_id, cours_id)
    VALUES (etudiant_id, cours_id);

    -- Journalisation
    INSERT INTO logs(action)
    VALUES ('Inscription étudiant ' || etudiant_email || ' au cours ' || cours_nom);

    RAISE NOTICE 'Inscription réussie : % -> %', etudiant_email, cours_nom;

EXCEPTION
    WHEN others THEN
        RAISE NOTICE 'Erreur inscription : %', SQLERRM;
END;
$$;

-- ============================================================
-- 4️⃣ Trigger validation avant insertion d'un étudiant
-- ============================================================
-- Objectif : Valider âge et email avant insertions automatiques
-- Étudiant doit compléter : éventuellement messages d'erreur plus détaillés
-- ============================================================

CREATE OR REPLACE FUNCTION valider_etudiant()
RETURNS trigger AS $$
BEGIN
    IF NEW.age < 18 THEN
        RAISE EXCEPTION 'Age invalide pour %', NEW.nom;
    END IF;

    IF NEW.email !~* '^[^@]+@[^@]+\.[^@]+$' THEN
        RAISE EXCEPTION 'Email invalide pour %', NEW.nom;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_valider_etudiant
BEFORE INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION valider_etudiant();

-- ============================================================
-- 5️⃣ Trigger log automatique sur etudiants et inscriptions
-- ============================================================
-- Objectif : journaliser toutes les modifications (INSERT, UPDATE, DELETE)
-- Étudiant doit compléter : gestion des OLD/NEW pour logs plus détaillés
-- ============================================================

CREATE OR REPLACE FUNCTION log_action()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME || ': ' || COALESCE(NEW.nom::text, OLD.nom::text));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT OR UPDATE OR DELETE ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_action();

CREATE TRIGGER trg_log_inscription
AFTER INSERT OR UPDATE OR DELETE ON inscriptions
FOR EACH ROW
EXECUTE FUNCTION log_action();
```

---

✅ **Résumé pour l’étudiant** :

* Tout le squelette est fourni.
* **À compléter** :

  * Messages RAISE NOTICE personnalisés
  * Gestion des exceptions détaillée
  * Optimisations possibles dans les fonctions et procédures
  * Eventuellement amélioration des logs (OLD/NEW)


