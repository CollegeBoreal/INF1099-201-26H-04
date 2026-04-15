INSERT INTO client (nom, telephone) VALUES
('Ali', '5141111111'),
('Sara', '5142222222'),
('Karim', '5143333333');

INSERT INTO immeuble (adresse, ville) VALUES
('123 Rue A', 'Montreal'),
('456 Rue B', 'Toronto');

INSERT INTO appartement (num_appartement, surface, prix, id_immeuble) VALUES
(101, 80, 250000, 1),
(102, 75, 230000, 1),
(201, 90, 300000, 2);

INSERT INTO vente (date_vente, id_client, id_appartement) VALUES
('2024-01-10', 1, 1),
('2024-02-15', 2, 2),
('2024-03-20', 3, 3);