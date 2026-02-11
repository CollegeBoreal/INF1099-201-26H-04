# INF1099 – TP : Manipulation de données avec MySQL et Podman sur Windows

## 📌 Informations

- **Nom complet** : Yahia Abderrafia  
- **ID étudiant** : 300142242  
- **GitHub** : yahiiiia  
- **Cours** : INF1099  
- **Système** : Windows 11  
- **Technologie** : Podman (alias Docker)  
- **Base de données** : MySQL 8.0  
- **Dataset** : Sakila DB  

---

## 🎯 Objectifs du TP

Ce TP permet de :

- Installer et utiliser Podman sur Windows
- Démarrer une machine Podman (VM Linux via WSL)
- Déployer un conteneur MySQL 8.0
- Créer une base de données `sakila`
- Créer un utilisateur MySQL `etudiants`
- Importer le schéma et les données Sakila
- Vérifier l'importation avec des commandes SQL
- Automatiser le processus avec un script PowerShell

---

## 🛠️ Prérequis

- Windows 10/11 (64 bits)
- Podman installé
- PowerShell
- Accès Internet

---

## 1) Démarrer Podman Machine

```powershell
podman machine init
podman machine start
podman machine list
