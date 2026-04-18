\# TP PostgreSQL avec Docker — Base Sakila

\*\*Salim Amir\*\* | \*\*#300150293\*\* | INF1099 · Collège Boréal · 2026



\---



\## 🎯 Objectifs

1\. Installer PostgreSQL dans Docker

2\. Charger la base de données Sakila

3\. Installer pgAdmin 4 avec Chocolatey

4\. Utiliser pgAdmin 4 pour explorer la base



\---



\## 🚀 Étapes du laboratoire



\### Étape 1 — Lancer le conteneur PostgreSQL

```powershell

docker container run -d `

&#x20; --name postgres `

&#x20; -e POSTGRES\_USER=postgres `

&#x20; -e POSTGRES\_PASSWORD=postgres `

&#x20; -e POSTGRES\_DB=appdb `

&#x20; -p 5432:5432 `

&#x20; -v postgres\_data:/var/lib/postgresql/data `

&#x20; postgres:16

```



\### Étape 2 — Vérifier que PostgreSQL fonctionne

```cmd

docker container ls

```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape2.png)



\---



\### Étape 3 — Télécharger Sakila

```powershell

Invoke-WebRequest `

&#x20; https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-schema.sql `

&#x20; -OutFile postgres-sakila-schema.sql



Invoke-WebRequest `

&#x20; https://raw.githubusercontent.com/jOOQ/sakila/master/postgres-sakila-db/postgres-sakila-insert-data.sql `

&#x20; -OutFile postgres-sakila-insert-data.sql

```



\### Étape 4 — Copier dans le conteneur

```cmd

docker container cp postgres-sakila-schema.sql postgres:/schema.sql

docker container cp postgres-sakila-insert-data.sql postgres:/data.sql

```



\### Étape 5 — Importer Sakila

```cmd

podman container exec postgres psql -U postgres -d appdb -f /schema.sql

podman container exec postgres psql -U postgres -d appdb -f /data.sql

```



\### Étape 6 — Vérifier les tables

```cmd

podman container exec postgres psql -U postgres -d appdb -c "\\dt"

podman container exec postgres psql -U postgres -d appdb -c "SELECT COUNT(\*) FROM film;"

podman container exec postgres psql -U postgres -d appdb -c "SELECT COUNT(\*) FROM actor;"

```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape3.png)

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape4.png)



\---



\### Étape 7 — Installer pgAdmin 4

```cmd

choco install pgadmin4 -y

```



\### Étape 8 — Configurer la connexion pgAdmin

| Paramètre | Valeur |

|---|---|

| Host | localhost |

| Port | 5432 |

| Maintenance database | appdb |

| Username | postgres |

| Password | postgres |



![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape%205.png)



\### Étape 9 — Explorer la base Sakila

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape6.png)

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape7.png)



\---



\## 📝 Exercices pratiques



\### Exercice 1 — Films contenant "Star"

```sql

SELECT title FROM film WHERE title ILIKE '%Star%';

```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape8.1.png)



\### Exercice 2 — Nombre d'acteurs

```sql

SELECT COUNT(\*) FROM actor;

```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape8.2.png)



\### Exercice 3 — 5 premiers clients

```sql

SELECT customer\_id, first\_name, last\_name, email

FROM customer

LIMIT 5;

```

![wait](https://github.com/CollegeBoreal/INF1099-201-26H-04/blob/main/3.Postgres/300150293/images/etape8.3.png)

