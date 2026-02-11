# Diagramme Entité-Relation  Maillots Vintage

```mermaid
erDiagram
    CLIENT ||--o{ COMMANDE : passe
    CLIENT ||--o{ ADRESSE : habite

    COMMANDE ||--|{ LIGNE_COMMANDE : contient
    MAILLOT ||--o{ LIGNE_COMMANDE : apparait_dans

    COMMANDE ||--|| PAIEMENT : est_payee_par
    MODE_PAIEMENT ||--o{ PAIEMENT : utilise
    PRESTATAIRE_PAIEMENT ||--o{ PAIEMENT : passe_par

    COMMANDE ||--|| LIVRAISON : genere
    COMMANDE ||--o{ HISTORIQUE_COMMANDE : genere

    CLUB ||--o{ MAILLOT : possede
    CATEGORIE_MAILLOT ||--o{ MAILLOT : classe

    CLIENT {
        int ID_Client PK
        string Nom
        string Prenom
        string Telephone
        string Email
    }

    ADRESSE {
        int ID_Adresse PK
        string Num_Rue
        string Rue
        string Ville
        string Code_Postal
        string Pays
        int ID_Client FK
    }

    CLUB {
        int ID_Club PK
        string Nom_Club
        string Pays_Club
    }

    CATEGORIE_MAILLOT {
        int ID_Categorie PK
        string Nom_Categorie
    }

    MAILLOT {
        int ID_Maillot PK
        string Nom_Maillot
        string Saison
        string Taille
        string Etat_Maillot
        float Prix
        int Stock
        int ID_Club FK
        int ID_Categorie FK
    }

    COMMANDE {
        int ID_Commande PK
        date Date_Commande
        string Statut_Commande
        float Total_Commande
        int ID_Client FK
    }

    LIGNE_COMMANDE {
        int ID_Ligne PK
        int Quantite
        float Prix_Unitaire
        int ID_Commande FK
        int ID_Maillot FK
    }

    PAIEMENT {
        int ID_Paiement PK
        date Date_Paiement
        float Montant_Paye
        int ID_Commande FK
        int ID_Mode_Paiement FK
        int ID_Prestataire FK
    }

    MODE_PAIEMENT {
        int ID_Mode_Paiement PK
        string Nom_Mode
    }

    PRESTATAIRE_PAIEMENT {
        int ID_Prestataire PK
        string Nom_Prestataire
        string Type_Service
    }

    LIVRAISON {
        int ID_Livraison PK
        date Date_Expedition
        date Date_Livraison
        string Statut_Livraison
        string Numero_Suivi
        int ID_Commande FK
    }

    HISTORIQUE_COMMANDE {
        int ID_Historique PK
        date Date_Action
        string Action
        int ID_Commande FK
    }
