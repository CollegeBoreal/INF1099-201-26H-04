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
    UTILISATEUR ||--o{ TICKET : "soumet"
    CATEGORIE ||--o{ TICKET : "classe"
    TECHNICIEN ||--o{ TICKET : "prend_en_charge"

    TICKET ||--o{ INTERVENTION : "donne_lieu_a"
    TECHNICIEN ||--o{ INTERVENTION : "effectue"

    EQUIPE ||--o{ TECHNICIEN : "regroupe"

    UTILISATEUR {
        id_utilisateur
        nom
        prenom
        email
        telephone
    }

    TICKET {
        id_ticket
        titre
        description
        date_creation
    }

    TECHNICIEN {
        id_technicien
        nom
        prenom
        email
    }

    INTERVENTION {
        id_intervention
        date_intervention
        commentaire
    }

    CATEGORIE {
        id_categorie
        libelle
    }

    EQUIPE {
        id_equipe
        nom_equipe
    }

