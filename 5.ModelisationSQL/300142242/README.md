# 🎓 Projet Moodle — Architecture & Administration de Base de Données

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Podman](https://img.shields.io/badge/Podman-892CA0?style=for-the-badge&logo=podman&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin4-336791?style=for-the-badge&logo=postgresql&logoColor=white)

> **Projet de fin de module (INF1099)** : Conception, déploiement et optimisation d'une base de données relationnelle robuste pour la gestion d'un système d'information académique (type Moodle).

---

## 🎯 Objectifs et Réalisations

Ce projet démontre la maîtrise du cycle complet de vie d'une base de données, de l'analyse des besoins jusqu'à l'administration fine des permissions :
- **Modélisation** : Conception conceptuelle et logique normalisée en **3FN** pour garantir l'intégrité référentielle.
- **Déploiement** : Conteneurisation de l'environnement avec **Podman**.
- **Performance** : Stratégie d'indexation (B-tree) validée via `EXPLAIN ANALYZE`.
- **Sécurité** : Mise en place d'un contrôle d'accès basé sur les rôles (RBAC) via le **DCL**.

---

## 🗂️ Architecture du Dépôt

Le projet est structuré selon les standards professionnels SQL :

| Fichier | Langage | Description |
| :--- | :--- | :--- |
| 📄 `DDL.sql` | **Data Definition** | Déploiement des schémas, tables, contraintes `CHECK`/`FK` et **Index**. |
| 📄 `DML.sql` | **Data Manipulation** | Peuplement de la base avec un jeu de données de test réaliste. |
| 📄 `DQL.sql` | **Data Query** | Requêtes d'analyse métier (Jointures multiples, Agrégations, Sous-requêtes). |
| 📄 `DCL.sql` | **Data Control** | Stratégie de sécurité, création des rôles et matrice des privilèges. |

---

## 🗺️ Modèle Entité-Relation (ERD)

```mermaid
erDiagram
    DEPARTEMENT ||--o{ PROFESSEUR : "emploie"
    PROFESSEUR ||--o{ COURS : "enseigne"
    ETUDIANT ||--o{ INSCRIPTION : "effectue"
    SESSION_SCOLAIRE ||--o{ INSCRIPTION : "appartient a"
    INSCRIPTION ||--o{ DETAIL_INSCRIPTION : "contient"
    COURS ||--o{ DETAIL_INSCRIPTION : "evalue dans"

    ETUDIANT {
        int id_etudiant PK
        string nom
        string prenom
        string email UK
    }
    COURS {
        int id_cours PK
        string titre
        int credits
        int id_professeur FK
    }
    DETAIL_INSCRIPTION {
        int id_detail PK
        float note_finale
        int id_cours FK
        int id_inscription FK
    }
