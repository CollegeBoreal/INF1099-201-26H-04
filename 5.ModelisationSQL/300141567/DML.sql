INSERT INTO utilisateur (nom, prenom, email)
VALUES ('Sow', 'Amadou', 'amadou@mail.com');

INSERT INTO categorie (libelle)
VALUES ('Réseau'), ('Logiciel');

INSERT INTO equipe (nom_equipe)
VALUES ('Support N1'), ('Support N2');

INSERT INTO technicien (nom, prenom, email, id_equipe)
VALUES ('Diallo', 'Ali', 'ali@mail.com', 1);

INSERT INTO ticket (titre, description, date_creation, id_utilisateur, id_categorie, id_technicien)
VALUES ('Problème wifi', 'Connexion instable', CURRENT_DATE, 1, 1, 1);

INSERT INTO intervention (date_intervention, commentaire, id_ticket, id_technicien)
VALUES (CURRENT_DATE, 'Redémarrage routeur', 1, 1);