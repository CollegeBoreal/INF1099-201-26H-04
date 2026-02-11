# Rabia BOUHALI 300151469
# Domaine 300151469 – Rendez-vous TCF Canada

## 1. Description du projet
Ce projet consiste à gérer les rendez-vous pour le test TCF au Canada.  
Il inclut :
- La normalisation des données en **1FN, 2FN et 3FN**.
- La création d’un **diagramme ER** pour visualiser les relations entre les entités.
- La documentation des étapes et commandes utilisées pour créer les fichiers et pousser sur GitHub.

---

## 2. Fichiers dans ce domaine
| Fichier | Description |
|---------|-------------|
| `1FN.txt` | Première forme normale (1FN) des données |
| `2FN.txt` | Deuxième forme normale (2FN) |
| `3FN.txt` | Troisième forme normale (3FN) |
| `README.md` | Ce fichier explicatif |
| `diagramme_er.mmd` | Diagramme ER au format Mermaid |

---

## 3. Diagramme ER (Mermaid)
```mermaid
erDiagram
    CANDIDAT ||--o{ RENDEZVOUS : prend
    RENDEZVOUS ||--|{ PAIEMENT : est_payé
    RENDEZVOUS ||--|{ SESSION : se_deroule
    SESSION ||--|{ LIEU : a_lieu

    CANDIDAT {
        string ID_Candidat PK
        string Nom
        string Prenom
        string Email
        string Telephone
    }

    SESSION {
        string ID_Session PK
        date Date
        string Heure
        string Type_Test
        string ID_Lieu FK
    }

    LIEU {
        string ID_Lieu PK
        string Nom_Lieu
        string Adresse
    }

    RENDEZVOUS {
        string ID_RendezVous PK
        string ID_Candidat FK
        string ID_Session FK
        string Statut
    }

    PAIEMENT {
        string ID_Paiement PK
        float Montant
        string Mode_Paiement
        date Date_Paiement
        string ID_RendezVous FK
    }
