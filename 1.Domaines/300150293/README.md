<img width="8192" height="7894" alt="digramme ERD" src="https://github.com/user-attachments/assets/aeff263e-a975-4054-a1e4-71cef918ef20" /># ⚽ Football Field Reservation System

Projet académique – INF1099  
Collège Boréal  

## 📌 Description

Ce projet consiste à concevoir et modéliser une base de données pour un système de réservation de terrains de football.  

Le système permet :

- La gestion des centres sportifs
- La gestion des terrains et des créneaux
- La gestion des clients
- La réservation en ligne
- Le paiement des réservations
- La gestion des équipes et joueurs
- La gestion des matchs
- L’application de promotions
- La gestion des avis clients

-------

<img width="8192" height="7894" alt="image" src="https://github.com/user-attachments/assets/12f1c9ae-d350-4ea2-a32e-e1ad03bd048e" />


-------

## 🗂 Structure du projet

1.Domaines/
│
├── 300150293/
│   ├── images/
│   │   ├── diagramme ERD.png
│   │   ├── schema_mermaid.png
│   │
│   ├── 1FN
│   ├── 2FN
│   ├── 3FN

---

## 🧱 Normalisation

### ✅ 1FN
Toutes les données sont atomiques (une seule valeur par attribut).  
Cependant, il existe encore de nombreuses redondances.

### ✅ 2FN
Suppression des dépendances partielles.  
Les entités principales sont séparées (Client, Terrain, Réservation, Paiement, etc.).

### ✅ 3FN
Suppression des dépendances transitives.  
Ajout des entités Centre, Employé, Disponibilité, etc.  
Chaque table dépend uniquement de sa clé primaire.

---

## 🧩 Entités principales (3FN)

- Client
- Centre
- Employe
- Terrain
- Creneau
- Reservation
- Paiement
- Promotion
- Equipe
- Joueur
- Match
- Avis

---

## 🔗 Relations principales

- Un centre possède plusieurs terrains
- Un terrain propose plusieurs créneaux
- Un client effectue plusieurs réservations
- Une réservation peut générer un paiement
- Une équipe contient plusieurs joueurs
- Une réservation peut donner lieu à un match

---

## 🛠 Technologies utilisées

- Git / GitHub
- Mermaid (diagrammes ERD)
- Modélisation relationnelle
- Normalisation (1FN, 2FN, 3FN)

---

## 👤 Auteur

Nom : Salim Amir  
Programme : Techniques des Systèmes Informatiques  
Collège Boréal  

