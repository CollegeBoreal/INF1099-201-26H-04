INSERT INTO type_abonnement (nom_type, duree_mois, prix) VALUES
('Mensuel', 1, 50.00),
('Trimestriel', 3, 135.00),
('Semestriel', 6, 250.00),
('Annuel', 12, 480.00),
('Étudiant', 1, 35.00);

INSERT INTO coach (nom, prenom, specialite, email) VALUES
('Bensaid', 'Karim', 'Musculation', 'karim.bensaid@gym.com'),
('Martin', 'Julie', 'Yoga', 'julie.martin@gym.com'),
('Ahmed', 'Samir', 'Cardio', 'samir.ahmed@gym.com'),
('Lopez', 'Maria', 'Zumba', 'maria.lopez@gym.com'),
('Bernard', 'Nadia', 'Pilates', 'nadia.bernard@gym.com');

INSERT INTO salle (nom_salle, capacite) VALUES
('Salle A', 20),
('Salle B', 15),
('Salle Cardio', 25),
('Studio Yoga', 12),
('Salle Polyvalente', 30);

INSERT INTO membre (nom, prenom, email, telephone, date_inscription) VALUES
('Benali', 'Yacine', 'yacine.benali@mail.com', '5141111111', '2026-01-05'),
('Tahar', 'Aroua', 'aroua.tahar@mail.com', '5142222222', '2026-01-12'),
('Khelifi', 'Sonia', 'sonia.khelifi@mail.com', '5143333333', '2026-02-01'),
('Mokhtar', 'Lina', 'lina.mokhtar@mail.com', '5144444444', '2026-02-10'),
('Rached', 'Imad', 'imad.rached@mail.com', '5145555555', '2026-03-03');

INSERT INTO abonnement (id_membre, id_type_abonnement, date_debut, date_fin, statut) VALUES
(1, 1, '2026-01-05', '2026-02-05', 'expiré'),
(2, 4, '2026-01-12', '2027-01-12', 'actif'),
(3, 2, '2026-02-01', '2026-05-01', 'actif'),
(4, 5, '2026-02-10', '2026-03-10', 'expiré'),
(5, 3, '2026-03-03', '2026-09-03', 'actif');

INSERT INTO cours (nom_cours, description, horaire, capacite_max, id_coach, id_salle) VALUES
('Musculation Débutant', 'Cours de musculation pour débutants', '2026-04-15 09:00:00', 15, 1, 1),
('Yoga Matinal', 'Séance de yoga douce', '2026-04-15 10:00:00', 12, 2, 4),
('Cardio Intensif', 'Entraînement cardio avancé', '2026-04-16 18:00:00', 20, 3, 3),
('Zumba Fitness', 'Cours dynamique de zumba', '2026-04-17 17:00:00', 18, 4, 5),
('Pilates Forme', 'Cours de pilates pour tous niveaux', '2026-04-18 11:00:00', 14, 5, 2);

INSERT INTO inscription (id_membre, id_cours, date_inscription, statut) VALUES
(1, 1, '2026-04-01', 'confirmée'),
(2, 2, '2026-04-01', 'confirmée'),
(3, 3, '2026-04-02', 'en attente'),
(4, 4, '2026-04-02', 'confirmée'),
(5, 5, '2026-04-03', 'confirmée');

INSERT INTO paiement (id_membre, id_abonnement, montant, date_paiement, mode_paiement, statut) VALUES
(1, 1, 50.00, '2026-01-05', 'carte', 'payé'),
(2, 2, 480.00, '2026-01-12', 'virement', 'payé'),
(3, 3, 135.00, '2026-02-01', 'carte', 'payé'),
(4, 4, 35.00, '2026-02-10', 'cash', 'payé'),
(5, 5, 250.00, '2026-03-03', 'carte', 'payé');
