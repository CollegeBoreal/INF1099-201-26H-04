🎯 OBJECTIF GÉNÉRAL

Concevoir une base de données pour Mama Makusa qui soit :

adaptée aux besoins réels du site

performante

évolutive

structurée de manière optimale

justifiée objectivement

🔹 2.1 ÉTAPES DE MODÉLISATION
1️⃣ Analyse des besoins
🔎 Identification des utilisateurs

Clients

Livreurs

Administrateur du site

📦 Données à stocker

Informations clients

Adresses

Plats

Catégories

Pays d’origine

Commandes

Lignes de commande

Paiements

Livraisons

Livreurs

📜 Règles d’affaires

Un client peut avoir plusieurs adresses.

Une commande appartient à un seul client.

Une commande contient plusieurs plats.

Un paiement est lié à une seule commande.

Une livraison est associée à une commande.

Un livreur peut effectuer plusieurs livraisons.

Un plat appartient à une seule catégorie.

Un plat a un seul pays d’origine.

👉 Cette étape évite les erreurs de conception.

2️⃣ Modélisation conceptuelle
Diagramme choisi : ER

Justification :

Le diagramme Entité-Relation a été choisi car il permet de représenter clairement :

les entités

les attributs

les relations
avant l’implémentation technique.

Il est adapté à une base relationnelle comme PostgreSQL.

3️⃣ Modélisation logique

Transformation en tables :

Exemple pour COMMANDE :

COMMANDE
id_commande (PK)
id_client (FK)
id_adresse (FK)
date_commande
statut_commande

Clés primaires

Toutes les tables possèdent une clé primaire (id_...)

Clés étrangères

Relations assurées par :

id_client

id_plat

id_commande

id_livreur
etc.

✅ Normalisation
1FN

Pas de champs multiples

Données atomiques

2FN

Aucune dépendance partielle

Ligne_commande dépend entièrement de (id_commande, id_plat)

3FN

Pas de dépendance transitive

Catégorie et Pays sont séparés

👉 Le modèle respecte la 3FN pour minimiser la redondance.

4️⃣ Modélisation physique
🎯 Choix du SGBD : PostgreSQL

Justification objective :

Données fortement relationnelles

Transactions sécurisées (paiement)

Contraintes d’intégrité référentielle

Support ACID

Bonne performance sur jointures

Comparaison :

Critère	PostgreSQL	MongoDB
Relations fortes	✅	❌
Transactions complexes	✅	Limité
Intégrité stricte	✅	❌

Donc PostgreSQL est plus adapté.

🔹 2.2 Importance de la communication

Dans le projet Mama Makusa :

Clarification des règles d’affaires

Validation des statuts (commande, paiement, livraison)

Confirmation des relations 1–N

Vérification que la quantité appartient à Ligne_Commande

Sans communication :
→ erreur de modélisation
→ incohérence des données
→ mauvaise performance

La collaboration permet :

cohérence

évolutivité

maintenance future facilitée

🔹 2.3 Choix de l’engin

Type de données : structurées avec relations fortes
Besoin de transactions : oui (paiement)
Volume : évolutif
Requêtes : jointures fréquentes

➡ PostgreSQL recommandé.

🔹 2.4 Minimiser le dédoublement

Techniques utilisées :

Séparation Client / Adresse

Séparation Plat / Catégorie

Séparation Plat / Pays

Table intermédiaire Ligne_Commande

Résultat :

Pas de répétition inutile

Intégrité assurée

Maintenance simplifiée

🔹 2.5 Choix du diagramme

Projet : base relationnelle transactionnelle
Diagramme utilisé : ER

Pourquoi pas UML ?
→ UML est plus orienté objet

Pourquoi pas BPMN ?
→ BPMN sert aux processus métier

Donc ER est le plus adapté.

🔹 2.6 Justification du diagramme

Le diagramme ER :

offre un niveau d’abstraction clair

est compréhensible par développeurs et analystes

facilite l’évolution

prépare à la transformation en tables SQL

🔹 2.7 Adaptation / Itération

Corrections effectuées :

Suppression de la quantité dans COMMANDE

Ajout de clés primaires

Ajout de clés étrangères

Ajout d’index

La conception est itérative et évolutive.

🔹 2.8 Pensée critique

Analyse effectuée :

Comparaison PostgreSQL vs MongoDB

Évaluation normalisation vs performance

Réflexion sur dénormalisation (ex : total_commande)

Anticipation croissance du site

🔹 2.9 Objectivité

Décisions basées sur :

Transactions nécessaires

Relations fortes

Intégrité référentielle

Performance mesurable

Pas de choix basé sur préférence personnelle.

📌 PLAN D’OPTIMISATION APPLIQUÉ À MAMA MAKUSA
1️⃣ Analyse préalable

Requêtes critiques probables :

Historique des commandes d’un client

Liste des plats par catégorie

Commandes par date

Statut des livraisons

Utilisation de :

EXPLAIN ANALYZE

2️⃣ Indexation

Index recommandés :

CREATE INDEX idx_commande_client ON commande(id_client);
CREATE INDEX idx_commande_date ON commande(date_commande);
CREATE INDEX idx_plat_categorie ON plat(id_categorie);
CREATE INDEX idx_ligne_commande_plat ON ligne_commande(id_plat);
CREATE INDEX idx_client_email ON client(email);


Justification :

Accélère jointures

Accélère filtres fréquents

Optimise recherches client

3️⃣ Optimisation des requêtes

✔ Éviter SELECT *
✔ Utiliser requêtes préparées
✔ Éviter fonctions sur colonnes indexées

4️⃣ Dénormalisation stratégique

Option possible :

Ajouter :

total_commande


Avantage :

Évite recalcul fréquent

Accélère affichage

Justification nécessaire.

5️⃣ Partitionnement

Si le site devient grand :

Partition par :

date_commande

Améliore performance historique.

6️⃣ Mise en cache

Cache possible :

Redis pour plats populaires

Cache applicatif pour catégories

7️⃣ Optimisation physique

SSD recommandé

Paramètres PostgreSQL ajustés

Monitoring continu

🎯 RÉSUMÉ FINAL

La base Mama Makusa :

✔ Analyse rigoureuse des besoins
✔ Modélisation ER claire
✔ Normalisation jusqu’à 3FN
✔ Choix technologique justifié (PostgreSQL)
✔ Indexation stratégique
✔ Plan d’optimisation structuré
✔ Justification objective
✔ Capacité d’évolution
