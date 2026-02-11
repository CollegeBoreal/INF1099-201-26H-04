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

<img width="467" height="100" alt="1" src="https://github.com/user-attachments/assets/2b80e77b-d737-4ccf-ad05-94a008e58c93" />





Alias Docker → Podman

Commande :



Set-Alias docker podman

docker --version

<img width="466" height="56" alt="2" src="https://github.com/user-attachments/assets/5daa8929-3169-49df-9442-d56c45cf5e46" />




Conteneur MySQL en cours d’exécution

Commande :



docker ps

<img width="464" height="79" alt="3" src="https://github.com/user-attachments/assets/cc2bcd50-138c-4bb9-b555-e85219673c61" />




Bases de données MySQL

Commande :



docker exec -it INF1099-mysql mysql -u root -prootpass -e "SHOW DATABASES;"

<img width="464" height="158" alt="4" src="https://github.com/user-attachments/assets/5d4e5a48-a460-4a4b-924b-46b1640f76d3" />




Utilisateurs MySQL

Commande :



docker exec -it INF1099-mysql mysql -u root -prootpass -e "SELECT User, Host FROM mysql.user;"

<img width="466" height="170" alt="5" src="https://github.com/user-attachments/assets/3406dee4-dfa7-41eb-8dc4-1409237d1cb5" />




Fichiers Sakila présents

Commande :



Get-ChildItem "$env:USERPROFILE\\Downloads\\INF1099\\sakila-db"

<img width="461" height="182" alt="6" src="https://github.com/user-attachments/assets/9c656494-49e8-4e0b-b91e-cdd82060c5d4" />




Tables de la base Sakila

Commande :



docker exec -it INF1099-mysql mysql -u etudiants -petudiants\_1 -e "USE sakila; SHOW TABLES;"

<img width="466" height="377" alt="7" src="https://github.com/user-attachments/assets/f98c4fe6-45ae-4a55-8846-0caa3254bf95" />




Données importées (nombre de films)

Commande :



docker exec -it INF1099-mysql mysql -u etudiants -petudiants\_1 -e "USE sakila; SELECT COUNT(\*) AS nb\_films FROM film;"

<img width="464" height="99" alt="8" src="https://github.com/user-attachments/assets/8065cdda-8063-4294-bfa8-97e1c2745e9e" />




Logs du conteneur MySQL

Commande :



docker logs INF1099-mysql

<img width="464" height="194" alt="9" src="https://github.com/user-attachments/assets/01e109c0-2069-4654-89f3-f6fec30f3c65" />






