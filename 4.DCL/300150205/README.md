# 🔐 TP PostgreSQL — DCL (Data Control Language)

**Nom : Mazigh Bareche**
**Code étudiant : 300150271**
**Cours : INF1099 — Bases de données**
**Session : Hiver 2026**

---

## 🚀 Étapes du laboratoire

## Étape 0 : Connexion au container Docker

```bash
docker container exec --interactive --tty postgres bash
```

Puis se connecter à PostgreSQL en tant que superutilisateur :

```bash
psql -U postgres
```

<details>
<summary>🖼️ Capture d'écran</summary>

![Étape 0 Screenshot](images/Screenshot_2026-04-22_153919.png)

</details>

---

## Étape 1 : Créer la base de données et le schéma

```sql
CREATE DATABASE cours;
\c cours
CREATE SCHEMA tp_dcl;
```

<details>
<summary>📋 Output attendu</summary>
