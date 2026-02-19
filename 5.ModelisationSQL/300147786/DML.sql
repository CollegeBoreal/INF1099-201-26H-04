-- Insertion utilisateurs
INSERT INTO utilisateur (nom, prenom, email, mot_de_passe, telephone)
VALUES 
('Diallo', 'Mamadou', 'mamadou@email.com', '123456', '5141234567'),
('Dupont', 'Jean', 'jean@email.com', 'abcdef', '4389876543');

-- Profil
INSERT INTO profil (description, age, genre, ville, budget_max, date_disponibilite, id_utilisateur)
VALUES 
('Etudiant en informatique', 22, 'Homme', 'Montreal', 800.00, '2026-02-01', 1);

-- Annonce
INSERT INTO annonce (type_annonce, ville, loyer, date_disponibilite, description, statut, id_utilisateur)
VALUES 
('Colocation', 'Montreal', 750.00, '2026-02-01', 'Chambre proche metro', 'Disponible', 2);

-- Preference
INSERT INTO preference (budget_min, budget_max, ville_souhaitee, age_min, age_max, fumeur_accepte, animaux_acceptes, id_utilisateur)
VALUES 
(500.00, 900.00, 'Montreal', 20, 30, TRUE, FALSE, 1);

-- Match
INSERT INTO match (statut, id_utilisateur_1, id_utilisateur_2)
VALUES 
('En cours', 1, 2);

-- Message
INSERT INTO message (contenu, id_match, id_expediteur)
VALUES 
('Salut, ton annonce m’intéresse !', 1, 1);

