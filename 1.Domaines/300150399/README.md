# Projet de Normalisation  Site de Maillots de Football Vintage

## 1) Choix du domaine
Le domaine choisi est la gestion dun site de vente en ligne spécialisé dans les maillots de football vintage.
Ce sujet permet de modéliser le cycle complet depuis linscription dun client, la consultation du catalogue
(clubs, saisons, tailles, état du maillot), la création dune commande, le paiement, jusquà la livraison et lhistorique des commandes.

## 2) Normalisation

### Fichier 1 : 1FN (Première Forme Normale)
Toutes les données sont regroupées dans une structure plate (Flat Table).
Chaque attribut est atomique. Il ny a pas encore dID techniques.
Voir : `1FN.txt`

### Fichier 2 : 2FN (Deuxième Forme Normale)
Définition des relations et cardinalités. Les entités sont séparées pour éviter les redondances partielles.
Voir : `2FN.txt`

### Fichier 3 : 3FN (Troisième Forme Normale)
Structure finale. Les dépendances transitives sont éliminées.
Introduction des clés primaires (ID) et des clés étrangères (#).
Voir : `3FN.txt`

##  Diagramme Entité-Relation
Voir : `diagramme_ER.md`
