CarGoRent – Système de gestion de location de voitures  

Nom : Taki Eddine Choufa  

Matricule : 300150524  



🌍 Présentation  

Bonjour,  

Je m’appelle Taki Eddine Choufa.  

Ce projet démontre ma compréhension de la modélisation Entité/Relation (E/R) et des formes normales (1FN, 2FN, 3FN), afin de concevoir une base de données claire, cohérente et évolutive pour un système de location de voitures.



🎯 Objectifs du projet  

\- Appliquer les principes de normalisation (1FN → 3FN)  

\- Identifier les entités, leurs attributs et leurs relations  

\- Réduire la redondance et éviter les anomalies (insertion / mise à jour / suppression)  

\- Préparer une structure solide pour une implémentation future (SQL)  



🧱 Formes normales  



✅ Première Forme Normale (1FN)  

\- Chaque champ contient une valeur atomique  

\- Aucune liste / valeur multiple dans une cellule  

\- Chaque enregistrement est identifiable par une clé (PK)  

📄 Fichier : 1FN.txt  



✅ Deuxième Forme Normale (2FN)  

\- Déjà en 1FN  

\- Tous les attributs non-clés dépendent entièrement de la clé primaire  

\- Élimination des dépendances partielles  

📄 Fichier : 2FN.txt  



✅ Troisième Forme Normale (3FN)  

\- Déjà en 2FN  

\- Aucun attribut non-clé ne dépend d’un autre attribut non-clé  

\- Élimination des dépendances transitives  

📄 Fichier : 3FN.txt  



---



✅ Modèle relationnel (3FN)  

Remarque : Les clés primaires (PK) et clés étrangères (FK) seront définies lors de l’implémentation SQL.



Client (Nom, Prénom, Téléphone, Email, Adresse)  

Voiture (Marque, Modèle, Année, Immatriculation, Couleur, Kilométrage)  

Catégorie (Nom\_catégorie, Description, Tarif\_journalier)  

Agence (Nom\_agence, Adresse, Téléphone)  

Réservation (Date\_réservation, Date\_début, Date\_fin, Statut)  

Contrat\_Location (Date\_contrat, Montant\_total, Statut\_contrat)  

Paiement (Date\_paiement, Montant, Mode\_paiement, Statut\_paiement)  

Assurance (Type\_assurance, Description, Prix\_journalier)  

Option (Nom\_option, Description, Prix\_journalier)  

Ajout\_Option (Date\_ajout)  

Retour\_Véhicule (Date\_retour, État\_véhicule, Kilométrage\_retour, Frais\_supplémentaires)  

Facture (Date\_facture, Montant\_total, Statut\_facture)  

Employé (Nom, Prénom, Poste, Téléphone, Email)  



