# Tâche 1 : Analyse, Modélisation et Optimisation - ID 300142242

## 1. Analyse des Besoins et Règles d'Affaires
L'objectif de ce projet est de concevoir une base de données robuste pour une plateforme de gestion scolaire (Moodle).
* **Entités clés** : Étudiants, Professeurs, Cours, Inscriptions, Départements.
* **Règles d'affaires** :
    * Un étudiant peut s'inscrire à plusieurs cours par session.
    * Un professeur est rattaché à un seul département.
    * Chaque inscription doit avoir un statut (Inscrit, Complété, etc.).

## 2. Conception et Modélisation
* **Modèle Conceptuel (ER)** : Utilisation d'un diagramme Entité-Relation pour structurer les liens entre les données.
* **Normalisation** : Application de la **3ème Forme Normale (3FN)** pour éliminer la redondance et garantir l'intégrité des données.
* **Choix du SGBD** : PostgreSQL a été retenu pour sa gestion avancée des contraintes d'intégrité et ses capacités d'optimisation.

## 3. Optimisation des Performances
Pour assurer la fluidité de la plateforme, nous avons mis en place une stratégie d'indexation ciblée sur les colonnes les plus sollicitées.

### Commandes SQL d'optimisation utilisées :
```sql
-- Création d'index pour accélérer les recherches et les jointures
CREATE INDEX idx_etudiant_nom ON ETUDIANT(nom);
CREATE INDEX idx_cours_titre ON COURS(titre);
CREATE INDEX idx_fk_prof_dept ON PROFESSEUR(id_departement);
CREATE INDEX idx_fk_cours_prof ON COURS(id_professeur);
