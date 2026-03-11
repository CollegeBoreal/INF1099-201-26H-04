-- Equipes
INSERT INTO boutique.equipe (nom_equipe,pays) VALUES
('FC Barcelona','Espagne'),
('Juventus','Italie'),
('Ajax','Pays-Bas');

-- Produits
INSERT INTO boutique.produit (nom_produit,saison,taille,etat,prix,stock,id_equipe) VALUES
('Maillot Barcelona 2009','2009','M','Très bon',120,5,1),
('Maillot Juventus 1996','1996','L','Bon',150,3,2),
('Maillot Ajax 1995','1995','M','Excellent',180,2,3);

-- Clients
INSERT INTO boutique.client (nom,prenom,telephone,email) VALUES
('Rahmani','Chakib','5141112222','chakib@email.com'),
('Martin','Lucas','4383334444','lucas@email.com');

-- Adresses
INSERT INTO boutique.adresse (numero_rue,rue,ville,code_postal,pays,id_client) VALUES
('10','Rue Ontario','Montréal','H2X1A1','Canada',1),
('5','Rue King','Toronto','M5H2N2','Canada',2);

-- Commandes
INSERT INTO boutique.commande (statut,total,id_client,id_adresse_livraison) VALUES
('Confirmée',120,1,1),
('Expédiée',150,2,2);

-- Ligne commande
INSERT INTO boutique.ligne_commande (quantite,prix_unitaire,id_commande,id_produit) VALUES
(1,120,1,1),
(1,150,2,2);

-- Modes paiement
INSERT INTO boutique.mode_paiement (nom_mode) VALUES
('Carte'),
('PayPal');

-- Prestataire
INSERT INTO boutique.prestataire_paiement (nom_prestataire,type_service) VALUES
('Stripe','Paiement en ligne'),
('PayPal','Wallet');

-- Paiements
INSERT INTO boutique.paiement (date_paiement,montant_paye,statut,id_commande,id_mode_paiement,id_prestataire) VALUES
('2024-03-10',120,'Payé',1,1,1),
('2024-03-11',150,'Payé',2,2,2);