INSERT INTO utilisateur (nom, prenom, telephone, email, mot_de_passe, type_utilisateur)
VALUES
('Bah','Thierno','111222333','thierno@email.com','pass123','vendeur'),
('Diallo','Amadou','444555666','amadou@email.com','pass456','acheteur');

INSERT INTO vendeur (id_utilisateur)
VALUES (1);

INSERT INTO acheteur (id_utilisateur)
VALUES (2);

INSERT INTO pays (nom_pays)
VALUES
('Canada'),
('Guinee');

INSERT INTO port (nom_port, id_pays)
VALUES
('Port de Montreal',1),
('Port de Conakry',2);

INSERT INTO transporteur (nom_transporteur, telephone, email)
VALUES
('Global Shipping','888777666','contact@shipping.com');

INSERT INTO vehicule (marque, modele, annee, kilometrage, etat, statut, id_vendeur)
VALUES
('Toyota','Corolla',2018,65000,'Bon','Disponible',1);

INSERT INTO transit
(date_demande, date_depart, date_arrivee_estimee, statut_transit, cout_transport,
id_vehicule, id_acheteur, id_port_depart, id_port_arrivee, id_transporteur)
VALUES
('2026-03-01','2026-03-05','2026-03-20','En cours',2500,
1,1,1,2,1);
INSERT INTO document (type_document, date_document, chemin_fichier, id_transit)
VALUES
('Facture','2026-03-02','/docs/facture1.pdf',1);

INSERT INTO paiement
(date_paiement, montant, mode_paiement, statut_paiement, reference_paiement, id_transit)
VALUES
('2026-03-03',2500,'Carte','Payé','REF12345',1);
