# 📚 Projet de Base de Données  
## Système de Gestion d’une Bibliothèque Universitaire

---

## 🎯 Objectif du projet

L’objectif de ce projet est de concevoir et normaliser une base de données relationnelle pour une bibliothèque universitaire.

Ce travail permet de :

- Identifier les entités d’un système réel
- Définir les relations et leurs cardinalités
- Appliquer les formes normales (1FN, 2FN, 3FN)
- Concevoir un diagramme Entité/Relation (E/R)
- Préparer l’implémentation en SQL

---

## 🏛️ Présentation du système

La bibliothèque universitaire permet aux étudiants d’emprunter des livres.

Le système permet de :

- Créer des comptes membres
- Enregistrer plusieurs adresses
- Consulter les livres classés par catégorie
- Associer chaque livre à un auteur
- Effectuer des emprunts
- Gérer les statuts des emprunts (en cours, retourné, en retard)
- Gérer les paiements d’amendes
- Assigner un employé responsable pour chaque emprunt

---

## 🧩 Entités principales

- Membre
- Adresse
- Livre
- Catégorie
- Auteur
- Emprunt
- Ligne_Emprunt
- Paiement
- Employé

---

## 🔄 Relations principales

- Un membre peut effectuer plusieurs emprunts.
- Un membre peut posséder plusieurs adresses.
- Un emprunt contient plusieurs livres.
- Un livre appartient à une seule catégorie.
- Un auteur peut écrire plusieurs livres.
- Un emprunt peut donner lieu à un paiement.
- Un employé gère les emprunts.

---

## 📊 Diagramme Entité / Relation (E/R)

Ci-dessous le diagramme conceptuel du système :

![Diagramme ER](A_diagram_of_an_entity-relationship_(ER)_model_for.png)

*(Assurez-vous que l’image se trouve dans le même dossier que le fichier README.md)*

---

## 🗂️ Structure du projet

Le projet contient :

- README.md
- 1FN.txt
- 2FN.txt
- 3FN.txt
- Diagramme E/R (image)

---

## 🛠️ Technologies prévues

- Modélisation conceptuelle (Diagramme E/R)
- Base de données relationnelle
- MySQL (implémentation future)

---

## 👨‍🎓 Auteur

Projet réalisé dans le cadre du cours de Bases de Données.
