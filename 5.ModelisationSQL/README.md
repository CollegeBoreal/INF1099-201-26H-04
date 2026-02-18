# Modélisation SQL

Appliquer les concepts de conception de bases de données pour maximiser l’efficacité

# 🎯 Objectif général

Concevoir une base de données adaptée aux besoins d’utilisation, performante, évolutive et structurée de façon optimale.

---

## 🔹 SAVOIRS

### 2.1 Étapes de modélisation d’une base de données

Les principales étapes sont :

1. **Analyse des besoins**

   * Identifier les utilisateurs
   * Déterminer les données à stocker
   * Définir les règles d’affaires

2. **Modélisation conceptuelle**

   * Diagramme Entité-Relation (ER)
   * Identification des entités, attributs, relations

3. **Modélisation logique**

   * Transformation en tables
   * Définition des clés primaires et étrangères
   * Normalisation (1FN, 2FN, 3FN)

4. **Modélisation physique**

   * Choix du SGBD (ex. PostgreSQL, MySQL, MongoDB)
   * Indexation
   * Optimisation des performances

5. **Implémentation et tests**

   * Création des tables
   * Tests de requêtes
   * Validation avec les utilisateurs

---

### 2.2 Importance de la communication et de la collaboration

Une bonne communication permet :

* D’éviter les erreurs d’interprétation
* D’assurer la cohérence du modèle
* De valider les règles d’affaires
* De faciliter la maintenance future
* D’adapter la conception aux besoins réels

👉 En conception de bases de données, les erreurs viennent souvent d’un **manque de clarification des besoins**.

---

## 🔹 SAVOIR-FAIRE

### 2.3 Choisir un engin de base de données approprié

Le choix dépend :

| Type de données                            | Solution recommandée |
| ------------------------------------------ | -------------------- |
| Données structurées avec relations fortes  | PostgreSQL           |
| Données transactionnelles simples          | MySQL                |
| Données semi-structurées (JSON, documents) | MongoDB              |
| Haute scalabilité distribuée               | Apache Cassandra     |

Critères :

* Volume de données
* Type de requêtes
* Besoin de transactions (ACID)
* Évolutivité
* Performance attendue

---

### 2.4 Modéliser pour minimiser le dédoublement

Techniques :

* Normalisation (jusqu’à 3FN généralement)
* Séparation des entités
* Utilisation de clés étrangères
* Indexation stratégique

Objectif :

* Éviter la redondance
* Assurer l’intégrité
* Accélérer les requêtes

---

### 2.5 Choisir le diagramme approprié

| Type de projet         | Diagramme recommandé               |
| ---------------------- | ---------------------------------- |
| Analyse conceptuelle   | Diagramme Entité-Relation (ER)  ✅ |
| Vision globale système | Diagramme UML                   ☑️ |
| Processus métiers      | Diagramme BPMN                  ☑️ |
| Architecture technique | Diagramme d’architecture           |

---

### 2.6 Justifier le choix du diagramme

Exemple de justification :

> « Le diagramme ER a été choisi car il permet de représenter clairement les entités, leurs attributs et leurs relations avant l’implémentation technique. »

On doit expliquer :

* Clarté
* Adaptation au public
* Niveau d’abstraction
* Facilité d’évolution

---

### 2.7 Adapter le diagramme (itération)

Lors du projet :

* Ajuster selon les tests
* Corriger les anomalies
* Optimiser les relations
* Simplifier si nécessaire

La conception est **itérative**, jamais figée.

---

## 🔹 SAVOIR-ÊTRE

### 2.8 Pensée critique

Cela implique :

* Questionner les choix techniques
* Évaluer performance vs complexité
* Comparer plusieurs solutions
* Anticiper la croissance des données

---

### 2.9 Objectivité dans la justification

Il faut :

* Justifier par des critères mesurables
* Éviter les préférences personnelles
* Appuyer les décisions par des faits techniques
* Expliquer les compromis

Exemple :

> « Nous avons choisi PostgreSQL plutôt que MongoDB car le projet nécessite des transactions complexes et des relations fortes entre les données. »

---

## ✅ Résumé global

Une bonne conception de base de données repose sur :

* Une analyse rigoureuse des besoins
* Une modélisation claire et normalisée
* Un choix technologique adapté
* Une communication efficace
* Une capacité d’adaptation
* Une justification technique objective

---

Voici un **plan d’optimisation d’une base de données** structuré, applicable à un SGBD relationnel comme PostgreSQL ou MySQL (les principes restent valides ailleurs).

---

# 📌 PLAN D’OPTIMISATION DE LA BASE DE DONNÉES

---

## 1️⃣ Analyse préalable (avant toute optimisation)

### 1.1 Identifier les requêtes critiques

* Requêtes lentes (> X ms)
* Requêtes exécutées fréquemment
* Jointures complexes
* Agrégations lourdes (GROUP BY)

Outils :

* `EXPLAIN`
* `EXPLAIN ANALYZE`
* Logs de requêtes lentes

👉 On optimise **les requêtes réellement utilisées**, pas la base entière.

---

## 2️⃣ Optimisation par les index

### 2.1 Index simples (B-tree)

À créer sur :

* Clés primaires (automatique)
* Clés étrangères
* Colonnes utilisées dans WHERE
* Colonnes utilisées dans JOIN
* Colonnes utilisées dans ORDER BY

Exemple :

```sql
CREATE INDEX idx_utilisateur_email ON utilisateur(email);
```

---

### 2.2 Index composites

Pour requêtes multi-colonnes :

```sql
CREATE INDEX idx_commande_client_date 
ON commande(client_id, date_commande);
```

⚠️ L’ordre des colonnes est crucial :

* Mettre la colonne la plus sélective en premier

---

### 2.3 Index partiels

Si beaucoup de valeurs NULL ou peu utilisées :

```sql
CREATE INDEX idx_commande_active 
ON commande(status)
WHERE status = 'ACTIVE';
```

---

### 2.4 Types d’index spécialisés (selon SGBD)

Dans PostgreSQL :

* GIN → pour JSONB, tableaux
* GiST → données géospatiales
* BRIN → très grandes tables

---

### ⚠️ Attention aux index

Trop d’index :

* Ralentissent INSERT/UPDATE/DELETE
* Augmentent l’espace disque
* Complexifient la maintenance

---

## 3️⃣ Optimisation des requêtes

### 3.1 Éviter SELECT *

❌

```sql
SELECT * FROM utilisateur;
```

*

```sql
SELECT id, nom, email FROM utilisateur;
```

---

### 3.2 Réduire les jointures inutiles

* Supprimer les tables non nécessaires
* Simplifier les sous-requêtes

---

### 3.3 Utiliser des requêtes préparées

Améliore performance + sécurité.

---

### 3.4 Utiliser les index correctement

Une requête peut ignorer un index si :

* Fonction sur colonne indexée
* Type incompatible
* Mauvaise cardinalité

---

## 4️⃣ Normalisation et dénormalisation stratégique

### 4.1 Normalisation

But :

* Réduire la redondance
* Maintenir l’intégrité

---

### 4.2 Dénormalisation contrôlée

Dans certains cas :

* Ajouter colonne calculée
* Copier donnée pour éviter JOIN fréquent

Exemple :

* Stocker `total_commande` dans la table commande

⚠️ Toujours justifier ce choix.

---

## 5️⃣ Partitionnement

Utile pour très grandes tables.

Exemple :

* Partition par date
* Partition par région

Avantages :

* Requêtes plus rapides
* Maintenance simplifiée

---

## 6️⃣ Mise en cache

### 6.1 Cache applicatif

* Redis
* Memcached

### 6.2 Cache des requêtes

Certaines bases gèrent un cache interne.

---

## 7️⃣ Optimisation physique

### 7.1 Paramètres serveur

Dans PostgreSQL :

* shared_buffers
* work_mem
* maintenance_work_mem

---

### 7.2 Stockage

* SSD plutôt que HDD
* RAID adapté
* Séparer data et logs

---

## 8️⃣ Surveillance continue

Outils :

* Monitoring CPU / RAM
* Temps de réponse
* Taille des tables
* Fragmentation

---

## 9️⃣ Plan d’action structuré (méthodologie)

1. Mesurer
2. Identifier la requête lente
3. Analyser avec EXPLAIN
4. Ajouter ou modifier index
5. Tester
6. Comparer avant / après
7. Documenter la décision

---

## 🎯 Résumé stratégique

Une base performante repose sur :

* Index bien choisis
* Requêtes optimisées
* Structure cohérente
* Paramétrage serveur adapté
* Surveillance continue
* Justification technique objective

