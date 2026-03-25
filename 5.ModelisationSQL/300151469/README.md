# Modélisation SQL — Gestion des rendez-vous TCF Canada

**Auteure :** Rabia BOUHALI  
**Matricule :** 300151469  

## 1. Description du projet

Ce projet consiste à concevoir une base de données relationnelle permettant de gérer les rendez-vous pour le test TCF (Test de Connaissance du Français) au Canada.

La base de données permet :
- La gestion des candidats
- La gestion des sessions d’examen
- L’organisation des lieux
- La prise de rendez-vous
- La gestion des paiements

## 2. Étapes de modélisation

La conception de cette base de données a suivi un processus structuré :
- Analyse des besoins (identification des utilisateurs et des données)
- Modélisation conceptuelle (diagramme Entité-Relation)
- Modélisation logique (création des tables, clés primaires et étrangères)
- Normalisation (réduction de la redondance des données)
- Implémentation SQL (création et manipulation de la base)

## 3. Fichiers du projet

| Fichier | Description |
|--------|-------------|
| `README.md` | Documentation du projet |
| `DDL.sql` | Création de la base et des tables |
| `DML.sql` | Insertion des données |
| `DQL.sql` | Requêtes SQL (SELECT, JOIN…) |
| `DCL.sql` | Gestion des droits et permissions |

## 4. Diagramme ER

```mermaid
erDiagram
    CANDIDAT ||--o{ RENDEZVOUS : prend
    RENDEZVOUS ||--|| SESSION : concerne
    LIEU ||--o{ SESSION : accueille
    RENDEZVOUS ||--o| PAIEMENT : est_paye

    CANDIDAT {
        int ID_Candidat PK
        string Nom
        string Prenom
        string Email
        string Telephone
    }

    SESSION {
        int ID_Session PK
        date Date
        time Heure
        string Type_Test
        int ID_Lieu FK
    }

    LIEU {
        int ID_Lieu PK
        string Nom_Lieu
        string Adresse
    }

    RENDEZVOUS {
        int ID_RendezVous PK
        int ID_Candidat FK
        int ID_Session FK
        string Statut
    }

    PAIEMENT {
        int ID_Paiement PK
        decimal Montant
        string Mode_Paiement
        date Date_Paiement
        int ID_RendezVous FK
    }

5. Justification des choix
Diagramme ER

Le diagramme Entité-Relation a été choisi car il permet de représenter clairement les entités, leurs attributs et leurs relations avant l’implémentation technique.

Choix du SGBD

Un SGBD relationnel (MySQL ou PostgreSQL) a été utilisé car le projet nécessite :

des relations fortes entre les données
des transactions fiables (ACID)
une bonne intégrité des données
6. Analyse critique

Le modèle pourrait être amélioré en ajoutant :

la gestion des disponibilités des sessions
la gestion des annulations et remboursements
des index pour améliorer les performances
7. Conclusion

Ce projet a permis d’appliquer les concepts de modélisation SQL, notamment :

la conception d’une base de données
la création d’un diagramme ER
la structuration des tables et des relations
l’implémentation SQL complète

La base de données obtenue est cohérente, évolutive et optimisée.
