## 1️⃣ **Préparation** 🛠️

La première étape consiste à préparer l’environnement de travail.

On commence par se connecter en tant que superutilisateur PostgreSQL afin d’avoir les privilèges nécessaires pour créer une nouvelle base de données.

Ensuite :

Une base de données nommée cours est créée.

On se connecte à cette base.

Un schéma nommé tp_dcl est créé afin d’organiser les objets.

Une table etudiants est créée dans ce schéma pour servir d’exemple pratique.

<img width="544" height="141" alt="1" src="https://github.com/user-attachments/assets/694cdff6-59ed-48f6-86b4-3fcf87326086" />
<img width="719" height="161" alt="2" src="https://github.com/user-attachments/assets/1e65a5d7-091e-465a-bdab-d1ebe372ffaf" />
<img width="554" height="103" alt="3" src="https://github.com/user-attachments/assets/35c27da6-b455-4ec0-82f3-a33b601889bb" />
<img width="757" height="181" alt="4" src="https://github.com/user-attachments/assets/0a2bfd6d-7925-4327-be11-74a16f987171" />


## 2️⃣ Créer des utilisateurs
Deux utilisateurs sont créés afin de simuler des rôles différents :

etudiant : accès en lecture seulement

professeur : accès en lecture et écriture

Cette séparation permet d’illustrer le principe de contrôle d’accès basé sur les rôles.

<img width="962" height="192" alt="5" src="https://github.com/user-attachments/assets/0c910d46-1067-4651-87fb-589052a6ca8a" />



## 3️⃣ Donner des droits (GRANT)
Les permissions sont ensuite attribuées progressivement :

Les utilisateurs reçoivent le droit de se connecter à la base cours.

Ils obtiennent l’autorisation d’utiliser le schéma tp_dcl.

Les droits sur la table sont attribués selon leur rôle :

L’étudiant peut uniquement consulter les données.

Le professeur peut consulter, ajouter, modifier et supprimer des données.

Le professeur reçoit également les droits nécessaires sur la séquence associée à la clé primaire (obligatoire pour effectuer des insertions).

Cette étape démontre comment PostgreSQL permet un contrôle très précis des permissions.

<img width="818" height="85" alt="6" src="https://github.com/user-attachments/assets/432a858c-cd9e-4448-8ec5-be34f9591ccb" />
<img width="1042" height="299" alt="7" src="https://github.com/user-attachments/assets/c66e3089-4feb-4108-bbcb-3198e5fddc10" />


## 4️⃣ vérifier les droits
Les permissions sont testées en se connectant successivement avec chaque utilisateur.

L’utilisateur etudiant peut consulter les données mais ne peut pas en ajouter ni en modifier.

L’utilisateur professeur peut insérer de nouveaux enregistrements et modifier les données existantes.

Cette validation confirme que les droits ont été correctement configurés.

<img width="999" height="302" alt="8" src="https://github.com/user-attachments/assets/73186982-3ecc-4549-a4cf-e39fc539f336" />
<img width="970" height="233" alt="9" src="https://github.com/user-attachments/assets/37881791-bbfb-4fe4-b5f4-9a922d54e86a" />


## 5️⃣ Retirer des droits (REVOKE)
Une permission précédemment accordée est retirée à l’utilisateur etudiant.

Après cette modification :

L’étudiant ne peut plus consulter la table.

Une erreur est générée lors de la tentative d’accès.

Cette étape montre que les permissions peuvent être modifiées dynamiquement selon les besoins.

<img width="1031" height="320" alt="10-1" src="https://github.com/user-attachments/assets/4d798a33-bff7-4723-9518-bdd8d488d5f3" />
<img width="787" height="173" alt="10-2-2" src="https://github.com/user-attachments/assets/21caffe7-78ca-4131-aa5f-d54ee3de6820" />


## 6️⃣ Supprimer un utilisateur (DROP USER)
Enfin, les comptes etudiant et professeur sont supprimés du système.

Cette opération permet de nettoyer l’environnement après les tests et illustre la gestion complète du cycle de vie des utilisateurs.

<img width="1218" height="296" alt="11" src="https://github.com/user-attachments/assets/41ccff5f-86a1-48f8-971c-1495f2f8b50c" />
















