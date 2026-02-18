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
        int id_client PK
        string nom
        string prenom
        string post_nom
        string telephone
        string email UNIQUE
        date date_creation
    }

    ADRESSE {
        int id_adresse PK
        int id_client FK
        int numero_rue
        string rue
        string ville
        string province
        string pays
        string code_postal
    }

    PLAT {
        int id_plat PK
        int id_categorie FK
        int id_pays FK
        string nom_plat
        string description
        float prix
        string statut
    }

    CATEGORIE {
        int id_categorie PK
        string nom_categorie UNIQUE
    }

    PAYS_ORIGINE {
        int id_pays PK
        string nom_pays UNIQUE
    }

    COMMANDE {
        int id_commande PK
        int id_client FK
        int id_adresse FK
        date date_commande
        string statut_commande
        float total_commande
    }

    LIGNE_COMMANDE {
        int id_commande FK
        int id_plat FK
        int quantite
        float prix_unitaire
    }

    PAIEMENT {
        int id_paiement PK
        int id_commande FK
        date date_paiement
        float montant
        string mode_paiement
        string statut_paiement
    }

    LIVRAISON {
        int id_livraison PK
        int id_commande FK
        int id_livreur FK
        date date_livraison
        string statut_livraison
        float frais_livraison
    }

    LIVREUR {
        int id_livreur PK
        string nom
        string prenom
        string post_nom
        string telephone
        string email
    }

```
