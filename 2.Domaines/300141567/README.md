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
    UTILISATEUR ||--o{ TICKET : "crée"
    CATEGORIE ||--o{ TICKET : "classe"
    STATUT ||--o{ TICKET : "définit"
    PRIORITE ||--o{ TICKET : "indique"

    TICKET ||--o{ INTERVENTION : "génère"
    TECHNICIEN ||--o{ INTERVENTION : "réalise"

    EQUIPE ||--o{ TECHNICIEN : "contient"

    UTILISATEUR {
        int id_utilisateur PK
        string nom
        string prenom
        string email
        string telephone
    }

    TICKET {
        int id_ticket PK
        string titre
        string description
        date date_creation
        int id_utilisateur FK
        int id_categorie FK
        int id_statut FK
        int id_priorite FK
    }

    TECHNICIEN {
        int id_technicien PK
        string nom
        string prenom
        string email
        int id_equipe FK
    }
