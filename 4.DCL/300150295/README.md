\# TP PostgreSQL – Gestion des utilisateurs et permissions (DCL)



\## Objectifs

\- Créer une base de données et un schéma

\- Créer des utilisateurs PostgreSQL

\- Attribuer des droits avec GRANT

\- Retirer des droits avec REVOKE

\- Tester les permissions selon les rôles

\- Comprendre la gestion des séquences SERIAL

\- Supprimer des utilisateurs avec DROP USER



\## Étapes du TP



1\. Création de la base `cours` et du schéma `tp\_dcl`

2\. Création de la table `etudiants` et insertion de données de test

3\. Création des utilisateurs `etudiant` (lecture) et `professeur` (lecture + écriture)

4\. Attribution des permissions avec GRANT

5\. Test des permissions avec SELECT, INSERT, UPDATE

6\. Retrait de droits avec REVOKE

7\. Suppression des utilisateurs (DROP USER)

8\. Bonus : création d’un rôle `enseignant` et d’un utilisateur `prof2` avec droits du rôle

9\. Correction des droits sur le schéma et la séquence SERIAL pour le rôle



\## Commandes principales

\- `CREATE USER`

\- `CREATE ROLE`

\- `GRANT`

\- `REVOKE`

\- `DROP USER`



