# 🐳 Démo PostgreSQL 

---

## 1️⃣ Étape 1 : Lancer PostgreSQL dans Docker

```bash
docker run -d \
  --name demo_postgres \
  -e POSTGRES_USER=demo \
  -e POSTGRES_PASSWORD=demo \
  -e POSTGRES_DB=demo_db \
  -p 5432:5432 \
  postgres:15
```

> Cela crée un conteneur PostgreSQL avec :
>
> * Utilisateur : `demo`
> * Mot de passe : `demo`
> * Base : `demo_db`
> * Exposé sur le port 5432

---

## 2️⃣ Étape 2 : Se connecter à la base

```bash
docker exec -it demo_postgres psql -U demo -d demo_db
```

---

## 3️⃣ Étape 3 : Créer les tables

```sql id="ddl_demo_no_dc"
CREATE TABLE etudiants (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    age INT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    date_creation TIMESTAMP DEFAULT NOW()
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    action TEXT,
    date_action TIMESTAMP DEFAULT NOW()
);
```

---

## 4️⃣ Étape 4 : Créer une fonction

Fonction pour compter les étudiants :

```sql id="func_demo_no_dc"
CREATE OR REPLACE FUNCTION nombre_etudiants()
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM etudiants;
    RETURN total;
END;
$$;
```

Tester la fonction :

```sql id="func_test_no_dc"
SELECT nombre_etudiants();
```

---

## 5️⃣ Étape 5 : Créer une procédure stockée (Stored Procedure / PSt)

Procédure pour ajouter un étudiant et loguer l’action :

```sql id="proc_demo_no_dc"
CREATE OR REPLACE PROCEDURE ajouter_etudiant(nom TEXT, age INT, email TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO etudiants(nom, age, email) VALUES (nom, age, email);
    INSERT INTO logs(action) VALUES ('Ajout étudiant : ' || nom);
    RAISE NOTICE 'Etudiant ajouté : %', nom;
END;
$$;
```

Appeler la procédure :

```sql id="proc_test_no_dc"
CALL ajouter_etudiant('Alice', 22, 'alice@email.com');
CALL ajouter_etudiant('Bob', 25, 'bob@email.com');
```

---

## 6️⃣ Étape 6 : Vérifier les résultats

* Nombre d’étudiants :

```sql id="check_func_no_dc"
SELECT nombre_etudiants(); -- Devrait afficher 2
```

* Logs :

```sql id="check_logs_no_dc"
SELECT * FROM logs;
```

---

## 7️⃣ Étape 7 (optionnel) : Trigger automatique

Créer un trigger pour log automatique à chaque insertion :

```sql id="trigger_demo_no_dc"
CREATE OR REPLACE FUNCTION log_auto()
RETURNS trigger AS $$
BEGIN
    INSERT INTO logs(action)
    VALUES ('Trigger: ajout étudiant ' || NEW.nom);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_etudiant
AFTER INSERT ON etudiants
FOR EACH ROW
EXECUTE FUNCTION log_auto();
```

Tester avec :

```sql id="trigger_test_no_dc"
CALL ajouter_etudiant('Charlie', 20, 'charlie@email.com');
SELECT * FROM logs;
```

> Tu verras **2 logs pour Charlie** : un via la procédure et un via le trigger.

---

## ✅ Résumé

Cette démo montre :

1. Lancer PostgreSQL dans un conteneur simple
2. Créer une **fonction** (`nombre_etudiants`)
3. Créer une **procédure stockée** (`ajouter_etudiant`)
4. Ajouter un **trigger** pour log automatique
5. Tester et afficher résultats avec `SELECT` et `CALL`

---

### 💡 Dollar-quoting `$$ … $$` en PostgreSQL

* **Qu’est-ce que c’est ?**
  Délimiteur pour écrire le code PL/pgSQL d’une fonction ou procédure. Tout entre `$$ … $$` est pris comme texte brut.

* **Pourquoi l’utiliser ?**

  * Permet d’écrire des blocs multi-lignes facilement
  * Pas besoin d’échapper les `'` ou `"`
  * Améliore la lisibilité

* **Exemple : fonction simple**

```sql
CREATE OR REPLACE FUNCTION addition(a INT, b INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a + b;
END;
$$;
```

* **Option : tag personnalisé**

```sql
AS $fonction$
-- code PL/pgSQL ici
$fonction$;
```

* **Analogie** : comme un **here document** en Bash (`<<EOF … EOF`) → tout ce qui est entre les délimiteurs est pris tel quel.

