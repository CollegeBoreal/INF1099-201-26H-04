# Projet: EduHome – Système de gestion d’apprentissage à domicile
**Nom :** Ramatoulaye Diallo  
**Matricule :** 300153476  

---

## 🌍 Présentation

Bonjour,  
Je m’appelle **Ramatoulaye Diallo**, originaire de **Guinée Conakry 🍀**.  
Ce projet démontre ma compréhension de la **modélisation Entité/Relation (E/R)** et des **formes normales (1FN, 2FN, 3FN)**, afin de concevoir une base de données claire, cohérente et évolutive.

---

## 🎯 Objectifs du projet

- Appliquer les principes de **normalisation (1FN → 3FN)**
- Identifier les **entités**, leurs **attributs** et leurs **relations**
- Réduire la redondance et éviter les anomalies (insertion / mise à jour / suppression)
- Préparer une structure solide pour une implémentation future (SQL)

---

## 🧱 Formes normales

### ✅ Première Forme Normale (1FN)
- Chaque champ contient **une valeur atomique**
- Aucune liste / valeur multiple dans une cellule
- Chaque enregistrement est identifiable par une clé (PK)

📄 Fichier : `1FN.txt`

---

### ✅ Deuxième Forme Normale (2FN)
- Déjà en **1FN**
- Tous les attributs non-clés dépendent **entièrement** de la clé primaire
- Élimination des **dépendances partielles**

📄 Fichier : `2FN.txt`

---

### ✅ Troisième Forme Normale (3FN)
- Déjà en **2FN**
- Aucun attribut non-clé ne dépend d’un autre attribut non-clé
- Élimination des **dépendances transitives**

📄 Fichier : `3FN.txt`

---

## ✅ Modèle relationnel (3FN)

> Remarque : Les clés primaires (PK) et clés étrangères (FK) seront définies lors de l’implémentation SQL.

- **Parent** (Nom, Prénom, Téléphone, Email)  
- **Enfant** (Nom, Prénom, Âge, Niveau)  
- **Professeur** (Nom, Prénom, Téléphone, Email, Spécialité)  
- **Cours** (Titre_cours, Langue, Niveau)  
- **Session_Cours** (Date_session, Heure_session, Durée, Mode_session)  
- **Inscription** (Date_inscription, Statut_inscription)  
- **Devoir** (Titre_devoir, Description, Date_limite)  
- **Soumission_Devoir** (Date_soumission, Fichier_ou_lien, Commentaire)  
- **Note** (Valeur, Commentaire, Date_correction)  
- **Ressource** (Titre_ressource, Type_ressource, URL_ressource)  
- **Récompense** (Nom_récompense, Description, Points)  
- **Attribution_Récompense** (Date_attribution, Motif)  
- **Concours** (Titre_concours, Date_concours, Description, Prix)  
- **Participation_Concours** (Résultat, Score, Rang)  
- **Session_ChatIA** (Date_session, Sujet, Durée)  
- **Message_ChatIA** (Contenu_message, Rôle, Date_heure)

---

## 🧩 Diagramme Entité / Relation (E/R)

> Ce diagramme illustre les liens principaux du système (cours, inscriptions, devoirs, notes, ressources, récompenses, concours, chat IA).

<img src = 'images/Entite Association.png' width = 800 />

```mermaid
erDiagram

    parent {
        int id_parent PK
        string nom
        string prenom
        string telephone
        string email
    }

    enfant {
        int id_enfant PK
        string nom
        string prenom
        int age
        string niveau
        int id_parent FK
    }

    professeur {
        int id_prof PK
        string nom
        string prenom
        string telephone
        string email
        string specialite
    }

    cours {
        int id_cours PK
        string titre_cours
        string langue
        string niveau
        int id_prof FK
    }

    session_cours {
        int id_session PK
        date date_session
        time heure_session
        int duree
        string mode_session
        int id_cours FK
    }

    inscription {
        int id_inscription PK
        date date_inscription
        string statut_inscription
        int id_enfant FK
        int id_session FK
    }

    devoir {
        int id_devoir PK
        string titre_devoir
        string description
        date date_limite
        int id_cours FK
    }

    soumission_devoir {
        int id_soumission PK
        date date_soumission
        string fichier_ou_lien
        string commentaire
        int id_devoir FK
        int id_enfant FK
    }

    note {
        int id_note PK
        float valeur
        string commentaire
        date date_correction
        int id_soumission FK
    }

    ressource {
        int id_ressource PK
        string titre_ressource
        string type_ressource
        string url_ressource
        int id_cours FK
    }

    recompense {
        int id_recompense PK
        string nom_recompense
        string description
        int points
    }

    attribution_recompense {
        int id_attribution PK
        date date_attribution
        string motif
        int id_enfant FK
        int id_recompense FK
    }

    concours {
        int id_concours PK
        string titre_concours
        date date_concours
        string description
        string prix
    }

    participation_concours {
        int id_participation PK
        string resultat
        float score
        int rang
        int id_enfant FK
        int id_concours FK
    }

    session_chatia {
        int id_session_chat PK
        date date_session
        string sujet
        int duree
        int id_enfant FK
    }

    message_chatia {
        int id_message PK
        string contenu_message
        string role
        datetime date_heure
        int id_session_chat FK
    }

    %% RELATIONS (crow's foot)

    parent ||--o{ enfant : "1 parent -> 0..n enfants"

    professeur ||--o{ cours : "1 prof -> 0..n cours"
    cours ||--o{ session_cours : "1 cours -> 0..n sessions"

    enfant ||--o{ inscription : "1 enfant -> 0..n inscriptions"
    session_cours ||--o{ inscription : "1 session -> 0..n inscriptions"

    cours ||--o{ devoir : "1 cours -> 0..n devoirs"
    devoir ||--o{ soumission_devoir : "1 devoir -> 0..n soumissions"
    enfant ||--o{ soumission_devoir : "1 enfant -> 0..n soumissions"

    soumission_devoir ||--o| note : "1 soumission -> 0..1 note"

    cours ||--o{ ressource : "1 cours -> 0..n ressources"

    enfant ||--o{ attribution_recompense : "1 enfant -> 0..n attributions"
    recompense ||--o{ attribution_recompense : "1 recompense -> 0..n attributions"

    enfant ||--o{ participation_concours : "1 enfant -> 0..n participations"
    concours ||--o{ participation_concours : "1 concours -> 0..n participations"

    enfant ||--o{ session_chatia : "1 enfant -> 0..n sessions chat"
    session_chatia ||--o{ message_chatia : "1 session chat -> 0..n messages"
