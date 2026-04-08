# Script d'automatisation pour le projet Moodle - INF1099
$ContainerName = "mysql-moodle"

echo "1. Arret et suppression des anciens conteneurs..."
podman stop $ContainerName 2>$null
podman rm $ContainerName 2>$null

echo "2. Lancement du conteneur MySQL..."
podman run --name $ContainerName -e MYSQL_ROOT_PASSWORD=RootPassword123! [cite_start]-d -p 3306:3306 mysql:latest [cite: 9]

echo "3. Attente de l'initialisation du serveur (25 secondes)..."
Start-Sleep -s 25

echo "4. Creation de la base de données et de l'utilisateur 'etudiants'..."
podman exec -i $ContainerName mysql -uroot -pRootPassword123! [cite_start]-e "CREATE DATABASE IF NOT EXISTS moodle_db; CREATE USER IF NOT EXISTS 'etudiants'@'%' IDENTIFIED BY 'EtudiantPass456!'; GRANT ALL PRIVILEGES ON moodle_db.* TO 'etudiants'@'%'; FLUSH PRIVILEGES;" [cite: 10, 11]

echo "5. Importation du schema..."
[cite_start]Get-Content schema.sql | podman exec -i $ContainerName mysql -uroot -pRootPassword123! moodle_db [cite: 13, 18]

echo "6. Importation des donnees..."
[cite_start]Get-Content data.sql | podman exec -i $ContainerName mysql -uroot -pRootPassword123! moodle_db [cite: 14, 18]

echo "7. Verification finale..."
podman exec -it $ContainerName mysql -uetudiants -pEtudiantPass456! [cite_start]-e "USE moodle_db; SHOW TABLES; SELECT * FROM ETUDIANT;" [cite: 15]
