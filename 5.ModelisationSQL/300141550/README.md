📘 RAPPORT – MODÉLISATION SQL
Projet : Base de données Mama Makusa
🎯 OBJECTIF GÉNÉRAL

L’objectif de ce projet est de concevoir une base de données relationnelle pour la plateforme Mama Makusa, spécialisée dans la vente en ligne de cuisine africaine à Toronto.

La base de données doit être :

adaptée aux besoins d’utilisation,

performante,

évolutive,

structurée de manière optimale,

justifiée de façon objective.

🔹 2.1 Étapes de modélisation d’une base de données
1️⃣ Analyse des besoins
Identification des utilisateurs

Clients

Livreurs

Administrateur

Données à stocker

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

Règles d’affaires

Un client peut avoir plusieurs adresses.

Une commande appartient à un seul client.

Une commande contient plusieurs plats.

Un paiement est lié à une seule commande.

Une livraison est associée à une commande.

Un livreur peut effectuer plusieurs livraisons.

Un plat appartient à une seule catégorie.

Un plat a un seul pays d’origine.

Cette étape a permis de structurer correctement la base et d’éviter les erreurs d’interprétation.

2️⃣ Modélisation conceptuelle

Un diagramme Entité-Relation (ER) a été utilisé afin de représenter :

les entités,

les attributs,

les relations,

les cardinalités.

Ce choix est justifié car le diagramme ER est le plus adapté pour une base relationnelle avant l’implémentation SQL.

3️⃣ Modélisation logique

Les entités ont été transformées en tables relationnelles avec :

des clés primaires (PRIMARY KEY),

des clés étrangères (FOREIGN KEY),

des contraintes d’intégrité.

La base respecte la 3e forme normale (3FN) :

1FN : données atomiques,

2FN : aucune dépendance partielle,

3FN : aucune dépendance transitive.

La quantité a été placée dans la table ligne_commande afin d’éviter la redondance dans commande.

4️⃣ Modélisation physique

Le SGBD choisi est PostgreSQL.

Justification :

Données structurées avec relations fortes.

Transactions sécurisées (paiement).

Respect des propriétés ACID.

Bonne performance sur les jointures.

Ce choix est basé sur des critères techniques objectifs.

🔹 Implémentation et tests

Les tables ont été créées avec leurs contraintes respectives.
Des données ont ensuite été insérées pour permettre les tests.

<img width="945" height="532" alt="image" src="https://github.com/user-attachments/assets/7fb6b5e4-005e-47ea-b1a1-cc620318521d" />
<img width="945" height="532" alt="image" src="https://github.com/user-attachments/assets/7fb6b5e4-005e-47ea-b1a1-cc620318521d" />


Capture montrant l’exécution des INSERT

Capture montrant les données insérées

Capture montrant les requêtes exécutées

Ces insertions permettent de :

vérifier le fonctionnement des relations,

tester les jointures,

valider l’intégrité référentielle.

🔹 Plan d’optimisation
1️⃣ Analyse préalable

Les requêtes critiques identifiées :

Historique des commandes d’un client,

Liste des plats par catégorie,

Commandes par date,

Plats les plus commandés.

2️⃣ Optimisation par index

Des index ont été créés sur :

les clés étrangères,

les colonnes utilisées dans WHERE,

les colonnes utilisées dans JOIN,

les colonnes utilisées dans ORDER BY.

Objectif :

accélérer les requêtes,

améliorer les performances,

réduire le temps d’exécution.

3️⃣ Analyse avec EXPLAIN ANALYZE

Les performances ont été vérifiées à l’aide de :

EXPLAIN ANALYZE


📸 INSÉRER ICI LA CAPTURE CORRESPONDANTE DU FICHIER Insertion.docx
(montrant l’exécution d’une requête avec analyse)

🔹 Importance de la communication

La communication a permis :

de clarifier les règles d’affaires,

d’éviter les erreurs de modélisation,

d’assurer la cohérence des relations,

de faciliter l’évolution du modèle.

Une mauvaise clarification aurait pu entraîner des incohérences structurelles.

🔹 Pensée critique et objectivité

Les décisions ont été prises selon :

le type de données,

le besoin de transactions,

la performance mesurable,

l’évolutivité future.

Le choix technologique est justifié par des critères techniques et non par préférence personnelle.

🎯 CONCLUSION

La base de données Mama Makusa :

respecte les principes de modélisation relationnelle,

est normalisée jusqu’à la 3FN,

est implémentée correctement dans PostgreSQL,

est testée avec des données réelles,

est optimisée par indexation,

est justifiée objectivement.

Elle répond pleinement à l’objectif général du travail demandé.
