📘 TP – PostgreSQL avec Docker & pgAdmin

(Base Sakila)

🧾 Structure conseillée du TP (IMPORTANT)

👉 Utilise cette structure dans ton rapport Word / PDF
👉 Les captures doivent être placées juste après chaque étape

1️⃣ Installation de PostgreSQL avec Docker

🎯 Objectif

Lancer un serveur PostgreSQL dans un conteneur Docker.

✅ Étape 1 : Lancer le conteneur PostgreSQL

<img width="539" height="216" alt="image" src="https://github.com/user-attachments/assets/95bd3dd3-0d7c-4052-a5ed-bf86044cf62d" />


<img width="1414" height="510" alt="image" src="https://github.com/user-attachments/assets/55e857d7-8064-4cf5-a84e-e1c7cfa528fd" />

✅ Étape 2 : Vérifier que PostgreSQL fonctionne

<img width="1512" height="126" alt="image" src="https://github.com/user-attachments/assets/355d4c7a-4c9c-4ebb-b8ae-662bca790a45" />

2️⃣ Chargement de la base de données Sakila
🎯 Objectif

Importer le schéma et les données Sakila dans PostgreSQL.

✅ Étape 1 : Télécharger les fichiers Sakila (Windows)

<img width="1226" height="189" alt="image" src="https://github.com/user-attachments/assets/2d383d92-6359-4af8-9d4c-986e77cb6251" />

✅ Étape 2 : Copier les fichiers dans le conteneur

<img width="1156" height="94" alt="image" src="https://github.com/user-attachments/assets/0bef85c0-5ae6-47dd-8cb5-ab2e02555d12" />

✅ Étape 3 : Exécuter les scripts SQL

<img width="574" height="232" alt="image" src="https://github.com/user-attachments/assets/0f80e104-f240-4952-875c-00e47c985998" />

✅ Étape 4 : Vérification des tables

<img width="624" height="637" alt="image" src="https://github.com/user-attachments/assets/4b354e87-d045-4ec1-9f6b-ad17ee8dbb1d" />

<img width="796" height="320" alt="image" src="https://github.com/user-attachments/assets/243cfed5-32b1-499a-8cf9-0a266e79f397" />

3️⃣ Installation de pgAdmin 4 (Windows)
🎯 Objectif

Installer une interface graphique pour PostgreSQL.

✅ Étape 1 : Installer pgAdmin avec Chocolatey

<img width="1022" height="434" alt="image" src="https://github.com/user-attachments/assets/c2f781a1-977a-42dd-a444-13f6f9eec256" />

4️⃣ Connexion à PostgreSQL avec pgAdmin 4
✅ Étape 1 : Ajouter un serveur

Paramètres :

Name : Postgres Docker

Host : localhost

Port : 5432

Username : postgres

Password : postgres

<img width="1818" height="733" alt="image" src="https://github.com/user-attachments/assets/589e7a7b-2ed6-4f46-8003-92eac9da73ea" />

✅ Étape 2 : Explorer la base Sakila
<img width="329" height="849" alt="image" src="https://github.com/user-attachments/assets/c103cdd0-abff-47af-a685-f89614d69cde" />

5️⃣ Exercices SQL
✅ Requête 1 : Films contenant “Star”

<img width="730" height="624" alt="image" src="https://github.com/user-attachments/assets/669907cc-0ebf-408d-838c-602fa966baa8" />

✅ Requête 2 : Nombre total d’acteurs

<img width="650" height="593" alt="image" src="https://github.com/user-attachments/assets/d26c8911-aa9d-48d0-ab52-d406342dec51" />

✅ Conclusion 

Ce TP m’a permis d’installer PostgreSQL avec Docker, d’importer la base Sakila et d’utiliser pgAdmin 4 pour explorer et interroger les données. J’ai appris à utiliser les commandes psql ainsi que l’interface graphique pour gérer une base PostgreSQL.



