# 🫛 Podman avec alias Docker + MySQL

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

💡 Astuce TP :
Tu peux créer un script `start-mysql-docker.ps1` :

```powershell
docker network create mynetwork -f
docker run -d --name mysql-server --network mynetwork -e MYSQL_ROOT_PASSWORD=motdepasse -p 3306:3306 mysql:8.0
```

Ainsi **tout le labo devient identique à Docker**, mais sécurisé par Podman.

---

**Principales commandes extraites et regroupées** du blog (Podman server homelab).

---

## 🧱 1. Installation de Podman (serveur)

```bash
# Supprimer Docker (si présent)
yum remove $(rpm -qa | grep docker)

# Installer Podman + compat Docker CLI
dnf install podman podman-docker

# Activer le socket (mode client/serveur)
systemctl enable --now podman.socket
```

👉 Le socket permet d’utiliser Podman comme un service distant (API / client). ([NVIDIA Docs][1])

---

## 📦 2. Commandes de base Podman

```bash
# Vérifier
podman --help
podman info

# Images
podman pull nginx
podman images
podman rmi nginx

# Containers
podman run -d nginx
podman ps
podman ps -a
podman stop <id>
podman start <id>
podman rm <id>

# Debug
podman logs <id>
podman exec -it <id> bash
```

👉 Ce sont les équivalents directs de Docker (quasi 1:1). ([FOSS Linux][2])

---

## 🧩 3. Gestion des Pods (spécifique Podman)

```bash
# Créer un pod
podman pod create --name my-pod

# Lancer des containers dans le pod
podman run --pod my-pod --name web nginx
podman run --pod my-pod --name db postgres

# Gérer le pod
podman pod stop my-pod
podman pod start my-pod
podman pod restart my-pod
podman pod rm my-pod
```

👉 Concept clé : plusieurs containers = 1 unité logique (comme Kubernetes). ([How-To Geek][3])

---

## 🌐 4. Réseau & ports

```bash
# Exposer un port
podman run -d -p 8080:80 nginx

# Lister les ports
podman port <container>

# Réseaux
podman network create mynet
podman run --network=mynet nginx
```

---

## 💾 5. Volumes & stockage

```bash
# Volume
podman volume create myvol

# Utilisation
podman run -v myvol:/data nginx
```

👉 Vérifier les chemins utilisés :

```bash
podman info -f json | jq -r '.store.graphRoot'
podman info -f json | jq -r '.store.volumePath'
```

([NethServer Documentation][4])

---

## 🔐 6. Mode rootless (important en homelab)

```bash
# Ajouter subuid / subgid
sudo usermod --add-subuids 10000-75535 $USER
sudo usermod --add-subgids 10000-75535 $USER
```

👉 Permet d’exécuter des containers **sans root (sécurité ++)**. ([Arch Linux Man Pages][5])

---

## ⚙️ 7. Auto-start avec systemd (très utilisé en homelab)

Exemple type (quadlet / systemd) :

```ini
[Container]
Image=nginx:latest

[Service]
Restart=always

[Install]
WantedBy=multi-user.target
```

👉 Permet de lancer les containers automatiquement au boot.

---

## 🔄 8. Commandes utiles avancées

```bash
# Inspecter
podman inspect <container>

# Stats
podman stats

# Copier fichiers
podman cp file.txt <container>:/tmp

# Commit (snapshot container -> image)
podman commit <container> myimage

# Générer YAML Kubernetes
podman generate kube my-pod
```

👉 Très intéressant pour transition vers Kubernetes. ([How-To Geek][3])

---

## 🧠 9. Commandes "workflow homelab"

Très typiques du blog :

```bash
# Lancer un service
podman run -d --name app -p 3000:3000 myapp

# Mettre à jour
podman pull myapp
podman stop app
podman rm app
podman run -d ...

# Debug
podman logs -f app
```

---

## ⚡ TL;DR (à donner aux étudiants)

👉 Les 5 commandes essentielles :

```bash
podman pull nginx
podman run -d -p 8080:80 nginx
podman ps
podman logs <id>
podman exec -it <id> bash
```

[1]: https://docs.nvidia.com/networking/display/ufmenterpriseumv61914/installation-notes?utm_source=chatgpt.com "Installation Notes - NVIDIA Docs"
[2]: https://www.fosslinux.com/49839/how-to-build-run-and-manage-container-images-with-podman.htm?utm_source=chatgpt.com "How to Build, Run, and Manage Container Images with Podman"
[3]: https://www.howtogeek.com/devops/what-is-podman-and-how-does-it-differ-from-docker/?utm_source=chatgpt.com "What Is Podman and How Does It Differ from Docker?"
[4]: https://docs.nethserver.org/projects/ns8/it/latest/disk_usage.html?utm_source=chatgpt.com "Utilizzo del disco — Documentazione NS8"
[5]: https://man.archlinux.org/man/podman.1.en?utm_source=chatgpt.com "podman(1) — Arch manual pages"

# 📖 **playbook Ansible simple et propre** pour :

1. Installer Podman sur Ubuntu
2. Démarrer un container Nginx

---

## 📘 Playbook : `install_podman_nginx.yml`

```yaml
---
- name: Installer Podman et démarrer Nginx
  hosts: all
  become: true

  vars:
    nginx_container_name: nginx_podman
    nginx_image: docker.io/library/nginx:latest
    nginx_port: 8080

  tasks:

    - name: Mettre à jour le cache APT
      apt:
        update_cache: yes

    - name: Installer Podman
      apt:
        name: podman
        state: present

    - name: Vérifier installation Podman
      command: podman --version
      register: podman_version

    - name: Afficher version Podman
      debug:
        var: podman_version.stdout

    - name: Télécharger image Nginx
      containers.podman.podman_image:
        name: "{{ nginx_image }}"

    - name: Démarrer container Nginx
      containers.podman.podman_container:
        name: "{{ nginx_container_name }}"
        image: "{{ nginx_image }}"
        state: started
        ports:
          - "{{ nginx_port }}:80"
        recreate: true

    - name: Vérifier container actif
      command: podman ps
      register: podman_ps

    - name: Afficher containers actifs
      debug:
        var: podman_ps.stdout
```

---

## 📦 Requirements

Créer un fichier `requirements.yml` :

```yaml
collections:
  - name: containers.podman
```

Puis installer :

```bash
ansible-galaxy collection install -r requirements.yml
```

---

## ▶️ Exécution

```bash
ansible-playbook -i inventory.ini install_podman_nginx.yml
```

---

## 🌐 Résultat

👉 Nginx sera accessible sur :

```
http://<IP_SERVEUR>:8080
```

---

## ⚡ Variante (sans collection Podman)

Si tu veux éviter la collection :

```yaml
- name: Lancer Nginx avec Podman (fallback)
  command: >
    podman run -d --name nginx_podman -p 8080:80 nginx
  args:
    creates: /var/lib/containers/storage
```

