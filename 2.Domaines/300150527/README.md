# Normalisation de la Base de Données  
## Projet : Ultras Green Army Shop

<img width="1004" height="567" alt="image" src="https://github.com/user-attachments/assets/1cd270bd-ecd1-4787-b319-43b73add5b84" />
<img width="1004" height="568" alt="image" src="https://github.com/user-attachments/assets/0defeb37-cf7f-4fd2-8c48-0a90fa819607" />
<img width="1004" height="567" alt="image" src="https://github.com/user-attachments/assets/23217b32-7d6e-4f09-bb69-906ae7dd3356" />


Ce travail présente la conception et la normalisation de la base de données
de l’application **Ultras Green Army Shop**, développée initialement avec Flutter.

L’objectif est d’appliquer les règles de normalisation des bases de données
(1NF, 2NF et 3NF) et de représenter la structure finale à l’aide d’un
diagramme Entité/Relation (E/R).

--------------

## 1️⃣ Première Forme Normale (1NF)

Dans la première étape, toutes les informations étaient regroupées
dans une seule table globale contenant les données du client,
des produits, de la commande et du paiement.

Cette structure respecte la 1NF car :
- Tous les attributs contiennent des valeurs atomiques
- Il n’y a pas de groupes répétitifs

Cependant, cette table présente plusieurs problèmes :
- Redondance des données
- Difficulté de mise à jour
- Risque d’incohérence

Les détails sont décrits dans le fichier **1FN.txt**.

--------------

## 2️⃣ Deuxième Forme Normale (2NF)

Pour passer de la 1NF à la 2NF, les dépendances partielles ont été supprimées
en séparant les données selon leur dépendance fonctionnelle.

Les informations ont été réparties dans plusieurs tables :
- CLIENT
- PRODUIT
- COMMANDE
- DETAIL_COMMANDE

Cette étape permet :
- Une meilleure organisation des données
- Une réduction de la redondance
- Une structure plus claire et plus maintenable

Les détails sont décrits dans le fichier **2FN.txt**.

-------------

## 3️⃣ Troisième Forme Normale (3NF)

Pour passer de la 2NF à la 3NF, les dépendances transitives ont été éliminées.

Les informations liées au paiement ont été séparées dans une table dédiée,
et la structure finale respecte entièrement les règles de normalisation.

Les tables finales sont :
- CLIENT
- PRODUIT
- COMMANDE
- DETAIL_COMMANDE
- PAIEMENT

Cette structure garantit :
- La cohérence des données
- L’absence de redondance
- Une base de données optimisée

Les détails sont décrits dans le fichier **3FN.txt**.

---

## Diagramme Entité / Relation (E/R)

![diagramme2](https://github.com/user-attachments/assets/e839e507-7f84-4a27-8624-30abd7016f81)

----------------

<img width="739" height="528" alt="diagramme1" src="https://github.com/user-attachments/assets/66f8f224-0f75-48f8-b4b9-434fe7d5063f" />


Le diagramme E/R représente graphiquement la structure finale de la base
de données en 3NF, ainsi que les relations entre les différentes entités.


---

## Conclusion

À travers ce travail, nous avons appliqué de manière progressive
les formes normales (1NF, 2NF et 3NF) afin d’obtenir une base de données
bien structurée, cohérente et adaptée à une application e-commerce.

Ce travail permet de mieux comprendre l’importance de la normalisation
dans la conception des bases de données relationnelles.

