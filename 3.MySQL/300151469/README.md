
Nom : Rabia Bouhali
ID étudiant : 300151469
Cours : INF1099 – Manipulation de données avec MySQL et Podman
TP : Podman + MySQL – Base Sakila

1️⃣ Lancement du conteneur MySQL

Pour vérifier que le conteneur MySQL fonctionne correctement, j’ai exécuté la commande :

docker ps


2️⃣ Création de la base Sakila

J’ai créé la base de données sakila avec la commande :

docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE DATABASE sakila;"

3️⃣ Création de l’utilisateur etudiants

Pour manipuler la base sans utiliser le compte root, j’ai créé l’utilisateur etudiants :

docker exec -it INF1099-mysql mysql -u root -prootpass -e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"
docker exec -it INF1099-mysql mysql -u root -prootpass -e "GRANT ALL PRIVILEGES ON sakila.* TO 'etudiants'@'%'; FLUSH PRIVILEGES;"

4️⃣ Import du schéma et des données Sakila

Avant l’import, j’ai activé la variable log_bin_trust_function_creators pour éviter l’erreur 1419 :

docker exec -it INF1099-mysql mysql -u root -prootpass -e "SET GLOBAL log_bin_trust_function_creators = 1;"


Ensuite, j’ai importé le schéma et les données :

Get-Content "$env:USERPROFILE\Downloads\INF1099\sakila-db\sakila-schema.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila
Get-Content "$env:USERPROFILE\Downloads\INF1099\sakila-db\sakila-data.sql" | docker exec -i INF1099-mysql mysql -u etudiants -petudiants_1 sakila


5️⃣ Script PowerShell automatisé

Pour automatiser le TP, j’ai créé le script start-sakila-INF1099.ps1, qui :

Lance le conteneur MySQL

Crée la base Sakila et l’utilisateur etudiants

Importe le schéma et les données


✅ Conclusion

Grâce à ce TP, j’ai réussi à :

Installer et configurer Podman sur Windows

Lancer une VM Linux Podman et un conteneur MySQL

Créer la base Sakila et l’utilisateur etudiants

Importer sans erreur le schéma et les données

Vérifier toutes les tables avec succès

Le TP INF1099 est donc complètement fonctionnel et validé.
