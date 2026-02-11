👨‍🎓 Auteur



Nom : Kahil Amine



Cours : INF1099



Établissement : Collège Boréal







\# INF1099 – MySQL avec Podman



\## Preuves d’exécution



---



\### Podman installé et machine active

Commande :

```powershell

podman --version

podman machine list

<!-- 👉 PLACE TA CAPTURE ICI : Podman version / machine list -->



Alias Docker → Podman

Commande :



Set-Alias docker podman

docker --version

<!-- 👉 PLACE TA CAPTURE ICI : Alias Docker -->



Conteneur MySQL en cours d’exécution

Commande :



docker ps

<!-- 👉 PLACE TA CAPTURE ICI : docker ps -->



Bases de données MySQL

Commande :



docker exec -it INF1099-mysql mysql -u root -prootpass -e "SHOW DATABASES;"

<!-- 👉 PLACE TA CAPTURE ICI : SHOW DATABASES -->



Utilisateurs MySQL

Commande :



docker exec -it INF1099-mysql mysql -u root -prootpass -e "SELECT User, Host FROM mysql.user;"

<!-- 👉 PLACE TA CAPTURE ICI : utilisateurs MySQL -->



Fichiers Sakila présents

Commande :



Get-ChildItem "$env:USERPROFILE\\Downloads\\INF1099\\sakila-db"

<!-- 👉 PLACE TA CAPTURE ICI : fichiers sakila -->



Tables de la base Sakila

Commande :



docker exec -it INF1099-mysql mysql -u etudiants -petudiants\_1 -e "USE sakila; SHOW TABLES;"

<!-- 👉 PLACE TA CAPTURE ICI : SHOW TABLES -->



Données importées (nombre de films)

Commande :



docker exec -it INF1099-mysql mysql -u etudiants -petudiants\_1 -e "USE sakila; SELECT COUNT(\*) AS nb\_films FROM film;"

<!-- 👉 PLACE TA CAPTURE ICI : COUNT film -->



Logs du conteneur MySQL

Commande :



docker logs INF1099-mysql

<!-- 👉 PLACE TA CAPTURE ICI : logs MySQL -->





