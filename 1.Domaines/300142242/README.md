\# TP - Normalisation (1FN, 2FN, 3FN)



\## Fichiers fournis

\- 1FN.txt : schéma relationnel en première forme normale

\- 2FN.txt : schéma relationnel en deuxième forme normale

\- 3FN.txt : schéma relationnel final en troisième forme normale



\## Hypothèses

\- ORDER\_ITEM est une entité associative entre ORDER et PRODUCT.

\- La clé primaire de ORDER\_ITEM est composée : (order\_id, product\_id).

\- ORDER\_ITEM.price représente le prix du produit au moment de la commande (historique).



\## Résultat final (3FN)

CUSTOMER(id, name, email)  

ORDER(id, orderDate, status, customer\_id)  

PRODUCT(id, name, price)  

ORDER\_ITEM(order\_id, product\_id, quantity, price)



