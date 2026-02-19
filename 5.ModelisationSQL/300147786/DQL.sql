-- Tous les utilisateurs
SELECT * FROM utilisateur;

-- Annonces disponibles
SELECT * 
FROM annonce
WHERE statut = 'Disponible';

-- Profils avec informations utilisateur
SELECT u.nom, u.prenom, p.age, p.ville
FROM utilisateur u
JOIN profil p ON u.id_utilisateur = p.id_utilisateur;

-- Messages d’un match
SELECT m.contenu, m.date_envoi, u.prenom
FROM message m
JOIN utilisateur u ON m.id_expediteur = u.id_utilisateur
WHERE m.id_match = 1;

-- Matches d’un utilisateur
SELECT *
FROM match
WHERE id_utilisateur_1 = 1
   OR id_utilisateur_2 = 1;

