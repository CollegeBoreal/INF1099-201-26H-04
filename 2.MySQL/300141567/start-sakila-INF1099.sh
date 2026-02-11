#!/bin/bash

PROJECT_DIR="$HOME/Downloads/INF1099"

# Démarrage du conteneur MySQL
docker run -d \
  --name INF1099-mysql \
  -e MYSQL_ROOT_PASSWORD=rootpass \
  -p 3306:3306 \
  mysql:8.0

# Attendre que MySQL soit prêt
sleep 20

# Création de la base de données
docker exec INF1099-mysql \
mysql -u root -prootpass \
-e "CREATE DATABASE sakila;"

# Création de l'utilisateur
docker exec INF1099-mysql \
mysql -u root -prootpass \
-e "CREATE USER 'etudiants'@'%' IDENTIFIED BY 'etudiants_1';"

# Attribution des privilèges
docker exec INF1099-mysql \
mysql -u root -prootpass \
-e "GRANT ALL PRIVILEGES ON *.* TO 'etudiants'@'%' WITH GRANT OPTION;"

# Importation du schéma
cat $PROJECT_DIR/sakila-db/sakila-schema.sql | \
docker exec -i INF1099-mysql \
mysql -u etudiants -petudiants_1 sakila

# Importation des données
cat $PROJECT_DIR/sakila-db/sakila-data.sql | \
docker exec -i INF1099-mysql \
mysql -u etudiants -petudiants_1 sakila

echo "✅ Importation terminée avec succès!"