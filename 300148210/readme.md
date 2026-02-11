podman version
<img width="552" height="76" alt="Screenshot 2026-02-04 141753" src="https://github.com/user-attachments/assets/ae7e738e-7422-4e97-9387-89b382ebc4b0" />
2️⃣Créer le dossier de travail (Downloads)

On crée un dossier propre pour le TP.

$projectDir = "$env:USERPROFILE\Downloads\INF1099"
New-Item -ItemType Directory -Path $projectDir -Force

<img width="949" height="326" alt="Screenshot 2026-02-04 141043" src="https://github.com/user-attachments/assets/55e9cc23-d7a8-48e3-a1c3-f6fcf69e2696" />

3️⃣ Télécharger et décompresser Sakila
📥 Télécharger Sakila
Downloads\sakila-db.zip
📦 Décompresser
Expand-Archive -Path "$env:USERPROFILE\Downloads\sakila-db.zip" -DestinationPath $projectDir

<img width="1062" height="430" alt="Screenshot 2026-02-04 141221" src="https://github.com/user-attachments/assets/4d707327-6f81-4e58-a7f8-090574d77e7f" />
4️⃣ Configurer Podman comme Docker 

<img width="1107" height="318" alt="image" src="https://github.com/user-attachments/assets/3c67400c-1ef7-484c-b963-6c9635a35dcc" />

5️⃣ Initialiser la machine Podman
<img width="944" height="393" alt="image" src="https://github.com/user-attachments/assets/12e765ec-7505-4148-a6a4-6d147623f5db" />

<img width="1311" height="339" alt="image" src="https://github.com/user-attachments/assets/436d5920-dcf5-49e3-bb82-b1b89b30b304" />

6️⃣ Lancer MySQL dans un conteneur
<img width="1168" height="85" alt="image" src="https://github.com/user-attachments/assets/ded53cc3-937c-4d84-9360-935f91f5563e" />

7️⃣ Création de la base de données Sakila

<img width="890" height="720" alt="Screenshot 2026-01-30 164317" src="https://github.com/user-attachments/assets/fdfbc019-e84a-414c-9aac-f56e1b49a016" />
8️⃣ Création de l’utilisateur etudiants

<img width="1230" height="318" alt="image" src="https://github.com/user-attachments/assets/e852bcb6-f5ce-4397-9d5b-19fbadb5c4b5" />

9️⃣ Importation de la base Sakila

<img width="1193" height="199" alt="image" src="https://github.com/user-attachments/assets/a61b17ba-cfc9-4fd4-aff8-0f263a94d132" />

🔟 Vérification de l’importation

<img width="917" height="686" alt="image" src="https://github.com/user-attachments/assets/a0ec1f6e-949b-47ad-8d97-19e2c4d2ed90" />

1️⃣2️⃣ Automatisation avec script PowerShell

<img width="1035" height="239" alt="image" src="https://github.com/user-attachments/assets/12201ad3-08c6-406e-b013-4572349f73a7" />
