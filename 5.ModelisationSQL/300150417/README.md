# ABDELATIF_NEMOUS *_* 

# 💱 TP Modélisation Base de Données – Site d’échange de devises (PostgreSQL)

## 👤 Étudiant
Nom : Abdelatif Nemous 
Projet : Site d’échange de devises en ligne  
SGBD : PostgreSQL (Podman)  
Outils : PowerShell, Podman, psql  

---

## 🎯 1. Objectif général

L’objectif de ce TP est de concevoir une base de données relationnelle adaptée à un **site d’échange de devises**, permettant :

- l’inscription des clients
- la gestion des devises
- l’enregistrement des taux de change
- la création de transactions de conversion
- la gestion des paiements
- l’enregistrement d’un historique complet des actions

Cette base de données doit être **performante, évolutive, normalisée et cohérente**.

---

# 🧠 2. Étapes de modélisation d’une base de données

La conception d’une base de données suit plusieurs étapes :

## 2.1 Analyse des besoins
- Identifier les utilisateurs du système (clients, administrateurs)
- Déterminer les données à stocker
- Définir les règles d’affaires

## 2.2 Modélisation conceptuelle
- Création d’un diagramme Entité-Relation (ER)
- Identification des entités, attributs et relations

## 2.3 Modélisation logique
- Transformation du modèle ER en tables relationnelles
- Définition des clés primaires et étrangères
- Normalisation (1FN, 2FN, 3FN)

## 2.4 Modélisation physique
- Choix du SGBD
- Création des index
- Optimisation et tests de requêtes

---

# 🤝 3. Importance de la communication et collaboration

Une bonne communication permet :

- d’éviter les erreurs d’interprétation
- d’assurer la cohérence du modèle
- de valider les règles(ii
- d’améliorer la maintenance et l’évolution future

Dans un projet de base de données, les erreurs viennent souvent d’un manque de clarification des besoins.

---

# 🗂️ 4. Choix du diagramme

Le diagramme Entité-Relation (ER) a été choisi car il permet :

- une représentation claire des entités et relations
- une compréhension globale avant implémentation
- une transformation facile vers un modèle relationnel

---

# 🏗️ 5. Choix du SGBD

Le SGBD choisi est **PostgreSQL** car :

- il supporte des transactions ACID
- il gère très bien les relations complexes (JOIN)
- il assure une forte intégrité des données (PK, FK, CHECK)
- il est performant et robuste

PostgreSQL est adapté à un système financier comme l’échange de devises.

---

# 🧾 6. Normalisation

## 6.1 Première Forme Normale (1FN)
Dans cette phase, toutes les données sont regroupées dans une structure plate (Flat Table).

Attributs :

- Client_Nom, Client_Prenom, Client_Tel, Client_Email
- Num_Rue, Rue, Ville, Code_Postal, Pays_Client
- Devise_Source, Devise_Cible, Taux_Change
- Montant_Initial, Montant_Converti, Date_Transaction, Statut_Transaction
- Mode_Paiement, Montant_Paye, Nom_Prestataire_Paiement

➡️ Problème : redondance importante et répétition des informations client/devise.

---

## 6.2 Deuxième Forme Normale (2FN)
Les entités sont séparées afin d’éviter les dépendances partielles.

Relations principales :

- CLIENT (1,N) —— EFFECTUE —— (1,1) TRANSACTION
- CLIENT (1,1) —— HABITE —— (1,1) ADRESSE
- CLIENT (1,1) —— POSSÈDE —— (1,1) COMPTE_CLIENT

- DEVISE (1,N) —— EST_SOURCE_DE —— (1,1) TRANSACTION
- DEVISE (1,N) —— EST_CIBLE_DE —— (1,1) TRANSACTION

- DEVISE (1,1) —— POSSÈDE —— (1,N) TAUX_CHANGE

- TRANSACTION (1,1) —— EST_PAYÉE_PAR —— (1,1) PAIEMENT
- PAIEMENT (1,1) —— UTILISE —— (1,1) MODE_PAIEMENT
- PAIEMENT (1,1) —— PASSE_PAR —— (1,1) PRESTATAIRE_PAIEMENT

- TRANSACTION (1,1) —— GÉNÈRE —— (0,N) HISTORIQUE_TRANSACTION

---

## 6.3 Troisième Forme Normale (3FN)
En 3FN, les dépendances transitives sont supprimées et chaque table dépend uniquement de sa clé primaire.

---

# 🏛️ 7. Modèle relationnel final (3FN)

Client (ID_Client, Nom, Prénom, Téléphone, Email)

Adresse (ID_Adresse, Numéro_Rue, Rue, Ville, Code_Postal, Pays, #ID_Client)

Compte_Client (ID_Compte, Date_Création, Statut, #ID_Client)

Devise (ID_Devise, Code_Devise, Nom_Devise, Symbole)

Taux_Change (ID_Taux, Valeur_Taux, Date_Mise_À_Jour, #ID_Devise_Source, #ID_Devise_Cible)

Transaction (ID_Transaction, Date_Transaction, Montant_Initial, Montant_Converti, Statut,
#ID_Client, #ID_Devise_Source, #ID_Devise_Cible, #ID_Taux)

Paiement (ID_Paiement, Date_Paiement, Montant_Payé, #ID_Transaction, #ID_Mode_Paiement, #ID_Prestataire)

Mode_Paiement (ID_Mode_Paiement, Nom_Mode)

Prestataire_Paiement (ID_Prestataire, Nom_Prestataire, Type_Service)

Historique_Transaction (ID_Historique, Date_Action, Action, #ID_Transaction)

---

# ⚙️ 8. Implémentation PostgreSQL (Podman + PowerShell)

## 8.1 Lancer PostgreSQL dans Podman
```powershell
podman run -d `
  --name postgres `
  -e POSTGRES_USER=postgres `
  -e POSTGRES_PASSWORD=postgres `
  -e POSTGRES_DB=appdb `
  -p 5432:5432 `
  -v postgres_data:/var/lib/postgresql/data `
  postgres:16

```


## 8.2 Connexion à PostgreSQL
```powershell
podman exec -it postgres psql -U postgres
```
## 🧱 9. Création de la base et du schéma
```powershell
CREATE DATABASE devisesdb;
\c devisesdb;

CREATE SCHEMA exchange;

```
![image](./images/1.PNG)

![image](./images/2.PNG)


## 🏗️ 10. Création des tables

Toutes les tables ont été créées dans le schéma exchange :

- client

- adresse

- compte_client

- devise

- taux_change

- transaction

- paiement

- mode_paiement

- prestataire_paiement

- historique_transaction

Vérification :
```powershell

\dt exchange.*

```

![image](./images/3,1.PNG)

## 🧾 11. Insertion des données (10 par table)

Des données de test ont été insérées dans chaque table afin de valider le bon fonctionnement du modèle.

Vérification :
```powershell

SELECT COUNT(*) FROM exchange.client;


```
![image](./images/5.PNG)


## 🔍 12. Requêtes SQL de test
### 12.1 Transactions avec informations client + devises
```powershell
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
![image](./images/6.PNG)


## 12.2 Paiements avec mode et prestataire
```powershell
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
![image](./images/7.PNG)


# ⚡ 13. Optimisation de la base de données
## 13.1 Index recommandés
```powershell
CREATE INDEX idx_client_email ON exchange.client(email);

CREATE INDEX idx_transaction_client ON exchange.transaction(id_client);

CREATE INDEX idx_transaction_date ON exchange.transaction(date_transaction);

CREATE INDEX idx_transaction_devises 
ON exchange.transaction(id_devise_source, id_devise_cible);

CREATE INDEX idx_taux_devise_source_cible
ON exchange.taux_change(id_devise_source, id_devise_cible);

CREATE INDEX idx_paiement_transaction ON exchange.paiement(id_transaction);

```
![image](./images/11.PNG)


## Sauvegarde SQL (Dump) (si prof demande)

Dans PowerShell (hors psql) :
```powershell
docker exec -t postgres pg_dump -U postgres devisesdb > devisesdb_backup.sql

```
Puis vérifie :
```powershell
dir devisesdb_backup.sql


```
![image](./images/20.PNG)


## ✅ 14. Conclusion

Ce TP a permis de concevoir une base de données relationnelle complète pour un site d’échange de devises.

Grâce à la normalisation jusqu’à la 3FN :

la redondance est réduite

l’intégrité des données est assurée

la base est claire et maintenable

la structure est évolutive

les performances sont améliorées grâce aux index

PostgreSQL est un choix pertinent pour ce projet car il garantit cohérence, fiabilité et performance pour un système transactionnel.
