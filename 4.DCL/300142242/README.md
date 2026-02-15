TP : Gestion des droits et sécurité (DCL)

**Étudiant :** Abderrafia Yahia

**Matricule :** 300142242

## 1. Introduction au DCL

Dans ce TP, j'ai exploré le **DCL (Data Control Language)**, qui est la composante du SQL dédiée à la sécurité des données. Contrairement au DML qui manipule les données, le DCL permet de définir **qui** peut accéder à ces données et **quelles actions** sont autorisées (lecture, écriture, modification).

## 2. Préparation de l'environnement de test

Pour isoler mes tests, j'ai créé une infrastructure dédiée dans mon conteneur PostgreSQL :

* 
**Base de données** : Création de la base `cours`.


* 
**Schéma** : Création du schéma `tp_dcl` pour organiser les objets.


* 
**Table** : Création d'une table `etudiants` comportant les colonnes `id`, `nom` et `moyenne`.



## 3. Gestion des utilisateurs et des rôles

J'ai simulé deux types d'utilisateurs avec des niveaux de privilèges distincts:

1. 
**Utilisateur `etudiant**` : Créé avec le mot de passe `etudiant123`, destiné à la consultation seule.


2. 
**Utilisateur `professeur**` : Créé avec le mot de passe `prof123`, possédant des droits étendus pour la gestion des notes.



## 4. Attribution et vérification des droits (GRANT)

J'ai configuré les permissions de manière granulaire:

* J'ai autorisé la connexion à la base et l'usage du schéma pour les deux comptes.


* 
**Pour l'étudiant** : J'ai limité l'accès à la commande `SELECT`.


* 
**Pour le professeur** : J'ai accordé les droits `SELECT`, `INSERT`, `UPDATE` et `DELETE`, ainsi que l'accès à la séquence d'auto-incrémentation pour permettre l'ajout de nouveaux dossiers.



### Validation des tests de sécurité

J'ai effectué des tests croisés pour valider ma configuration :

* 
**Test Étudiant** : La tentative d'insertion (`INSERT`) a été bloquée par le système avec un message d'erreur de permission, confirmant que ma politique de "lecture seule" est active.


* 
**Test Professeur** : L'insertion de mon nom ("Yahia") a réussi sans encombre, prouvant que les privilèges d'écriture sont correctement attribués.



## 5. Révocation et Nettoyage (REVOKE / DROP)

Pour finaliser le cycle de gestion des droits, j'ai testé la commande `REVOKE` en retirant le droit de lecture à l'étudiant, ce qui a immédiatement rendu la table inaccessible pour lui. Enfin, j'ai supprimé les utilisateurs temporaires pour laisser la base de données propre.

## 6. Conclusion : DCL vs ACL

Ce TP m'a permis de bien distinguer le **DCL**, qui gère les permissions à l'intérieur de la base (tables, colonnes), des **ACL**, qui gèrent les accès au niveau du système de fichiers ou du réseau.

---

### Pièces jointes (Captures d'écran)

* **Preuve 1** : Erreur de permission lors de la tentative d'insertion par l'étudiant.
* **Preuve 2** : Succès de l'insertion et affichage de la table par le professeur.
* 
**Preuve 3** : Liste des droits via la commande `\dp` ou `\du`.
