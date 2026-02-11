# 📊 Schéma de base de données –  betformula 

```mermaid
erDiagram
    UTILISATEUR {
        int id_user PK
        string nom
        string email
        int id_ville FK
    }

    VILLE {
        int id_ville PK
        string nom_ville
        string code_postal
    }

    PILOTE {
        int id_pilote PK
        string nom_pilote
        int id_equipe FK
    }

    EQUIPE {
        int id_equipe PK
        string nom_equipe
        int id_sponsor FK
    }

    SPONSOR {
        int id_sponsor PK
        string nom_sponsor
    }

    CIRCUIT {
        int id_circuit PK
        string nom_circuit
        int id_ville FK
    }

    EVENEMENT {
        int id_evenement PK
        string nom_evenement
        date date_evenement
        int id_circuit FK
    }

    COURSE {
        int id_course PK
        string nom_course
        date date_course
        int id_evenement FK
    }

    PARI {
        int id_pari PK
        int id_user FK
        int id_course FK
        int id_pilote FK
        float montant
        string resultat
    }

    UTILISATEUR ||--o{ VILLE : "habite à"
    PILOTE ||--o{ EQUIPE : "appartient à"
    EQUIPE ||--o{ SPONSOR : "sponsorisé par"
    CIRCUIT ||--o{ VILLE : "situé à"
    EVENEMENT ||--o{ CIRCUIT : "se déroule sur"
    COURSE ||--o{ EVENEMENT : "fait partie de"
    PARI ||--o{ UTILISATEUR : "fait par"
    PARI ||--o{ COURSE : "concernant"
    PARI ||--o{ PILOTE : "sur"
