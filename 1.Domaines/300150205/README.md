## 1. Choix du Domaine
Le domaine choisi est la **gestion d'une boutique de réparation de smartphones**. Ce sujet permet de modéliser le cycle complet depuis le dépôt d'un appareil par un client jusqu'au paiement final et à la garantie, en passant par l'affectation d'un technicien.

---

## 2. Normalisation

### Fichier 1 : 1FN (Première Forme Normale)
Dans cette phase, toutes les données sont regroupées dans une structure plate ("Flat Table"). Chaque attribut est atomique. **Il n'y a pas encore d'ID techniques.**

**Attributs :**
> Client_Nom, Client_Prenom, Client_Tel, Client_Email, Num_Rue, Rue, Ville, Code_Postal, Num_IMEI, Couleur_Tel, Etat_Tel, Marque, Modele, Annee_Modele, Panne_Description, Date_Depot, Statut_Reparation, Nom_Technicien, Piece_Nom, Piece_Prix, Montant_Total, Mode_Paiement, Date_Garantie

---

### Fichier 2 : 2FN (Deuxième Forme Normale)
Définition des relations et des cardinalités. On sépare les entités pour éviter les redondances partielles.

* **CLIENT (0,N)** —— POSSÈDE —— **(1,1) APPAREIL**
* **CLIENT (1,N)** —— HABITE —— **(1,1) ADRESSE**
* **APPAREIL (0,N)** —— FAIT_L’OBJET —— **(1,1) REPARATION**
* **MARQUE (1,N)** —— FABRIQUE —— **(1,1) MODELE**
* **MODELE (0,N)** —— DÉFINIT —— **(1,1) APPAREIL**
* **REPARATION (1,N)** —— CONTIENT —— **(1,1) LIGNE_REPARATION**
* **PIECE_RECHANGE (0,N)** —— EST_UTILISÉE_DANS —— **(1,1) LIGNE_REPARATION**
* **TECHNICIEN (1,N)** —— EFFECTUE —— **(1,1) REPARATION**
* **REPARATION (1,1)** —— EST_PAYÉE_PAR —— **(1,1) PAIEMENT**
* **REPARATION (0,1)** —— DONNE_LIEU_A —— **(1,1) GARANTIE**

---

### Fichier 3 : 3FN (Troisième Forme Normale)
Structure finale. Les dépendances transitives sont éliminées. Introduction des **Clés Primaires (ID)** et des **Clés Étrangères (#)**.

* **Client** (**ID_Client**, Nom, Prénom, Téléphone, Email)
* **Adresse** (**ID_Adresse**, Numéro_rue, Rue, Ville, Code_Postal, **#ID_Client**)
* **Marque** (**ID_Marque**, Nom_Marque)
* **Modèle** (**ID_Modele**, Nom_Modèle, Annee_Sortie, **#ID_Marque**)
* **Appareil** (**Num_IMEI**, Couleur, État_Général, **#ID_Modele**, **#ID_Client**)
* **Réparation** (**ID_Reparation**, Date_Dépôt, Statut, **#Num_IMEI**, **#ID_Technicien**)
* **Ligne_Réparation** (**ID_Ligne**, Description_Tâche, Prix_MO, **#ID_Reparation**, **#ID_Piece**)
* **Pièce_Rechange** (**ID_Piece**, Nom_Pièce, Prix_Unitaire)
* **Technicien** (**ID_Technicien**, Nom, Prénom, Spécialité)
* **Paiement** (**ID_Paiement**, Date_Paiement, Montant_Total, Mode_Paiement, **#ID_Reparation**)
* **Garantie** (**ID_Garantie**, Date_Fin, Conditions, **#ID_Reparation**)

---

## 3. Diagramme ER (Mermaid)



```mermaid
erDiagram
    CLIENT ||--o{ APPAREIL : "possede"
    CLIENT ||--|| ADRESSE : "habite"
    MARQUE ||--o{ MODELE : "fabrique"
    MODELE ||--o{ APPAREIL : "definit"
    APPAREIL ||--o{ REPARATION : "fait_objet_de"
    REPARATION ||--|{ LIGNE_REPARATION : "detaille"
    PIECE_RECHANGE ||--o{ LIGNE_REPARATION : "est_utilisee_dans"
    TECHNICIEN ||--o{ REPARATION : "effectue"
    REPARATION ||--|| PAIEMENT : "genere"
    REPARATION ||--o| GARANTIE : "active"

    CLIENT {
        int id_client PK
        string nom
        string telephone
    }
    APPAREIL {
        string imei PK
        int id_modele FK
        int id_client FK
    }
    MODELE {
        int id_modele PK
        string nom_modele
        int id_marque FK
    }
    REPARATION {
        int id_reparation PK
        string imei FK
        int id_technicien FK
        date date_depot
    }
    LIGNE_REPARATION {
        int id_ligne PK
        int id_reparation FK
        int id_piece FK
    }
