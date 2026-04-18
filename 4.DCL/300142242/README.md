# Tâche 4 : Contrôle d'accès aux données (DCL) - ID 300142242

## Description
Ce volet du projet porte sur le **Data Control Language (DCL)**, qui permet de gérer la sécurité et les privilèges des utilisateurs au sein de notre plateforme Moodle. L'objectif est de s'assurer que chaque acteur (étudiant ou professeur) possède uniquement les droits nécessaires à ses fonctions.

## Concepts Clés
* **DCL (Data Control Language)** : Commandes SQL comme `GRANT` et `REVOKE` utilisées pour contrôler l'accès aux données.
* **ACL (Access Control List)** : Contrairement au DCL qui agit dans la base de données, l'ACL gère les permissions au niveau du système de fichiers ou du réseau.

## Configuration des Rôles
Pour ce projet, nous avons créé deux utilisateurs avec des niveaux d'accès distincts sur le schéma `tp_dcl` :

1. **prof_moodle** : 
   * Possède les droits de lecture et d'écriture (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).
   * Peut modifier les notes et gérer les entrées du schéma.
2. **etudiant_moodle** : 
   * Possède uniquement le droit de lecture (`SELECT`).
   * Ne peut pas modifier ou ajouter de données.

## Preuve de fonctionnement (Sécurité)
L'image suivante montre une tentative d'insertion de données par l'utilisateur `etudiant_moodle`. Le système rejette l'action avec une erreur de permission, prouvant que les règles DCL sont bien appliquées.

![Capture Erreur DCL](./images/erreur_dcl_etudiant.png)

## Scripts inclus
* `dcl-moodle.sql` : Script contenant la création des utilisateurs et l'attribution des privilèges.
