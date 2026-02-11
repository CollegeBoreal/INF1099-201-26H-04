# :ringed_planet: Jupyter

[:tada: Participation](.scripts/Participation.md)

---

Installer **Jupyter** (Notebook ou Lab) sous **Windows PowerShell**, en utilisant **Chocolatey**.

Installer **Miniforge** via **Chocolatey** sur Windows, voici la procédure complète :

---

### 1️⃣ Commande de base

Pour installer Miniforge pour **tous les utilisateurs** (AllUsers) et utiliser les valeurs par défaut :

```powershell
choco install miniforge3 -y
```

* `/AddToPath` par défaut est `0` pour AllUsers (il ne mettra pas Miniforge dans le PATH pour des raisons de sécurité).
* Le chemin par défaut sera : `C:\tools\miniforge3`

* L’installation se fera dans :
  `C:\Users\<TonNom>\AppData\Local\miniforge3`
* Python de Miniforge sera accessible directement depuis PowerShell.

---

### 3️⃣ Vérifier l’installation

Après installation, ferme et rouvre PowerShell puis tape :

```powershell
conda --version
```

si ça ne marche pas ajoute la variable d'environnement:

```powershell
$env:Path += ";C:\tools\miniforge3;C:\tools\miniforge3\Scripts"
```

Tu devrais voir la version de Conda.

---

Si tu veux donc **ajouter manuellement Miniforge au PATH de ton profil PowerShell**, puisque `/AddToPath` n’a pas été activé (ce qui est normal en mode `AllUsers` pour des raisons de sécurité).

Voici les **étapes propres et sûres** pour le faire.

### 🧭 1️⃣ Localiser l’installation de Miniforge

```powershell
 choco info miniforge3
```
<details>

```powershell
Chocolatey v2.5.1
miniforge3 24.11.3.200 [Approved]
 Title: Miniforge3 | Published: 2025-03-13
 Package approved as a trusted package on Mar 13 2025 22:38:45.
 Package testing status: Passing on Mar 13 2025 08:59:54.
 Number of Downloads: 63040 | Downloads for this version: 24704
 Package url https://community.chocolatey.org/packages/miniforge3/24.11.3.200
 Chocolatey Package Source: https://github.com/geicht/chocolatey-packages/tree/master/miniforge3
 Package Checksum: 'eigGBK1iugVqZZcC/TKDMXi3fvqJr2bMA4ymhyV1AiZVrLzRXg+rK6wgRSW0c22c9vsYfLSI8mcrT71SbbOV0g==' (SHA512)
 Tags: conda-forge anaconda3 miniconda3 miniforge3 python3
 Software Site: https://conda-forge.org/
 Software License: https://github.com/conda-forge/miniforge/blob/main/LICENSE
 Software Source: https://github.com/conda-forge/miniforge
 Documentation: https://github.com/conda-forge/miniforge
 Issues: https://github.com/conda-forge/miniforge/issues
 Summary: Miniforge3 installs the conda package manager with conda-forge specific pre-configurations.
 Description: Miniforge3 installs the conda package manager with the following features pre-configured:

    * [conda-forge](https://conda-forge.org/) set as the default (and only) channel.
    * Packages in the base environment are obtained from the [conda-forge channel](https://anaconda.org/conda-forge).

  You can provide parameters for the installation ([conda docs](https://conda.io/projects/conda/en/latest/user-guide/install/windows.html#installing-in-silent-mode)).
  To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.

    * `/InstallationType:`[`AllUsers`|`JustMe`]
  * Default: `AllUsers` (install for all users)
    * `/RegisterPython:`[`0`|`1`]
  * Default: `1` (register miniforge3 python as the system's default)
    * `/AddToPath:`[`0`|`1`]
  * Default: `0` (do not add miniforge3 directories to path)
  * _Note: As of Miniforge3 4.12.0-0, you cannot add miniforge3 to the PATH environment during an `AllUsers` installation.
    This was done to address [a security exploit](https://nvd.nist.gov/vuln/detail/CVE-2022-26526)
    ([additional information](https://github.com/ContinuumIO/anaconda-issues/issues/12995#issuecomment-1188441961))._
    * `/D:`(installation path)
  * Default for `AllUsers`: `$toolsDir\miniforge3`
    (`$toolsDir` is the path returned by chocolatey's `Get-ToolsLocation` function and defaults to `C:\tools`)
  * Default for `JustMe`: `$Env:LOCALAPPDATA\miniforge3`
    (`$Env:LOCALAPPDATA` is set by Windows and defaults to `C:\Users\{USERNAME}\AppData\Local`)

  Example: `choco install miniforge3 --params="'/InstallationType:JustMe /AddToPath:1'"`.
 Release Notes: https://github.com/conda-forge/miniforge/releases/tag/24.11.3-2

1 packages found.
```

</details>


Par défaut, si tu as utilisé :

```powershell
choco install miniforge3 -y
```

et donc `/InstallationType:AllUsers`, ton Miniforge est ici :

```
C:\tools\miniforge3
```

Les dossiers importants à ajouter au PATH sont :

```
C:\tools\miniforge3
C:\tools\miniforge3\Scripts
C:\tools\miniforge3\Library\bin
```

---

### ⚙️ 2️⃣ Vérifier le fichier `$PROFILE`

Ouvre PowerShell et tape :

```powershell
echo $PROFILE
```

Tu verras un chemin du type :

```
C:\Users\<TonNom>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
```

S’il n’existe pas, crée-le :

```powershell
New-Item -ItemType File -Path $PROFILE -Force
```

---

### 🪄 3️⃣ Ajouter Miniforge au PATH dans le profil

Édite le fichier :

```powershell
nano $PROFILE
```

Et ajoute à la fin :

```powershell
# >>> Miniforge3 initialization >>>
$env:Path += ";C:\tools\miniforge3;C:\tools\miniforge3\Scripts;C:\tools\miniforge3\Library\bin"
# <<< Miniforge3 initialization <<<
```

Sauvegarde et ferme.

---

### 🔁 4️⃣ Recharger le profil

Recharge ton profil sans redémarrer PowerShell : (en utilisant dot-sourcing)

```powershell
. $PROFILE
```

Puis vérifie :

```powershell
conda --version
```

➡️ Tu devrais maintenant voir la version Conda s’afficher.

## 🧩 2. (Optionnel) Mets à jour Conda

Toujours dans PowerShell :

```powershell
conda update -n base -c defaults conda -y
```

---

## 📦 3. Crée un environnement Python pour Jupyter

C’est préférable pour éviter les conflits de versions.

```powershell
conda create -n INF1102 python=3.12 -y
conda activate INF1102
```

- [ ] Si tu rencontres cette erreur:

> CondaError: Run 'conda init' before 'conda activate'

- [ ] Rajoute `init` a ton `$PROFILE`

```powershell
nano $PROFILE
```

```powershell
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
(& "C:\tools\miniforge3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
# <<< conda initialize <<<
```

 - [ ] Recharge ton profil sans redémarrer PowerShell : (en utilisant dot-sourcing)

```powershell
. $PROFILE
```

---

## 🧠 4. Installe **JupyterLab (plus moderne)**

```powershell
conda install -c conda-forge jupyterlab -y
```

Puis lance-le avec :

```powershell
jupyter lab
```

---

## 🧭 5. (Optionnel) Ajoute un raccourci PowerShell pour l’ouvrir rapidement

Tu peux ajouter ceci à ton profil PowerShell :

```powershell
nano $PROFILE
```

Puis ajoute à la fin du fichier :

```powershell
function start-jupyter {
    conda activate INF1102
    jupyter lab
}
```

Ainsi tu pourras simplement taper :

```powershell
start-jupyter
```

à n’importe quel moment.

---

## 🧹 6. Vérifie ton installation

```powershell
jupyter --version
python3 --version
```

Tu devrais voir des versions cohérentes (par ex. Python 3.12.x et Jupyter 7.x ou 8.x).

# :books: References

### 🧩 Ce que ta ligne fait

```powershell
$env:Path += ";C:\tools\miniforge3;C:\tools\miniforge3\Scripts;C:\tools\miniforge3\Library\bin"
```

➡️ Cela ajoute simplement les dossiers de Miniforge à la variable d’environnement **PATH**, donc Windows peut trouver `conda.exe`.
Autrement dit, après ça tu peux taper :

```powershell
conda --version
```

et ça marchera ✅
Mais...

---

### ⚠️ Pourquoi ce n’est **pas suffisant** pour `conda activate`

La commande `conda activate` **n’est pas une simple exécutable** (`conda.exe`) :
c’est une **fonction de shell**, qui :

* modifie dynamiquement le `$env:PATH`,
* change d’environnement virtuel,
* ajuste des variables internes (comme `CONDA_DEFAULT_ENV`).

Ces fonctions **ne sont pas chargées** si tu ne fais qu’ajouter le dossier dans ton `PATH`.

---

### ✅ Ce que fait `conda init powershell`

Quand tu fais :

```powershell
conda init powershell
```

Conda ajoute ceci dans ton profil PowerShell (`$PROFILE`, souvent `Documents\PowerShell\Microsoft.PowerShell_profile.ps1`) :

```powershell
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
(& "C:\tools\miniforge3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
# <<< conda initialize <<<
```

👉 Cette ligne exécute un **hook** spécial qui :

* définit la fonction `conda activate`,
* configure le prompt,
* met à jour les variables correctement.

---

### 💡 En résumé

| Action                         | Résultat                                                                |
| ------------------------------ | ----------------------------------------------------------------------- |
| Ajouter le `PATH` manuellement | Permet d’exécuter `conda` mais **pas d’activer** les environnements     |
| Faire `conda init powershell`  | Configure PowerShell pour que `conda activate` fonctionne comme prévu ✅ |

### Environnements

```powershell
conda info --envs
```
>
```powershell
# conda environments:
#
base        C:\tools\miniforge3
INF1102   * C:\tools\miniforge3\envs\INF1102
```

## **supprimer complètement** l’environnement `INF1102`.

Voici comment faire proprement :

---

## 🧹 1. Désactiver l’environnement courant

Si tu es **actuellement dedans**, commence par le quitter :

```bash
conda deactivate
```

---

## 🗑️ 2. Supprimer l’environnement

Ensuite, exécute :

```bash
conda env remove --name INF1102
```

ou version courte :

```bash
conda remove --name INF1102 --all
```

---

## 🔍 3. Vérifier la suppression

Teste :

```bash
conda info --envs
```

Tu devrais voir que `INF1102` n’apparaît plus dans la liste ✅

---

## ⚠️ 4. Cas particuliers

Si l’environnement résiste (par exemple erreur de permission ou conflit de lien symbolique sur Windows), tu peux le supprimer **manuellement** :

```bash
rm -rf C:\tools\miniforge3\envs\INF1102
```

Puis relancer :

```bash
conda clean --all
```

