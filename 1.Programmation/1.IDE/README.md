# IDE (Integrated Development Environment)

| SSH | USR/Passwd |
|-|-|
| [:1st_place_medal: Participation](.scripts/Participation.md) | [:2nd_place_medal: Participation Intermediaire](.scripts/Intermediaire.md) |

### :o: Installation

:point_right: Suivre l'[Installation](https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT/Installation) 

### :one: Les premiers pas avec git

* Ouvrir une fenêtre de ligne de commande
* Creer un repertoire pour faire du développement (en anglais et avec `D` en majuscule)
```sh
mkdir Developer
```
* changer de repertoire pour faire du développement
```sh
cd Developer
```

* Cloner votre premier repertoire git

   - aller sur la page github du cours
   
   - cliquer sur le bouton `clone or download`
   
   - cliquer sur le `presse papier` pour mettre en mémoire l'URL du répertoire

   <img src="images/NomDeURL.png" width=482 heigth=212></image>

   - coller l'URL du répertoire en mémoire dans le presse papier avec RIGHT-CLICK/PASTE

   :warning: remplacer le `0X` avec le numéro de section

   ```sh
   git clone https://github.com/CollegeBoreal/INF1099-201-26H-04.git
   ```
   
* allez dans le répertoire du cours

```sh
cd INF1099-201-26H-04/1.Programmation/1.IDE
```

### :two: Créer son premier fichier sous git (utiliser vi)
* Creer un fichier et l'éditer, par example un fichier ayant votre :id: Boréal avec l'extension `MarkDown` $\textbf{.md}$
```sh
nano 300098957.md
```
* mettre le fichier en scene (add to stage)
```sh
git add 300098957.md
```
> Vérifier son status avec (doit etre :green_circle: vert)  
```sh
git status
```

* donner un commentaire aux fichiers à valider (commit)
```sh
git commit --message ":star: Mon premier commentaire"
```
:warning: Se referer à la [:point_right: section](#three-configurer-git-gitconfig---configuration-dinformations-personnelles) `Configuration d'informations personnelles` pour le premier `commit` 

* envoyer les modifications locales au serveur github
  
```sh
git push
```

:secret: Remonter les informations vers le serveur requiert votre `utilisateur` et `mot de passe`

> Username for 'https://github.com': b300098957
> 
> Password for 'https://b300098957@github.com':

### :three: Configurer GIT `~/.gitconfig` - `Configuration d'informations personnelles`

:bulb: pour soumettre son travail vers `github.com`

* Changer l'éditeur par défaut de `vi` à `nano`

```sh
git config --global core.editor "nano"
```

* Editer son nom utilisateur `github` et son courriel

```sh
git config --global --edit
```

* Rajouter la section `[user]` et remplacer `MonNom` et `MonCourriel@me_remplacer.com` par le votre

```ini
[core]
        editor = nano

[user]
# Please adapt and uncomment the following lines:
        name = MonNom
        email = MonCourriel@me_remplacer.com
```

### :u6307: Mettre à jour mon répertoire local (pull)
```sh
git pull --no-edit
```

## :b: SSH

### :four: Gestion de votre clé SSH

- [ ] [Générer votre clé SSH][SSH_KEY]
   ```sh
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
   - Éviter le 'pass phrase' en appuyant sur la touche `Enter`
   - renommer les fichiers par défaut qui se trouvent dans le répertoire `~/.ssh`

        - aller vers le répertoire `~/.ssh`
      ```sh
      cd ~/.ssh
      ```
        - renommer les fichiers
      ```sh
      mv id_ed25519 ma_cle.pk
      mv id_ed25519.pub ma_cle.pub
      ```
     


- [ ] [:secret: Configurer git avec votre clé personnelle][SSH_PRIVATE_KEY] [Documentation][SSH_GITHUB_ACCOUNT]

* le Fichier de configuration `SSH` ***~/.ssh/config***

:pushpin: Utilisation du port ssh par défaut :two::two:

- Éditer le fichier de configuration de `SSH`

   ```sh
   nano ~/.ssh/config
   ```

- Ajouter le contenu ci-dessous et ajuster le nom de fichier de votre clé publique.

   ```powershell
   Host github.com
       HostName github.com
       User git
       IdentityFile ~/.ssh/ma_cle.pk
   ```

- [ ] [Ajouter votre clé publique à votre compte github][SSH_KEY_ACCOUNT]


### :five: Changer l'URL du cours

1. **revenir au répertoire du cours**

   :warning: remplacer le numéro de section `0X`

   ```sh
   cd ~/Developer/INF1099-201-26H-04/1.Programmation/1.IDE
   ```

2. **Changer l’URL du dépôt distant**

   :warning: remplacer le numéro de section `0X`

   ```sh
   git remote set-url origin git@github.com:CollegeBoreal/INF1099-201-26H-04.git
   ```

3. **Vérifier la nouvelle configuration du dépôt distant**

   ```sh
   git remote --verbose
   ```

   Ce qui affiche actuellement :

   ```lua
   origin  git@github.com:CollegeBoreal/INF1099-201-26H-04.git (fetch)
   origin  git@github.com:CollegeBoreal/INF1099-201-26H-04.git (push)
   ```

### :six: Créer un fichier dans ce répertoire `(1.IDE)`:

:checkered_flag: Finalement,

- [ ] avec le nom de répertoire :id: (votre identifiant boreal)
- [ ] dans votre répertoire ajouter le fichier `README.md`
  - [ ] `nano `README.md
- [ ] envoyer vers le serveur `git`
  - [ ] `git add `:id:/README.md
  - [ ] `git commit -m "mon fichier ..."` :id:/README.md
  - [ ] `git push`



## :toolbox: IDE

- [ ] [:beer: HomeBrew Visual Studio Code](https://formulae.brew.sh/cask/visual-studio-code) sur :apple: Apple

```sh
brew install --cask visual-studio-code
```

- [ ] [:chocolate_bar: Chocolatey Visual Studio Code](https://community.chocolatey.org/packages/vscode) sur :window: Windows

```sh
choco install vscode
```

# :books: References

## :bulb: [Tutoriel sur GIT](https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT)


[SSH_KEY]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
[SSH_KEY_ACCOUNT]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account
[SSH_PRIVATE_KEY]: https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT#secret-configurer-git-clé-personnelle-documentation
[SSH_GITHUB_ACCOUNT]: https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

