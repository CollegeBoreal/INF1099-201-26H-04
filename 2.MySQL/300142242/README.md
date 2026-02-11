Yeah, your README is missing key stuff.

A complete README must include:

Podman setup commands (machine init/start)

Download + unzip Sakila

Run MySQL container

Create DB + user + privileges

Import schema + data

Verification commands

How to run your script

Screenshots section

Your identity info (name/id/github)

Use this FULL README (copy/paste):

# INF1099 – TP : MySQL Sakila avec Podman (Docker alias)

## 📋 Informations

- **Nom complet** : Yahia Abderrafia
- **ID étudiant** : 300142242
- **GitHub** : yahiiiia
- **Cours** : INF1099
- **Système** : Windows 11
- **Technologie** : Podman (WSL)
- **Base** : MySQL 8.0 + Sakila

---

## 🎯 Objectifs

Ce TP consiste à :
- Configurer Podman sur Windows
- Lancer un conteneur MySQL 8.0
- Créer la base `sakila`
- Créer un utilisateur MySQL
- Importer le schéma et les données Sakila
- Vérifier l’importation avec des requêtes SQL
- Automatiser le processus avec un script bash

---

## 🛠️ Prérequis

- Windows 10/11 64 bits
- Podman installé
- WSL activé
- Accès Internet

---

## 1) Initialiser et démarrer Podman Machine

```powershell
podman machine init
podman machine start
podman machine list
