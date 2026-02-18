Présentation du site Mama Makusa 
 
Mama Makusa est une plateforme de vente en ligne spécialisée dans la cuisine africaine, basée à Toronto.
En lingala, Makusa signifie « cuisine », ce qui reflète l’identité du site : une cuisine africaine authentique, faite comme à la maison.

Le site permet aux clients de :

créer un compte utilisateur,

enregistrer une ou plusieurs adresses,

consulter les plats africains classés par catégorie et pays d’origine,

passer des commandes en ligne,

effectuer des paiements sécurisés,

et recevoir leurs commandes à domicile grâce à un service de livraison assuré par des livreurs.

Chaque commande est suivie à travers différents statuts (en préparation, payée, livrée, annulée), garantissant un bon suivi du processus de vente.

Mama Makusa s’adresse principalement à la communauté africaine de Toronto ainsi qu’à toute personne souhaitant découvrir la richesse de la gastronomie africaine.

```mermaid
erDiagram
    CLIENT ||--o{ COMMANDE : PASSE
    CLIENT ||--|{ ADRESSE : POSSEDE
    ADRESSE ||--o{ COMMANDE : LIVRAISON_A

    CATEGORIE ||--|{ PLAT : CLASSE
    PAYS_ORIGINE ||--o{ PLAT : ORIGINE

    COMMANDE ||--|{ LIGNE_COMMANDE : CONTIENT
    PLAT ||--o{ LIGNE_COMMANDE : EST_COMMANDE_DANS

    COMMANDE ||--|| PAIEMENT : EST_PAYEE_PAR
    COMMANDE o|--|| LIVRAISON : DONNE_LIEU_A
    LIVREUR ||--|{ LIVRAISON : EFFECTUE

    CLIENT {
        int id_client
        string nom
        string prenom
        string post_nom
        string telephone
        string email
        date date_creation
    }

    ADRESSE {
        int id_adresse
        int id_client
        int numero_rue
        string rue
        string ville
        string province
        string pays
        string code_postal
    }

    PLAT {
        int id_plat
        int id_categorie
        int id_pays
        string nom_plat
        string description
        float prix
        string statut
    }

    CATEGORIE {
        int id_categorie
        string nom_categorie
    }

    PAYS_ORIGINE {
        int id_pays
        string nom_pays
    }

    COMMANDE {
        int id_commande
        int id_client
        int id_adresse
        date date_commande
        string statut_commande
        float total_commande
    }

    LIGNE_COMMANDE {
        int id_commande
        int id_plat
        int quantite
        float prix_unitaire
    }

    PAIEMENT {
        int id_paiement
        int id_commande
        date date_paiement
        float montant
        string mode_paiement
        string statut_paiement
    }

    LIVRAISON {
        int id_livraison
        int id_commande
        int id_livreur
        date date_livraison
        string statut_livraison
        float frais_livraison
    }

    LIVREUR {
        int id_livreur
        string nom
        string prenom
        string post_nom
        string telephone
        string email
    }

```
