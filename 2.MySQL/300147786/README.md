# INF1099 – Manipulation de données avec MySQL et Podman (Windows)

Ce projet a été réalisé dans le cadre du cours **INF1099**.  
Il présente la mise en place d’un environnement **MySQL** conteneurisé à l’aide de **Podman** (utilisé comme Docker) sur Windows, ainsi que l’importation et la manipulation de la base de données **Sakila**.

---

## 🎯 Objectifs

- Installer et configurer Podman avec un alias Docker
- Initialiser et démarrer une machine virtuelle Podman (Linux)
- Déployer un conteneur MySQL
- Créer une base de données et un utilisateur
- Importer la base de données Sakila
- Préparer l’environnement pour des exercices SQL

---

## 🧰 Prérequis

- Windows 10 / 11 (64 bits)
- Podman installé
- PowerShell (de préférence en mode Administrateur)
- Connexion Internet

---

## 📁 Préparation du projet

Créer un dossier de travail dans **Downloads** :

```powershell
$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force
