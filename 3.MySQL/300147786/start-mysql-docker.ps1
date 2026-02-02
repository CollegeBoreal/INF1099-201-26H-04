#executer mysql
docker network create mynetwork -f
docker run -d --name mysql-server --network mynetwork -e MYSQL_ROOT_PASSWORD=dia620370620 -p 3306:3306 mysql:8.0
