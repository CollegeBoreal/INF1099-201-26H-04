# Système de Gestion Scolaire (Type Moodle) - Modélisation de Base de Données

## Diagramme Entité-Relation (E/R)
![Diagramme ER](./images/diagramme_er.png)

## Explication du Diagramme en Langage Clair

Ce diagramme représente la structure fondamentale de notre plateforme de gestion scolaire. Il est composé de quatre entités principales qui interagissent pour gérer les étudiants et leurs cours :

1. **ETUDIANT (Student) :** Représente l'utilisateur qui suit les cours. Chaque étudiant possède un identifiant unique (`id`), un nom (`nom`), et une adresse courriel (`email`).
2. **INSCRIPTION (Enrollment/Order) :** Agit comme le dossier d'admission global d'un étudiant pour une session donnée. Un étudiant peut avoir plusieurs dossiers d'inscription au fil du temps. Il contient un identifiant (`id`), la date d'inscription (`date_inscription`), et le statut du dossier (`statut`).
3. **COURS (Course/Product) :** Représente les matières offertes par l'école. Chaque cours a un identifiant unique (`id`), un titre (`titre`), et un nombre de crédits ou un coût (`credits`).
4. **DETAIL_INSCRIPTION (Enrollment Item) :** C'est la table de liaison (ou table associative) qui connecte une inscription spécifique à un cours spécifique. Elle permet de gérer le fait qu'une inscription peut inclure plusieurs cours, et qu'un cours peut avoir plusieurs étudiants inscrits. Elle stocke des informations spécifiques à cette relation, comme la note obtenue (`note`).

**Flux des relations :**
Un `ETUDIANT` *effectue* une `INSCRIPTION`. Cette `INSCRIPTION` *contient* un ou plusieurs `DETAIL_INSCRIPTION`, qui à leur tour *incluent* les `COURS` spécifiques que l'étudiant va suivre.

<img width="6643" height="5800" alt="Academic Enrollment-2026-04-08-184001" src="https://github.com/user-attachments/assets/7588e9fe-c477-46fd-8811-23fd8faf25e7" />
