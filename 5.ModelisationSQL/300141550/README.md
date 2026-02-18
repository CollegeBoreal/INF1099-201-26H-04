``` 📄 RAPPORT – MODÉLISATION ET OPTIMISATION SQL ```
Projet : Base de données Mama Makusa
1. Objectif du projet

L’objectif était de concevoir une base de données relationnelle :

adaptée aux besoins du site Mama Makusa ;

performante pour les requêtes fréquentes ;

évolutive ;

structurée selon les principes de normalisation ;

justifiée de manière technique et objective.

2. Étapes de modélisation
2.1 Analyse des besoins

Les utilisateurs identifiés sont :

Clients

Livreurs

Administrateur

Les principales données à stocker :

Clients, Adresses

Plats, Catégories, Pays

Commandes, Lignes de commande

Paiements

Livraisons

Les règles d’affaires ont été définies clairement (relations 1–N, dépendances logiques), ce qui a permis d’éviter les erreurs de conception.

2.2 Modélisation conceptuelle

Le diagramme Entité–Relation (ER) a été choisi car il permet de représenter clairement :

les entités,

les attributs,

les relations.

Il est particulièrement adapté à une base relationnelle.

2.3 Modélisation logique

Les entités ont été transformées en tables avec :

clés primaires (id_*) ;

clés étrangères pour assurer l’intégrité référentielle.

La base respecte :

1FN (données atomiques) ;

2FN (pas de dépendance partielle) ;

3FN (pas de dépendance transitive).

Cela permet de minimiser la redondance et d’assurer la cohérence des données.

3. Choix du SGBD

Le SGBD choisi est PostgreSQL.

Justification :

données fortement relationnelles ;

besoin de transactions sécurisées (paiements) ;

gestion stricte de l’intégrité référentielle ;

performance élevée sur les jointures.

Le choix est basé sur des critères techniques et non sur une préférence personnelle.

4. Minimisation du dédoublement

Pour éviter la redondance :

séparation Client / Adresse ;

séparation Plat / Catégorie ;

séparation Plat / Pays ;

utilisation d’une table intermédiaire Ligne_Commande.

Cela améliore :

l’intégrité ;

la maintenabilité ;

l’évolutivité.

5. Optimisation des performances
5.1 Analyse des requêtes

Les requêtes critiques concernent :

historique des commandes ;

plats par catégorie ;

suivi des livraisons.

L’outil EXPLAIN ANALYZE permet d’évaluer les performances.

5.2 Indexation

Des index ont été ajoutés sur :

clés étrangères ;

colonnes utilisées dans WHERE ;

colonnes utilisées dans JOIN.

Cela améliore significativement la vitesse d’exécution des requêtes.

5.3 Bonnes pratiques

Éviter SELECT *

Utiliser des requêtes optimisées

Évaluer la possibilité d’une dénormalisation stratégique si nécessaire

6. Communication et adaptation

La communication a permis :

de valider les règles d’affaires ;

de corriger certaines erreurs (ex : emplacement de la quantité) ;

d’ajuster le modèle de manière itérative.

La conception d’une base de données est un processus évolutif.

7. Conclusion

La base de données conçue pour Mama Makusa :

respecte les étapes complètes de modélisation ;

applique la normalisation jusqu’à la 3FN ;

utilise un SGBD adapté aux besoins ;

intègre une stratégie d’optimisation claire ;

repose sur une justification technique objective.

Les captures d’écran ajoutées à la fin du document démontrent l’implémentation et les tests réalisés.


🔎 1️⃣ Vérifier la structure (Justifier la modélisation)
 <img width="945" height="231" alt="image" src="https://github.com/user-attachments/assets/dbbdcf5e-9271-46c7-b362-8970a1bd01cc" />


2️⃣ Requêtes fonctionnelles
 <img width="945" height="179" alt="image" src="https://github.com/user-attachments/assets/5cf38a8b-1a14-4b28-a35f-fe6c32426c12" />



✅ Détail complet d’une commande
<img width="945" height="174" alt="image" src="https://github.com/user-attachments/assets/f5b5edfb-4944-4242-9472-bc92578495c3" />
 

✅ Plats par catégorie
 <img width="945" height="175" alt="image" src="https://github.com/user-attachments/assets/1d25b687-cd45-47d2-9f01-e88519f8b10d" />


3️⃣ Requêtes de performance (Justifier l’optimisation)

<img width="945" height="203" alt="image" src="https://github.com/user-attachments/assets/b82eddd5-daf0-4608-901d-3af7cace6c90" />
