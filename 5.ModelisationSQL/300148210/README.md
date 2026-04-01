# Système de Gestion d’un Laboratoire d’Analyses Alimentaires

## Contexte du projet

Ce projet consiste à implémenter une base de données relationnelle permettant de gérer l’ensemble du cycle d’analyse d’un laboratoire alimentaire.
Le système couvre la traçabilité complète : du produit analysé jusqu’au rapport final et à la facturation.

L’objectif est de garantir :

* la cohérence des données
* l’intégrité référentielle
* la traçabilité des analyses
* un accès sécurisé selon les rôles

---

## Environnement d’exécution

* **SGBD** : PostgreSQL
* **Conteneurisation** : Docker
* **Interface d’exécution** : PowerShell via `psql`
* **Système** : Windows

Le choix de PostgreSQL repose sur sa gestion robuste des contraintes, des transactions et des relations complexes.

---

## Organisation des fichiers

| Fichier   | Rôle                                               |
| --------- | -------------------------------------------------- |
| `DDL.sql` | Création de la structure (tables, clés, relations) |
| `DML.sql` | Insertion des données de test                      |
| `DQL.sql` | Requêtes d’exploitation des données                |
| `DCL.sql` | Gestion des rôles et des permissions               |

---

## Structure fonctionnelle

La base de données repose sur plusieurs blocs logiques :

### 1. Gestion des acteurs

* Clients
* Analystes
* Laboratoires
* Adresses

### 2. Gestion des produits et échantillons

* Produits alimentaires
* Lots de production
* Échantillons prélevés

### 3. Gestion des analyses

* Types d’analyses
* Analyses effectuées
* Résultats mesurés
* Normes réglementaires
* Conformité

### 4. Gestion administrative

* Rapports d’analyse
* Facturation
* Paiements

Chaque entité est liée par des relations garantissant une navigation logique dans les données.

---

## Implémentation technique

### Création des tables (DDL)

Les tables ont été définies avec :

* des clés primaires (`SERIAL`)
* des clés étrangères (`REFERENCES`)
* des contraintes d’unicité (ex: un rapport par analyse)

L’ordre de création respecte les dépendances pour éviter les erreurs de références.

---

### Insertion des données (DML)

Chaque table contient au minimum 5 enregistrements.
Les données ont été insérées en respectant l’ordre hiérarchique :

1. Entités indépendantes (adresse, produit, norme)
2. Entités dépendantes (client, lot, échantillon)
3. Entités métier (analyse, résultat, conformité)
4. Entités finales (rapport, facture, paiement)

Cela garantit l’absence d’erreurs liées aux clés étrangères.

---

### Exploitation des données (DQL)

Les requêtes réalisées permettent d’extraire des informations utiles :

* Consultation simple des tables
* Jointures multi-tables
* Analyse des relations entre entités
* Calculs statistiques (COUNT, SUM)
* Filtrage de données (analyses non conformes)

Exemples de logique métier :

* Relier un client à ses analyses
* Vérifier la conformité d’un produit
* Calculer le total facturé par client
* Associer résultats, normes et conformité

---

### Gestion des accès (DCL)

Trois rôles ont été définis pour simuler un environnement réel :

#### 1. Administrateur

* Accès total à toutes les tables
* Gestion complète du système

#### 2. Analyste

* Lecture et modification des analyses
* Accès aux résultats et conformités
* Lecture des données nécessaires au travail

#### 3. Client

* Accès en lecture uniquement
* Consultation des rapports, factures et paiements

Les permissions sont attribuées avec `GRANT` et appliquées aussi aux futures tables via `ALTER DEFAULT PRIVILEGES`.

---

## Exécution du projet

### Lancement du conteneur PostgreSQL

```powershell id="mkhc1y"
docker run --name labo-postgres -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 -e POSTGRES_DB=laboratoire -p 5432:5432 -d postgres
```

---

### Exécution des scripts

```powershell id="4rw1vh"
Get-Content DDL.sql | docker exec -i labo-postgres psql -U admin -d laboratoire
Get-Content DML.sql | docker exec -i labo-postgres psql -U admin -d laboratoire
Get-Content DQL.sql | docker exec -i labo-postgres psql -U admin -d laboratoire
Get-Content DCL.sql | docker exec -i labo-postgres psql -U admin -d laboratoire
```

---

### Vérification

* Tables : `\dt`
* Rôles : `\du`
* Permissions : `\dp`
* Données : `SELECT * FROM table;`

---

## Validation du système

Le système est considéré valide si :

* Toutes les tables sont créées sans erreur
* Les données sont insérées correctement
* Les requêtes retournent des résultats cohérents
* Les permissions limitent correctement l’accès

---

## Limites

* Données fictives (simulation uniquement)
* Pas d’interface utilisateur
* Pas d’automatisation avancée (triggers, procédures)

---

## Conclusion

La base de données implémentée répond aux besoins d’un laboratoire d’analyses alimentaires en assurant :

* une structuration claire des données
* une traçabilité complète des analyses
* une exploitation efficace via SQL
* une gestion sécurisée des accès

Le système est opérationnel, extensible et conforme aux bonnes pratiques des bases de données relationnelles.

