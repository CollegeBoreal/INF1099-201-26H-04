Parfait ! On va ajouter la **version “alias Docker”**, comme ça tes étudiants peuvent utiliser les mêmes commandes Docker mais avec Podman. Cela rend la transition facile.

---

# Leçon : Podman avec alias Docker + MySQL

## 1️⃣ Installer Podman (Windows + Chocolatey)

Dans **PowerShell Administrateur** :

```powershell
choco install podman-desktop -y
```

Redémarre PowerShell et vérifie :

```powershell
podman --version
podman info
```

---

## 2️⃣ Créer un alias Docker pour Podman

Dans **PowerShell** (non admin suffisant maintenant) :

```powershell
# Alias temporaire pour cette session
Set-Alias docker podman
```

✅ Maintenant tu peux taper par exemple :

```powershell
docker ps
docker run hello-world
```

Au lieu de `podman ps` et `podman run`.

---

### 🔹 Pour rendre l’alias permanent

Ajoute dans ton **profile PowerShell** :

```powershell
notepad $PROFILE
```

Puis ajoute la ligne :

```powershell
Set-Alias docker podman
```

Sauvegarde et relance PowerShell.
💡 Test :

```powershell
docker --version
docker ps
```

---

## 3️⃣ Lancer MySQL avec alias Docker

Avec l’alias en place, tu peux utiliser **la syntaxe Docker habituelle** :

```powershell
docker network create mynetwork

docker run -d `
  --name mysql-server `
  --network mynetwork `
  -e MYSQL_ROOT_PASSWORD=monmotdepasse `
  -p 3306:3306 `
  mysql:8.0
```

⚡ Explications :

* Tout est identique à Docker, mais **c’est Podman qui tourne en arrière-plan**
* Tu peux utiliser tous les tutoriels Docker pour MySQL, compose, etc.

---

## 4️⃣ Se connecter à MySQL

```powershell
docker exec -it mysql-server mysql -uroot -p
```

💡 Tu es maintenant **dans MySQL**, mot de passe root = `monmotdepasse`.

---

## 5️⃣ Commandes utiles (alias Docker)

| Commande                    | Podman équivalent           | Description                |
| --------------------------- | --------------------------- | -------------------------- |
| `docker ps -a`              | `podman ps -a`              | Lister tous les conteneurs |
| `docker stop mysql-server`  | `podman stop mysql-server`  | Arrêter                    |
| `docker start mysql-server` | `podman start mysql-server` | Démarrer                   |
| `docker logs mysql-server`  | `podman logs mysql-server`  | Voir logs                  |
| `docker rm mysql-server`    | `podman rm mysql-server`    | Supprimer conteneur        |

---

## 6️⃣ Avantages pédagogiques

* Étudiants **ne changent pas leurs habitudes Docker**
* Découvrent la **sécurité rootless de Podman**
* Compatible **Docker Compose** via `podman-compose`
* Facile à migrer en prod Linux sans Docker Desktop

---

💡 Astuce TP INF1099 :
Tu peux créer un script `start-mysql-docker.ps1` :

```powershell
docker network create mynetwork -f
docker run -d --name mysql-server --network mynetwork -e MYSQL_ROOT_PASSWORD=motdepasse -p 3306:3306 mysql:8.0
```

Ainsi **tout le labo devient identique à Docker**, mais sécurisé par Podman.

