# 🏋️ Gestion d'une salle de sport
👤 Informations étudiant

Nom : Aroua Mohand Tahar

ID Boréal : 300150284

Cours : INF1099

## 📌 Description du projet

Ce projet consiste à concevoir une base de données pour la **gestion d'une salle de sport**.  
Le système permet de gérer les **membres**, les **abonnements**, les **séances d'entraînement**, les **coachs**, les **paiements** et la **présence des membres**.

---

## 🧩 Normalisation

Le modèle de données respecte les règles de normalisation suivantes :
- Première Forme Normale (1FN)
- Deuxième Forme Normale (2FN)
- Troisième Forme Normale (3FN)

---

## 📊 Diagramme ER (ERD)

```mermaid
erDiagram
    MEMBRE ||--o{ ABONNEMENT : "souscrit"
    ABONNEMENT ||--o{ PAIEMENT : "genere"
    COACH ||--o{ SEANCE : "anime"
    MEMBRE ||--o{ PRESENCE : "participe"
    SEANCE ||--o{ PRESENCE : "concerne"
    
    MEMBRE {
        int id_membre PK
        string nom
        string prenom
        string telephone
        string email
        date date_naissance
    }
    
    ABONNEMENT {
        int id_abonnement PK
        string type
        float prix
        date date_debut
        date date_fin
        int id_membre FK
    }
    
    COACH {
        int id_coach PK
        string nom
        string prenom
        string specialite
    }
    
    SEANCE {
        int id_seance PK
        string nom_seance
        date date
        time heure
        int id_coach FK
    }
    
    PRESENCE {
        int id_presence PK
        string statut
        int id_membre FK
        int id_seance FK
    }
    
    PAIEMENT {
        int id_paiement PK
        date date_paiement
        float montant
        string mode_paiement
        int id_abonnement FK
    }
```

---

## 🚀 Utilisation

Ce modèle de base de données peut être utilisé pour :
- Gérer les inscriptions des membres
- Suivre les abonnements et leur validité
- Organiser les séances d'entraînement
- Enregistrer la présence aux séances
- Gérer les paiements

---

## 📝 Licence

Ce projet est développé dans un cadre éducatif.
