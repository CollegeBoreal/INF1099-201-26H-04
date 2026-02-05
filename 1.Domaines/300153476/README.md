# 📘 Projet de Modélisation de Base de Données (E/R + Normalisation)
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
    PARENT ||--o{ ENFANT : "a"
    ENFANT ||--o{ INSCRIPTION : "s'inscrit"
    COURS ||--o{ SESSION_COURS : "contient"
    SESSION_COURS ||--o{ INSCRIPTION : "accueille"

    PROFESSEUR ||--o{ SESSION_COURS : "anime"
    COURS ||--o{ DEVOIR : "donne"
    DEVOIR ||--o{ SOUMISSION_DEVOIR : "reçoit"
    SOUMISSION_DEVOIR ||--o| NOTE : "obtient"

    COURS ||--o{ RESSOURCE : "utilise"

    ENFANT ||--o{ ATTRIBUTION_RECOMPENSE : "reçoit"
    RECOMPENSE ||--o{ ATTRIBUTION_RECOMPENSE : "attribuée"

    CONCOURS ||--o{ PARTICIPATION_CONCOURS : "a"
    ENFANT ||--o{ PARTICIPATION_CONCOURS : "participe"

    ENFANT ||--o{ SESSION_CHATIA : "utilise"
    SESSION_CHATIA ||--o{ MESSAGE_CHATIA : "contient"
