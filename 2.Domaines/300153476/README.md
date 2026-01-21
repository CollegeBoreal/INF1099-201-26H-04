# 📘 Projet de Modélisation de Base de Données  
**Nom :** Ramatoulaye Diallo  
**Matricule :** 300153476  

---

## 🌍 Présentation

Bonjour,  
Je m’appelle **Ramatoulaye Diallo**, originaire de la **Guinée Conakry 🍀**.  
Ce projet a pour objectif de démontrer ma compréhension des **formes normales (1FN, 2FN, 3FN)** ainsi que de la **modélisation Entité/Relation (E/R)** dans le cadre d’un système informatique structuré.

---

## 🎯 Objectifs du projet

- Appliquer les **principes de normalisation**
- Concevoir un **diagramme Entité/Relation**
- Structurer correctement les données
- Préparer une base solide pour un **projet réel évolutif**

---

## 🧱 Formes normales

### ✅ Première Forme Normale (1FN)
- Chaque champ contient **une valeur atomique**
- Aucune liste ou valeur multiple dans une cellule
- Chaque ligne est identifiable par une clé primaire

📄 Fichier : `1FN.txt`

---

### ✅ Deuxième Forme Normale (2FN)
- La table est déjà en **1FN**
- Tous les attributs non-clés dépendent **entièrement** de la clé primaire
- Suppression des **dépendances partielles**

📄 Fichier : `2FN.txt`

---

### ✅ Troisième Forme Normale (3FN)
- La table est déjà en **2FN**
- Aucun attribut non-clé ne dépend d’un autre attribut non-clé
- Suppression des **dépendances transitives**

📄 Fichier : `3FN.txt`

---

## 🧩 Diagramme Entité / Relation (E/R)

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : includes

    CUSTOMER {
        string id
        string name
        string email
    }
    ORDER {
        string id
        date orderDate
        string status
    }
    PRODUCT {
        string id
        string name
        float price
    }
    ORDER_ITEM {
        int quantity
        float price
    }

