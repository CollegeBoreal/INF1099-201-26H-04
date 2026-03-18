## Auteur

Projet réalisé Par **Freedy Ebah**

# ⚽👟 Gestion de la vente de crampons — Base de données

## Description du projet

Ce projet modélise un système de gestion de vente de crampons de football. Il permet de gérer les clients, les produits (crampons), les commandes et le suivi du stock de manière simple, efficace et normalisée.

Le système est conçu dans un objectif pédagogique (cours de base de données). Il ne couvre pas les paiements complexes ni la livraison, afin de se concentrer sur la structure des données et les relations entre entités.

---

## Objectifs

- Enregistrer les clients et leurs informations de contact
- Suivre les crampons disponibles et leurs caractéristiques (marque, modèle, pointure, couleur, prix)
- Gérer les commandes passées par les clients, avec le détail des produits commandés
- Maintenir un suivi du stock pour chaque crampon

---

## Structure du projet

```
crampon_project/
├── README.md               ← Ce fichier
├── DDL.sql                 ← Création des tables (structure)
├── DML.sql                 ← Insertion, modification et suppression de données
├── DQL.sql                 ← Requêtes de consultation (SELECT)
├── DCL.sql                 ← Gestion des accès et permissions
└── images/
    └── diagramme_ER.svg    ← Diagramme Entité-Relation
```

---

## Modélisation

### Entités et attributs (3FN)

| Entité | Attributs |
|---|---|
| **Client** | id_client (PK), nom, prenom, email |
| **Crampon** | id_crampon (PK), marque, modele, pointure, couleur, prix |
| **Commande** | id_commande (PK), date_commande, statut, id_client (FK) |
| **Ligne_Commande** | id_ligne_commande (PK), id_commande (FK), id_crampon (FK), quantite |
| **Stock** | id_crampon (PK/FK), quantite_disponible |

### Relations

| Relation | Cardinalité | Description |
|---|---|---|
| Client → Commande | 1,N | Un client peut passer plusieurs commandes |
| Commande → Ligne_Commande | 1,N | Une commande contient plusieurs lignes |
| Crampon → Ligne_Commande | 1,N | Un crampon peut apparaître dans plusieurs commandes |
| Crampon → Stock | 1,1 | Chaque crampon possède un stock associé |

---

## Normalisation

### 1FN — Première forme normale
Toutes les valeurs sont atomiques (non divisibles). Chaque colonne contient une seule valeur par ligne. Aucun groupe répétitif.

✅ Respectée par : `Client`, `Crampon`, `Commande`

### 2FN — Deuxième forme normale
Tous les attributs non-clés dépendent entièrement de la clé primaire (pas de dépendances partielles).

✅ Respectée par :
- `Client (1,N) Commande` — le client est lié à la commande via FK, pas de répétition
- `Commande (1,N) Ligne_Commande` — les détails sont séparés de la commande
- `Crampon (1,N) Ligne_Commande` — les attributs du crampon restent dans sa table

### 3FN — Troisième forme normale
Aucun attribut non-clé ne dépend d'un autre attribut non-clé (pas de dépendances transitives).

✅ Respectée :
- `Client(id_client, nom, prenom, email)` — tous dépendent de `id_client`
- `Crampon(id_crampon, marque, modele, pointure, couleur, prix)` — tous dépendent de `id_crampon`
- `Commande(id_commande, date_commande, statut, id_client)` — tous dépendent de `id_commande`
- `Ligne_Commande(id_ligne_commande, id_commande, id_crampon, quantite)` — tous dépendent de `id_ligne_commande`
- `Stock(id_crampon, quantite_disponible)` — dépend entièrement de `id_crampon`

---

## Choix technologique

**SGBD choisi : PostgreSQL**

| Critère | Justification |
|---|---|
| Données relationnelles | Les entités ont des relations fortes (FK, jointures) |
| Transactions ACID | Intégrité des commandes et du stock garantie |
| Contraintes avancées | CHECK, UNIQUE, ON DELETE CASCADE supportés nativement |
| Séquences (SERIAL) | Gestion automatique des clés primaires |
| Performance | Index B-tree efficaces pour les jointures fréquentes |

---

## Fichiers SQL

### DDL.sql — Définition de la structure
- Création des 5 tables avec contraintes (PK, FK, CHECK, UNIQUE)
- Définition des index pour optimiser les performances
- Gestion de l'ordre de suppression (DROP TABLE IF EXISTS)

### DML.sql — Manipulation des données
- **INSERT** : 5 clients, 6 crampons, stocks initiaux, 5 commandes, 7 lignes de commande
- **UPDATE** : mise à jour de statut, prix, stock et email
- **DELETE** : suppression d'une commande annulée (cascade sur les lignes)

### DQL.sql — Requêtes de consultation
1. Liste complète des clients
2. Crampons disponibles avec stock
3. Commandes avec nom du client
4. Détail complet d'une commande
5. Montant total par commande
6. Crampons en stock faible (< 10)
7. Nombre de commandes par client
8. Crampons les plus commandés
9. Historique d'un client spécifique
10. Chiffre d'affaires par marque

### DCL.sql — Contrôle des accès
| Rôle | Privilèges |
|---|---|
| `admin_crampon` | ALL sur toutes les tables |
| `vendeur_crampon` | SELECT partout, INSERT/UPDATE sur commandes et stock |
| `lecteur_crampon` | SELECT uniquement sur toutes les tables |

---

## Optimisations appliquées

- **Index** sur les clés étrangères fréquemment utilisées dans les JOIN
- **Contraintes CHECK** pour valider les données à l'insertion (prix > 0, pointure entre 30-50, statut valide)
- **ON DELETE CASCADE** sur Ligne_Commande pour maintenir l'intégrité référentielle
- **DEFAULT CURRENT_DATE** sur date_commande pour simplifier les insertions
- **Séparation Stock/Crampon** évite les mises à jour répétées dans la table principale

---
