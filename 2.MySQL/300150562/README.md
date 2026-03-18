# TP INF1099 - Installation Podman + MySQL

## Étudiant
- Nom: corneil ekofo
- Numéro: 300150562

## Installation complète

### 1. Installer Scoop (gestionnaire de paquets)
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
irm get.scoop.sh | iex
## installer Podman
scoop install podman
## installer mysql
scoop install mysql

# Base Sakila - Windows / MySQL

Ce projet installe et utilise la base de données **Sakila** sur Windows avec MySQL local.

## Prérequis
- Windows 10 ou supérieur  
- MySQL installé  
- Fichiers SQL Sakila décompressés, par exemple :  
  `C:\Users\lenovo\Downloads\projectDir\sakila-db\`

## Importer la base

Ouvrir **PowerShell** et exécuter :

```powershell
# Importer la structure (schema)
Get-Content "C:\Users\lenovo\Downloads\projectDir\sakila-db\sakila-schema.sql" | mysql -u root

# Importer les données
Get-Content "C:\Users\lenovo\Downloads\projectDir\sakila-db\sakila-data.sql" | mysql -u root

mysql -u root

SHOW DATABASES;
USE sakila;
SHOW TABLES;











