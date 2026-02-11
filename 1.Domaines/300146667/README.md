# Projet : Fabrication et vente de pièces industrielles
## Djaber Benyezza 300146667

Ce dépôt décrit un mini-schéma de base de données pour gérer **la fabrication** et **la vente** de pièces industrielles (clients, commandes, production, fournisseurs, stock).

## Contenu

- `README.md` : description + diagramme E/R (Mermaid)
- `1FN.txt` : proposition de modèle **en 1ère forme normale (1FN)**
- `2FN.txt` : passage en **2ème forme normale (2FN)**
- `3FN.txt` : passage en **3ème forme normale (3FN)**

## Diagramme E/R (Mermaid ERD)

> Copie/colle ce bloc dans un viewer Mermaid (ou GitHub) pour afficher le diagramme.

```mermaid
erDiagram
    CLIENT ||--o{ COMMANDE : passe
    COMMANDE ||--|{ LIGNE_COMMANDE : contient
    PIECE ||--o{ LIGNE_COMMANDE : vendue_dans
    CATEGORIE_PIECE ||--o{ PIECE : classe
    USINE ||--o{ ORDRE_FABRICATION : planifie
    PIECE ||--o{ ORDRE_FABRICATION : fabrique
    ORDRE_FABRICATION ||--|{ OPERATION : compose
    FOURNISSEUR ||--o{ APPROVISIONNEMENT : fournit
    PIECE ||--o{ APPROVISIONNEMENT : approvisionnee
    ENTREPOT ||--o{ STOCK : contient
    PIECE ||--o{ STOCK : stockee

    CLIENT {
      int client_id PK
      string nom
      string email
      string telephone
      string adresse
      string ville
      string province
      string code_postal
      string pays
    }

    COMMANDE {
      int commande_id PK
      date date_commande
      string statut
      int client_id
    }

    LIGNE_COMMANDE {
      int ligne_id PK
      int commande_id
      int piece_id
      int quantite
      decimal prix_unitaire
      decimal remise
    }

    CATEGORIE_PIECE {
      int categorie_id PK
      string libelle
    }

    PIECE {
      int piece_id PK
      string reference UK
      string designation
      string type_piece
      string unite
      decimal prix_catalogue
      int categorie_id
    }

    USINE {
      int usine_id PK
      string nom
      string adresse
      string ville
      string province
      string pays
    }

    ORDRE_FABRICATION {
      int of_id PK
      int piece_id
      int usine_id
      date date_lancement
      date date_fin_prevue
      string statut
      int quantite_planifiee
    }

    OPERATION {
      int operation_id PK
      int of_id
      string poste
      string description
      int duree_minutes
      int ordre
    }

    FOURNISSEUR {
      int fournisseur_id PK
      string nom
      string email
      string telephone
      string pays
    }

    APPROVISIONNEMENT {
      int appro_id PK
      int fournisseur_id
      int piece_id
      decimal cout_unitaire
      int delai_jours
      string reference_fournisseur
    }

    ENTREPOT {
      int entrepot_id PK
      string nom
      string adresse
      string ville
    }

    STOCK {
      int stock_id PK
      int entrepot_id
      int piece_id
      int quantite_disponible
      int seuil_alerte
      date date_maj
    }
```

## Idée d’utilisation (SQL)

- Créer les tables à partir des entités ci-dessus
- Ajouter des contraintes (PK, FK, UNIQUE, CHECK)
- Tester des requêtes : ventes par période, stock bas, suivi des ordres de fabrication, fournisseurs par pièce, etc.
