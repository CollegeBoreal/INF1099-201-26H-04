📌 Présentation du projet

Ce projet consiste à concevoir et modéliser une base de données relationnelle pour un site d’échange de devises en ligne.
La plateforme permet à des clients de créer un compte, consulter les taux de change, effectuer des conversions entre différentes devises et procéder au paiement des transactions.
L’objectif principal est d’appliquer les règles de modélisation et de normalisation des bases de données afin d’obtenir une structure cohérente, sans redondance et prête pour une implémentation SQL.

🎯 Objectifs du projet

Modéliser un domaine réel et pertinent

Identifier les entités et leurs relations

Appliquer les formes normales (1FN, 2FN, 3FN)

Éliminer les redondances et les dépendances transitives

Obtenir une base de données exploitable dans un SGBD relationnel

🧩 Choix du domaine

Le domaine choisi est la gestion d’un site d’échange de devises.
Ce type de système permet de gérer les clients, les devises, les taux de change mis à jour régulièrement, les transactions de conversion ainsi que les paiements associés.
Chaque transaction enregistre la devise source, la devise cible, le montant initial, le montant converti et le statut de l’opération.

📂 Normalisation
📁 Première Forme Normale (1FN)

Dans cette première étape, les données sont regroupées dans une structure plate (Flat Table).
Tous les attributs sont atomiques et aucune clé technique n’est encore définie.

Exemples d’attributs :

Nom du client, prénom, téléphone, email

Adresse du client

Devise source et devise cible

Taux de change

Montant initial et montant converti

Date et statut de la transaction

Mode de paiement

📁 Deuxième Forme Normale (2FN)

Dans cette phase, les données sont réparties en entités distinctes afin d’éliminer les dépendances partielles.
Les relations entre les entités sont définies à l’aide de cardinalités logiques (1,1), (1,N) et (0,N).

Les principales entités identifiées sont :

Client

Adresse

Compte_Client

Devise

Taux_Change

Transaction

Paiement

Mode_Paiement

Prestataire_Paiement

Historique_Transaction

📁 Troisième Forme Normale (3FN)

Dans la troisième forme normale, les dépendances transitives sont supprimées.
Chaque table possède une clé primaire (PK) et les relations sont assurées par des clés étrangères (FK).

📌 Structure finale des entités

Client (ID_Client, Nom, Prénom, Téléphone, Email)

Adresse (ID_Adresse, Numéro_Rue, Rue, Ville, Code_Postal, Pays, #ID_Client)

Compte_Client (ID_Compte, Date_Création, Statut, #ID_Client)

Devise (ID_Devise, Code_Devise, Nom_Devise, Symbole)

Taux_Change (ID_Taux, Valeur_Taux, Date_Mise_À_Jour, #ID_Devise_Source, #ID_Devise_Cible)

Transaction (ID_Transaction, Date_Transaction, Montant_Initial, Montant_Converti, Statut, #ID_Client, #ID_Devise_Source, #ID_Devise_Cible, #ID_Taux)

Paiement (ID_Paiement, Date_Paiement, Montant_Payé, #ID_Transaction, #ID_Mode_Paiement)

Mode_Paiement (ID_Mode_Paiement, Nom_Mode)

Prestataire_Paiement (ID_Prestataire, Nom_Prestataire, Type_Service)

Historique_Transaction (ID_Historique, Date_Action, Action, #ID_Transaction)

## 📊 Diagramme Entité-Relation

![Diagramme ER - Site de changement de devise](images/DR.png)
