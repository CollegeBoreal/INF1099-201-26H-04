<div align="center">

# 💱 TP Modélisation Base de Données
## Site d'Échange de Devises (PostgreSQL)

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Podman](https://img.shields.io/badge/Podman-892CA0?style=for-the-badge&logo=podman&logoColor=white)](https://podman.io/)
[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://docs.microsoft.com/fr-fr/powershell/)

**Étudiant :** Abdelatif Nemous  
**Projet :** Site d'échange de devises en ligne  
**SGBD :** PostgreSQL (Podman) | **Outils :** PowerShell, psql

</div>

---

## 📋 Table des matières

- [🎯 Objectif général](#-objectif-général)
- [🧠 Étapes de modélisation](#-étapes-de-modélisation-dune-base-de-données)
- [🤝 Communication et collaboration](#-importance-de-la-communication-et-collaboration)
- [🗂️ Choix du diagramme](#-choix-du-diagramme)
- [🏛️ Choix du SGBD](#-choix-du-sgbd)
- [🧾 Normalisation](#-normalisation)
- [🏗️ Modèle relationnel final](#️-modèle-relationnel-final-3fn)
- [⚙️ Implémentation PostgreSQL](#️-implémentation-postgresql-podman--powershell)
- [⚡ Optimisation](#-optimisation-de-la-base-de-données)
- [💾 Sauvegarde](#-sauvegarde-sql-dump)
- [✅ Conclusion](#-conclusion)

---

## 🎯 Objectif général

L'objectif de ce TP est de concevoir une **base de données relationnelle** adaptée à un site d'échange de devises, permettant :

| Fonctionnalité | Description |
|----------------|-------------|
| 👤 **Inscription clients** | Gestion complète des profils utilisateurs |
| 💰 **Gestion des devises** | Catalogue des devises supportées |
| 📈 **Taux de change** | Enregistrement et historisation des taux |
| 🔄 **Transactions** | Conversion de devises en temps réel |
| 💳 **Paiements** | Gestion des modes et prestataires de paiement |
| 📜 **Historique** | Traçabilité complète des actions |

> 🎯 **Cible :** Une base de données **performante, évolutive, normalisée et cohérente**

---

## 🧠 Étapes de modélisation d'une base de données

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  📊 ANALYSE     │───▶│  🎨 CONCEPTUEL  │───▶│  📐 LOGIQUE     │───▶│  ⚙️ PHYSIQUE    │
│   des besoins   │    │   (Diagramme ER)│    │   (Tables SQL)  │    │   (Index, SGBD) │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 2.1 Analyse des besoins
- ✅ Identifier les utilisateurs (clients, administrateurs)
- ✅ Déterminer les données à stocker
- ✅ Définir les règles d'affaires

### 2.2 Modélisation conceptuelle
- 🎨 Création du diagramme Entité-Relation (ER)
- 🔍 Identification des entités, attributs et relations

### 2.3 Modélisation logique
- 📝 Transformation du modèle ER en tables relationnelles
- 🔑 Définition des clés primaires et étrangères
- 📊 Normalisation (1FN, 2FN, 3FN)

### 2.4 Modélisation physique
- 🗄️ Choix du SGBD (PostgreSQL)
- ⚡ Création des index
- 🧪 Optimisation et tests de requêtes

---

## 🤝 Importance de la communication et collaboration

> 💡 **Une bonne communication permet de :**

| Avantage | Impact |
|----------|--------|
| 🎯 **Éviter les erreurs** | Réduction des malentendus sur les besoins |
| 🔗 **Assurer la cohérence** | Modèle unifié et validé par tous |
| ✅ **Valider les règles** | Confirmation des contraintes métier |
| 🚀 **Améliorer la maintenance** | Documentation claire pour l'évolution |

> ⚠️ *Les erreurs viennent souvent d'un manque de clarification des besoins !*

---

## 🗂️ Choix du diagramme

### Diagramme Entité-Relation (ER)

Le diagramme ER a été choisi car il offre :

- ✨ **Représentation claire** des entités et relations
- 🌐 **Compréhension globale** avant implémentation
- 🔄 **Transformation facile** vers un modèle relationnel

---

## 🏛️ Choix du SGBD

<div align="center">

### 🐘 **PostgreSQL**

</div>

| Caractéristique | Avantage pour le projet |
|-----------------|------------------------|
| 🔒 **Transactions ACID** | Intégrité des données financières garantie |
| 🔗 **Relations complexes** | Gestion optimale des JOIN multi-tables |
| ✅ **Intégrité forte** | PK, FK, CHECK pour la cohérence |
| ⚡ **Performance** | Robuste pour les systèmes transactionnels |

> 🏆 **PostgreSQL est le choix idéal** pour un système financier comme l'échange de devises.

---

## 🧾 Normalisation

### 📊 6.1 Première Forme Normale (1FN)

Structure plate (Flat Table) avec tous les attributs :

```
Client_Nom, Client_Prenom, Client_Tel, Client_Email
Num_Rue, Rue, Ville, Code_Postal, Pays_Client
Devise_Source, Devise_Cible, Taux_Change
Montant_Initial, Montant_Converti, Date_Transaction
Mode_Paiement, Montant_Paye, Nom_Prestataire_Paiement
```

> ❌ **Problème :** Redondance importante et répétition des informations

---

### 📊 6.2 Deuxième Forme Normale (2FN)

Séparation des entités pour éviter les dépendances partielles :

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│   CLIENT    │◄───────►│ TRANSACTION │◄───────►│   DEVISE    │
└──────┬──────┘         └─────────────┘         └──────┬──────┘
       │                                               │
       ▼                                               ▼
┌─────────────┐                              ┌─────────────┐
│   ADRESSE   │                              │ TAUX_CHANGE │
└─────────────┘                              └─────────────┘

┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│  PAIEMENT   │◄───────►│MODE_PAIEMENT│   ┌────►│ PRESTATAIRE │
└─────────────┘         └─────────────┘   │     └─────────────┘
       │                                  │
       ▼                                  │
┌─────────────┐                           │
│ HISTORIQUE  │───────────────────────────┘
└─────────────┘
```

**Relations principales :**
- `CLIENT (1,N)` —— `EFFECTUE` —— `(1,1) TRANSACTION`
- `CLIENT (1,1)` —— `HABITE` —— `(1,1) ADRESSE`
- `DEVISE (1,N)` —— `EST_SOURCE/CIBLE_DE` —— `(1,1) TRANSACTION`
- `DEVISE (1,1)` —— `POSSÈDE` —— `(1,N) TAUX_CHANGE`
- `TRANSACTION (1,1)` —— `EST_PAYÉE_PAR` —— `(1,1) PAIEMENT`
- `TRANSACTION (1,1)` —— `GÉNÈRE` —— `(0,N) HISTORIQUE`

---

### 📊 6.3 Troisième Forme Normale (3FN)

✅ Suppression des dépendances transitives  
✅ Chaque table dépend uniquement de sa clé primaire

---

## 🏗️ Modèle relationnel final (3FN)

```sql
-- 👤 Table CLIENT
Client (ID_Client PK, Nom, Prénom, Téléphone, Email)

-- 📍 Table ADRESSE
Adresse (ID_Adresse PK, Numéro_Rue, Rue, Ville, Code_Postal, Pays, ID_Client FK)

-- 💼 Table COMPTE_CLIENT
Compte_Client (ID_Compte PK, Date_Création, Statut, ID_Client FK)

-- 💱 Table DEVISE
Devise (ID_Devise PK, Code_Devise, Nom_Devise, Symbole)

-- 📈 Table TAUX_CHANGE
Taux_Change (ID_Taux PK, Valeur_Taux, Date_Mise_À_Jour, 
             ID_Devise_Source FK, ID_Devise_Cible FK)

-- 🔄 Table TRANSACTION
Transaction (ID_Transaction PK, Date_Transaction, Montant_Initial, 
             Montant_Converti, Statut, ID_Client FK, ID_Devise_Source FK, 
             ID_Devise_Cible FK, ID_Taux FK)

-- 💳 Table PAIEMENT
Paiement (ID_Paiement PK, Date_Paiement, Montant_Payé, 
          ID_Transaction FK, ID_Mode_Paiement FK, ID_Prestataire FK)

-- 💰 Table MODE_PAIEMENT
Mode_Paiement (ID_Mode_Paiement PK, Nom_Mode)

-- 🏦 Table PRESTATAIRE_PAIEMENT
Prestataire_Paiement (ID_Prestataire PK, Nom_Prestataire, Type_Service)

-- 📜 Table HISTORIQUE_TRANSACTION
Historique_Transaction (ID_Historique PK, Date_Action, Action, ID_Transaction FK)
```

---

## ⚙️ Implémentation PostgreSQL (Podman + PowerShell)

### 🚀 8.1 Lancer PostgreSQL dans Podman

```powershell
# Création du conteneur PostgreSQL
podman run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16
```

### 🔌 8.2 Connexion à PostgreSQL

```powershell
# Connexion interactive
podman exec -it postgres psql -U postgres
```

---

### 🧱 9. Création de la base et du schéma

```sql
-- Création de la base de données
CREATE DATABASE devisesdb;

-- Connexion à la base
\c devisesdb;

-- Création du schéma
CREATE SCHEMA exchange;
```

📸 *Voir captures d'écran dans le dossier `/images/`*

---

### 🏗️ 10. Création des tables

Toutes les tables ont été créées dans le schéma `exchange` :

| Table | Description |
|-------|-------------|
| `client` | Informations des clients |
| `adresse` | Adresses des clients |
| `compte_client` | Comptes utilisateurs |
| `devise` | Catalogue des devises |
| `taux_change` | Taux de conversion |
| `transaction` | Opérations de change |
| `paiement` | Paiements associés |
| `mode_paiement` | Modes de paiement disponibles |
| `prestataire_paiement` | Prestataires de paiement |
| `historique_transaction` | Journal des actions |

**Vérification :**
```powershell
\dt exchange.*
```

---

### 🧾 11. Insertion des données

✅ **10 enregistrements par table** insérés pour valider le modèle

**Vérification :**
```sql
SELECT COUNT(*) FROM exchange.client;
```

---

### 🔍 12. Requêtes SQL de test

#### 12.1 Transactions avec informations client + devises

```sql
SELECT 
    t.id_transaction,
    c.nom,
    c.prenom,
    d1.code_devise AS devise_source,
    d2.code_devise AS devise_cible,
    t.montant_initial,
    t.montant_converti,
    t.statut,
    t.date_transaction
FROM exchange.transaction t
JOIN exchange.client c ON t.id_client = c.id_client
JOIN exchange.devise d1 ON t.id_devise_source = d1.id_devise
JOIN exchange.devise d2 ON t.id_devise_cible = d2.id_devise
ORDER BY t.date_transaction;
```

#### 12.2 Paiements avec mode et prestataire

```sql
SELECT
    p.id_paiement,
    p.date_paiement,
    p.montant_paye,
    m.nom_mode AS mode_paiement,
    pr.nom_prestataire AS prestataire,
    pr.type_service
FROM exchange.paiement p
JOIN exchange.mode_paiement m ON p.id_mode_paiement = m.id_mode_paiement
JOIN exchange.prestataire_paiement pr ON p.id_prestataire = pr.id_prestataire
ORDER BY p.date_paiement;
```

---

## ⚡ Optimisation de la base de données

### 13.1 Index recommandés

```sql
-- Index sur l'email client (recherche rapide)
CREATE INDEX idx_client_email ON exchange.client(email);

-- Index sur les transactions par client
CREATE INDEX idx_transaction_client ON exchange.transaction(id_client);

-- Index sur la date des transactions
CREATE INDEX idx_transaction_date ON exchange.transaction(date_transaction);

-- Index composite pour les conversions de devises
CREATE INDEX idx_transaction_devises 
ON exchange.transaction(id_devise_source, id_devise_cible);

-- Index sur les taux de change
CREATE INDEX idx_taux_devise_source_cible
ON exchange.taux_change(id_devise_source, id_devise_cible);

-- Index sur les paiements par transaction
CREATE INDEX idx_paiement_transaction ON exchange.paiement(id_transaction);
```

> ⚡ **Résultat :** Requêtes optimisées, temps de réponse réduit

---

## 💾 Sauvegarde SQL (Dump)

### Création du backup

```powershell
# Dans PowerShell (hors psql)
docker exec -t postgres pg_dump -U postgres devisesdb > devisesdb_backup.sql
```

### Vérification

```powershell
# Vérifier la présence du fichier
dir devisesdb_backup.sql
```

---

## ✅ Conclusion

Ce TP a permis de concevoir une **base de données relationnelle complète** pour un site d'échange de devises.

### 🎯 Résultats obtenus

| Objectif | Statut |
|----------|--------|
| ✅ Réduction de la redondance | Normalisation 3FN |
| ✅ Intégrité des données | Contraintes PK, FK, CHECK |
| ✅ Base maintenable | Structure claire et documentée |
| ✅ Évolutivité | Architecture modulaire |
| ✅ Performance | Index optimisés |

### 🏆 Bilan

**PostgreSQL** s'est révélé être un choix pertinent pour ce projet, garantissant :
- 🔒 **Cohérence** des données transactionnelles
- ✅ **Fiabilité** pour un système financier
- ⚡ **Performance** pour les requêtes complexes

---

<div align="center">

### 📝 **Abdelatif Nemous** — *Projet Base de Données*

[![Made with PostgreSQL](https://img.shields.io/badge/Made%20with-PostgreSQL-336791?style=flat-square&logo=postgresql)](https://www.postgresql.org/)

</div>
