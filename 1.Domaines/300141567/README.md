# Projet : Système de gestion de tickets IT (Helpdesk)

Ce projet modélise une base de données pour un système de support informatique.
Il permet de gérer :
- Les utilisateurs
- Les tickets de support
- Les techniciens
- Les interventions
- Les statuts et priorités

Le but principal est d'illustrer la **normalisation des données (1NF → 3NF)**.

---

---

## Diagramme Entité-Relation 

```mermaid
erDiagram
    UTILISATEUR ||--o{ TICKET : soumet
    CATEGORIE ||--o{ TICKET : classe
    TECHNICIEN ||--o{ TICKET : prend_en_charge

    TICKET ||--o{ INTERVENTION : donne_lieu_a
    TECHNICIEN ||--o{ INTERVENTION : effectue

    EQUIPE ||--o{ TECHNICIEN : regroupe

    UTILISATEUR {
        int id_utilisateur
        string nom
        string prenom
        string email
        string telephone
    }

    TICKET {
        int id_ticket
        string titre
        string description
        date date_creation
    }

    TECHNICIEN {
        int id_technicien
        string nom
        string prenom
        string email
    }

    INTERVENTION {
        int id_intervention
        date date_intervention
        string commentaire
    }

    CATEGORIE {
        int id_categorie
        string libelle
    }

    EQUIPE {
        int id_equipe
        string nom_equipe
    }
